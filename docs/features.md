# Design OS - Full Feature Reference

> Complete documentation of all editable sections, theme controls, visual editor capabilities, and admin panel features.

---

## Tech Stack and Libraries

### Core Framework
| Library | Version | Purpose |
|---|---|---|
| react | ^19.2.7 | UI framework |
| react-dom | ^19.2.7 | DOM rendering |
| typescript | ~6.0.2 | Type safety |
| vite | ^8.1.1 | Build tool and dev server |

### Routing and State
| Library | Version | Purpose |
|---|---|---|
| react-router-dom | ^7.18.1 | Client-side routing |
| zustand | ^5.0.14 | Global state (ThemeStore, NodeStore, EditorStore) |

### Styling
| Library | Version | Purpose |
|---|---|---|
| tailwindcss | ^4.3.2 | Utility CSS framework |
| @tailwindcss/vite | ^4.3.2 | Vite plugin for Tailwind |
| tailwind-merge | ^3.6.0 | Class conflict resolution |
| clsx | ^2.1.1 | Conditional class names |

### Animation and Motion
| Library | Version | Purpose |
|---|---|---|
| framer-motion | ^12.42.2 | React animation primitives |
| gsap | ^3.15.0 | ScrollTrigger, timeline animations |
| @studio-freight/lenis | ^1.0.42 | Smooth scroll engine |

### 3D and Visual
| Library | Version | Purpose |
|---|---|---|
| three | ^0.185.1 | WebGL 3D engine |
| @react-three/fiber | ^9.6.1 | React renderer for Three.js |
| @react-three/drei | ^10.7.7 | Three.js helpers and utilities |

### Drag and Drop
| Library | Version | Purpose |
|---|---|---|
| @dnd-kit/core | ^6.3.1 | Core drag-and-drop |
| @dnd-kit/sortable | ^10.0.0 | Sortable drag lists |
| @dnd-kit/utilities | ^3.2.2 | DnD helper utilities |

### Forms and Validation
| Library | Version | Purpose |
|---|---|---|
| react-hook-form | ^7.81.0 | Form state management |
| @hookform/resolvers | ^5.4.0 | Schema validation adapter |
| zod | ^4.4.3 | Schema validation |

### UI Utilities
| Library | Version | Purpose |
|---|---|---|
| lucide-react | ^1.23.0 | Icon library |
| react-icons | ^5.7.0 | Extended icon sets |
| react-hot-toast | ^2.6.0 | Toast notifications |
| react-helmet-async | ^3.0.0 | Head/SEO meta management |

### Backend and Data
| Library | Version | Purpose |
|---|---|---|
| @supabase/supabase-js | ^2.110.1 | Database, Auth, Storage |

### Dev Dependencies
| Library | Version | Purpose |
|---|---|---|
| @vitejs/plugin-react | ^6.0.3 | Fast Refresh |
| oxlint | ^1.71.0 | Linter |
| vercel | ^54.21.1 | Deployment |

---

## Theme System

### ThemeState Interface
```ts
interface ThemeState {
  colors: {
    primary: string;      // Accent / CTA color
    background: string;   // Page background
    surface: string;      // Cards, panels, inputs
    text: string;         // Body text
    muted: string;        // Secondary / placeholder text
    border: string;       // Dividers, outlines
    accent?: string;      // Optional secondary accent
  };
  typography: {
    fontFamily: string;   // Body font CSS stack
    headingFont: string;  // Heading font CSS stack
    bodySize: string;     // e.g. 16px
    headingSize: string;  // e.g. 48px
    bodyWeight: string;   // e.g. 400
    headingWeight: string;// e.g. 700
  };
  layout: {
    radius: string;
    borderStyle?: string;
    animationStyle?: 'joyrush'|'k95'|'juliencalot'|'depoluxe'|'monolog'|'hildenkaira'|'radian'|'avantgarde'|'cyber'|'metropolitan'|'default';
    cursorStyle?: 'dot'|'bubble'|'invert'|'crosshair'|'none'|'default';
    navbarStyle?: 'capsule'|'minimal'|'karolbinkowski'|'pelizzari'|'vividmotion'|'studiomodular'|'default';
    cardStyle?: 'minimal'|'editorial'|'karolbinkowski'|'pelizzari'|'russellnumo'|'vividmotion'|'glass'|'gradient'|'magazine'|'bento'|'masonry'|'flip'|'magnetic'|'default';
    heroStyle?: 'karolbinkowski'|'pelizzari'|'russellnumo'|'vividmotion'|'default';
    footerStyle?: 'karolbinkowski'|'pelizzari'|'russellnumo'|'studiomodular'|'default';
    scrollStyle?: 'vertical'|'horizontal'|'none';
    projectsScroll?: 'grid'|'horizontal'|'vertical'|'masonry'|'bento';
    blogScroll?: 'grid'|'horizontal'|'masonry';
  };
}
```

### CSS Variable Tokens (injected on html element)
| CSS Variable | Source Field | Notes |
|---|---|---|
| --color-primary | colors.primary | Main accent |
| --color-background | colors.background | |
| --color-surface | colors.surface | |
| --color-text | colors.text | |
| --color-muted | colors.muted | |
| --color-border | colors.border | |
| --color-accent | colors.primary | Legacy alias |
| --color-bg | colors.background | Legacy alias |
| --color-ink | colors.text | Legacy alias |
| --color-ink-soft | colors.muted | Legacy alias |
| --color-line | colors.border | Legacy alias |
| --font-primary | typography.fontFamily | |
| --font-sans | typography.fontFamily | |
| --font-heading | typography.headingFont | |
| --font-display | typography.headingFont | |
| --font-size-base | typography.bodySize | |
| --font-size-heading | typography.headingSize | |
| --font-weight-base | typography.bodyWeight | |
| --font-weight-heading | typography.headingWeight | |
| --radius-base | layout.radius | |

---

## Theme Presets (16 Built-in)

| Preset Name | Source Site | Primary | Background | Style |
|---|---|---|---|---|
| Default | - | #2563EB | #FAFAFA | Clean blue |
| Joy Rush | drinkjoyrush.com | #FF5C8A | #FFF3F6 | Playful pink |
| K95 Minimal | k95.it | #0D0D0D | #F4F4F4 | B+W minimal |
| Julien Calot Art | juliencalot.com | #FF2A54 | #0B0A0F | Dark editorial |
| Depoluxe | depoluxe.xyz | #D4AF37 | #0E0F11 | Gold luxury dark |
| Monolog Editorial | bymonolog.com | #4D4137 | #FAF6F0 | Warm editorial |
| Hilden Kaira | hildenkaira.fi | #2B4A3F | #F9F8F6 | Forest minimal |
| Radian | rideradian.com | #CCFF00 | #050505 | Neon-on-black |
| Avant-Garde | Awwwards | #8B5CF6 | #0B0914 | Purple dark |
| Retro Cyber | Awwwards | #00FF66 | #080C0A | Green terminal |
| Metropolitan Luxe | Awwwards | #AF956B | #0A0C10 | Gold dark luxe |
| Pelizzari Studio | pelizzari.com | #D63E2E | #F7F5F0 | Red editorial light |
| Karol Binkowski | karolbinkow.ski | #E0FD60 | #0F0F0F | Neon brutalist |
| Russell Numo | russellnumo.nl | #000000 | #EEEEEE | Monochrome grid |
| Studio Modular | studiomodular.be | #0055FF | #FFFFFF | Corporate blue |
| Haoqi Design | haoqi.design | #FF4D00 | #111111 | Orange dark tech |

---

## Font System

### Theme Studio Fonts - Grouped by Reference Site (26 fonts)

| Group / Site | Font Name | Category | Role |
|---|---|---|---|
| Joy Rush (drinkjoyrush.com) | Fredoka | Display | Heading |
| Joy Rush | Sora | Sans | Body |
| Joy Rush | Baloo 2 | Display | Both |
| K95 (k95.it) | Space Mono | Mono | Both |
| K95 | Archivo | Sans | Body |
| Julien Calot | Anton | Display | Heading |
| Julien Calot | Fraunces | Serif | Heading |
| Julien Calot | Space Grotesk | Sans | Body |
| Depoluxe | Cinzel | Serif | Heading |
| Depoluxe | Cormorant Garamond | Serif | Body |
| Depoluxe | EB Garamond | Serif | Body |
| Monolog | Instrument Serif | Serif | Heading |
| Monolog | Cormorant Garamond | Serif | Heading |
| Monolog | Archivo | Sans | Body |
| Hilden and Kaira | Playfair Display | Serif | Heading |
| Hilden and Kaira | Outfit | Sans | Body |
| Hilden and Kaira | DM Sans | Sans | Body |
| Radian | Anton | Display | Heading |
| Radian | Plus Jakarta Sans | Sans | Body |
| Radian | JetBrains Mono | Mono | Body |
| Awwwards Extras | Syne | Sans | Heading |
| Awwwards Extras | Unbounded | Sans | Heading |
| Awwwards Extras | JetBrains Mono | Mono | Body |
| Awwwards Extras | Playfair Display | Serif | Heading |
| Awwwards Extras | Inter | Sans | Body |
| Awwwards Extras | Space Grotesk | Sans | Both |

### Visual Editor Font Catalog (100+ Google Fonts)

Sans-Serif (40 fonts): Inter, Roboto, Open Sans, Lato, Montserrat, Poppins, Raleway, Nunito, Nunito Sans, Work Sans, Rubik, Mulish, Manrope, DM Sans, Space Grotesk, Archivo, Outfit, Sora, Jost, Karla, Barlow, Josefin Sans, Quicksand, Cabin, Titillium Web, Fira Sans, PT Sans, Source Sans 3, Noto Sans, Heebo, Assistant, Red Hat Display, Public Sans, Figtree, Plus Jakarta Sans, Lexend, Urbanist, Epilogue, Kanit, Oxygen

Serif (25 fonts): Playfair Display, Merriweather, Lora, PT Serif, Noto Serif, Roboto Slab, Bitter, Crimson Text, Cormorant Garamond, EB Garamond, Libre Baskerville, Source Serif 4, Zilla Slab, Domine, Frank Ruhl Libre, Spectral, Cardo, Arvo, Bree Serif, Vollkorn, Alegreya, Newsreader, Fraunces, DM Serif Display, Josefin Slab

Display (22 fonts): Bebas Neue, Anton, Righteous, Comfortaa, Pacifico, Lobster, Abril Fatface, Fjalla One, Alfa Slab One, Bungee, Staatliches, Teko, Chakra Petch, Orbitron, Russo One, Bangers, Fredoka, Baloo 2, Secular One, Rowdies, Paytone One, Passion One

Handwriting (12 fonts): Dancing Script, Caveat, Satisfy, Great Vibes, Sacramento, Shadows Into Light, Indie Flower, Permanent Marker, Kalam, Patrick Hand, Amatic SC, Courgette

Monospace (11 fonts): Fira Code, JetBrains Mono, Source Code Pro, IBM Plex Mono, Space Mono, Roboto Mono, Inconsolata, Ubuntu Mono, Overpass Mono, DM Mono, Red Hat Mono

---

## Design OS Studio - Visual Editor

Path: /admin/studio

### Studio Layout (3-column)

Left Panel (52 wide) | Center Canvas (iframe) | Right Panel (72 wide)

### Left Panel Features (collapsible)
- Section jump navigation - click to scroll iframe to: Hero, About, Skills, Experience, Projects, Blog, Footer
- Quick Preset access - first 8 presets with 3-dot color preview
- Active Palette strip - live 6-color swatch of current theme

### Center Canvas Features
- Live iframe of the public site at /?preview=1
- Device switcher: Desktop (full width), Laptop (1280px), Tablet (834px), Mobile (390px)
- Mobile frame with realistic notch and device chrome
- Refresh preview button
- Publish button - saves theme to Supabase with animated success toast
- Status bar showing: device width, active preset name

### Right Panel - 4 Tabs

---

### Tab 1: Theme Panel
Inner sub-tabs: Colors / Type / Effects

#### Colors Sub-tab
- Live mini-site preview rendering navbar + hero + 3 cards with active palette
- Collapsible Color Presets grid - all 16 presets as 2-col clickable cards with dot preview
- 6 editable color token rows:
  - Accent (primary) - CTA buttons, links, highlights
  - Background - page background
  - Surface - cards, panels, inputs
  - Text - body text color
  - Muted - secondary / placeholder text
  - Border - dividers, outlines
- Each row: color picker swatch (click = native color picker) + hex text field (click to edit inline, Enter/Escape to commit/cancel)
- Reset to Default button

#### Type Sub-tab
- Heading Font grouped select (26 site fonts in optgroups)
  - Live preview "Hello World" with current font + weight
  - Weight selector: 400 / 500 / 600 / 700 / 800 / 900
  - Size free-text input (e.g. 48px)
- Body Font grouped select (same 26 site fonts)
  - Live preview "The quick brown fox jumps over the lazy dog."
  - Weight selector: 300 / 400 / 500 / 600 / 700
  - Size free-text input (e.g. 16px)

#### Effects Sub-tab
- Animation Package select (11 options)
- Custom Cursor select (6 options)
- Corner Radius: 6 quick-pick buttons (0px / 4px / 8px / 1rem / 1.5rem / 2rem) + free-text input
- Projects Scroll layout: Grid / Horizontal / Vertical / Masonry / Bento (5 button group)

---

### Tab 2: Structure Panel
Each setting updates the live preview in real time.

| Section | Options |
|---|---|
| Navbar | Standard Full Width, Floating Capsule, Minimal Text Only, Brutalist Split, Elegant Transparent, Glassy Minimal, Side Nav Left |
| Hero | Standard Parallax, Massive Split Typography, Editorial Cinematic, Monospace Grid, Soft Glassy |
| Project Cards | 3D Tilt, Glass/Frosted, Vivid Gradient, Magazine/Editorial, Bento Grid Tiles, Masonry Pinterest, Flip Card, Magnetic Spring, Minimal Flat, Editorial Image, Neon Brutalist, Cinematic Serif, Monospace Grid, Smooth Glassy |
| Projects Layout | Standard Grid, Horizontal Carousel, Vertical Track, Masonry Columns, Bento Grid |
| Blog Layout | Horizontal Carousel, 3-Column Grid, Masonry Columns |
| Footer | Standard Wave, Brutalist Grid, Elegant Serif, Monospace Table, Asymmetrical Left |
| Scroll Ticker | Horizontal Ticker Marquee, Vertical Stacking Marquee, No Marquee |

---

### Tab 3: Motion Panel (ScrollStudio)
All settings saved to localStorage (key: design-os-motion). Apply on next page reload.

#### Scroll Mode
| Setting | Control | Options |
|---|---|---|
| Page Scroll Type | Toggle | Native / Smooth / Snap |
| Section Transition | Toggle | Fade / Slide / None |

#### Parallax
| Setting | Control | Options |
|---|---|---|
| Parallax Enabled | Toggle | On / Off |
| Parallax Intensity | Slider | 0-100% (conditional on enabled) |

#### Ticker / Marquee
| Setting | Control | Options |
|---|---|---|
| Speed | Slider | 5-60s |
| Pause on Hover | Toggle | On / Off |

#### Reveal Animations
| Setting | Control | Options |
|---|---|---|
| Reveal Style | Select | Slice Reveal, Fade Up, Scale In, Blur In, Stagger Words, Clip Path, None |
| Duration | Slider | 100-2000ms |
| Delay Stagger | Slider | 0-300ms |
| Easing Curve | Select | ease-out, ease-in-out, spring, linear, back-out, elastic |

#### Project Slider
| Setting | Control | Options |
|---|---|---|
| Slider Mode | Select | Grid, Horizontal Carousel, Vertical Stack, 3D Coverflow, Film Strip, Fade, Stack Cards, Masonry, Bento |
| Slide Speed | Slider | 100-1500ms |
| Autoplay | Toggle | On / Off |
| Autoplay Delay | Slider | 1000-10000ms (conditional) |

#### Mouse Interactions
| Setting | Control | Options |
|---|---|---|
| Magnetic Buttons | Toggle | On / Off |
| Tilt Cards | Toggle | On / Off |
| Hover Lift | Toggle | On / Off |

---

### Tab 4: AI Inspiration Scraper (ScraperPanel)
Extracts design metadata from any public website via CORS proxy.

- URL input field with Enter-to-submit
- Analyze button (loading spinner while processing)
- Quick link shortcuts: pelizzari.com, karolbinkow.ski, haoqi.design, vividmotion.co, tol.is, pxpush.com

Extracted and displayed:
- Detected Colors: up to 4 palettes (bg + accent + text), each with Apply button
- Detected Fonts: heading + body pair, with Apply button
- Detected Components: Navbar, Hero Section, Grid/Masonry Cards, Flex Layout, Footer, Contact Form, Slider/Carousel, Video Background, 3D Scene (Three.js), Custom Cursor
- Design metadata table: Navbar type, Hero layout, Cards style, Scroll effect, Animation style, Border radius
- Apply All button: applies color[0] + fonts[0] + borderRadius in one click

Note: Only CSS metadata extracted. No images, logos, or copyrighted assets copied.

---

## Animation Presets (11)

| Value | Label | Source / Description |
|---|---|---|
| default | None - clean | No site effects |
| joyrush | Joy Rush | drinkjoyrush.com - top marquee, lowercase, sticker buttons |
| k95 | K95 | k95.it - letter-roll nav hover, uppercase grid |
| juliencalot | Calot | juliencalot.com - 000% preloader, film grain |
| depoluxe | Depo Luxe | depoluxe.xyz - roman-numeral index, cinematic |
| monolog | Monolog | bymonolog.com - word rotator, giant footer brand |
| hildenkaira | Hilden and Kaira | hildenkaira.fi - letter-stagger headline |
| radian | Radian | rideradian.com - chapter scroll nav 01/06 |
| avantgarde | Avant-Garde | Overlap and outline type |
| cyber | Retro Cyber | Scanlines and glitch |
| metropolitan | Metropolitan Luxe | Slow gold fades |

Applied as body class: awwwards-preset-{value}

---

## Cursor Presets (6)

| Value | Style | Inspired By |
|---|---|---|
| default | System default | - |
| dot | Dot cursor | k95.it / rideradian.com |
| bubble | Bubble ring | drinkjoyrush.com |
| invert | Invert blend | juliencalot.com |
| crosshair | Crosshair | depoluxe.xyz |
| none | Hidden cursor | - |

---

## Admin Panel

Layout: AdminLayout.jsx - sidebar navigation + main content area

### Admin Pages and Routes

| Page | Route | Description |
|---|---|---|
| Dashboard | /admin | Stats KPI cards overview |
| Projects | /admin/projects | Full CRUD for portfolio projects |
| Blogs | /admin/blogs | Full CRUD for blog posts |
| Experiences | /admin/experiences | Full CRUD for work timeline |
| Inbox | /admin/inbox | Read contact form messages |
| Settings | /admin/settings | Site-wide general settings |
| Studio | /admin/studio | Design OS Visual Editor |
| Canvas | /admin/canvas | Visual page builder |
| Login | /admin/login | Supabase auth gate |

---

### Dashboard (/admin)
- 4 KPI metric cards with icons and sparkline bars:
  - Total Projects (FolderOpen icon, blue)
  - Published Blogs (PenTool icon, purple)
  - Experiences (Briefcase icon, indigo)
  - Contact Messages (Mail icon, orange)
- Live Supabase counts
- Trend percentage vs last month
- Click-through navigation to each admin section

---

### Settings (/admin/settings)
Organized in collapsible SectionCard components, validated with Zod schemas.

#### Welcome / Splash Section
| Field | Input Type | Validation |
|---|---|---|
| enabled | Toggle (eye icon) | boolean |
| name | Text | required |
| quote | Text | required |
| inviteTitle | Text | required |
| inviteSubtitle | Text | required |

#### Footer Section
| Field | Input Type | Validation |
|---|---|---|
| name | Text | required |
| tagline | Text | optional |
| github | URL | valid URL or empty |
| linkedin | URL | valid URL or empty |
| email | Email | valid email or empty |
| copyright | Text | optional |
| designYear | Text | optional |

#### Navbar Section
| Field | Input Type | Validation |
|---|---|---|
| ctaLabel | Text | required |
| ctaHref | Text | required |

#### Section Labels
| Field | Input Type | Validation |
|---|---|---|
| projects.label | Text | optional |
| projects.title | Text | required |
| projects.subtitle | Text | optional |
| blog.label | Text | optional |
| blog.title | Text | required |

#### Branding
| Field | Input Type | Notes |
|---|---|---|
| logoUrl | ImageUpload | Supabase Storage |
| faviconUrl | ImageUpload | Supabase Storage |

#### Theme (Legacy Quick Editor in Settings)
- 6 color pickers: Accent, Background, Surface, Text, Muted, Border
- Font family selector
- Saved custom themes: save current, apply saved, delete saved (localStorage)
- Preset gallery: click to apply any of the 16 presets

---

### Settings Sub-pages (src/pages/admin/settings/)

#### HeroSettings.jsx
- Profile photo (ImageUpload, Supabase Storage)
- Name field
- Title / subtitle fields
- CTA button: label + href
- Social links: GitHub, LinkedIn, Twitter, etc.
- Rotating animated text words (add / remove)
- Bio / description textarea

#### AboutSettings.jsx
- Profile description textarea
- Profile image (ImageUpload)
- Stats grid: years of experience, projects, clients, etc.
- SQL card text / skill showcase
- Availability / open-to-work toggle

#### SkillsSettings.jsx
- Skill categories list (DnD sortable)
- Per-category: icon, label, skill tags
- Add / remove individual skill tags
- Certifications subsection

#### CertificationsSettings.jsx
- List of certifications (add / edit / delete)
- Per-cert fields: name, issuer, issue date, credential ID, URL
- Badge image upload

#### ContactSettings.jsx
- Contact email
- Phone number
- Location text
- Social platform links

#### SeoSettings.jsx
- Page title
- Meta description
- Open Graph image (ImageUpload)
- Keywords
- Canonical URL

#### ThemeSettings.jsx
- Quick link to Design OS Studio
- Legacy color settings panel

---

## Component Library (Visual Thumbnails)

Located in Studio view. Click thumbnails to apply style instantly.

### Cards Tab (14 styles)
| Value | Label | Description |
|---|---|---|
| default | 3D Tilt | Perspective tilt on hover |
| glass | Glass | Glassmorphism with blur + glow |
| gradient | Gradient | Vivid rotating color gradient |
| magazine | Magazine | Feature image + text side layout |
| bento | Bento | Tall/wide alternating tiles |
| masonry | Masonry | Variable height column flow |
| flip | Flip | 3D flip reveals details on back |
| magnetic | Magnetic | Spring-scale hover with glow |
| minimal | Minimal | Clean outlines, no shadow |
| editorial | Editorial | Image-dominant with overlay |
| karolbinkowski | Brutalist | Bold borders + neon accent |
| pelizzari | Cinematic Serif | Tall portrait, serif italic |
| russellnumo | Monospace Grid | Technical, monospace table |
| vividmotion | Glassy | Translucent glass look |

### Navbars Tab (7 styles)
Standard, Capsule, Minimal, Brutalist, Transparent, Glass, Sidebar

### Sections Tab (8 sections, click to scroll preview)
Hero - Parallax (3D scene + headline)
About - Bento (Profile + SQL card + stats)
Skills - Grid (Category cards + certs)
Timeline (Vertical experience list)
Projects - Grid (Card grid / carousel)
Blog - 3-Col (Article cards)
Contact Form (Email form + socials)
Footer (Name + links + copy)

### Footers Tab (5 styles)
Standard, Brutalist, Elegant, Grid Table, Dark Split

---

## Public Site Sections

### Hero
- Three.js / React Three Fiber 3D scene (Scene3D.jsx)
- Animated headline with rotating text words
- Parallax depth layers
- Profile photo with magnetic hover
- Primary + secondary CTA buttons
- Social link icon row
- Scroll-down indicator

### About
- Bento-grid layout (About.jsx)
- Profile card with bio
- SQL-style skill showcase card
- Animated counter stats
- Availability badge

### Skills
- Category cards with icons and skill tags (Skills.jsx)
- Certifications carousel
- Drag-sortable categories (via admin)

### Timeline / Experience
- Vertical alternating timeline (Timeline.jsx)
- Company, role, duration, description per entry
- GSAP scroll-triggered reveal animations

### Projects
- Multiple layouts: grid, horizontal carousel, masonry, bento, vertical (ProjectCard.jsx)
- Cover image, title, tech stack tags, GitHub and live links
- All card style variants

### Blog
- Horizontal carousel, grid, or masonry (BlogCard.jsx)
- Cover, title, date, read time, excerpt, tags

### Contact
- React Hook Form + Zod validated (ContactForm.jsx)
- Name, email, subject, message fields
- Supabase insert to contact_messages
- react-hot-toast success/error feedback

### Navbar (Navbar.jsx)
- 7 style presets
- Lenis smooth scroll on nav links
- Active section indicator
- Configurable CTA button label and link
- Logo image support

### Footer
- 5 style presets
- Social links, copyright, back-to-top

---

## Developer Utilities

### Zustand Stores
| Store File | State / Actions |
|---|---|
| src/theme/store.ts | theme, setTheme, updateColors, updateTypography, updateLayout, applyPreset |
| src/store/useNodeStore.ts | Canvas visual editor nodes |
| src/store/useEditorStore.ts | Canvas editor UI state (selected, mode) |

### Context Providers
| Provider | File | Purpose |
|---|---|---|
| ContentProvider | src/context/ContentProvider.jsx | Fetches all Supabase content, exposes via useContent() |
| ThemeProvider | src/theme/ThemeProvider.tsx | Applies CSS vars, handles Studio iframe postMessage |

### PostMessage Protocol (Studio iframe bridge)
| Message Type | Direction | Data |
|---|---|---|
| THEME_STUDIO_READY | Preview to Studio | {} - iframe signals readiness |
| SYNC_THEME | Studio to Preview | { theme: ThemeState } - live push |
| PREVIEW_SCROLL | Studio to Preview | { anchor: string } - scroll to section |

### Admin UI Reusable Components
| Component | File | Notes |
|---|---|---|
| AdminLayout | components/admin/AdminLayout.jsx | Sidebar shell |
| AdminRoute | components/admin/AdminRoute.jsx | Auth guard |
| ConfirmModal | components/admin/ConfirmModal.jsx | Delete dialog |
| Modal | components/admin/Modal.jsx | Generic modal |
| TextField, Toggle | components/admin/ui/FormInputs.jsx | Form primitives |
| ImageUpload | components/admin/ui/ImageUpload.jsx | Supabase Storage upload |
| SaveActionPanel | components/admin/ui/SaveActionPanel.jsx | Sticky save/discard bar |
| SectionCard | components/admin/ui/SectionCard.jsx | Collapsible section |
| PreviewPanel | components/admin/preview/PreviewPanel.jsx | Live site preview sidebar |
| useSiteSettings | components/admin/hooks/useSiteSettings.js | Load/save to Supabase settings |

---

## Supabase Tables

| Table | Purpose |
|---|---|
| projects | Portfolio project entries |
| blogs | Blog post entries |
| experiences | Work timeline entries |
| contact_messages | Contact form submissions |
| site_settings | All site/theme/settings (keyed by section name) |

---

## Auth

- Supabase Auth (email + password)
- AdminRoute.jsx guards all /admin/* routes
- Redirect to /admin/login if unauthenticated
- Session persistence via supabase-js

---

## Directory Structure

```
src/
  components/
    admin/
      hooks/         useSiteSettings.js
      preview/       PreviewPanel.jsx, PreviewContext.jsx, usePreviewSync.js
      ui/            FormInputs.jsx, ImageUpload.jsx, SaveActionPanel.jsx, SectionCard.jsx
      AdminLayout.jsx
      AdminRoute.jsx
      ConfirmModal.jsx
      Modal.jsx
    editor/          EditorCanvas.tsx, InspectorPanel.tsx, ThemePanel.tsx
    About.jsx
    BlogCard.jsx
    ContactForm.jsx
    Hero.jsx
    MagneticButton.jsx
    Navbar.jsx
    Parallax.jsx
    ProjectCard.jsx
    Scene3D.jsx
    Skills.jsx
    SliceReveal.jsx
    Timeline.jsx
    Welcome.jsx
  context/
    ContentProvider.jsx
  editor/
    CanvasRuntime.tsx
    StyleOverrides.tsx
    catalog.ts
    editorStore.ts
    fonts.ts
  pages/
    HomePage.jsx
    admin/
      Blogs.jsx
      Canvas.tsx
      Dashboard.jsx
      Experiences.jsx
      Inbox.jsx
      Login.jsx
      Projects.jsx
      Settings.jsx
      Studio.tsx
      canvas/
        CommandPalette.tsx
        Inspector.tsx
      settings/
        AboutSettings.jsx
        CertificationsSettings.jsx
        ContactSettings.jsx
        HeroSettings.jsx
        SeoSettings.jsx
        SkillsSettings.jsx
        ThemeSettings.jsx
      studio/
        ComponentLibrary.tsx
        ScraperPanel.tsx
        ScrollStudio.tsx
        StructurePanel.tsx
        ThemePanel.tsx
  store/
    useEditorStore.ts
    useNodeStore.ts
    useThemeStore.ts
  theme/
    Modifiers.jsx
    ThemeProvider.tsx
    presets.ts
    store.ts
  types/
  utils/
  App.tsx
  main.tsx
  index.css
```

---

## Build and Dev Commands

```bash
npm run dev        # Vite dev server (hot reload)
npm run build      # TypeScript compile + Vite production build
npm run preview    # Preview production build locally
npm run lint       # oxlint static analysis
```

Deployment: Vercel (vercel.json config present)

---

Generated from source: c:\Users\Rishi\OneDrive\Documents\resume - 2026-07-13
