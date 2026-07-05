import Reveal from "@/components/ui/Reveal";
import SectionHeader from "@/components/ui/SectionHeader";
import CircuitTrace from "@/components/ui/CircuitTrace";
import { tokens } from "@/lib/theme";

type Program = {
  id: string;
  eyebrow: string;
  title: string;
  description: string;
  stages: { label: string }[];
  chips: string[];
  curriculum: string[];
  batchFormat: string;
  whoFor: string;
  colorFrom: string;
  colorTo: string;
};

const PROGRAMS: Program[] = [
  {
    id: "fullstack",
    eyebrow: "Path A",
    title: "Full-Stack Development",
    description: "Build a full production app from scratch, not a toy demo.",
    stages: [
      { label: "Frontend" },
      { label: "Backend" },
      { label: "Database" },
      { label: "Deploy" },
    ],
    chips: ["HTML/CSS/JS", "React", "Node.js", "REST APIs", "SQL / MongoDB", "Git", "Cloud Deploy"],
    curriculum: [
      "HTML, CSS, and JavaScript fundamentals",
      "React for building interfaces",
      "Node.js and Express for APIs",
      "SQL and MongoDB data modeling",
      "Git workflows and code review",
      "Deploying to the cloud with a basic CI/CD pipeline",
    ],
    batchFormat: "Weekday and weekend batches available",
    whoFor:
      "Freshers, students, and career switchers who want a portfolio-ready full-stack project, not just tutorial checkboxes.",
    colorFrom: tokens.primary,
    colorTo: tokens.primaryLight,
  },
  {
    id: "genai",
    eyebrow: "Path B",
    title: "Generative AI",
    description: "Ship an AI agent that does something real, not a chatbot demo.",
    stages: [
      { label: "Prompt Eng." },
      { label: "LLM Fund." },
      { label: "RAG / Agents" },
      { label: "Deploy" },
    ],
    chips: ["Python", "LangChain", "Vector DBs", "OpenAI / Hugging Face APIs", "n8n", "Prompt Engineering"],
    curriculum: [
      "Prompt engineering fundamentals",
      "LLM fundamentals: tokens, context windows, embeddings",
      "Retrieval-Augmented Generation (RAG) pipelines",
      "Agent orchestration with n8n and agent frameworks",
      "Deploying an AI service others can actually use",
    ],
    batchFormat: "Weekday and weekend batches available",
    whoFor:
      "Developers and career switchers who want to ship a working AI agent, not just prompt around in a playground.",
    colorFrom: tokens.primary,
    colorTo: tokens.accent,
  },
];

export default function Programs() {
  return (
    <section id="programs" className="relative px-6 py-24 sm:py-32">
      <div className="mx-auto max-w-6xl">
        <SectionHeader eyebrow="Programs" title="Two paths. Both end with something you built." />

        <div className="mt-16 flex flex-col gap-10">
          {PROGRAMS.map((program, i) => (
            <Reveal key={program.id} delay={i * 0.1}>
              <article className="rounded-3xl border border-teal/10 bg-white p-6 sm:p-10 shadow-sm hover:shadow-md transition-all duration-300">
                <div className="flex flex-col gap-2 sm:flex-row sm:items-baseline sm:justify-between">
                  <div>
                    <p className="eyebrow mb-2">{program.eyebrow}</p>
                    <h3 className="font-display text-2xl font-bold text-ink sm:text-3xl">
                      {program.title}
                    </h3>
                  </div>
                </div>

                <p className="mt-4 max-w-xl text-ink-dim">{program.description}</p>

                <div className="mt-10">
                  <CircuitTrace
                    id={program.id}
                    stages={program.stages}
                    colorFrom={program.colorFrom}
                    colorTo={program.colorTo}
                  />
                </div>

                <div className="mt-8 flex flex-wrap gap-2">
                  {program.chips.map((chip) => (
                    <span
                      key={chip}
                      className="rounded-full border border-teal/10 bg-slate-50 px-3 py-1 font-mono text-xs text-ink-dim"
                    >
                      {chip}
                    </span>
                  ))}
                </div>

                <div className="mt-8 grid gap-8 sm:grid-cols-2">
                  <details className="group">
                    <summary className="cursor-pointer font-display text-sm font-bold text-primary-strong select-none outline-none">
                      Curriculum outline
                    </summary>
                    <ul className="mt-3 space-y-2 text-sm text-ink-dim">
                      {program.curriculum.map((item) => (
                        <li key={item} className="flex gap-2">
                          <span className="text-primary">—</span>
                          {item}
                        </li>
                      ))}
                    </ul>
                  </details>

                  <div className="space-y-4 text-sm">
                    <div>
                      <p className="font-mono text-xs uppercase tracking-wide text-ink-dim">
                        Batch format
                      </p>
                      <p className="mt-1 font-medium text-ink">{program.batchFormat}</p>
                    </div>
                    <div>
                      <p className="font-mono text-xs uppercase tracking-wide text-ink-dim">
                        Who this is for
                      </p>
                      <p className="mt-1 font-medium text-ink">{program.whoFor}</p>
                    </div>
                  </div>
                </div>
              </article>
            </Reveal>
          ))}
        </div>
      </div>
    </section>
  );
}
