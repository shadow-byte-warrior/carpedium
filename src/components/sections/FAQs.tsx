"use client";

import { useState } from "react";
import { motion, AnimatePresence } from "framer-motion";
import Reveal from "@/components/ui/Reveal";
import SectionEyebrow from "@/components/ui/SectionEyebrow";

const FAQS = [
  {
    q: "Who are these programs designed for?",
    a: "Our cohorts are designed for fresh graduates, final-year college students, and working professionals looking to switch careers. We focus on practical, production-level software design rather than basic tutorials, meaning you exit ready for real-world demands."
  },
  {
    q: "Are the training batches online, offline, or hybrid?",
    a: "We operate a hybrid model. The cohorts involve live, interactive online sessions and code reviews combined with scheduled offline portfolio evaluations and coding check-ins at our Coimbatore training hub."
  },
  {
    q: "How does the placement referral support operate?",
    a: "Once you successfully build and ship your capstone production project and clear our internal mock SDE tests, your profile is unlocked for direct referral. We refer you directly to engineering leaders at our 45+ hiring partners in Bangalore, Chennai, and Coimbatore."
  },
  {
    q: "What is the weekly time commitment?",
    a: "You should plan to dedicate 12 to 15 hours per week. This covers live coding labs (2 hours/session), peer code syncs, and 6-8 hours of self-directed code building and solving mentor feedback on pull requests."
  },
  {
    q: "Can I join without any prior coding background?",
    a: "Yes. Our flagship Full-Stack Development cohort starts with basic web fundamentals (HTML/CSS/JS). We also provide a structured 2-week pre-work program to help beginners get comfortable with simple loops and terminal logic before the main batch starts."
  }
];

export default function FAQs() {
  const [openIndex, setOpenIndex] = useState<number | null>(null);

  const toggle = (idx: number) => {
    setOpenIndex(openIndex === idx ? null : idx);
  };

  return (
    <section id="faqs" className="relative px-6 py-24 sm:py-32 bg-white">
      <div className="mx-auto max-w-4xl">
        
        {/* Header */}
        <div className="text-center flex flex-col items-center">
          <Reveal>
            <SectionEyebrow>FAQs</SectionEyebrow>
            <h2 className="font-display text-3xl font-bold sm:text-4xl text-ink leading-tight">
              Frequently Asked Questions
            </h2>
            <p className="mt-4 max-w-xl text-sm sm:text-base text-ink-dim">
              Everything you need to know about the batches, curriculum reviews, mentorships, and corporate placements.
            </p>
          </Reveal>
        </div>

        {/* Accordions */}
        <div className="mt-16 flex flex-col gap-4">
          {FAQS.map((faq, i) => {
            const isOpen = openIndex === i;
            return (
              <Reveal key={faq.q} delay={i * 0.05}>
                <div className="rounded-2xl border border-teal/10 bg-white shadow-sm overflow-hidden transition-colors hover:border-primary/20">
                  <button
                    type="button"
                    onClick={() => toggle(i)}
                    aria-expanded={isOpen}
                    className="flex w-full items-center justify-between px-6 py-5 text-left outline-none"
                  >
                    <span className="font-display text-sm sm:text-base font-extrabold text-ink leading-snug">
                      {faq.q}
                    </span>
                    <span className={`ml-4 h-6 w-6 shrink-0 rounded-full border border-teal/20 flex items-center justify-center text-xs text-primary-strong transition-transform duration-300 ${
                      isOpen ? "rotate-180 bg-primary/10 border-primary/30" : ""
                    }`}>
                      ↓
                    </span>
                  </button>

                  <AnimatePresence initial={false}>
                    {isOpen && (
                      <motion.div
                        initial={{ height: 0, opacity: 0 }}
                        animate={{ height: "auto", opacity: 1 }}
                        exit={{ height: 0, opacity: 0 }}
                        transition={{ duration: 0.28, ease: "easeInOut" }}
                      >
                        <div className="px-6 pb-5 pt-1 text-xs sm:text-sm text-ink-dim border-t border-teal/5 leading-relaxed bg-slate-50/50">
                          {faq.a}
                        </div>
                      </motion.div>
                    )}
                  </AnimatePresence>
                </div>
              </Reveal>
            );
          })}
        </div>

      </div>
    </section>
  );
}
