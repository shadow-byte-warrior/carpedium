export default function TopBar({ visible }: { visible: boolean }) {
  return (
    <div
      className={`overflow-hidden border-b border-line bg-surface-alt transition-[max-height,opacity] duration-300 ease-out ${
        visible ? "max-h-10 opacity-100" : "max-h-0 opacity-0"
      }`}
    >
      <div className="mx-auto flex max-w-6xl items-center justify-between px-6 py-1.5 text-xs">
        <p className="font-mono text-ink-dim">
          Full-Stack &amp; Gen AI Training — Coimbatore
        </p>
        <a
          href="tel:+917339512373"
          className="flex items-center gap-1.5 font-mono text-primary-strong hover:text-primary"
        >
          <svg viewBox="0 0 24 24" className="h-3.5 w-3.5" fill="none" stroke="currentColor" strokeWidth={2}>
            <path d="M22 16.92v3a2 2 0 01-2.18 2 19.79 19.79 0 01-8.63-3.07 19.5 19.5 0 01-6-6 19.79 19.79 0 01-3.07-8.67A2 2 0 014.11 2h3a2 2 0 012 1.72c.127.96.362 1.903.7 2.81a2 2 0 01-.45 2.11L8.09 9.91a16 16 0 006 6l1.27-1.27a2 2 0 012.11-.45c.907.338 1.85.573 2.81.7A2 2 0 0122 16.92z" strokeLinecap="round" strokeLinejoin="round" />
          </svg>
          For Enquiry: +91 73395 12373
        </a>
      </div>
    </div>
  );
}
