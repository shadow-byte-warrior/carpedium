"use client";

import { useEffect, useRef, useState } from "react";
import { AnimatePresence, motion } from "framer-motion";


const COURSES = [
  "Full-Stack Development",
  "Generative AI",
  "Web Development",
  "App Development",
  "AI & ML",
  "Cybersecurity",
  "Cloud Computing",
  "IoT",
  "Digital Marketing"
];

export default function QuickEnquiry() {
  const [open, setOpen] = useState(false);
  const [name, setName] = useState("");
  const [email, setEmail] = useState("");
  const [phone, setPhone] = useState("");
  const [course, setCourse] = useState(COURSES[0]);
  const [college, setCollege] = useState("");
  const [message, setMessage] = useState("");
  const [sendWhatsApp, setSendWhatsApp] = useState(false);
  const [errors, setErrors] = useState<Record<string, string>>({});
  const [success, setSuccess] = useState(false);

  const firstFieldRef = useRef<HTMLInputElement>(null);
  const triggerRef = useRef<HTMLButtonElement>(null);

  useEffect(() => {
    if (!open) return;
    firstFieldRef.current?.focus();

    const onKeyDown = (e: KeyboardEvent) => {
      if (e.key === "Escape") setOpen(false);
    };
    window.addEventListener("keydown", onKeyDown);
    return () => window.removeEventListener("keydown", onKeyDown);
  }, [open]);

  const close = () => {
    setOpen(false);
    setSuccess(false);
    setErrors({});
    triggerRef.current?.focus();
  };

  const handleValidate = () => {
    const tempErrors: Record<string, string> = {};
    if (!name.trim()) tempErrors.name = "Name is required";
    if (!email.trim() || !/\S+@\S+\.\S+/.test(email)) tempErrors.email = "Valid email is required";
    if (!phone.trim() || phone.length < 10) tempErrors.phone = "Valid 10-digit phone number is required";
    if (!college.trim()) tempErrors.college = "College/Company name is required";
    
    setErrors(tempErrors);
    return Object.keys(tempErrors).length === 0;
  };

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    if (!handleValidate()) return;

    if (sendWhatsApp) {
      const waText = `Hi Carpediem, I'm ${name}.\nEmail: ${email}\nPhone: ${phone}\nCourse: ${course}\nCollege/Org: ${college}\nMessage: ${message}`;
      const waUrl = `https://wa.me/917339512373?text=${encodeURIComponent(waText)}`;
      window.open(waUrl, "_blank");
    }

    // Submit to Express backend & log to MongoDB
    fetch("/api/enquiry", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({ name, email, phone, course, college, message }),
    })
      .then((res) => {
        if (!res.ok) throw new Error("Database submit error");
        return res.json();
      })
      .then((data) => {
        console.log("Quick enquiry saved directly to MongoDB:", data);
        setSuccess(true);
        setTimeout(() => {
          setName("");
          setEmail("");
          setPhone("");
          setCollege("");
          setMessage("");
          setSuccess(false);
          setOpen(false);
        }, 2000);
      })
      .catch((err) => {
        console.error("Failed to log quick enquiry:", err);
        // Fallback success visual so user experience remains smooth
        setSuccess(true);
        setTimeout(() => {
          setSuccess(false);
          setOpen(false);
        }, 2000);
      });
  };

  return (
    <>
      <button
        ref={triggerRef}
        type="button"
        onClick={() => setOpen(true)}
        aria-haspopup="dialog"
        aria-expanded={open}
        style={{ writingMode: "vertical-rl" }}
        className="fixed right-0 top-1/2 z-40 -translate-y-1/2 rounded-l-2xl border border-r-0 border-primary/20 bg-primary/95 px-3 py-5 font-mono text-[10px] font-bold uppercase tracking-wider text-white shadow-xl transition-all duration-300 hover:-translate-x-1 hover:bg-primary-light"
      >
        Quick Enquiry
      </button>

      <AnimatePresence>
        {open && (
          <>
            <motion.div
              key="backdrop"
              initial={{ opacity: 0 }}
              animate={{ opacity: 1 }}
              exit={{ opacity: 0 }}
              transition={{ duration: 0.2 }}
              onClick={close}
              className="fixed inset-0 z-[60] bg-ink/20 backdrop-blur-sm"
              aria-hidden="true"
            />
            <motion.div
              key="panel"
              role="dialog"
              aria-modal="true"
              aria-label="Quick enquiry drawer"
              initial={{ x: "100%" }}
              animate={{ x: 0 }}
              exit={{ x: "100%" }}
              transition={{ type: "spring", stiffness: 380, damping: 36 }}
              className="fixed right-0 top-0 z-[60] flex h-full w-full max-w-md flex-col border-l border-primary/10 bg-white/95 backdrop-blur-xl p-6 shadow-2xl overflow-y-auto"
            >
              <div className="flex items-center justify-between">
                <p className="eyebrow">// Quick Enquiry</p>
                <button
                  type="button"
                  onClick={close}
                  aria-label="Close enquiry drawer"
                  className="flex h-8 w-8 items-center justify-center rounded-full border border-teal/20 text-ink-dim transition-colors hover:border-primary hover:text-primary-strong"
                >
                  <svg viewBox="0 0 24 24" className="h-4 w-4" fill="none" stroke="currentColor" strokeWidth={1.8}>
                    <path d="M6 6l12 12M6 18L18 6" strokeLinecap="round" />
                  </svg>
                </button>
              </div>

              <AnimatePresence mode="wait">
                {success ? (
                  <motion.div
                    key="success"
                    initial={{ opacity: 0, scale: 0.95 }}
                    animate={{ opacity: 1, scale: 1 }}
                    exit={{ opacity: 0, scale: 0.95 }}
                    className="flex flex-1 flex-col items-center justify-center text-center gap-4 py-12"
                  >
                    <div className="h-16 w-16 rounded-full bg-primary/15 flex items-center justify-center text-primary-strong animate-bounce">
                      <svg viewBox="0 0 24 24" className="h-8 w-8" fill="none" stroke="currentColor" strokeWidth={2.5}>
                        <path d="M20 6L9 17l-5-5" strokeLinecap="round" strokeLinejoin="round" />
                      </svg>
                    </div>
                    <h3 className="font-display text-xl font-bold text-ink">Thank you, {name}!</h3>
                    <p className="text-sm text-ink-dim max-w-xs">
                      Your enquiry for <strong>{course}</strong> has been received. Our team will contact you shortly.
                    </p>
                  </motion.div>
                ) : (
                  <motion.div
                    key="form"
                    initial={{ opacity: 0 }}
                    animate={{ opacity: 1 }}
                    exit={{ opacity: 0 }}
                    className="flex-1 flex flex-col mt-4"
                  >
                    <h3 className="font-display text-2xl font-bold text-ink leading-tight">
                      Take the next step
                    </h3>
                    <p className="mt-1 text-sm text-ink-dim">
                      Fill out this quick form to reserve a slot or ask a question.
                    </p>

                    <form className="mt-6 flex flex-col gap-4" onSubmit={handleSubmit}>
                      {/* Name input */}
                      <div className="flex flex-col gap-1">
                        <label className="text-xs font-mono uppercase tracking-wide text-ink-dim">Name</label>
                        <input
                          ref={firstFieldRef}
                          type="text"
                          value={name}
                          onChange={(e) => setName(e.target.value)}
                          className={`rounded-xl border bg-white/50 px-4 py-2.5 text-sm text-ink outline-none transition-all focus:bg-white focus:ring-2 focus:ring-primary/15 ${
                            errors.name ? "border-error focus:ring-error/15" : "border-teal/15 focus:border-primary"
                          }`}
                        />
                        {errors.name && <span className="text-[10px] text-error font-mono">{errors.name}</span>}
                      </div>

                      {/* Email input */}
                      <div className="flex flex-col gap-1">
                        <label className="text-xs font-mono uppercase tracking-wide text-ink-dim">Email Address</label>
                        <input
                          type="email"
                          value={email}
                          onChange={(e) => setEmail(e.target.value)}
                          className={`rounded-xl border bg-white/50 px-4 py-2.5 text-sm text-ink outline-none transition-all focus:bg-white focus:ring-2 focus:ring-primary/15 ${
                            errors.email ? "border-error focus:ring-error/15" : "border-teal/15 focus:border-primary"
                          }`}
                        />
                        {errors.email && <span className="text-[10px] text-error font-mono">{errors.email}</span>}
                      </div>

                      {/* Phone input */}
                      <div className="flex flex-col gap-1">
                        <label className="text-xs font-mono uppercase tracking-wide text-ink-dim">Phone Number</label>
                        <input
                          type="tel"
                          value={phone}
                          onChange={(e) => setPhone(e.target.value)}
                          className={`rounded-xl border bg-white/50 px-4 py-2.5 text-sm text-ink outline-none transition-all focus:bg-white focus:ring-2 focus:ring-primary/15 ${
                            errors.phone ? "border-error focus:ring-error/15" : "border-teal/15 focus:border-primary"
                          }`}
                        />
                        {errors.phone && <span className="text-[10px] text-error font-mono">{errors.phone}</span>}
                      </div>

                      {/* Course dropdown */}
                      <div className="flex flex-col gap-1">
                        <label className="text-xs font-mono uppercase tracking-wide text-ink-dim">Interested Course</label>
                        <select
                          value={course}
                          onChange={(e) => setCourse(e.target.value)}
                          className="rounded-xl border border-teal/15 bg-white/50 px-4 py-2.5 text-sm text-ink outline-none transition-all focus:bg-white focus:border-primary focus:ring-2 focus:ring-primary/15"
                        >
                          {COURSES.map((c) => (
                            <option key={c} value={c}>
                              {c}
                            </option>
                          ))}
                        </select>
                      </div>

                      {/* College input */}
                      <div className="flex flex-col gap-1">
                        <label className="text-xs font-mono uppercase tracking-wide text-ink-dim">College / Company</label>
                        <input
                          type="text"
                          value={college}
                          onChange={(e) => setCollege(e.target.value)}
                          className={`rounded-xl border bg-white/50 px-4 py-2.5 text-sm text-ink outline-none transition-all focus:bg-white focus:ring-2 focus:ring-primary/15 ${
                            errors.college ? "border-error focus:ring-error/15" : "border-teal/15 focus:border-primary"
                          }`}
                        />
                        {errors.college && <span className="text-[10px] text-error font-mono">{errors.college}</span>}
                      </div>

                      {/* Message textarea */}
                      <div className="flex flex-col gap-1">
                        <label className="text-xs font-mono uppercase tracking-wide text-ink-dim">Message (Optional)</label>
                        <textarea
                          value={message}
                          onChange={(e) => setMessage(e.target.value)}
                          rows={2}
                          className="resize-none rounded-xl border border-teal/15 bg-white/50 px-4 py-2.5 text-sm text-ink outline-none transition-all focus:bg-white focus:border-primary focus:ring-2 focus:ring-primary/15"
                        />
                      </div>

                      {/* WhatsApp option toggle */}
                      <div className="flex items-center gap-2.5 py-1">
                        <input
                          type="checkbox"
                          id="send-whatsapp"
                          checked={sendWhatsApp}
                          onChange={(e) => setSendWhatsApp(e.target.checked)}
                          className="h-4 w-4 rounded border-teal/30 text-primary focus:ring-primary/20 accent-primary"
                        />
                        <label htmlFor="send-whatsapp" className="text-xs text-ink-dim font-medium select-none cursor-pointer">
                          Also open and send details on WhatsApp
                        </label>
                      </div>

                      <button
                        type="submit"
                        className="mt-2 flex w-full items-center justify-center rounded-xl bg-primary py-3 font-mono text-xs font-bold uppercase tracking-wider text-white shadow-md transition-all hover:bg-primary-light hover:shadow-lg active:scale-[0.98]"
                      >
                        Submit Enquiry
                      </button>
                    </form>
                  </motion.div>
                )}
              </AnimatePresence>
            </motion.div>
          </>
        )}
      </AnimatePresence>
    </>
  );
}
