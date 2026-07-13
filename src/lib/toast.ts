/**
 * toast.ts — Lightweight in-app toast + confirm dialog system.
 * Replaces all native alert() / confirm() calls with modern UI.
 *
 * Usage:
 *   import { toast, confirm } from "@/lib/toast";
 *
 *   toast.success("Saved!");
 *   toast.error("Something went wrong.");
 *   toast.info("FYI: ...");
 *
 *   const yes = await confirm({ title: "Delete?", message: "This is permanent." });
 */

// ─── Types ────────────────────────────────────────────────────────────────────

type ToastKind = "success" | "error" | "info" | "warning";

interface ToastOptions {
  duration?: number; // ms — default 3500
}

interface ConfirmOptions {
  title: string;
  message?: string;
  confirmLabel?: string;
  cancelLabel?: string;
  danger?: boolean; // red confirm button
}

// ─── Helpers ──────────────────────────────────────────────────────────────────

function injectStyles() {
  if (document.getElementById("cdt-toast-styles")) return;
  const style = document.createElement("style");
  style.id = "cdt-toast-styles";
  style.textContent = `
    #cdt-toast-root {
      position: fixed;
      bottom: 24px;
      right: 24px;
      z-index: 2147483640;
      display: flex;
      flex-direction: column-reverse;
      gap: 10px;
      pointer-events: none;
    }
    .cdt-toast {
      pointer-events: all;
      display: flex;
      align-items: flex-start;
      gap: 10px;
      min-width: 280px;
      max-width: 380px;
      padding: 13px 16px;
      border-radius: 12px;
      font-family: 'Inter', 'DM Sans', system-ui, sans-serif;
      font-size: 13.5px;
      font-weight: 500;
      line-height: 1.45;
      color: #fff;
      box-shadow: 0 8px 32px rgba(0,0,0,0.22), 0 2px 8px rgba(0,0,0,0.12);
      backdrop-filter: blur(12px);
      animation: cdt-slide-in 0.28s cubic-bezier(0.34,1.56,0.64,1) forwards;
      cursor: pointer;
      border: 1px solid rgba(255,255,255,0.12);
    }
    .cdt-toast.dismissing {
      animation: cdt-slide-out 0.22s ease-in forwards;
    }
    .cdt-toast-success { background: linear-gradient(135deg, #059669cc, #047857cc); }
    .cdt-toast-error   { background: linear-gradient(135deg, #dc2626cc, #b91c1ccc); }
    .cdt-toast-info    { background: linear-gradient(135deg, #2563ebcc, #1d4ed8cc); }
    .cdt-toast-warning { background: linear-gradient(135deg, #d97706cc, #b45309cc); }
    .cdt-toast-icon { font-size: 17px; flex-shrink: 0; margin-top: 1px; }
    .cdt-toast-text { flex: 1; }
    .cdt-toast-title { font-weight: 700; }
    .cdt-toast-msg { opacity: 0.88; font-size: 12.5px; margin-top: 2px; }
    .cdt-toast-close {
      flex-shrink: 0;
      width: 18px;
      height: 18px;
      opacity: 0.55;
      cursor: pointer;
      background: none;
      border: none;
      color: inherit;
      font-size: 16px;
      line-height: 1;
      padding: 0;
      margin-top: 1px;
    }
    .cdt-toast-close:hover { opacity: 1; }
    @keyframes cdt-slide-in {
      from { opacity: 0; transform: translateX(60px) scale(0.92); }
      to   { opacity: 1; transform: translateX(0)    scale(1); }
    }
    @keyframes cdt-slide-out {
      from { opacity: 1; transform: translateX(0)    scale(1);    max-height: 80px; }
      to   { opacity: 0; transform: translateX(60px) scale(0.92); max-height: 0;    }
    }

    /* Confirm dialog */
    #cdt-confirm-backdrop {
      position: fixed;
      inset: 0;
      z-index: 2147483645;
      background: rgba(0,0,0,0.55);
      backdrop-filter: blur(6px);
      display: flex;
      align-items: center;
      justify-content: center;
      animation: cdt-fade-in 0.18s ease;
    }
    @keyframes cdt-fade-in {
      from { opacity: 0; }
      to   { opacity: 1; }
    }
    .cdt-confirm-panel {
      background: #18181b;
      border: 1px solid rgba(255,255,255,0.1);
      border-radius: 18px;
      padding: 28px 28px 22px;
      width: min(400px, 92vw);
      box-shadow: 0 32px 80px rgba(0,0,0,0.6);
      font-family: 'Inter', 'DM Sans', system-ui, sans-serif;
      animation: cdt-pop-in 0.24s cubic-bezier(0.34,1.56,0.64,1) forwards;
    }
    @keyframes cdt-pop-in {
      from { opacity: 0; transform: scale(0.88); }
      to   { opacity: 1; transform: scale(1); }
    }
    .cdt-confirm-icon {
      width: 44px;
      height: 44px;
      border-radius: 50%;
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 20px;
      margin-bottom: 16px;
    }
    .cdt-confirm-icon-danger  { background: rgba(220,38,38,0.15); }
    .cdt-confirm-icon-neutral { background: rgba(99,102,241,0.15); }
    .cdt-confirm-title {
      font-size: 17px;
      font-weight: 700;
      color: #f4f4f5;
      margin: 0 0 8px;
    }
    .cdt-confirm-message {
      font-size: 13.5px;
      color: #a1a1aa;
      line-height: 1.55;
      margin: 0 0 24px;
    }
    .cdt-confirm-btns {
      display: flex;
      gap: 10px;
      justify-content: flex-end;
    }
    .cdt-btn {
      padding: 9px 22px;
      border-radius: 9px;
      font-size: 13px;
      font-weight: 600;
      cursor: pointer;
      border: none;
      transition: transform 0.12s, opacity 0.12s;
      font-family: inherit;
    }
    .cdt-btn:hover   { opacity: 0.9; transform: translateY(-1px); }
    .cdt-btn:active  { transform: translateY(0); }
    .cdt-btn-cancel  { background: rgba(255,255,255,0.07); color: #a1a1aa; border: 1px solid rgba(255,255,255,0.1); }
    .cdt-btn-confirm { background: #2563eb; color: #fff; }
    .cdt-btn-danger  { background: #dc2626; color: #fff; }
  `;
  document.head.appendChild(style);
}

function getRoot(): HTMLElement {
  let root = document.getElementById("cdt-toast-root");
  if (!root) {
    root = document.createElement("div");
    root.id = "cdt-toast-root";
    document.body.appendChild(root);
  }
  return root;
}

function dismiss(el: HTMLElement) {
  el.classList.add("dismissing");
  el.addEventListener("animationend", () => el.remove(), { once: true });
}

// ─── Icons ────────────────────────────────────────────────────────────────────

const ICONS: Record<ToastKind, string> = {
  success: "✓",
  error:   "✕",
  info:    "ℹ",
  warning: "⚠",
};

const TITLES: Record<ToastKind, string> = {
  success: "Success",
  error:   "Error",
  info:    "Info",
  warning: "Warning",
};

// ─── Toast ────────────────────────────────────────────────────────────────────

function show(kind: ToastKind, message: string, options?: ToastOptions) {
  if (typeof document === "undefined") return;
  injectStyles();
  const root = getRoot();
  const duration = options?.duration ?? 3500;

  const el = document.createElement("div");
  el.className = `cdt-toast cdt-toast-${kind}`;
  el.setAttribute("data-edit-ignore", "1");
  el.innerHTML = `
    <span class="cdt-toast-icon">${ICONS[kind]}</span>
    <div class="cdt-toast-text">
      <div class="cdt-toast-title">${TITLES[kind]}</div>
      <div class="cdt-toast-msg">${message}</div>
    </div>
    <button class="cdt-toast-close" aria-label="Dismiss">×</button>
  `;

  el.querySelector(".cdt-toast-close")?.addEventListener("click", (e) => {
    e.stopPropagation();
    dismiss(el);
  });
  el.addEventListener("click", () => dismiss(el));

  root.appendChild(el);

  const timer = setTimeout(() => dismiss(el), duration);
  el.addEventListener("mouseenter", () => clearTimeout(timer));
}

// ─── Confirm ──────────────────────────────────────────────────────────────────

function showConfirm(opts: ConfirmOptions): Promise<boolean> {
  return new Promise((resolve) => {
    if (typeof document === "undefined") {
      resolve(false);
      return;
    }
    injectStyles();

    const backdrop = document.createElement("div");
    backdrop.id = "cdt-confirm-backdrop";
    backdrop.setAttribute("data-edit-ignore", "1");

    const danger = opts.danger ?? false;
    const iconClass = danger ? "cdt-confirm-icon-danger" : "cdt-confirm-icon-neutral";
    const iconEmoji = danger ? "🗑" : "💬";
    const confirmClass = danger ? "cdt-btn-danger" : "cdt-btn-confirm";

    backdrop.innerHTML = `
      <div class="cdt-confirm-panel">
        <div class="cdt-confirm-icon ${iconClass}">${iconEmoji}</div>
        <h3 class="cdt-confirm-title">${opts.title}</h3>
        ${opts.message ? `<p class="cdt-confirm-message">${opts.message}</p>` : ""}
        <div class="cdt-confirm-btns">
          <button class="cdt-btn cdt-btn-cancel" id="cdt-cancel">${opts.cancelLabel ?? "Cancel"}</button>
          <button class="cdt-btn ${confirmClass}" id="cdt-confirm">${opts.confirmLabel ?? "Confirm"}</button>
        </div>
      </div>
    `;

    document.body.appendChild(backdrop);

    const close = (result: boolean) => {
      backdrop.remove();
      resolve(result);
    };

    backdrop.querySelector("#cdt-confirm")?.addEventListener("click", () => close(true));
    backdrop.querySelector("#cdt-cancel")?.addEventListener("click",  () => close(false));
    backdrop.addEventListener("click", (e) => { if (e.target === backdrop) close(false); });

    // Keyboard: Enter = confirm, Escape = cancel
    const onKey = (e: KeyboardEvent) => {
      if (e.key === "Enter")  { document.removeEventListener("keydown", onKey); close(true);  }
      if (e.key === "Escape") { document.removeEventListener("keydown", onKey); close(false); }
    };
    document.addEventListener("keydown", onKey);
  });
}

// ─── Public API ───────────────────────────────────────────────────────────────

export const toast = {
  success: (msg: string, opts?: ToastOptions) => show("success", msg, opts),
  error:   (msg: string, opts?: ToastOptions) => show("error",   msg, opts),
  info:    (msg: string, opts?: ToastOptions) => show("info",    msg, opts),
  warning: (msg: string, opts?: ToastOptions) => show("warning", msg, opts),
};

export { showConfirm as confirm };
