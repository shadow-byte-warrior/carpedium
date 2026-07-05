import Reveal from "@/components/ui/Reveal";
import SectionEyebrow from "@/components/ui/SectionEyebrow";

const POSTS = [
  {
    title: "Demystifying RAG: Chunks, Embeddings, and Vector Search",
    desc: "A developer guide on building context-aware applications. Learn how vector DB indexes work, how to split texts, and optimize LLM search.",
    category: "AI & ML",
    date: "July 2026",
    readTime: "5 min read",
  },
  {
    title: "Mastering the Git Rebase and Pull Request Workflows",
    desc: "Coordinate merge reviews smoothly. We explain how our students manage shared branch features and handle merge conflicts like pros.",
    category: "Git & Dev",
    date: "June 2026",
    readTime: "4 min read",
  },
  {
    title: "How to Dockerize and Deploy Next.js Web Systems",
    desc: "A step-by-step outline to containerize Next.js projects and deploy them on AWS EC2 nodes with clean reverse proxy configurations.",
    category: "DevOps & Cloud",
    date: "May 2026",
    readTime: "6 min read",
  },
];

export default function BlogPreview() {
  return (
    <section id="blog" className="relative px-6 py-24 sm:py-32 bg-slate-50/20">
      <div className="mx-auto max-w-6xl">
        
        {/* Header */}
        <Reveal>
          <SectionEyebrow>Latest Articles</SectionEyebrow>
          <h2 className="font-display max-w-2xl text-3xl font-bold sm:text-4xl text-ink leading-tight">
            Insights from our team build logs.
          </h2>
          <p className="mt-4 max-w-xl text-sm sm:text-base text-ink-dim">
            We write about database design, prompt engineering, deployment configurations, and modern web architectures.
          </p>
        </Reveal>

        {/* Posts list */}
        <div className="mt-16 grid grid-cols-1 md:grid-cols-3 gap-8">
          {POSTS.map((post, i) => (
            <Reveal key={post.title} delay={i * 0.08}>
              <article className="group h-full rounded-2xl border border-teal/10 bg-white p-6 shadow-sm hover:shadow-lg hover:border-primary/25 transition-all duration-300 hover:-translate-y-1.5 flex flex-col justify-between">
                <div>
                  {/* Category and date metadata */}
                  <div className="flex items-center justify-between text-[10px] font-mono text-ink-dim mb-4">
                    <span className="text-primary-strong font-bold uppercase tracking-wider bg-teal/5 border border-teal/10 rounded px-1.5 py-0.5">
                      {post.category}
                    </span>
                    <span>{post.date}</span>
                  </div>

                  <h3 className="font-display text-base font-extrabold text-ink leading-snug group-hover:text-primary transition-colors">
                    {post.title}
                  </h3>
                  
                  <p className="mt-2.5 text-xs sm:text-sm text-ink-dim leading-relaxed">
                    {post.desc}
                  </p>
                </div>

                <div className="mt-6 pt-4 border-t border-teal/5 flex items-center justify-between text-xs font-mono text-ink-dim">
                  <span>{post.readTime}</span>
                  <span className="text-primary-strong font-bold group-hover:translate-x-1 transition-transform">
                    Read Article →
                  </span>
                </div>
              </article>
            </Reveal>
          ))}
        </div>

      </div>
    </section>
  );
}
