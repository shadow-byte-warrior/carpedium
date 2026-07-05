"use client";

import { useState } from "react";
import { motion, AnimatePresence } from "framer-motion";
import Reveal from "@/components/ui/Reveal";
import SectionEyebrow from "@/components/ui/SectionEyebrow";
import { scrollToSection } from "@/lib/scroll";

type Course = {
  id: string;
  title: string;
  category: "Flagship" | "Development" | "AI & Data" | "Security & Cloud" | "Design & Marketing";
  difficulty: "Beginner" | "Intermediate" | "Advanced";
  duration: string;
  projects: number;
  placement: boolean;
  mentor: { name: string; avatar: string; role: string };
  description: string;
  href: string;
};

const COURSES: Course[] = [
  {
    id: "c-fullstack",
    title: "Flagship Full-Stack Development",
    category: "Flagship",
    difficulty: "Beginner",
    duration: "16 Weeks",
    projects: 6,
    placement: true,
    mentor: { name: "Arun Kumar", avatar: "👨‍💻", role: "Ex-SDE Amazon" },
    description: "Master React, Node.js, databases, and CI/CD pipelines through production-grade cohorts.",
    href: "#programs",
  },
  {
    id: "c-genai",
    title: "Flagship Generative AI & Agents",
    category: "Flagship",
    difficulty: "Intermediate",
    duration: "12 Weeks",
    projects: 4,
    placement: true,
    mentor: { name: "Dr. R. Priya", avatar: "👩‍🔬", role: "AI Research Lead" },
    description: "Orchestrate RAG pipelines, LLM fine-tuning, and multi-agent workflows with LangChain and Python.",
    href: "#programs",
  },
  {
    id: "c-webdev",
    title: "Modern Web Development",
    category: "Development",
    difficulty: "Beginner",
    duration: "8 Weeks",
    projects: 3,
    placement: false,
    mentor: { name: "Magesh S.", avatar: "👨‍💻", role: "Tech Lead at CTS" },
    description: "Responsive layouts, advanced JS, Tailwind CSS, and headless architectures.",
    href: "#contact",
  },
  {
    id: "c-appdev",
    title: "Advanced Mobile App Development",
    category: "Development",
    difficulty: "Intermediate",
    duration: "12 Weeks",
    projects: 4,
    placement: true,
    mentor: { name: "Karthik R.", avatar: "📱", role: "Independent Consultant" },
    description: "Build robust cross-platform mobile apps for iOS and Android using React Native.",
    href: "#contact",
  },
  {
    id: "c-aiml",
    title: "Machine Learning & Python",
    category: "AI & Data",
    difficulty: "Intermediate",
    duration: "14 Weeks",
    projects: 5,
    placement: true,
    mentor: { name: "Dr. R. Priya", avatar: "👩‍🔬", role: "AI Research Lead" },
    description: "Mathematical foundations of ML, predictive algorithms, Pandas, Scikit-Learn, and Tensorflow.",
    href: "#contact",
  },
  {
    id: "c-cyber",
    title: "Cybersecurity & Pentesting",
    category: "Security & Cloud",
    difficulty: "Advanced",
    duration: "12 Weeks",
    projects: 3,
    placement: true,
    mentor: { name: "Vikram N.", avatar: "🛡️", role: "Certified Auditor" },
    description: "Network defense, vulnerability assessments, ethical hacking protocols, and compliance.",
    href: "#contact",
  },
  {
    id: "c-cloud",
    title: "Cloud Solutions Architect (AWS)",
    category: "Security & Cloud",
    difficulty: "Intermediate",
    duration: "10 Weeks",
    projects: 4,
    placement: false,
    mentor: { name: "Suresh M.", avatar: "☁️", role: "AWS Solutions Specialist" },
    description: "Infrastructure mapping, load balancing, serverless deployments, and secure data storage.",
    href: "#contact",
  },
  {
    id: "c-iot",
    title: "Internet of Things (IoT) Systems",
    category: "Security & Cloud",
    difficulty: "Intermediate",
    duration: "12 Weeks",
    projects: 4,
    placement: false,
    mentor: { name: "Anand D.", avatar: "🔌", role: "IoT Labs Coimbatore" },
    description: "Hardware microcontrollers, sensor networking, MQTT communication, and smart dashboard design.",
    href: "#contact",
  },
  {
    id: "c-uiux",
    title: "UI/UX Product Design",
    category: "Design & Marketing",
    difficulty: "Beginner",
    duration: "8 Weeks",
    projects: 5,
    placement: false,
    mentor: { name: "Divya K.", avatar: "🎨", role: "Senior Designer" },
    description: "Figma wireframing, interactive prototyping, user research, and modern UI patterns.",
    href: "#contact",
  },
  {
    id: "c-marketing",
    title: "Digital Marketing Strategy",
    category: "Design & Marketing",
    difficulty: "Beginner",
    duration: "6 Weeks",
    projects: 2,
    placement: false,
    mentor: { name: "Rahul S.", avatar: "📈", role: "Growth Marketer" },
    description: "Search Engine Optimization (SEO), programmatic advertising, copy frameworks, and analytics.",
    href: "#contact",
  },
  {
    id: "c-dsa",
    title: "Data Structures & Algorithms",
    category: "Development",
    difficulty: "Advanced",
    duration: "10 Weeks",
    projects: 0,
    placement: true,
    mentor: { name: "Arun Kumar", avatar: "👨‍💻", role: "Ex-SDE Amazon" },
    description: "Master algorithmic patterns, complexity analysis, trees, graphs, and system optimization.",
    href: "#contact",
  },
  {
    id: "c-devops",
    title: "DevOps & CI/CD Orchestration",
    category: "Security & Cloud",
    difficulty: "Advanced",
    duration: "10 Weeks",
    projects: 4,
    placement: true,
    mentor: { name: "Suresh M.", avatar: "☁️", role: "AWS Solutions Specialist" },
    description: "Automate code shipping with Docker, Kubernetes, Jenkins pipelines, and Terraform.",
    href: "#contact",
  }
];

const CATEGORIES = ["All", "Flagship", "Development", "AI & Data", "Security & Cloud", "Design & Marketing"];

export default function CourseGrid() {
  const [searchQuery, setSearchQuery] = useState("");
  const [selectedCategory, setSelectedCategory] = useState("All");
  const [showAll, setShowAll] = useState(false);

  const handleAction = (href: string) => (e: React.MouseEvent) => {
    e.preventDefault();
    scrollToSection(href);
  };

  const filteredCourses = COURSES.filter((course) => {
    const matchesSearch = course.title.toLowerCase().includes(searchQuery.toLowerCase()) || 
                          course.description.toLowerCase().includes(searchQuery.toLowerCase());
    const matchesCategory = selectedCategory === "All" || course.category === selectedCategory;
    return matchesSearch && matchesCategory;
  });

  const displayedCourses = showAll ? filteredCourses : filteredCourses.slice(0, 6);

  return (
    <section id="courses" className="relative px-6 py-24 sm:py-32 bg-slate-50/50">
      <div className="mx-auto max-w-6xl">
        
        {/* Header */}
        <Reveal>
          <SectionEyebrow>Course Catalog</SectionEyebrow>
          <h2 className="font-display max-w-2xl text-3xl font-bold sm:text-4xl text-ink leading-tight">
            Learn what ships. Ship what&apos;s learned.
          </h2>
          <p className="mt-4 max-w-xl text-sm sm:text-base text-ink-dim">
            Explore our curated catalog of software engineering, artificial intelligence, security, and product design programs built for students and career switchers.
          </p>
        </Reveal>

        {/* Search and Filters */}
        <div className="mt-12 flex flex-col md:flex-row gap-4 items-center justify-between">
          {/* Category Filter Chips */}
          <div className="flex flex-wrap gap-2 w-full md:w-auto">
            {CATEGORIES.map((cat) => (
              <button
                key={cat}
                type="button"
                onClick={() => setSelectedCategory(cat)}
                className={`rounded-full px-4 py-1.5 font-mono text-xs uppercase tracking-wider transition-all border duration-200 select-none ${
                  selectedCategory === cat
                    ? "bg-primary text-white border-primary shadow-sm"
                    : "bg-white text-ink-dim border-teal/15 hover:border-primary/50"
                }`}
              >
                {cat}
              </button>
            ))}
          </div>

          {/* Search input */}
          <div className="relative w-full md:w-72">
            <span className="absolute inset-y-0 left-0 pl-3.5 flex items-center text-teal/40">
              <svg viewBox="0 0 24 24" className="h-4 w-4" fill="none" stroke="currentColor" strokeWidth={2}>
                <path d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" strokeLinecap="round" />
              </svg>
            </span>
            <input
              type="text"
              placeholder="Search courses..."
              value={searchQuery}
              onChange={(e) => setSearchQuery(e.target.value)}
              className="w-full rounded-full border border-teal/15 bg-white pl-10 pr-4 py-2 text-sm text-ink outline-none transition-all placeholder:text-teal/40 focus:border-primary focus:ring-2 focus:ring-primary/10"
            />
          </div>
        </div>

        {/* Grid List */}
        <div className="mt-10 grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
          <AnimatePresence mode="popLayout">
            {displayedCourses.map((course, idx) => (
              <motion.article
                key={course.id}
                layout
                initial={{ opacity: 0, scale: 0.96 }}
                animate={{ opacity: 1, scale: 1 }}
                exit={{ opacity: 0, scale: 0.96 }}
                transition={{ duration: 0.35, delay: idx * 0.04 }}
                className="group relative flex flex-col justify-between rounded-2xl border border-teal/10 bg-white p-6 shadow-sm hover:shadow-lg transition-all duration-300 hover:-translate-y-1.5"
              >
                {/* Visual border outline trace on hover */}
                <svg className="pointer-events-none absolute inset-0 h-full w-full" aria-hidden="true">
                  <rect
                    x="1"
                    y="1"
                    width="99%"
                    height="99%"
                    rx="15"
                    fill="none"
                    stroke="var(--color-primary)"
                    strokeWidth="1.5"
                    pathLength={100}
                    strokeDasharray={100}
                    strokeDashoffset={100}
                    className="transition-[stroke-dashoffset] duration-500 ease-out group-hover:[stroke-dashoffset:0]"
                  />
                </svg>

                {/* Category and Badges */}
                <div className="flex items-center justify-between gap-2">
                  <span className={`rounded-full px-2.5 py-0.5 font-mono text-[9px] uppercase tracking-wider ${
                    course.category === "Flagship"
                      ? "bg-primary/10 text-primary-strong font-bold"
                      : "bg-slate-100 text-ink-dim"
                  }`}>
                    {course.category}
                  </span>
                  
                  <div className="flex gap-1">
                    <span className="rounded bg-teal/5 border border-teal/10 px-1.5 py-0.5 font-mono text-[8px] uppercase text-primary-strong">
                      {course.difficulty}
                    </span>
                    <span className="rounded bg-slate-50 border border-slate-100 px-1.5 py-0.5 font-mono text-[8px] uppercase text-ink-dim">
                      {course.duration}
                    </span>
                  </div>
                </div>

                {/* Course Metadata */}
                <div className="mt-5 flex-1">
                  <h3 className="font-display text-lg font-bold text-ink group-hover:text-primary transition-colors">
                    {course.title}
                  </h3>
                  <p className="mt-2.5 text-xs sm:text-sm text-ink-dim line-clamp-3">
                    {course.description}
                  </p>
                </div>

                {/* Badges footer & mentor details */}
                <div className="mt-6 pt-5 border-t border-teal/5 flex flex-col gap-4">
                  {/* Info badges */}
                  <div className="flex items-center justify-between text-xs text-ink-dim">
                    <span className="flex items-center gap-1">
                      📁 {course.projects > 0 ? `${course.projects} Labs` : "Theory Tracks"}
                    </span>
                    {course.placement && (
                      <span className="flex items-center gap-1 text-primary-strong font-medium">
                        🛡️ Placement Help
                      </span>
                    )}
                  </div>

                  {/* Mentor profile */}
                  <div className="flex items-center justify-between">
                    <div className="flex items-center gap-2">
                      <span className="h-8 w-8 rounded-full bg-slate-100 flex items-center justify-center text-sm shadow-sm">
                        {course.mentor.avatar}
                      </span>
                      <div>
                        <p className="font-display text-[11px] font-bold text-ink leading-tight">{course.mentor.name}</p>
                        <p className="text-[9px] text-ink-dim leading-none mt-0.5">{course.mentor.role}</p>
                      </div>
                    </div>

                    <a
                      href={course.href}
                      onClick={handleAction(course.href)}
                      className="inline-flex h-8 w-8 items-center justify-center rounded-full bg-primary/5 text-primary-strong border border-teal/10 hover:bg-primary hover:text-white transition-all shadow-sm active:scale-95"
                      aria-label={`View details of ${course.title}`}
                    >
                      →
                    </a>
                  </div>
                </div>
              </motion.article>
            ))}
          </AnimatePresence>
        </div>

        {/* Empty search state */}
        {filteredCourses.length === 0 && (
          <div className="mt-16 text-center py-12 border border-dashed border-teal/10 rounded-2xl bg-white/40">
            <p className="font-mono text-xs uppercase tracking-wider text-ink-dim">No courses found matching search criteria</p>
          </div>
        )}

        {/* View More toggle button */}
        {filteredCourses.length > 6 && (
          <div className="mt-12 flex justify-center">
            <button
              type="button"
              onClick={() => setShowAll((v) => !v)}
              className="inline-flex items-center justify-center gap-2 rounded-full border border-teal/25 bg-white px-7 py-3 font-mono text-xs font-bold uppercase tracking-wider text-primary-strong shadow-sm transition-all hover:border-primary hover:-translate-y-0.5"
            >
              {showAll ? "Show Less" : "View All Courses"}
              <svg
                viewBox="0 0 24 24"
                className={`h-4 w-4 transition-transform duration-300 ${showAll ? "rotate-180" : ""}`}
                fill="none"
                stroke="currentColor"
                strokeWidth={2.5}
              >
                <path d="M19 9l-7 7-7-7" strokeLinecap="round" />
              </svg>
            </button>
          </div>
        )}

      </div>
    </section>
  );
}
