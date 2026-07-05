

const COURSE_LINKS = [
  { href: "#programs", label: "Full-Stack Development" },
  { href: "#programs", label: "Generative AI" },
  { href: "#courses", label: "All courses" },
];

const COMPANY_LINKS = [
  { href: "#why", label: "Why Carpediem" },
  { href: "#how-it-works", label: "How It Works" },
  { href: "#mentors", label: "Mentors" },
  { href: "#outcomes", label: "Outcomes" },
];

const RESOURCE_LINKS = [
  { href: "#resources", label: "Tutorials" },
  { href: "#resources", label: "Interview Prep" },
];

// Genuine Coimbatore localities — describes reach, not fabricated branch claims.
const LOCALITIES = [
  "Saravanampatty", "Peelamedu", "RS Puram", "Gandhipuram", "Race Course",
  "Ganapathy", "Singanallur", "Ramanathapuram", "Vadavalli", "Kovaipudur",
  "Sundarapuram", "Ondipudur", "Avinashi Road", "Sitra", "Thudiyalur",
  "Kalapatti", "Kuniyamuthur", "Podanur", "Sowripalayam",
];

function FooterColumn({ title, links }: { title: string; links: { href: string; label: string }[] }) {
  return (
    <div>
      <p className="font-mono text-xs uppercase tracking-wide text-primary-strong">{title}</p>
      <ul className="mt-4 space-y-2.5">
        {links.map((link) => (
          <li key={link.label}>
            <a
              href={link.href}
              className="text-sm text-ink-dim hover:text-ink"
            >
              {link.label}
            </a>
          </li>
        ))}
      </ul>
    </div>
  );
}

export default function Footer() {
  return (
    <footer className="relative border-t border-line bg-surface-alt px-6 pt-16">
      <div className="mx-auto max-w-6xl">
        <div className="grid grid-cols-2 gap-8 sm:grid-cols-4">
          <FooterColumn title="Courses" links={COURSE_LINKS} />
          <FooterColumn title="Company" links={COMPANY_LINKS} />
          <FooterColumn title="Resources" links={RESOURCE_LINKS} />
          <div>
            <p className="font-mono text-xs uppercase tracking-wide text-primary-strong">Contact</p>
            <ul className="mt-4 space-y-2.5 text-sm text-ink-dim">
              <li>
                <a href="mailto:carpediemtechinnovations@gmail.com" className="hover:text-ink">
                  carpediemtechinnovations@gmail.com
                </a>
              </li>
              <li>
                <a href="tel:+917339512373" className="hover:text-ink">
                  +91 73395 12373
                </a>
              </li>
              <li>
                <a
                  href="https://linkedin.com/in/carpediem-tech-innovations"
                  target="_blank"
                  rel="noopener noreferrer"
                  className="hover:text-ink"
                >
                  LinkedIn
                </a>
              </li>
            </ul>
          </div>
        </div>

        <div className="mt-14 border-t border-line pt-8">
          <p className="font-mono text-xs uppercase tracking-wide text-ink-dim">
            Serving learners across Coimbatore
          </p>
          <p className="mt-3 max-w-4xl text-sm leading-relaxed text-ink-dim/80">
            {LOCALITIES.join(", ")}
          </p>
        </div>

        <div className="mt-10 flex flex-col gap-6 border-t border-line py-8 sm:flex-row sm:items-center sm:justify-between">
          <div className="flex items-center gap-3">
            <img
              src="/logo/carpediem-mark.jpg"
              alt="Carpediem Tech Innovations"
              width={36}
              height={36}
              className="rounded-full"
            />
            <div>
              <p className="font-display text-sm font-bold text-ink">
                CARPEDIEM TECH INNOVATIONS
              </p>
              <p className="text-xs text-ink-dim">Coimbatore, Tamil Nadu</p>
            </div>
          </div>

          <p className="text-xs text-ink-dim/70">
            © {new Date().getFullYear()} Carpediem Tech Innovations. All rights reserved.
          </p>
        </div>
      </div>
    </footer>
  );
}
