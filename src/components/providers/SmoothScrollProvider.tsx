"use client";

import { useEffect } from "react";
import { MotionConfig } from "framer-motion";
import { initSmoothScroll } from "@/lib/scroll";

export default function SmoothScrollProvider({
  children,
}: {
  children: React.ReactNode;
}) {
  useEffect(() => {
    const prefersReducedMotion = window.matchMedia(
      "(prefers-reduced-motion: reduce)"
    ).matches;

    if (prefersReducedMotion) return;

    const cleanup = initSmoothScroll();
    return cleanup;
  }, []);

  return <MotionConfig reducedMotion="user">{children}</MotionConfig>;
}
