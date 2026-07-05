"use client";

import { useEffect, useState } from "react";

// [TODO: insert real hiring partner logos once confirmed — these are
// structural placeholders, not a claim of existing partnerships]
const SLOT_COUNT = 10;

function Slot() {
  return (
    <div className="flex h-16 w-40 shrink-0 items-center justify-center rounded-xl border border-dashed border-line bg-surface-alt font-mono text-[10px] uppercase tracking-wide text-ink-dim">
      [TODO: logo]
    </div>
  );
}

export default function HiringMarquee() {
  const [reducedMotion, setReducedMotion] = useState<boolean | null>(null);

  useEffect(() => {
    setReducedMotion(
      window.matchMedia("(prefers-reduced-motion: reduce)").matches
    );
  }, []);

  if (reducedMotion === null) return null;

  if (reducedMotion) {
    return (
      <div className="flex flex-wrap justify-center gap-4">
        {Array.from({ length: SLOT_COUNT }, (_, i) => (
          <Slot key={i} />
        ))}
      </div>
    );
  }

  return (
    <div className="group overflow-hidden [mask-image:linear-gradient(to_right,transparent,black_8%,black_92%,transparent)]">
      <div className="flex w-max animate-marquee gap-4 group-hover:[animation-play-state:paused]">
        {Array.from({ length: SLOT_COUNT * 2 }, (_, i) => (
          <Slot key={i} />
        ))}
      </div>
    </div>
  );
}
