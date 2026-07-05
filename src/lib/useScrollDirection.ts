"use client";

import { useEffect, useState } from "react";

/**
 * True while the user is at the top of the page or actively scrolling up.
 * Lenis scrolls the real document, so a plain window scroll listener
 * tracks it fine without needing Lenis's own event.
 */
export function useScrollUpOrTop(threshold = 80): boolean {
  const [visible, setVisible] = useState(true);

  useEffect(() => {
    let lastY = window.scrollY;

    const onScroll = () => {
      const y = window.scrollY;
      if (y < threshold) {
        setVisible(true);
      } else {
        setVisible(y < lastY);
      }
      lastY = y;
    };

    window.addEventListener("scroll", onScroll, { passive: true });
    return () => window.removeEventListener("scroll", onScroll);
  }, [threshold]);

  return visible;
}
