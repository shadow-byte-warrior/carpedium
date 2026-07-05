import Reveal from "@/components/ui/Reveal";
import SectionEyebrow from "@/components/ui/SectionEyebrow";

const PROJECTS = [
  {
    title: "OmniAgent Orchestrator",
    track: "Gen AI Capstone",
    tech: ["Python", "LangChain", "n8n", "Pinecone"],
    metric: "1.4s execution",
    desc: "Autonomous workflow agent that parses incoming support emails, checks vector search databases for solutions, drafts responses, and auto-schedules calendar meetings.",
    liveUrl: "#",
  },
  {
    title: "PayStream Ledger Sandbox",
    track: "Full-Stack Capstone",
    tech: ["React", "Express", "PostgreSQL", "Tailwind"],
    metric: "1,200+ mock tx/min",
    desc: "A developer payment gateway sandbox supporting mock transaction ledgers, active webhooks triggers, and robust schema validations for test queries.",
    liveUrl: "#",
  },
  {
    title: "EduSync Collaborative LMS",
    track: "Full-Stack Capstone",
    tech: ["Next.js", "WebSockets", "MongoDB", "Tailwind"],
    metric: "50ms latency",
    desc: "Real-time remote classroom dashboard featuring whiteboard synchronization, collaborative code compiler pads, and instantaneous cohort chat.",
    liveUrl: "#",
  },
];

export default function LiveProjects() {
  return (
    <section id="live-projects" className="relative px-6 py-24 sm:py-32 bg-slate-50/20">
      <div className="mx-auto max-w-6xl">
        
        {/* Header */}
        <Reveal>
          <SectionEyebrow>Live Projects</SectionEyebrow>
          <h2 className="font-display max-w-2xl text-3xl font-bold sm:text-4xl text-ink leading-tight">
            Stop building exercises. Ship actual software.
          </h2>
          <p className="mt-4 max-w-xl text-sm sm:text-base text-ink-dim">
            Our learners don&apos;t just follow checkboxes. They architect and deploy functional systems that handle load, validation, and real database workflows.
          </p>
        </Reveal>

        {/* Projects Grid */}
        <div className="mt-16 grid grid-cols-1 md:grid-cols-3 gap-8">
          {PROJECTS.map((proj, i) => (
            <Reveal key={proj.title} delay={i * 0.08}>
              <div className="group h-full rounded-2xl border border-teal/10 bg-white p-6 shadow-sm hover:shadow-lg hover:border-primary/25 transition-all duration-300 hover:-translate-y-1.5 flex flex-col justify-between">
                <div>
                  {/* Category & performance badge */}
                  <div className="flex items-center justify-between gap-2 mb-5">
                    <span className="font-mono text-[9px] uppercase tracking-wide text-primary-strong bg-primary/10 border border-primary/10 rounded px-1.5 py-0.5">
                      {proj.track}
                    </span>
                    <span className="font-mono text-[9px] text-ink-dim bg-slate-100 rounded px-1.5 py-0.5">
                      ⚡ {proj.metric}
                    </span>
                  </div>

                  <h3 className="font-display text-base font-extrabold text-ink leading-snug group-hover:text-primary transition-colors">
                    {proj.title}
                  </h3>
                  
                  <p className="mt-2.5 text-xs sm:text-sm text-ink-dim leading-relaxed">
                    {proj.desc}
                  </p>
                </div>

                <div className="mt-6 pt-5 border-t border-teal/5">
                  {/* Tech Chips */}
                  <div className="flex flex-wrap gap-1.5 mb-5">
                    {proj.tech.map((t) => (
                      <span key={t} className="font-mono text-[8px] font-bold text-ink-dim border border-teal/10 rounded px-1.5 py-0.5 bg-slate-50">
                        {t}
                      </span>
                    ))}
                  </div>

                  {/* Actions */}
                  <div className="flex items-center justify-between text-xs font-mono">
                    <a href={proj.liveUrl} className="font-bold text-primary-strong hover:text-primary transition-colors">
                      Live Demo ↗
                    </a>
                    <span className="text-ink-dim/40 font-light">Code Reviewed</span>
                  </div>
                </div>
              </div>
            </Reveal>
          ))}
        </div>

      </div>
    </section>
  );
}
