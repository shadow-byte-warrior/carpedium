import Reveal from "@/components/ui/Reveal";
import SectionEyebrow from "@/components/ui/SectionEyebrow";

const STEPS = [
  {
    step: "01",
    title: "Cohort Intake & Onboarding",
    tagline: "Weeks 1–2",
    description:
      "Join a dedicated cohort. Setup your local cloud sandbox environment, integrate Git workflows, and get introduced to your primary SDE mentor.",
    milestone: "Git & Dev Environment locked",
  },
  {
    step: "02",
    title: "Interactive SDE Mentorship",
    tagline: "Weeks 3–10",
    description:
      "Dive deep into architecture. Participate in live coding labs, attend weekly core reviews, and get line-by-line feedback on pull requests.",
    milestone: "Core stack validation passed",
  },
  {
    step: "03",
    title: "Production Capstone Shipping",
    tagline: "Weeks 11–14",
    description:
      "Stop building toys. Ship a fully functional production application or autonomous AI service. Deploy to real cloud servers with active metrics.",
    milestone: "Live app deployed and reviewed",
  },
  {
    step: "04",
    title: "Placement Drills & Referral",
    tagline: "Weeks 15–16",
    description:
      "Practice mock tech interviews with senior engineers, refine your resume structure, and enter direct referrals with our 45+ hiring partners.",
    milestone: "Hiring referral unlocked",
  },
];

export default function HowItWorks() {
  return (
    <section id="how-it-works" className="relative px-6 py-24 sm:py-32 bg-slate-50/30">
      <div className="mx-auto max-w-6xl">
        {/* Header */}
        <Reveal>
          <SectionEyebrow>How It Works</SectionEyebrow>
          <h2 className="font-display max-w-2xl text-3xl font-bold sm:text-4xl text-ink leading-tight">
            A structured path from day one to hire.
          </h2>
          <p className="mt-4 max-w-xl text-sm sm:text-base text-ink-dim">
            We guide you step-by-step through a rigorous engineering lifecycle, combining cohort accountability with expert feedback.
          </p>
        </Reveal>

        {/* Timeline Grid */}
        <div className="relative mt-20">
          {/* Vertical line indicator */}
          <div className="absolute left-[33px] top-6 bottom-6 hidden w-[2px] bg-teal/15 lg:block lg:left-1/2 lg:-translate-x-1/2" />

          <div className="flex flex-col gap-12 lg:gap-16">
            {STEPS.map((step, i) => {
              const isEven = i % 2 === 0;
              return (
                <div
                  key={step.step}
                  className={`flex flex-col lg:flex-row items-start ${
                    isEven ? "lg:flex-row" : "lg:flex-row-reverse"
                  } gap-6 lg:gap-16 relative`}
                >
                  {/* Timeline Circle Badge */}
                  <div className="absolute left-0 top-1.5 flex h-[68px] w-[68px] items-center justify-center rounded-full bg-white border border-teal/20 text-primary-strong font-display text-lg font-bold shadow-sm z-10 lg:left-1/2 lg:-translate-x-1/2 lg:top-4 ring-4 ring-slate-50">
                    {step.step}
                  </div>

                  {/* Content Container */}
                  <div className="w-full lg:w-1/2 pl-20 lg:pl-0 flex flex-col justify-center">
                    <Reveal delay={i * 0.1}>
                      <div
                        className={`rounded-2xl border border-teal/10 bg-white p-6 shadow-sm hover:shadow-md hover:border-primary/20 transition-all duration-300 ${
                          isEven ? "lg:text-right lg:items-end" : "lg:text-left lg:items-start"
                        } flex flex-col`}
                      >
                        <span className="font-mono text-xs font-bold text-primary tracking-wider uppercase">
                          {step.tagline}
                        </span>
                        <h3 className="font-display mt-2 text-lg font-extrabold text-ink leading-snug">
                          {step.title}
                        </h3>
                        <p className="mt-2 text-xs sm:text-sm text-ink-dim leading-relaxed">
                          {step.description}
                        </p>

                        <div className="mt-4 inline-flex items-center gap-2 rounded bg-teal/5 px-2.5 py-1 text-[10px] font-mono font-bold text-primary-strong uppercase w-fit">
                          🎯 {step.milestone}
                        </div>
                      </div>
                    </Reveal>
                  </div>

                  {/* Balance spacer */}
                  <div className="hidden lg:block lg:w-1/2" />
                </div>
              );
            })}
          </div>
        </div>
      </div>
    </section>
  );
}
