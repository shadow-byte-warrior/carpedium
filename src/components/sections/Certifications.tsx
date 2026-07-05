import Reveal from "@/components/ui/Reveal";
import SectionEyebrow from "@/components/ui/SectionEyebrow";

export default function Certifications() {
  return (
    <section id="certifications" className="relative px-6 py-24 sm:py-32 bg-white">
      <div className="mx-auto max-w-6xl">
        <div className="grid grid-cols-1 lg:grid-cols-12 gap-12 items-center">
          
          {/* Left Column: Staggered Info */}
          <div className="lg:col-span-6">
            <Reveal>
              <SectionEyebrow>Certifications</SectionEyebrow>
              <h2 className="font-display text-3xl font-bold sm:text-4xl text-ink leading-tight">
                Verified credentials for your next step.
              </h2>
              <p className="mt-4 text-sm sm:text-base text-ink-dim leading-relaxed">
                Every cohort graduate receives a cryptographically signed certificate of competency. This is not just a participation badge — it validates the production-grade code repositories you shipped.
              </p>
            </Reveal>

            <div className="mt-8 flex flex-col gap-5">
              <Reveal delay={0.08}>
                <div className="flex gap-4">
                  <div className="h-10 w-10 shrink-0 rounded-xl bg-primary/10 flex items-center justify-center text-primary font-bold">✓</div>
                  <div>
                    <h4 className="font-display font-bold text-ink text-sm">ISO Certified Validation</h4>
                    <p className="text-xs text-ink-dim mt-0.5">Aligned with international software development training benchmarks.</p>
                  </div>
                </div>
              </Reveal>
              <Reveal delay={0.12}>
                <div className="flex gap-4">
                  <div className="h-10 w-10 shrink-0 rounded-xl bg-primary/10 flex items-center justify-center text-primary font-bold">✓</div>
                  <div>
                    <h4 className="font-display font-bold text-ink text-sm">One-Click LinkedIn Add</h4>
                    <p className="text-xs text-ink-dim mt-0.5">Integrates directly into your LinkedIn Certifications profile section.</p>
                  </div>
                </div>
              </Reveal>
              <Reveal delay={0.16}>
                <div className="flex gap-4">
                  <div className="h-10 w-10 shrink-0 rounded-xl bg-primary/10 flex items-center justify-center text-primary font-bold">✓</div>
                  <div>
                    <h4 className="font-display font-bold text-ink text-sm">QR Code Verification</h4>
                    <p className="text-xs text-ink-dim mt-0.5">Employers can scan to view your live, verified portfolio repos instantly.</p>
                  </div>
                </div>
              </Reveal>
            </div>
          </div>

          {/* Right Column: Premium Certificate Mockup */}
          <div className="lg:col-span-6 flex justify-center w-full">
            <Reveal delay={0.15}>
              <div className="relative w-full max-w-[460px] aspect-[1.414/1] rounded-2xl border border-teal/15 bg-slate-50/50 p-6 sm:p-8 shadow-2xl glassmorphic overflow-hidden flex flex-col justify-between select-none">
                
                {/* Decorative mesh background */}
                <div className="absolute inset-0 z-0 pointer-events-none opacity-40 bg-[radial-gradient(ellipse_at_top_right,var(--color-primary-light)_10%,transparent_60%)]" />

                {/* Border corners */}
                <div className="absolute top-4 left-4 h-4 w-4 border-t border-l border-primary/45" />
                <div className="absolute top-4 right-4 h-4 w-4 border-t border-r border-primary/45" />
                <div className="absolute bottom-4 left-4 h-4 w-4 border-b border-l border-primary/45" />
                <div className="absolute bottom-4 right-4 h-4 w-4 border-b border-r border-primary/45" />

                {/* Header */}
                <div className="relative z-10 flex items-start justify-between">
                  <div>
                    <h5 className="font-mono text-[9px] uppercase tracking-widest text-primary-strong">Carpediem Tech</h5>
                    <p className="font-display text-[10px] font-bold text-ink mt-0.5">Innovations Academy</p>
                  </div>
                  <div className="h-10 w-10 rounded-full border border-teal/20 bg-white flex items-center justify-center font-bold text-xs text-primary-strong shadow-sm">
                    CD
                  </div>
                </div>

                {/* Middle Text */}
                <div className="relative z-10 my-4 text-center">
                  <p className="font-mono text-[8px] uppercase tracking-widest text-ink-dim">This certifies that the graduate has completed</p>
                  <h3 className="font-display text-base sm:text-lg font-bold text-ink mt-2 text-gradient">
                    Advanced Engineering Cohort
                  </h3>
                  <p className="font-mono text-[9px] text-ink-dim mt-2">
                    Validating mastery in React, NodeJS, LLM RAG pipelines & AWS Devops.
                  </p>
                </div>

                {/* Footer details */}
                <div className="relative z-10 flex items-end justify-between border-t border-teal/5 pt-4">
                  <div className="text-left">
                    <p className="font-mono text-[7px] uppercase tracking-wider text-ink-dim">Verification ID</p>
                    <p className="font-mono text-[9px] text-ink font-bold">CD-2026-X89B</p>
                  </div>
                  <div className="text-right">
                    <p className="font-mono text-[7px] uppercase tracking-wider text-ink-dim">Authorized Seal</p>
                    <p className="font-display text-[9px] font-bold text-primary-strong">APPROVED COHORT</p>
                  </div>
                </div>

              </div>
            </Reveal>
          </div>

        </div>
      </div>
    </section>
  );
}
