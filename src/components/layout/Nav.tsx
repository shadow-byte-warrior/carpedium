"use client";

import { useState } from "react";
import { scrollToSection } from "@/lib/scroll";
import { useScrollUpOrTop } from "@/lib/useScrollDirection";
import TopBar from "./TopBar";

const LINKS = [
  { href: "#courses", label: "Courses" },
  { href: "#why", label: "Why Us" },
  { href: "#programs", label: "Programs" },
  { href: "#how-it-works", label: "Timeline" },
  { href: "#mentors", label: "Mentors" },
  { href: "#outcomes", label: "Careers" },
  { href: "#contact", label: "Contact" },
];

export default function Nav() {
  const [open, setOpen] = useState(false);
  const topBarVisible = useScrollUpOrTop();

  const handleClick = (href: string) => (e: React.MouseEvent) => {
    e.preventDefault();
    setOpen(false);
    scrollToSection(href);
  };

  return (
    <header className="fixed inset-x-0 top-0 z-40 border-b border-teal/10 bg-white/70 backdrop-blur-md">
      <TopBar visible={topBarVisible} />
      <nav className="mx-auto flex max-w-6xl items-center justify-between px-6 py-4">
        <a
          href="#hero"
          onClick={handleClick("#hero")}
          className="flex items-center gap-2.5 font-display text-sm font-bold tracking-wider text-ink transition-transform hover:scale-[1.02]"
        >
          <img
            src="/logo/carpediem-mark.jpg"
            alt="Carpediem Tech Innovations"
            width={32}
            height={32}
            className="rounded-full ring-2 ring-primary/20"
          />
          <span className="hidden sm:inline font-mono tracking-widest text-[13px] uppercase">CARPEDIEM TECH</span>
        </a>

        {/* Desktop Links */}
        <ul className="hidden items-center gap-7 md:flex">
          {LINKS.map((link) => (
            <li key={link.href}>
              <a
                href={link.href}
                onClick={handleClick(link.href)}
                className="relative py-1 font-mono text-xs uppercase tracking-wider text-ink-dim transition-colors duration-200 hover:text-primary after:absolute after:bottom-0 after:left-0 after:h-[2px] after:w-full after:origin-right after:scale-x-0 after:bg-primary after:transition-transform after:duration-350 hover:after:origin-left hover:after:scale-x-100"
              >
                {link.label}
              </a>
            </li>
          ))}
        </ul>

        {/* CTA Button */}
        <div className="hidden items-center gap-4 md:flex">
          <a
            href="#contact"
            onClick={handleClick("#contact")}
            className="inline-flex items-center justify-center rounded-full bg-primary px-5 py-2 font-mono text-xs font-bold uppercase tracking-wider text-white shadow-sm transition-all hover:bg-primary-light hover:shadow-md hover:-translate-y-0.5 active:translate-y-0"
          >
            Enquire Now
          </a>
        </div>

        {/* Mobile Toggle */}
        <button
          type="button"
          onClick={() => setOpen((v) => !v)}
          aria-expanded={open}
          aria-controls="mobile-nav"
          aria-label="Toggle navigation menu"
          className="flex h-9 w-9 items-center justify-center rounded-full border border-teal/20 text-ink transition-colors hover:bg-primary/5 hover:text-primary md:hidden"
        >
          <svg viewBox="0 0 24 24" className="h-5 w-5" fill="none" stroke="currentColor" strokeWidth={1.8}>
            {open ? (
              <path d="M6 6l12 12M6 18L18 6" strokeLinecap="round" />
            ) : (
              <path d="M4 7h16M4 12h16M4 17h16" strokeLinecap="round" />
            )}
          </svg>
        </button>
      </nav>

      {/* Mobile Menu */}
      {open && (
        <div className="border-t border-teal/10 bg-white/95 px-6 py-6 shadow-xl md:hidden">
          <ul id="mobile-nav" className="flex flex-col gap-2">
            {LINKS.map((link) => (
              <li key={link.href}>
                <a
                  href={link.href}
                  onClick={handleClick(link.href)}
                  className="block py-2.5 font-mono text-sm uppercase tracking-wider text-ink-dim hover:text-primary transition-colors"
                >
                  {link.label}
                </a>
              </li>
            ))}
            <li className="mt-4 pt-4 border-t border-teal/5">
              <a
                href="#contact"
                onClick={handleClick("#contact")}
                className="flex w-full items-center justify-center rounded-full bg-primary py-3 font-mono text-xs font-bold uppercase tracking-wider text-white shadow-sm hover:bg-primary-light"
              >
                Enquire Now
              </a>
            </li>
          </ul>
        </div>
      )}
    </header>
  );
}
