import Reveal from "@/components/ui/Reveal";
import SectionEyebrow from "@/components/ui/SectionEyebrow";

const RESOURCE_GROUPS = [
  {
    title: "Full-Stack Dev logs",
    items: [
      "React UI performance patterns",
      "Node.js API security checklist",
      "SQL schema optimization tips"
    ],
  },
  {
    title: "Generative AI Guides",
    items: [
      "Prompt orchestration guides",
      "RAG document retrieval basics",
      "Multi-agent frameworks comparison"
    ],
  },
  {
    title: "Career & Interview prep",
    items: [
      "Coimbatore local tech review guides",
      "System design mock questions",
      "Software portfolio templates"
    ],
  },
];

export default function Resources() {
  return (
    <section id="resources" className="relative px-6 py-24 sm:py-32 bg-white">
      <div className="mx-auto max-w-6xl">
        <Reveal>
          <SectionEyebrow>Resources</SectionEyebrow>
          <h2 className="font-display max-w-2xl text-3xl font-bold sm:text-4xl text-ink leading-tight">
            Developer learning resources.
          </h2>
          <p className="mt-4 max-w-xl text-sm sm:text-base text-ink-dim">
            Curated references, interview guides, and technical tutorials to help you scale your skills outside classroom hours.
          </p>
        </Reveal>

        <div className="mt-14 grid grid-cols-1 gap-8 sm:grid-cols-3">
          {RESOURCE_GROUPS.map((group, i) => (
            <Reveal key={group.title} delay={i * 0.08}>
              <div className="h-full rounded-2xl border border-teal/10 bg-white p-6 shadow-sm hover:shadow-md hover:border-primary/20 transition-all duration-300 hover:-translate-y-1">
                <h3 className="font-display text-base font-bold text-ink border-b border-teal/5 pb-3">
                  {group.title}
                </h3>
                <ul className="mt-4 space-y-2.5">
                  {group.items.map((item) => (
                    <li key={item} className="flex items-center gap-2">
                      <span className="text-primary text-xs">•</span>
                      <span className="cursor-pointer text-xs sm:text-sm text-ink-dim hover:text-primary transition-colors">
                        {item}
                      </span>
                    </li>
                  ))}
                </ul>
              </div>
            </Reveal>
          ))}
        </div>
      </div>
    </section>
  );
}
