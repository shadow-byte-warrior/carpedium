# Carpediem Tech Innovations — Website Build Brief

> **For Claude Code**: This is a from-scratch, original website build for a real training-and-services company (IT Services, Software Development, Full-Stack & Gen AI Training) based in Coimbatore, India. This is NOT a clone of any existing website — it's an original design built to the same ambition level as top awwwards-tier immersive sites (reference: business.nrg.com/campaigns/build-your-data-center for the 3D-scroll interaction quality bar). Follow this brief section by section. Build incrementally: scaffold → hero → sections → polish → responsive/a11y pass.

---

## 1. Brand Foundation

**Company**: Carpediem Tech Innovations
**What they do**: IT Services, Software Development & Professional Training — Web Development, App Development, AI & ML, Cybersecurity, IoT, Cloud Computing, Digital Marketing. Strong current focus: **Full-Stack Development** and **Generative AI** training tracks for freshers, students, and career-switchers.
**Tagline direction**: Something that plays on the name itself — "Carpe Diem" (seize the day) fused with "seize the stack" / "seize your build" energy. Do not force a pun if it reads corny — a confident, direct line works too (e.g. "Learn what ships. Ship what's learned.").
**Logo**: Circuit-etched shield mark on a dark circular badge, sage-green header block, teal/cyan metallic linework, condensed bold wordmark "CARPE·DIEM TECH INNOVATIONS" in teal. The shield + circuit motif is the visual DNA of the entire site — echo it in the hero, not just the logo mark.

## 2. Design Tokens (derived from the logo — do not substitute defaults)

```
--color-obsidian:      #0A1412   /* primary background, near-black with a green cast */
--color-obsidian-2:    #0F1B18   /* secondary surface, cards/panels */
--color-sage:          #7C9186   /* logo's header-block green — use for quiet section dividers, not text */
--color-teal:          #3FA9A0   /* primary brand teal — shield metal color */
--color-teal-bright:   #6EE7DD   /* glow/accent state — hover, active traces, particle highlights */
--color-off-white:     #EDECE3  /* primary text on dark */
--color-off-white-dim: #A8B0AC  /* secondary/muted text */

Gradient (hero atmosphere): radial from --color-teal at 8% opacity into --color-obsidian
Accent glow: --color-teal-bright used ONLY for interactive/active states, never static decoration
```

**Typography**
- Display: a condensed, technical grotesk with some personality — **Space Grotesk** or **General Sans** (bold/700 weight for headlines). Avoid generic Inter-only setups.
- Body: **Inter** or **IBM Plex Sans** at 400/500, generous line-height (1.6+) for readability against the dark background.
- Utility/mono (labels, eyebrows, stats, code-like flourishes — this is where the "tech" in the brand lives): **JetBrains Mono** or **IBM Plex Mono**, small caps, wide letter-spacing (0.08–0.12em), used for section eyebrows like `// 01 CURRICULUM` or `$ carpediem --init`.

**Signature element**: A circuit-board shield that **assembles itself from scattered trace-fragments as the user scrolls into the hero**, then stays "alive" in the background (subtle pulse along traces) as a persistent ambient presence through the rest of the page — echoing the actual logo mark rather than an arbitrary 3D object. This is the one big swing; keep everything else disciplined around it.

## 3. Tech Stack

- **Next.js 14+ (App Router)** + TypeScript
- **React Three Fiber** + `drei` for the 3D circuit-shield hero scene
- **GSAP + ScrollTrigger** for scroll-driven choreography (pin sections, reveal sequences, camera moves tied to scroll progress)
- **Lenis** for smooth-scroll (required for the GSAP ScrollTrigger + 3D camera sync to feel right)
- **Tailwind CSS** for layout/utility styling, tokens above wired into `tailwind.config.ts` theme
- **Framer Motion** for micro-interactions (hover states, card reveals) — reserve GSAP for the big scroll-orchestrated moments, Framer Motion for local component polish
- Deploy target: static export or Vercel-compatible — no backend needed for v1 (contact form can post to a serverless function or a form service like Formspree)

## 4. Site Map & Section-by-Section Spec

### 4.1 Hero
- Full-viewport 3D scene: fragmented circuit-shield pieces slowly drift/rotate in space on load (ambient, not yet assembled)
- As the user scrolls down ~1 viewport height (pinned section), the fragments **converge and snap into the complete shield**, traces illuminate in teal sequence (like a circuit powering on), camera pulls back to reveal the full mark
- Headline appears mid-assembly, staggered word-by-word: e.g. "Build the stack. / Ship the future." (write final copy to fit brand voice — direct, technical, no filler)
- Sub-line: one sentence stating what Carpediem actually does (Full-Stack + Gen AI training, real projects, Coimbatore-based)
- CTA pair: primary "Explore Programs" (scrols to Programs section), secondary "Talk to Us" (scrolls to Contact)
- Eyebrow above headline in mono type: `// CARPEDIEM TECH INNOVATIONS`

### 4.2 Why Carpediem (quiet section, right after the loud hero)
- 3–4 column stat/value row: e.g. hands-on project count, mentor-to-student ratio, hiring partner count, batch format flexibility
- Keep numbers honest/placeholder-labeled — mark with `[TODO: confirm real number]` comments in the copy so the real company can fill in verified stats rather than inventing false claims
- No numbered markers (01/02/03) unless the four items are genuinely sequential — they aren't, so use icon + label + one-line description instead

### 4.3 Programs (the core commercial section)
Two primary tracks, presented as distinct "paths" rather than a generic card grid:

**Path A — Full-Stack Development**
- Frontend → Backend → Database → Deployment, shown as a literal left-to-right circuit trace that lights up segment by segment on scroll (ties back to the signature element)
- Tech chips: HTML/CSS/JS, React, Node.js, REST APIs, SQL/MongoDB, Git, Cloud deploy
- One real-project callout (e.g. "Build a full production app from scratch, not a toy demo")

**Path B — Generative AI**
- Prompt Engineering → LLM Fundamentals → RAG/Agents → Deployment, same circuit-trace treatment, teal-to-brighter-teal gradient to differentiate from Path A
- Tech chips: Python, LangChain, Vector DBs, OpenAI/Hugging Face APIs, n8n/agent orchestration, prompt engineering
- One real-project callout (e.g. "Ship an AI agent that does something real, not a chatbot demo")

Each path: expandable/scroll-revealed curriculum outline, batch format (weekday/weekend), and a "Who this is for" line (freshers / career switchers / working professionals) — written in plain, specific language per the writing guidance below, not marketing fluff.

### 4.4 How It Works (process, genuinely sequential — numbered markers ARE appropriate here)
Real numbered steps: Enroll → Learn (cohort + mentor) → Build (real projects) → Get Placement-Ready (resume, mock interviews, referrals). Keep to 4 steps max.

### 4.5 Mentors / Trainers
Simple, credible grid — photo placeholder, name placeholder, one-line real-world credibility statement (e.g. "X years building production systems at ___"). Mark all names/photos as `[TODO: replace with real mentor data]`.

### 4.6 Placements / Outcomes
- Honest framing only — do not invent specific company logos or salary figures. Use structure like: "Where our learners work" with a `[TODO: insert real hiring partner logos once confirmed]` placeholder grid, and a real testimonial quote block (2–3 short quotes, marked as placeholders for the company to swap in verified ones)

### 4.7 Contact / CTA
- Two-column: left = direct value statement + Carpediem's real contact info (carpediemtechinnovations@gmail.com, +91 7339512373 — verify before launch), right = simple form (Name, Email, Interest: Full-Stack / Gen AI, Message)
- Ambient circuit-shield glow persists faintly in the background here too, dimmed to not compete with the form

### 4.8 Footer
- Logo mark (small, static version — no animation here, let it rest)
- Quick links, social/LinkedIn (`linkedin.com/in/carpediem-tech-innovations`), location (Coimbatore, Tamil Nadu), copyright line

## 5. Motion Choreography Rules

- The **shield assembly** in the hero is the one orchestrated "big moment" — everything else should be quieter: scroll-reveals (fade + slight rise, 20–30px translate, staggered by 60–100ms per item), hover states on cards (subtle scale 1.02 + teal glow border), no gratuitous parallax layering beyond the hero
- Respect `prefers-reduced-motion`: fall back to a static assembled shield image/SVG and simple fade-ins, no forced scroll-jacking, if the user has this preference set
- Circuit traces animate via SVG `stroke-dashoffset` or Three.js line-drawing shaders — pick one approach and use it consistently across hero + Programs section for visual cohesion

## 6. Writing Rules (apply throughout)

- Write from the learner's side: name what they'll be able to do, not what the curriculum "covers"
- Active voice, plain verbs: "Build a production app" not "Comprehensive coverage of application development methodologies"
- No invented statistics, no invented company names in placements, no invented testimonials presented as real — mark every unverified claim with an inline `[TODO: verify]` comment in the source so Carpediem's team catches it before launch
- Keep the mono/eyebrow labels functional (they signpost section identity) not decorative

## 7. File Structure

```
/app
  /page.tsx                 → assembles all sections
  /layout.tsx                → fonts, metadata, Lenis provider
  /globals.css                → Tailwind base + custom properties from tokens above
/components
  /hero/
    ShieldScene.tsx           → R3F canvas, circuit-shield assembly logic
    Hero.tsx                  → headline, CTA, wraps ShieldScene
  /sections/
    WhyCarpediem.tsx
    Programs.tsx               → Path A + Path B, circuit-trace SVG component
    HowItWorks.tsx
    Mentors.tsx
    Outcomes.tsx
    Contact.tsx
  /ui/
    CircuitTrace.tsx           → reusable animated trace component (shared by hero + Programs)
    Button.tsx
    SectionEyebrow.tsx
/lib
  /scroll.ts                  → Lenis + GSAP ScrollTrigger setup/sync
  /theme.ts                   → exported design tokens for reuse in R3F materials
/public
  /logo/                      → place the uploaded logo asset here (carpediem-mark.png + a cleaned SVG version if possible)
tailwind.config.ts
```

## 8. Build Order (do this incrementally, don't attempt everything at once)

1. Scaffold Next.js + Tailwind + fonts, wire design tokens into `tailwind.config.ts` and `globals.css`
2. Build static (non-animated) layout for all sections top to bottom with real copy — get information architecture right before adding motion
3. Add Lenis smooth scroll + GSAP ScrollTrigger wiring
4. Build the `CircuitTrace` component (SVG-based) and prove it works in isolation (e.g. in the Programs section first — simpler 2D case)
5. Build the hero `ShieldScene` (R3F) — start with the assembled static shield, then add the scroll-driven fragment/converge animation last, since it's the highest-risk piece
6. Polish: hover states, stagger timing, reduced-motion fallback, mobile breakpoints (the 3D hero especially needs a lighter/simpler mobile treatment — consider a pre-baked animated SVG instead of full R3F on small viewports for performance)
7. Accessibility pass: keyboard focus states, alt text, color contrast check on all text-on-dark combinations
8. Lighthouse/perf pass, especially around the Three.js bundle size

---

**Reminder to Claude Code**: all placement stats, mentor bios, testimonials, and hiring-partner names in this brief are structural placeholders (`[TODO]`) — do not fabricate specific numbers or company names as if verified. Carpediem's team fills those in before launch.
