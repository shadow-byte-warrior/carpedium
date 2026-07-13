# Carpediem Tech Innovations — UI & UX Architecture Summary

This document summarizes the user interface (UI) and user experience (UX) layout, design system, reusable components, and motion choreography rules implemented in the **Carpediem Tech Innovations** website.

---

## 1. Brand Foundation & Design Tokens

The UI is designed to feel technical, premium, and cohort-focused, bridging high-end immersive website design with structured educational tracks.

### Color Palette
Although the project brief specifies a dark obsidian theme, the current codebase defines the following color system in CSS variables and JavaScript tokens:
*   **Background / Surfaces:** Primary light-mode configurations (`#FFFFFF` background, `#F8FAFC` surface alt) paired with technical dark accents (`#0F172A` ink text, `#64748B` muted text).
*   **Primary Brand Color:** Teal (`#14B8A6`), Teal Light (`#2DD4BF`), and Teal Strong (`#0F766E`) used for buttons, interactive elements, highlights, and circuit paths.
*   **Accents:** Sky Blue (`#0EA5E9`) for accent points and secondary visual cues.
*   **Borders & Lines:** Slate/gray lines (`#E2E8F0`) for clean division.
*   *Note on Obsidian Theme:* References to Obsidian (`#0A1412` and `#0F1B18`) are present in custom component backgrounds and text shadows to give the hero scene and specific section elements a rich, immersive aesthetic contrast.

### Typography
*   **Display (Headlines):** **Space Grotesk** — A condensed, technical grotesk with bold weight (700) for headlines.
*   **Body:** **Inter** — Generous line-height (1.6) for readability.
*   **Utility/Mono:** **JetBrains Mono** — Small caps, wide letter-spacing for section eyebrows (e.g. `// WHAT WE TEACH`) and terminal/console-style details.

---

## 2. Page & Layout Structure

The layout is assembled as a single-page marketing and cohort site under [app/page.tsx](file:///c:/Users/Rishi/Downloads/carpedium_tech/app/page.tsx):

1.  **Header Navigation ([Nav.tsx](file:///c:/Users/Rishi/Downloads/carpedium_tech/components/layout/Nav.tsx)):** A sticky top header bar with obsidian backdrop blur and navigation options. Includes a smart scrolling utility (`useScrollUpOrTop`) that hides/reveals a top info banner on scroll.
2.  **Hero Section ([Hero.tsx](file:///c:/Users/Rishi/Downloads/carpedium_tech/components/hero/Hero.tsx)):** Uses a 3D Canvas wrapper displaying a circuit shield that converges on scroll, supporting a staggered header reveal and dual CTA buttons (*Explore Programs* and *Talk to Us*).
3.  **Trust Strip ([TrustStrip.tsx](file:///c:/Users/Rishi/Downloads/carpedium_tech/components/sections/TrustStrip.tsx)):** Highlights core high-level company stats (e.g. students trained, placement percentages, active batches) in a technical grid.
4.  **Course Grid ([CourseGrid.tsx](file:///c:/Users/Rishi/Downloads/carpedium_tech/components/sections/CourseGrid.tsx)):** Lists all 9 course domains with interactive SVG border-drawing indicators.
5.  **Why Carpediem ([WhyCarpediem.tsx](file:///c:/Users/Rishi/Downloads/carpedium_tech/components/sections/WhyCarpediem.tsx)):** A 4-column value proposition highlighting mentor ratios, project-led curriculum, and flexible schedules.
6.  **Programs Section ([Programs.tsx](file:///c:/Users/Rishi/Downloads/carpedium_tech/components/sections/Programs.tsx)):** Features the two flagship tracks: **Path A (Full-Stack Development)** and **Path B (Generative AI)**. Both tracks use sequential circuit-trace visualizer paths.
7.  **How It Works ([HowItWorks.tsx](file:///c:/Users/Rishi/Downloads/carpedium_tech/components/sections/HowItWorks.tsx)):** A clear, numbered sequence mapping the student journey from Enrollment to Placement-Readiness.
8.  **Mentors Section ([Mentors.tsx](file:///c:/Users/Rishi/Downloads/carpedium_tech/components/sections/Mentors.tsx)):** A grid showcase of cohort instructors and their real-world experience.
9.  **Outcomes Section ([Outcomes.tsx](file:///c:/Users/Rishi/Downloads/carpedium_tech/components/sections/Outcomes.tsx)):** Testimonial quote blocks and partner logo tracks.
10. **Resources ([Resources.tsx](file:///c:/Users/Rishi/Downloads/carpedium_tech/components/sections/Resources.tsx)):** Technical learning resources, cheatsheets, and articles.
11. **Contact ([Contact.tsx](file:///c:/Users/Rishi/Downloads/carpedium_tech/components/sections/Contact.tsx)):** A dual-column layout with direct office addresses/contact info on the left, and an embedded Google Form placeholder on the right.

---

## 3. Interactive & Reusable Components

The project makes extensive use of interactive and reusable components located in [components/ui](file:///c:/Users/Rishi/Downloads/carpedium_tech/components/ui/):

### Reusable UI Blocks
*   **[Button.tsx](file:///c:/Users/Rishi/Downloads/carpedium_tech/components/ui/Button.tsx):** Configurable primary/secondary action button built with Framer Motion hover scaling (`scale: 1.03`) and tap spring effects.
*   **[Card.tsx](file:///c:/Users/Rishi/Downloads/carpedium_tech/components/ui/Card.tsx):** Standard content container with surface or dashed placeholder states, supporting translate-on-hover effects.
*   **[CircuitTrace.tsx](file:///c:/Users/Rishi/Downloads/carpedium_tech/components/ui/CircuitTrace.tsx):** SVG-based animated connection trace. As the user scrolls through the programs, the path dynamically strokes from left to right, sequentially lighting up stage indicators (`Frontend → Backend → Database → Deploy`).
*   **[HiringMarquee.tsx](file:///c:/Users/Rishi/Downloads/carpedium_tech/components/ui/HiringMarquee.tsx):** An infinite horizontal marquee loop displaying hiring partner slots, which pauses on mouse hover.
*   **[QuickEnquiry.tsx](file:///c:/Users/Rishi/Downloads/carpedium_tech/components/ui/QuickEnquiry.tsx):** A persistent vertical tab (`Quick Enquiry`) fixed to the right side of the screen. Clicking it slides out a sidebar form supporting rapid contact options (Email/WhatsApp text generation).
*   **[WhatsAppButton.tsx](file:///c:/Users/Rishi/Downloads/carpedium_tech/components/ui/WhatsAppButton.tsx):** A floating action button pinned in the bottom-right corner to initiate immediate support chat.
*   **[Reveal.tsx](file:///c:/Users/Rishi/Downloads/carpedium_tech/components/ui/Reveal.tsx):** Framer Motion viewport reveal component wrapping elements in a subtle fade-and-rise transition.

### 3D Shield Scene ([ShieldScene.tsx](file:///c:/Users/Rishi/Downloads/carpedium_tech/components/hero/ShieldScene.tsx))
Built using **React Three Fiber** and **GSAP**:
*   On load, fragmented circuit pieces float scattered in 3D space with subtle idle rotation.
*   On scroll down, the fragments converge and snap together into a unified circuit shield.
*   Traces sequence from dull opacity to bright emissive glow.
*   Includes camera positioning adjustments bound to scroll progress.

---

## 4. Motion Choreography & UX Standards

The animations are split between global, scroll-jacking scrolltriggers and local micro-interactions:
1.  **GSAP ScrollTrigger & Lenis:** Used exclusively for high-precision, scroll-linked animations such as the 3D hero camera zoom/fragment assembly and the 2D programs circuit trace stroke dashboard offsets.
2.  **Framer Motion:** Reserved for micro-interactions including button click taps, cards hover lift, and fade-in scroll reveals.
3.  **Accessibility (a11y) & Motion Reduction:**
    *   Full support for `prefers-reduced-motion` media queries. When active, it disables the 3D fragmentation convergence and R3F animation, rendering a pre-assembled fallback SVG ([StaticShieldSVG.tsx](file:///c:/Users/Rishi/Downloads/carpedium_tech/components/hero/StaticShieldSVG.tsx)), stops the infinite loop marquees, and simplifies component fades.
    *   Focus indicators (`:focus-visible`) are styled consistently to support keyboard-only navigation.
