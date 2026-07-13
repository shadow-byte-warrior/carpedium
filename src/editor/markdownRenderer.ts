// ============================================================
// markdownRenderer.ts — lightweight Markdown → HTML renderer
//
// No external dependencies. Supports:
//   - ATX headings (# h1 through ###### h6)
//   - Bold (**text** or __text__)
//   - Italic (*text* or _text_)
//   - Bold+Italic (***text***)
//   - Inline code (`code`)
//   - Fenced code blocks (``` ... ```)
//   - Unordered lists (- / * / +)
//   - Ordered lists (1. 2. 3.)
//   - Blockquotes (> text)
//   - Horizontal rules (--- / ***)
//   - Links ([label](url))
//   - Images (![alt](url))
//   - Paragraphs (blank-line separated)
//   - Line breaks (two trailing spaces or <br>)
// ============================================================

function escapeHtml(str: string): string {
  return str
    .replace(/&/g, "&amp;")
    .replace(/</g, "&lt;")
    .replace(/>/g, "&gt;")
    .replace(/"/g, "&quot;")
    .replace(/'/g, "&#39;");
}

/** Apply inline formatting to a text run (outside code blocks). */
function inlineFormat(text: string): string {
  // Images before links
  text = text.replace(
    /!\[([^\]]*)\]\(([^)]+)\)/g,
    (_, alt, src) => `<img src="${src}" alt="${escapeHtml(alt)}" style="max-width:100%;height:auto;" />`
  );

  // Links
  text = text.replace(
    /\[([^\]]+)\]\(([^)]+)\)/g,
    (_, label, href) =>
      `<a href="${escapeHtml(href)}" target="_blank" rel="noopener noreferrer">${escapeHtml(label)}</a>`
  );

  // Bold + Italic (*** / ___)
  text = text.replace(/\*{3}(.+?)\*{3}/g, "<strong><em>$1</em></strong>");
  text = text.replace(/_{3}(.+?)_{3}/g, "<strong><em>$1</em></strong>");

  // Bold (** / __)
  text = text.replace(/\*{2}(.+?)\*{2}/g, "<strong>$1</strong>");
  text = text.replace(/_{2}(.+?)_{2}/g, "<strong>$1</strong>");

  // Italic (* / _)
  text = text.replace(/\*([^*\n]+)\*/g, "<em>$1</em>");
  text = text.replace(/_([^_\n]+)_/g, "<em>$1</em>");

  // Inline code
  text = text.replace(/`([^`]+)`/g, (_, code) => `<code>${escapeHtml(code)}</code>`);

  // Line break (two trailing spaces)
  text = text.replace(/  \n/g, "<br />");

  return text;
}

type Block =
  | { type: "heading"; level: number; text: string }
  | { type: "hr" }
  | { type: "code"; lang: string; text: string }
  | { type: "blockquote"; lines: string[] }
  | { type: "ul"; items: string[] }
  | { type: "ol"; items: string[] }
  | { type: "p"; lines: string[] };

function parseBlocks(input: string): Block[] {
  const lines = input.split("\n");
  const blocks: Block[] = [];

  let i = 0;
  while (i < lines.length) {
    const line = lines[i];

    // Fenced code block
    const fenceMatch = line.match(/^```(\w*)/);
    if (fenceMatch) {
      const lang = fenceMatch[1] || "";
      const codeLines: string[] = [];
      i++;
      while (i < lines.length && !lines[i].startsWith("```")) {
        codeLines.push(lines[i]);
        i++;
      }
      i++; // skip closing ```
      blocks.push({ type: "code", lang, text: codeLines.join("\n") });
      continue;
    }

    // Horizontal rule
    if (/^(---+|\*\*\*+|___+)\s*$/.test(line)) {
      blocks.push({ type: "hr" });
      i++;
      continue;
    }

    // ATX Heading
    const headingMatch = line.match(/^(#{1,6})\s+(.+)/);
    if (headingMatch) {
      blocks.push({ type: "heading", level: headingMatch[1].length, text: headingMatch[2] });
      i++;
      continue;
    }

    // Blockquote
    if (line.startsWith("> ")) {
      const bqLines: string[] = [];
      while (i < lines.length && lines[i].startsWith("> ")) {
        bqLines.push(lines[i].slice(2));
        i++;
      }
      blocks.push({ type: "blockquote", lines: bqLines });
      continue;
    }

    // Unordered list
    if (/^[-*+] /.test(line)) {
      const items: string[] = [];
      while (i < lines.length && /^[-*+] /.test(lines[i])) {
        items.push(lines[i].replace(/^[-*+] /, ""));
        i++;
      }
      blocks.push({ type: "ul", items });
      continue;
    }

    // Ordered list
    if (/^\d+\. /.test(line)) {
      const items: string[] = [];
      while (i < lines.length && /^\d+\. /.test(lines[i])) {
        items.push(lines[i].replace(/^\d+\. /, ""));
        i++;
      }
      blocks.push({ type: "ol", items });
      continue;
    }

    // Blank line — skip
    if (line.trim() === "") {
      i++;
      continue;
    }

    // Paragraph — collect consecutive non-blank, non-special lines
    const pLines: string[] = [];
    while (
      i < lines.length &&
      lines[i].trim() !== "" &&
      !lines[i].startsWith("#") &&
      !lines[i].startsWith("> ") &&
      !/^[-*+] /.test(lines[i]) &&
      !/^\d+\. /.test(lines[i]) &&
      !lines[i].startsWith("```") &&
      !/^(---+|\*\*\*+|___+)\s*$/.test(lines[i])
    ) {
      pLines.push(lines[i]);
      i++;
    }
    if (pLines.length > 0) {
      blocks.push({ type: "p", lines: pLines });
    }
  }

  return blocks;
}

function renderBlock(block: Block): string {
  switch (block.type) {
    case "heading":
      return `<h${block.level}>${inlineFormat(escapeHtml(block.text))}</h${block.level}>`;

    case "hr":
      return "<hr />";

    case "code":
      return `<pre><code${block.lang ? ` class="language-${block.lang}"` : ""}>${escapeHtml(block.text)}</code></pre>`;

    case "blockquote":
      return `<blockquote>${block.lines.map((l) => inlineFormat(escapeHtml(l))).join("<br />")}</blockquote>`;

    case "ul":
      return `<ul>${block.items.map((item) => `<li>${inlineFormat(escapeHtml(item))}</li>`).join("")}</ul>`;

    case "ol":
      return `<ol>${block.items.map((item) => `<li>${inlineFormat(escapeHtml(item))}</li>`).join("")}</ol>`;

    case "p":
      return `<p>${block.lines.map((l) => inlineFormat(escapeHtml(l))).join(" ")}</p>`;

    default:
      return "";
  }
}

/**
 * Convert a Markdown string to an HTML string.
 * Safe to call on untrusted input — all user text is HTML-escaped before
 * formatting transforms are applied.
 */
export function renderMarkdown(markdown: string): string {
  if (!markdown) return "";
  const blocks = parseBlocks(markdown.trim());
  return blocks.map(renderBlock).join("\n");
}

/**
 * Detect whether a string contains Markdown syntax.
 * Used by the editor to suggest promoting a text element to `markdown` kind.
 */
export function looksLikeMarkdown(text: string): boolean {
  return /[*_`#\[\]>]/.test(text) || /\n/.test(text);
}
