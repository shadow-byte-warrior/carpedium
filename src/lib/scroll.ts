import gsap from "gsap";
import { ScrollTrigger } from "gsap/ScrollTrigger";
import Lenis from "lenis";

let lenisInstance: Lenis | null = null;

export function getLenis() {
  return lenisInstance;
}

/**
 * Wires Lenis smooth scroll into GSAP's ticker so ScrollTrigger reads the
 * same interpolated scroll position Lenis renders — without this the two
 * drift apart and pinned/scrubbed animations visibly lag the scrollbar.
 */
export function initSmoothScroll(): () => void {
  gsap.registerPlugin(ScrollTrigger);

  const lenis = new Lenis({
    duration: 1.1,
    smoothWheel: true,
  });
  lenisInstance = lenis;

  lenis.on("scroll", ScrollTrigger.update);

  const tickerCallback = (time: number) => {
    lenis.raf(time * 1000);
  };
  gsap.ticker.add(tickerCallback);
  gsap.ticker.lagSmoothing(0);

  return () => {
    gsap.ticker.remove(tickerCallback);
    lenis.destroy();
    lenisInstance = null;
  };
}

export function scrollToSection(id: string) {
  const el = document.querySelector(id);
  if (!el) return;
  if (lenisInstance) {
    lenisInstance.scrollTo(el as HTMLElement, { offset: -72 });
  } else {
    el.scrollIntoView({ behavior: "smooth" });
  }
}
