import Reveal from "@/components/ui/Reveal";
import SectionEyebrow from "@/components/ui/SectionEyebrow";

const MENTORS = [
  {
    name: "Arun Kumar",
    role: "Full-Stack Architect",
    credibility: "Ex-SDE at Amazon. 10+ years engineering high-scale distributed commerce engines.",
    avatar: "👨‍💻",
    tag: "Ex-Amazon"
  },
  {
    name: "Dr. Priya Ramakrishnan",
    role: "Generative AI Lead",
    credibility: "Ph.D. in ML. Consultant for enterprise RAG pipelines and autonomous agent deployments.",
    avatar: "👩‍🔬",
    tag: "PhD AI"
  },
  {
    name: "Suresh Murugesan",
    role: "Cloud & DevOps Specialist",
    credibility: "AWS Solutions Lead. Managed massive automated Kubernetes node infrastructures.",
    avatar: "☁️",
    tag: "AWS Lead"
  },
  {
    name: "Magesh Sundar",
    role: "Product Designer",
    credibility: "Former Senior UX Designer. Shipped consumer products with millions of active users.",
    avatar: "🎨",
    tag: "Ex-CTS"
  },
];

export default function Mentors() {
  return (
    <section id="mentors" className="relative px-6 py-24 sm:py-32 bg-white">
      <div className="mx-auto max-w-6xl">
        <Reveal>
          <SectionEyebrow>Mentors</SectionEyebrow>
          <h2 className="font-display max-w-2xl text-3xl font-bold sm:text-4xl text-ink leading-tight">
            Learn from engineers, not instructors.
          </h2>
          <p className="mt-4 max-w-xl text-sm sm:text-base text-ink-dim">
            Our mentors build, scale, and secure production systems daily. They review your pull requests, correct your architectures, and guide your portfolio.
          </p>
        </Reveal>

        <div className="mt-16 grid grid-cols-1 gap-8 sm:grid-cols-2 lg:grid-cols-4">
          {MENTORS.map((mentor, i) => (
            <Reveal key={mentor.name} delay={i * 0.08}>
              <div className="group h-full rounded-2xl border border-teal/10 bg-white p-6 shadow-sm hover:shadow-md hover:border-primary/25 transition-all duration-300 hover:-translate-y-1 flex flex-col justify-between items-center text-center relative overflow-hidden">
                {/* Visual badge top right */}
                <span className="absolute top-3 right-3 font-mono text-[8px] font-bold uppercase tracking-wider text-teal/40 bg-teal/5 border border-teal/10 rounded px-1.5 py-0.5">
                  {mentor.tag}
                </span>

                <div className="flex flex-col items-center">
                  {/* Avatar Bubble */}
                  <div
                    className="flex h-20 w-20 items-center justify-center rounded-full bg-slate-50 border border-teal/10 text-4xl shadow-inner group-hover:scale-105 transition-transform duration-300"
                    aria-hidden="true"
                  >
                    {mentor.avatar}
                  </div>
                  
                  <h3 className="font-display mt-5 text-base font-extrabold text-ink leading-none">
                    {mentor.name}
                  </h3>
                  <p className="font-mono text-[10px] uppercase tracking-wider text-primary-strong mt-1.5">
                    {mentor.role}
                  </p>
                  <p className="mt-3.5 text-xs sm:text-sm text-ink-dim leading-relaxed">
                    {mentor.credibility}
                  </p>
                </div>

                {/* Social Placeholder Row */}
                <div className="mt-6 flex justify-center gap-3">
                  <a
                    href="https://linkedin.com"
                    target="_blank"
                    rel="noopener noreferrer"
                    className="h-7 w-7 rounded-full border border-teal/10 flex items-center justify-center text-ink-dim hover:text-primary hover:border-primary transition-all text-xs"
                    aria-label={`${mentor.name}'s LinkedIn profile`}
                  >
                    in
                  </a>
                </div>
              </div>
            </Reveal>
          ))}
        </div>
      </div>
    </section>
  );
}
