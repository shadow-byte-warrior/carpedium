"use client";

import { useEffect, useRef, useState } from "react";
import { motion, AnimatePresence } from "framer-motion";
import Button from "@/components/ui/Button";

const HIGHLIGHTS = [
  "Full-Stack Development",
  "Generative AI Orchestration",
  "Cloud & DevOps Architecture",
  "Cybersecurity Systems",
  "Advanced AI & Machine Learning"
];

/* 
================================================================================
GEMINI PROMPT GENERATION KIT (For visual asset creation)
================================================================================

1. HERO BACKGROUND VIDEO PROMPT:
   "Create a premium, cinematic 4K video loop, abstract network node visualization. Soft glowing teal and cyan lines slowly connecting across a clean, minimal white background. Thin data packets pulsing along paths. Very shallow depth of field, high-tech, minimalist, luxury aesthetic, 30fps, seamless loop."

2. SECONDARY LOOPING VIDEOS PROMPT:
   "Create a close-up, high-tech looping animation. Abstract clean white glass panels rotating slowly with soft light refraction. Neon cyan and royal blue glowing accent lines tracing edges. Modern, minimalistic design, Apple/Stripe-like luxury advertising quality."

3. PREMIUM HERO ILLUSTRATION PROMPT:
   "Vector flat design illustration of a professional modern software workstation. Floating glass layers showing database schemas, UI wireframes, and neural network graphs. Color palette: Clean white background, soft teal highlights, cyan gradients, metallic blue. High detail, isometric perspective."

4. AI-GENERATED BACKGROUND GRAPHIC PROMPT:
   "Sleek, futuristic abstract mesh gradient. Shifting bright cyan, soft teal, and luxury sky blue wave shapes blended together with noise texture. Pure clean studio lighting, high contrast, web landing page header style, premium look."

5. MODERN SVG ICONS PROMPT:
   "A collection of clean, thin-line circuit design icons. Hexagonal shield shape, connection node, prompt terminal cursor, brain network. Tech, modern, soft teal outline, transparent background."
================================================================================
*/

export default function Hero() {
  const containerRef = useRef<HTMLDivElement>(null);
  const [mousePos, setMousePos] = useState({ x: 0, y: 0 });
  const [highlightIdx, setHighlightIdx] = useState(0);

  // Mouse Parallax tracking
  useEffect(() => {
    const handleMouseMove = (e: MouseEvent) => {
      if (!containerRef.current) return;
      const { clientWidth, clientHeight } = containerRef.current;
      const x = (e.clientX / clientWidth - 0.5) * 35; // displacement strength
      const y = (e.clientY / clientHeight - 0.5) * 35;
      setMousePos({ x, y });
    };

    window.addEventListener("mousemove", handleMouseMove, { passive: true });
    return () => window.removeEventListener("mousemove", handleMouseMove);
  }, []);

  // Text rotator interval
  useEffect(() => {
    const interval = setInterval(() => {
      setHighlightIdx((prev) => (prev + 1) % HIGHLIGHTS.length);
    }, 3200);
    return () => clearInterval(interval);
  }, []);

  return (
    <section
      id="hero"
      ref={containerRef}
      className="relative min-h-[92vh] flex items-center justify-center overflow-hidden bg-white pt-24 pb-16 gradient-mesh"
      aria-label="Welcome to Carpediem Tech Innovations"
    >
      {/* Background Cinematic Video & Gradient Overlay */}
      <div className="absolute inset-0 z-0 pointer-events-none overflow-hidden select-none">
        <video
          autoPlay
          muted
          loop
          playsInline
          className="absolute min-w-full min-h-full top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 object-cover opacity-[0.06] filter grayscale saturate-[0.5]"
        >
          {/* High-quality abstract tech loop */}
          <source
            src="https://assets.mixkit.co/videos/preview/mixkit-digital-animation-of-screens-and-numbers-31908-large.mp4"
            type="video/mp4"
          />
        </video>
        {/* Soft Animated Blurs */}
        <div className="absolute top-1/4 left-1/4 h-[350px] w-[350px] rounded-full bg-primary/10 blur-[100px] animate-float-1" />
        <div className="absolute bottom-1/4 right-1/4 h-[400px] w-[400px] rounded-full bg-accent/80 opacity-[0.07] blur-[120px] animate-float-2" />
      </div>

      {/* Floating Particles Overlay */}
      <div className="absolute inset-0 z-0 pointer-events-none select-none">
        <svg className="w-full h-full opacity-60">
          <circle cx="10%" cy="20%" r="2" fill="var(--color-primary)" className="animate-pulse" />
          <circle cx="85%" cy="15%" r="3.5" fill="var(--color-accent)" className="animate-pulse" style={{ animationDelay: "1s" }} />
          <circle cx="45%" cy="80%" r="2.5" fill="var(--color-primary-light)" className="animate-pulse" style={{ animationDelay: "1.5s" }} />
          <circle cx="75%" cy="75%" r="3" fill="var(--color-primary-strong)" className="opacity-40 animate-bounce" style={{ animationDuration: "12s" }} />
          <circle cx="15%" cy="65%" r="2" fill="var(--color-accent)" className="opacity-30 animate-bounce" style={{ animationDuration: "9s" }} />
        </svg>
      </div>

      {/* Main Content & Parallax Cards */}
      <div className="relative z-10 mx-auto max-w-6xl px-6 grid grid-cols-1 lg:grid-cols-12 gap-12 items-center w-full">
        
        {/* Left Side: Staggered Typography, CTAs, Statistics */}
        <motion.div
          initial={{ opacity: 0, y: 30 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.8, ease: [0.16, 1, 0.3, 1] }}
          className="lg:col-span-7 text-left flex flex-col"
        >
          {/* Trust Badge */}
          <div className="inline-flex items-center gap-2 rounded-full border border-teal/15 bg-teal/5 px-4 py-1.5 w-fit mb-6 shadow-sm">
            <span className="h-2 w-2 rounded-full bg-primary animate-ping" />
            <span className="font-mono text-[10px] font-bold uppercase tracking-wider text-primary-strong">
              Coimbatore&apos;s Elite Coding Academy
            </span>
          </div>

          {/* Staggered Heading */}
          <h1 className="font-display text-4xl sm:text-5xl md:text-6xl font-bold leading-[1.08] text-ink tracking-tight">
            Seize the Stack.
            <span className="block mt-1 text-gradient">Master the Future.</span>
          </h1>

          {/* Rotating Highlights & Subtitle */}
          <div className="h-10 mt-4 flex items-center">
            <span className="font-mono text-xs uppercase tracking-wide text-ink-dim mr-2">Cohort Focus:</span>
            <div className="relative overflow-hidden h-full flex-1">
              <AnimatePresence mode="wait">
                <motion.div
                  key={highlightIdx}
                  initial={{ y: 25, opacity: 0 }}
                  animate={{ y: 0, opacity: 1 }}
                  exit={{ y: -25, opacity: 0 }}
                  transition={{ duration: 0.4, ease: "easeOut" }}
                  className="absolute font-display text-lg sm:text-xl font-bold text-primary-strong"
                >
                  {HIGHLIGHTS[highlightIdx]}
                </motion.div>
              </AnimatePresence>
            </div>
          </div>

          <p className="mt-4 max-w-xl text-base sm:text-lg text-ink-dim leading-relaxed">
            Premium, project-led coding cohorts with 1-on-1 mentorship. Accelerate your career in software development and artificial intelligence with our industry-driven models in Coimbatore.
          </p>

          {/* CTA Group */}
          <div className="mt-8 flex flex-wrap gap-4 items-center">
            <Button href="#courses" variant="primary" className="shadow-lg shadow-primary/10">
              Explore Catalog
            </Button>
            <Button href="#contact" variant="secondary">
              Talk to a Advisor
            </Button>
          </div>

          {/* Trust Badges */}
          <div className="mt-12 pt-8 border-t border-teal/10 grid grid-cols-3 gap-4 items-center">
            <div>
              <p className="font-display text-2xl font-bold text-ink">95%</p>
              <p className="font-mono text-[9px] uppercase tracking-wider text-ink-dim">Placement Success</p>
            </div>
            <div>
              <p className="font-display text-2xl font-bold text-ink">1:1</p>
              <p className="font-mono text-[9px] uppercase tracking-wider text-ink-dim">Mentor Feedback</p>
            </div>
            <div>
              <p className="font-display text-2xl font-bold text-ink">12+</p>
              <p className="font-mono text-[9px] uppercase tracking-wider text-ink-dim">Production Projects</p>
            </div>
          </div>
        </motion.div>

        {/* Right Side: Interactive 3D Depth Parallax Illustration & floating widgets */}
        <div className="lg:col-span-5 relative flex items-center justify-center min-h-[350px] w-full">
          {/* Center Graphic Glow */}
          <div className="absolute h-64 w-64 rounded-full bg-gradient-to-tr from-primary to-accent opacity-[0.12] blur-[50px] z-0" />

          {/* Parallax Card Container */}
          <motion.div
            style={{
              x: mousePos.x,
              y: mousePos.y,
              rotateX: mousePos.y * -0.2,
              rotateY: mousePos.x * 0.2,
            }}
            transition={{ type: "spring", stiffness: 100, damping: 20 }}
            className="relative z-10 w-full max-w-[360px] aspect-[4/5] flex items-center justify-center"
          >
            {/* Base Frame Layer */}
            <div className="absolute inset-0 rounded-[24px] bg-gradient-to-br from-white/80 to-white/30 border border-teal/10 p-6 shadow-2xl glassmorphic backdrop-blur-md flex flex-col justify-between overflow-hidden">
              {/* Inner Decorative Code snippet */}
              <div className="font-mono text-[10px] text-primary-strong/80 leading-normal select-none">
                <span className="text-accent">const</span> learner = {"{"} <br />
                &nbsp;&nbsp;skills: [&apos;Full-Stack&apos;, &apos;GenAI&apos;], <br />
                &nbsp;&nbsp;projects: [&apos;RealProductionApp&apos;], <br />
                &nbsp;&nbsp;hired: <span className="text-teal font-bold">true</span> <br />
                {"}"}; <br />
                <span className="text-ink-dim">// Ready to scale...</span>
              </div>
              
              <div className="mt-8 flex flex-col gap-2">
                <div className="h-2.5 w-3/4 rounded-full bg-teal/10 overflow-hidden">
                  <div className="h-full w-4/5 rounded-full bg-primary animate-pulse" />
                </div>
                <div className="h-2 w-1/2 rounded-full bg-teal/10" />
              </div>

              {/* Bottom logo block */}
              <div className="flex items-center gap-3 border-t border-teal/5 pt-4">
                <div className="h-8 w-8 rounded-full bg-primary/10 flex items-center justify-center font-bold text-primary">C</div>
                <div>
                  <p className="font-mono text-[9px] uppercase tracking-wider text-ink-dim">Build Platform</p>
                  <p className="font-display text-[11px] font-bold text-ink">v2.4 Production</p>
                </div>
              </div>
            </div>

            {/* Float Layer 1: Stat Panel (Top-Right, offset, parallax displacement) */}
            <motion.div
              style={{
                x: mousePos.x * 1.5,
                y: mousePos.y * 1.5,
              }}
              className="absolute -top-6 -right-6 rounded-2xl border border-teal/10 bg-white/90 p-4 shadow-xl backdrop-blur-md flex items-center gap-3 w-48"
            >
              <div className="h-9 w-9 rounded-xl bg-teal/10 flex items-center justify-center text-primary-strong font-bold">⚡</div>
              <div>
                <p className="font-display text-sm font-extrabold text-ink">LPA 12+</p>
                <p className="font-mono text-[8px] uppercase tracking-wider text-ink-dim">Top Package</p>
              </div>
            </motion.div>

            {/* Float Layer 2: Placement Badge (Bottom-Left, offset) */}
            <motion.div
              style={{
                x: mousePos.x * -1.2,
                y: mousePos.y * -1.2,
              }}
              className="absolute -bottom-6 -left-6 rounded-2xl border border-teal/15 bg-white/95 p-4 shadow-xl backdrop-blur-md flex items-center gap-3 w-48"
            >
              <div className="h-9 w-9 rounded-xl bg-accent/10 flex items-center justify-center text-accent font-bold">💼</div>
              <div>
                <p className="font-display text-sm font-extrabold text-ink">45+ Partner</p>
                <p className="font-mono text-[8px] uppercase tracking-wider text-ink-dim">Hiring Networks</p>
              </div>
            </motion.div>

            {/* Float Layer 3: Extra badge */}
            <motion.div
              style={{
                x: mousePos.x * 0.8,
                y: mousePos.y * -0.8,
              }}
              className="absolute top-1/2 -left-12 rounded-xl border border-teal/10 bg-primary/95 px-3 py-1.5 shadow-md flex items-center gap-1.5"
            >
              <span className="h-1.5 w-1.5 rounded-full bg-white animate-ping" />
              <span className="font-mono text-[8px] font-bold text-white uppercase tracking-wider">Live Sandbox</span>
            </motion.div>
          </motion.div>
        </div>

      </div>

      {/* Scroll indicator */}
      <div className="absolute bottom-6 left-1/2 -translate-x-1/2 z-10 flex flex-col items-center gap-1 opacity-60">
        <span className="font-mono text-[9px] uppercase tracking-widest text-ink-dim">Scroll</span>
        <div className="h-6 w-3.5 rounded-full border border-ink-dim/40 flex justify-center p-1">
          <motion.div
            animate={{
              y: [0, 8, 0],
            }}
            transition={{
              duration: 1.5,
              repeat: Infinity,
              ease: "easeInOut",
            }}
            className="h-1 w-1 rounded-full bg-primary-strong"
          />
        </div>
      </div>
    </section>
  );
}
