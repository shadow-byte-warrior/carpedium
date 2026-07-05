import Reveal from "@/components/ui/Reveal";
import SectionEyebrow from "@/components/ui/SectionEyebrow";
import HiringMarquee from "@/components/ui/HiringMarquee";

const TESTIMONIALS = [
  {
    quote: "“The code reviews here are brutal but essential. My mentor at Carpediem helped me restructure a database model that resolved a major bottlenecks. I was hired as a React Dev in Bengaluru three weeks after graduating.”",
    name: "Preethi Srinivasan",
    track: "Full-Stack Cohort",
    outcome: "SDE-1 @ SaaS Hub",
  },
  {
    quote: "“I transitioned from manual testing to AI automation. Building a multi-agent n8n service from scratch that handles customer returns taught me more about vector databases and prompt workflows than any tutorial series.”",
    name: "Gokul Krishnan",
    track: "Generative AI Cohort",
    outcome: "AI Engineer @ DevStudio",
  },
  {
    quote: "“Being a career-switcher from support, I was overwhelmed. The 1:5 mentor ratio kept me accountable. Shipped three real deployments on AWS, got my resume refactored, and unlocked a direct referral into a SDE role.”",
    name: "Naveen Prasad",
    track: "Full-Stack Cohort",
    outcome: "Software Engineer @ FinTech Corp",
  },
];

export default function Outcomes() {
  return (
    <section id="outcomes" className="relative px-6 py-24 sm:py-32 bg-slate-50/50">
      <div className="mx-auto max-w-6xl">
        
        {/* Header */}
        <Reveal>
          <SectionEyebrow>Outcomes</SectionEyebrow>
          <h2 className="font-display max-w-2xl text-3xl font-bold sm:text-4xl text-ink leading-tight">
            Our learners ship value at top teams.
          </h2>
          <p className="mt-4 max-w-xl text-sm sm:text-base text-ink-dim">
            Direct referral loops and placement support built for engineers. Here is what our alumni say about the intensive building blocks.
          </p>
        </Reveal>

        {/* Hiring Partners Logo Marquee */}
        <Reveal delay={0.1}>
          <div className="mt-12 border-y border-teal/10 py-8 bg-white/40 rounded-2xl">
            <p className="font-mono text-[10px] uppercase tracking-widest text-center text-ink-dim mb-6">
              Hiring Networks & Recruitment Partners
            </p>
            <HiringMarquee />
          </div>
        </Reveal>

        {/* Success Stories Grid */}
        <div className="mt-16 grid grid-cols-1 gap-6 lg:grid-cols-3">
          {TESTIMONIALS.map((t, i) => (
            <Reveal key={t.name} delay={i * 0.08}>
              <blockquote className="group h-full rounded-2xl border border-teal/10 bg-white p-6 shadow-sm hover:shadow-md hover:border-primary/20 transition-all duration-300 hover:-translate-y-1 flex flex-col justify-between">
                <div>
                  {/* Rating Stars mock */}
                  <div className="flex gap-1 text-primary text-xs mb-4">⭐⭐⭐⭐⭐</div>
                  <p className="text-xs sm:text-sm italic text-ink leading-relaxed">
                    {t.quote}
                  </p>
                </div>
                <footer className="mt-6 pt-4 border-t border-teal/5 flex flex-col">
                  <span className="font-display text-sm font-extrabold text-ink leading-none">
                    {t.name}
                  </span>
                  <span className="font-mono text-[9px] uppercase tracking-wider text-primary mt-1.5 leading-none">
                    {t.track}
                  </span>
                  <span className="inline-flex items-center gap-1.5 rounded bg-teal/5 border border-teal/10 px-2 py-0.5 mt-2.5 text-[9px] font-mono font-bold text-primary-strong uppercase w-fit">
                    💼 {t.outcome}
                  </span>
                </footer>
              </blockquote>
            </Reveal>
          ))}
        </div>
      </div>
    </section>
  );
}
