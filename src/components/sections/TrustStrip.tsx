import Reveal from "@/components/ui/Reveal";

const BADGES = [
  { platform: "Google Reviews", value: "4.9★" },
  { platform: "CourseReport", value: "4.8★" },
  { platform: "Active Batches", value: "12+" }
];

export default function TrustStrip() {
  return (
    <div className="relative border-y border-teal/10 bg-slate-50/50 px-6 py-6 select-none">
      <Reveal>
        <div className="mx-auto flex max-w-6xl flex-col items-center justify-center gap-3 text-center sm:flex-row sm:gap-10">
          <p className="font-mono text-xs uppercase tracking-wide text-ink-dim">
            Coimbatore Hub — 150+ Alumni Trained & Shipped
          </p>
          <div className="flex gap-6">
            {BADGES.map((badge) => (
              <div key={badge.platform} className="flex items-center gap-2">
                <span className="font-mono text-xs font-bold text-primary-strong">{badge.value}</span>
                <span className="text-[11px] font-mono text-ink-dim uppercase">{badge.platform}</span>
              </div>
            ))}
          </div>
        </div>
      </Reveal>
    </div>
  );
}
