-- ============================================================
-- CARPEDIEM TECH INNOVATIONS
-- FULL SCHEMA + SEED — Run once in Supabase SQL Editor
-- Project: elqkyhmziiibdkvykata.supabase.co
-- ============================================================
-- STEP 1  → Extensions
-- STEP 2  → Create all tables (IF NOT EXISTS — safe to re-run)
-- STEP 3  → Indexes
-- STEP 4  → Role grants
-- STEP 5  → Row Level Security + policies
-- STEP 6  → Storage buckets
-- STEP 7  → Realtime publications
-- STEP 8  → Seed: site settings
-- STEP 9  → Seed: mentors (5)
-- STEP 10 → Seed: courses (20, with full Markdown long_descriptions)
-- STEP 11 → Seed: testimonials (8 sample reviews)
-- ============================================================

-- ============================================================
-- STEP 1  EXTENSIONS
-- ============================================================
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- ============================================================
-- STEP 2  TABLES
-- ============================================================

-- ── COURSES ─────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS public.courses (
    id                   UUID        DEFAULT uuid_generate_v4() PRIMARY KEY,
    title                TEXT        NOT NULL,
    slug                 TEXT        UNIQUE NOT NULL,
    category             TEXT        NOT NULL,
    description          TEXT,
    long_description     TEXT,
    overview             TEXT,
    difficulty           TEXT,
    duration             TEXT,
    language             TEXT        DEFAULT 'English',
    instructor           TEXT,
    price                TEXT,
    discount_price       TEXT,
    course_image         TEXT,
    banner_image         TEXT,
    preview_video        TEXT,
    rating               NUMERIC(2,1) DEFAULT 0.0,
    students_enrolled    INTEGER     DEFAULT 0,
    certificate_included BOOLEAN     DEFAULT true,
    projects_included    INTEGER     DEFAULT 0,
    placement_support    BOOLEAN     DEFAULT true,
    tools_covered        TEXT[],
    career_outcomes      TEXT[],
    requirements         TEXT[],
    curriculum           JSONB,
    faqs                 JSONB,
    status               TEXT        DEFAULT 'draft',
    seo_title            TEXT,
    seo_description      TEXT,
    meta_keywords        TEXT,
    is_published         BOOLEAN     DEFAULT false,
    created_at           TIMESTAMPTZ DEFAULT NOW(),
    updated_at           TIMESTAMPTZ DEFAULT NOW()
);

-- ── MENTORS ─────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS public.mentors (
    id              UUID        DEFAULT uuid_generate_v4() PRIMARY KEY,
    name            TEXT        NOT NULL,
    designation     TEXT,
    company         TEXT,
    experience      TEXT,
    bio             TEXT,
    linkedin        TEXT,
    github          TEXT,
    twitter         TEXT,
    website         TEXT,
    skills          TEXT[],
    profile_image   TEXT,
    display_order   INTEGER     DEFAULT 0,
    featured_toggle BOOLEAN     DEFAULT false,
    status          TEXT        DEFAULT 'active',
    created_at      TIMESTAMPTZ DEFAULT NOW()
);

-- ── TESTIMONIALS ─────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS public.testimonials (
    id                UUID        DEFAULT uuid_generate_v4() PRIMARY KEY,
    student_name      TEXT        NOT NULL,
    photo             TEXT,
    course            TEXT,
    company           TEXT,
    job_role          TEXT,
    rating            INTEGER     DEFAULT 5,
    review            TEXT        NOT NULL,
    video_testimonial TEXT,
    linkedin          TEXT,
    date              DATE        DEFAULT CURRENT_DATE,
    featured          BOOLEAN     DEFAULT false,
    status            TEXT        DEFAULT 'published',
    created_at        TIMESTAMPTZ DEFAULT NOW()
);

-- ── SETTINGS ────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS public.settings (
    id         UUID        DEFAULT uuid_generate_v4() PRIMARY KEY,
    key        TEXT        UNIQUE NOT NULL,
    value      JSONB       NOT NULL,
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- ── STUDENTS ────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS public.students (
    id                          UUID        DEFAULT uuid_generate_v4() PRIMARY KEY,
    -- Personal
    full_name                   TEXT        NOT NULL,
    profile_photo               TEXT,
    gender                      TEXT,
    date_of_birth               DATE,
    email                       TEXT,
    mobile                      TEXT,
    alternate_number            TEXT,
    address                     TEXT,
    city                        TEXT,
    state                       TEXT,
    country                     TEXT        DEFAULT 'India',
    -- Course
    course_id                   UUID        REFERENCES public.courses(id) ON DELETE SET NULL,
    course_name                 TEXT,
    batch                       TEXT,
    enrollment_date             DATE,
    expected_completion_date    DATE,
    mentor_id                   UUID        REFERENCES public.mentors(id) ON DELETE SET NULL,
    mentor_name                 TEXT,
    learning_mode               TEXT        DEFAULT 'Online',
    -- Attendance summary
    attendance_percentage       NUMERIC(5,2) DEFAULT 0,
    total_classes               INTEGER     DEFAULT 0,
    classes_attended            INTEGER     DEFAULT 0,
    -- Project
    project_title               TEXT,
    github_link                 TEXT,
    drive_link                  TEXT,
    live_demo_link              TEXT,
    project_status              TEXT        DEFAULT 'Not Started',
    mentor_feedback             TEXT,
    -- Certification
    certificate_issued          BOOLEAN     DEFAULT false,
    certificate_number          TEXT,
    certificate_verification_url TEXT,
    certificate_issue_date      DATE,
    -- Placement
    resume_link                 TEXT,
    linkedin                    TEXT,
    portfolio                   TEXT,
    current_company             TEXT,
    job_role                    TEXT,
    salary_package              TEXT,
    placement_status            TEXT        DEFAULT 'Not Placed',
    -- Documents
    doc_resume                  TEXT,
    doc_id_proof                TEXT,
    doc_offer_letter            TEXT,
    doc_internship_certificate  TEXT,
    doc_course_certificate      TEXT,
    -- Fees
    fees_total                  NUMERIC(10,2) DEFAULT 0,
    fees_paid                   NUMERIC(10,2) DEFAULT 0,
    pending_fees                NUMERIC(10,2) DEFAULT 0,
    invoice_number              TEXT,
    -- CRM
    lead_status                 TEXT        DEFAULT 'Enrolled',
    counsellor_notes            TEXT,
    admin_notes                 TEXT,
    mentor_notes                TEXT,
    status                      TEXT        DEFAULT 'active',
    created_at                  TIMESTAMPTZ DEFAULT NOW(),
    updated_at                  TIMESTAMPTZ DEFAULT NOW()
);

-- ── STUDENT INTERACTIONS ────────────────────────────────────
CREATE TABLE IF NOT EXISTS public.student_interactions (
    id             UUID        DEFAULT uuid_generate_v4() PRIMARY KEY,
    student_id     UUID        REFERENCES public.students(id) ON DELETE CASCADE,
    type           TEXT        DEFAULT 'Note',
    notes          TEXT,
    follow_up_date DATE,
    lead_status    TEXT,
    created_at     TIMESTAMPTZ DEFAULT NOW()
);

-- ── STUDENT PAYMENTS ────────────────────────────────────────
CREATE TABLE IF NOT EXISTS public.student_payments (
    id              UUID        DEFAULT uuid_generate_v4() PRIMARY KEY,
    student_id      UUID        REFERENCES public.students(id) ON DELETE CASCADE,
    amount          NUMERIC(10,2) DEFAULT 0,
    installment_no  INTEGER,
    invoice_number  TEXT,
    receipt_url     TEXT,
    method          TEXT,
    payment_date    DATE        DEFAULT CURRENT_DATE,
    notes           TEXT,
    created_at      TIMESTAMPTZ DEFAULT NOW()
);

-- ── STUDENT ATTENDANCE ──────────────────────────────────────
CREATE TABLE IF NOT EXISTS public.student_attendance (
    id           UUID        DEFAULT uuid_generate_v4() PRIMARY KEY,
    student_id   UUID        REFERENCES public.students(id) ON DELETE CASCADE,
    student_name TEXT,
    course       TEXT,
    batch        TEXT,
    date         DATE        NOT NULL,
    status       TEXT        CHECK (status IN ('Present','Absent','Late','Leave')) NOT NULL,
    check_in     TIME,
    check_out    TIME,
    mentor       TEXT,
    remarks      TEXT,
    created_at   TIMESTAMPTZ DEFAULT NOW(),
    CONSTRAINT unique_student_date UNIQUE (student_id, date)
);

-- ── ATTENDANCE SYNC LOGS ────────────────────────────────────
CREATE TABLE IF NOT EXISTS public.attendance_sync_logs (
    id            UUID        DEFAULT uuid_generate_v4() PRIMARY KEY,
    synced_at     TIMESTAMPTZ DEFAULT NOW(),
    status        TEXT        CHECK (status IN ('Success','Failed')) NOT NULL,
    rows_synced   INTEGER     DEFAULT 0,
    error_message TEXT,
    created_at    TIMESTAMPTZ DEFAULT NOW()
);

-- ============================================================
-- STEP 3  INDEXES
-- ============================================================
CREATE INDEX IF NOT EXISTS idx_students_course      ON public.students(course_id);
CREATE INDEX IF NOT EXISTS idx_students_mentor      ON public.students(mentor_id);
CREATE INDEX IF NOT EXISTS idx_students_status      ON public.students(status);
CREATE INDEX IF NOT EXISTS idx_interactions_student ON public.student_interactions(student_id);
CREATE INDEX IF NOT EXISTS idx_payments_student     ON public.student_payments(student_id);
CREATE INDEX IF NOT EXISTS idx_attendance_student   ON public.student_attendance(student_id);
CREATE INDEX IF NOT EXISTS idx_attendance_date      ON public.student_attendance(date);
CREATE INDEX IF NOT EXISTS idx_attendance_status    ON public.student_attendance(status);

-- ============================================================
-- STEP 4  ROLE GRANTS
-- ============================================================
GRANT USAGE ON SCHEMA public TO anon, authenticated, service_role;

-- Public tables (read-only for anon)
GRANT SELECT
    ON public.courses, public.mentors, public.testimonials, public.settings
    TO anon;

-- Public tables (full for authenticated)
GRANT SELECT, INSERT, UPDATE, DELETE
    ON public.courses, public.mentors, public.testimonials, public.settings
    TO authenticated, service_role;

-- Admin-only tables
GRANT SELECT, INSERT, UPDATE, DELETE
    ON public.students, public.student_interactions, public.student_payments,
       public.student_attendance, public.attendance_sync_logs
    TO authenticated, service_role;

GRANT SELECT
    ON public.student_attendance, public.attendance_sync_logs
    TO anon;

-- Future tables
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO authenticated;

-- ============================================================
-- STEP 5  ROW LEVEL SECURITY
-- ============================================================
ALTER TABLE public.courses              ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.mentors              ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.testimonials         ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.settings             ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.students             ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.student_interactions ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.student_payments     ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.student_attendance   ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.attendance_sync_logs ENABLE ROW LEVEL SECURITY;

DO $$
BEGIN
  -- Public site: read published content
  BEGIN CREATE POLICY "Public view published courses"
      ON public.courses FOR SELECT USING (is_published = true AND status = 'published');
  EXCEPTION WHEN duplicate_object THEN NULL; END;

  BEGIN CREATE POLICY "Public view active mentors"
      ON public.mentors FOR SELECT USING (status = 'active');
  EXCEPTION WHEN duplicate_object THEN NULL; END;

  BEGIN CREATE POLICY "Public view published testimonials"
      ON public.testimonials FOR SELECT USING (status = 'published');
  EXCEPTION WHEN duplicate_object THEN NULL; END;

  BEGIN CREATE POLICY "Public view settings"
      ON public.settings FOR SELECT USING (true);
  EXCEPTION WHEN duplicate_object THEN NULL; END;

  -- Admin: full access to public tables
  BEGIN CREATE POLICY "Admins full access to courses"
      ON public.courses FOR ALL USING (auth.role() = 'authenticated');
  EXCEPTION WHEN duplicate_object THEN NULL; END;

  BEGIN CREATE POLICY "Admins full access to mentors"
      ON public.mentors FOR ALL USING (auth.role() = 'authenticated');
  EXCEPTION WHEN duplicate_object THEN NULL; END;

  BEGIN CREATE POLICY "Admins full access to testimonials"
      ON public.testimonials FOR ALL USING (auth.role() = 'authenticated');
  EXCEPTION WHEN duplicate_object THEN NULL; END;

  BEGIN CREATE POLICY "Admins full access to settings"
      ON public.settings FOR ALL USING (auth.role() = 'authenticated');
  EXCEPTION WHEN duplicate_object THEN NULL; END;

  -- Admin: full access to student/attendance tables
  BEGIN CREATE POLICY "Admins full access students"
      ON public.students FOR ALL USING (auth.role() = 'authenticated')
      WITH CHECK (auth.role() = 'authenticated');
  EXCEPTION WHEN duplicate_object THEN NULL; END;

  BEGIN CREATE POLICY "Admins full access interactions"
      ON public.student_interactions FOR ALL USING (auth.role() = 'authenticated')
      WITH CHECK (auth.role() = 'authenticated');
  EXCEPTION WHEN duplicate_object THEN NULL; END;

  BEGIN CREATE POLICY "Admins full access payments"
      ON public.student_payments FOR ALL USING (auth.role() = 'authenticated')
      WITH CHECK (auth.role() = 'authenticated');
  EXCEPTION WHEN duplicate_object THEN NULL; END;

  BEGIN CREATE POLICY "Public select attendance"
      ON public.student_attendance FOR SELECT USING (true);
  EXCEPTION WHEN duplicate_object THEN NULL; END;

  BEGIN CREATE POLICY "Admins full attendance"
      ON public.student_attendance FOR ALL USING (auth.role() = 'authenticated')
      WITH CHECK (auth.role() = 'authenticated');
  EXCEPTION WHEN duplicate_object THEN NULL; END;

  BEGIN CREATE POLICY "Public select sync logs"
      ON public.attendance_sync_logs FOR SELECT USING (true);
  EXCEPTION WHEN duplicate_object THEN NULL; END;

  BEGIN CREATE POLICY "Admins full sync logs"
      ON public.attendance_sync_logs FOR ALL USING (auth.role() = 'authenticated')
      WITH CHECK (auth.role() = 'authenticated');
  EXCEPTION WHEN duplicate_object THEN NULL; END;
END $$;

-- ============================================================
-- STEP 6  STORAGE BUCKETS
-- ============================================================
INSERT INTO storage.buckets (id, name, public) VALUES ('media',   'media',   true) ON CONFLICT DO NOTHING;
INSERT INTO storage.buckets (id, name, public) VALUES ('avatars', 'avatars', true) ON CONFLICT DO NOTHING;

DO $$
BEGIN
  BEGIN CREATE POLICY "Public read media"    ON storage.objects FOR SELECT USING (bucket_id IN ('media','avatars')); EXCEPTION WHEN duplicate_object THEN NULL; END;
  BEGIN CREATE POLICY "Auth insert storage"  ON storage.objects FOR INSERT WITH CHECK (auth.role() = 'authenticated'); EXCEPTION WHEN duplicate_object THEN NULL; END;
  BEGIN CREATE POLICY "Auth update storage"  ON storage.objects FOR UPDATE USING  (auth.role() = 'authenticated'); EXCEPTION WHEN duplicate_object THEN NULL; END;
  BEGIN CREATE POLICY "Auth delete storage"  ON storage.objects FOR DELETE USING  (auth.role() = 'authenticated'); EXCEPTION WHEN duplicate_object THEN NULL; END;
END $$;

-- ============================================================
-- STEP 7  REALTIME
-- ============================================================
DO $$
BEGIN
  BEGIN ALTER PUBLICATION supabase_realtime ADD TABLE public.courses;              EXCEPTION WHEN duplicate_object THEN NULL; END;
  BEGIN ALTER PUBLICATION supabase_realtime ADD TABLE public.mentors;              EXCEPTION WHEN duplicate_object THEN NULL; END;
  BEGIN ALTER PUBLICATION supabase_realtime ADD TABLE public.testimonials;         EXCEPTION WHEN duplicate_object THEN NULL; END;
  BEGIN ALTER PUBLICATION supabase_realtime ADD TABLE public.settings;             EXCEPTION WHEN duplicate_object THEN NULL; END;
  BEGIN ALTER PUBLICATION supabase_realtime ADD TABLE public.students;             EXCEPTION WHEN duplicate_object THEN NULL; END;
  BEGIN ALTER PUBLICATION supabase_realtime ADD TABLE public.student_interactions; EXCEPTION WHEN duplicate_object THEN NULL; END;
  BEGIN ALTER PUBLICATION supabase_realtime ADD TABLE public.student_payments;     EXCEPTION WHEN duplicate_object THEN NULL; END;
  BEGIN ALTER PUBLICATION supabase_realtime ADD TABLE public.student_attendance;   EXCEPTION WHEN duplicate_object THEN NULL; END;
  BEGIN ALTER PUBLICATION supabase_realtime ADD TABLE public.attendance_sync_logs; EXCEPTION WHEN duplicate_object THEN NULL; END;
END $$;

-- ============================================================
-- STEP 8  SEED — SITE SETTINGS
-- ============================================================
INSERT INTO public.settings (key, value) VALUES
('site', '{
  "name": "Carpediem Tech Innovations",
  "tagline": "Build Real Skills. Land Real Jobs.",
  "description": "Carpediem Tech is a premium tech education platform offering project-based courses in Software Engineering, AI, Cloud, DevOps, Product Design and Cybersecurity — mentored by industry veterans.",
  "email": "hello@carpediemtech.in",
  "phone": "+91 98765 43210",
  "location": "Chennai, Tamil Nadu, India",
  "founded": "2024",
  "logo": "",
  "favicon": "",
  "social": {
    "linkedin": "https://linkedin.com/company/carpediemtech",
    "twitter": "https://twitter.com/carpediemtech",
    "instagram": "https://instagram.com/carpediemtech",
    "youtube": "https://youtube.com/@carpediemtech"
  }
}')
ON CONFLICT (key) DO UPDATE SET value = EXCLUDED.value, updated_at = NOW();

-- ============================================================
-- STEP 9  SEED — MENTORS (idempotent)
-- ============================================================
DELETE FROM public.mentors WHERE name IN (
  'Arun Kumar', 'Dr. Priya Ramakrishnan', 'Suresh Murugesan', 'Magesh Sundar', 'Karthik Rajan'
);

INSERT INTO public.mentors
  (name, designation, company, experience, bio, linkedin, github, twitter, website, skills, profile_image, display_order, featured_toggle, status)
VALUES
(
  'Arun Kumar', 'Full-Stack Architect', 'Ex-Amazon', '10+ years',
  'Former SDE at Amazon, Arun has built high-scale distributed commerce systems serving millions of users daily. He specialises in clean architecture, microservices, and helping junior engineers level up fast. His courses blend real-world system design with hands-on project work — every module ships something real.',
  'https://linkedin.com/in/arunkumar', 'https://github.com/arunkumar', NULL, NULL,
  ARRAY['React','Node.js','System Design','AWS','TypeScript','Next.js','Flutter','Rust','Blockchain']::text[],
  'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=800&q=80',
  1, true, 'active'
),
(
  'Dr. Priya Ramakrishnan', 'Generative AI Lead', 'PhD in Machine Learning', '12+ years',
  'PhD in Machine Learning from IIT Madras. Dr. Priya consults Fortune 500 companies on enterprise RAG pipelines, LLM fine-tuning, and autonomous agent deployments. She has published 20+ papers in NeurIPS, ICML, and ICLR. Her teaching philosophy: every student should be able to deploy a production AI system by the end of Week 2.',
  'https://linkedin.com/in/priyaramakrishnan', NULL, NULL, NULL,
  ARRAY['LLMs','PyTorch','RAG','Prompt Engineering','Python','MLOps','Deep Learning','Computer Vision','Generative AI']::text[],
  'https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&w=800&q=80',
  2, true, 'active'
),
(
  'Suresh Murugesan', 'Cloud & DevOps Principal', 'AWS Certified Solutions Architect', '9+ years',
  'AWS Solutions Principal and multi-cert holder (SAA, DevOps-Pro, Security-Specialty). Suresh has managed 300-node Kubernetes clusters and greenfield CI/CD platforms for fintech and SaaS scale-ups. His motto: if it isn''t automated and observable, it''s not production-ready.',
  'https://linkedin.com/in/sureshmurugesan', NULL, NULL, NULL,
  ARRAY['Kubernetes','AWS','Terraform','Docker','CI/CD','DevSecOps','Golang','SRE','GitHub Actions']::text[],
  'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=800&q=80',
  3, true, 'active'
),
(
  'Magesh Sundar', 'Senior Product Designer', 'Ex-Cognizant Digital Studio', '8+ years',
  'Former Head of Product Design at Cognizant''s Digital Studio, Magesh has shipped consumer-facing products used by 8M+ users and led a 22-person design org. He brings the full spectrum — from ethnographic user research and service blueprinting to high-fidelity Figma prototypes and design system governance.',
  'https://linkedin.com/in/mageshsundar', NULL, NULL, NULL,
  ARRAY['Figma','UX Research','Design Systems','Prototyping','Product Management','Accessibility','Motion Design']::text[],
  'https://images.unsplash.com/photo-1544005313-94ddf0286df2?auto=format&fit=crop&w=800&q=80',
  4, true, 'active'
),
(
  'Karthik Rajan', 'Cybersecurity & Data Lead', 'OSCP Certified | Ex-Wipro Security', '11+ years',
  'Offensive security expert, OSCP-certified red-teamer, and data engineering architect. Karthik runs adversarial penetration tests for banking and healthcare clients and builds streaming data platforms on Kafka + Spark. He believes every developer should know how their code gets exploited — before an attacker does.',
  'https://linkedin.com/in/karthikrajan', NULL, NULL, NULL,
  ARRAY['Ethical Hacking','Python','Apache Spark','SIEM','Networking','Burp Suite','Metasploit','Kali Linux','Data Engineering']::text[],
  'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?auto=format&fit=crop&w=800&q=80',
  5, false, 'active'
);

-- ============================================================
-- STEP 10  SEED — COURSES (20 courses, Markdown long_description)
-- ============================================================
INSERT INTO public.courses
  (title, slug, category, description, long_description, overview,
   difficulty, duration, language, instructor, price, discount_price, course_image,
   rating, students_enrolled, certificate_included, projects_included, placement_support,
   tools_covered, career_outcomes, requirements,
   status, seo_title, seo_description, meta_keywords, is_published)
VALUES

-- ── 1. Full-Stack ─────────────────────────────────────────
(
  'Full-Stack Development with React & Node.js',
  'full-stack-development-with-react-node-js',
  'Software Engineering',
  'Build production-grade full-stack apps with React, Node.js, and PostgreSQL.',
  E'## What You Will Build\n\nIn 16 intensive weeks you will ship **6 production-grade projects**:\n\n1. **Task Manager SaaS** — React + Node.js + PostgreSQL with JWT auth\n2. **Real-Time Chat App** — WebSockets, Redis pub-sub, React\n3. **E-Commerce API** — REST + GraphQL, Stripe payments, Docker\n4. **CMS Dashboard** — Role-based access, file uploads, image optimisation\n5. **Portfolio Site** — Next.js 15, Server Components, Vercel Edge\n6. **Full-Stack Capstone** — Your own product idea, mentored and deployed\n\n## Curriculum Highlights\n\n- **Week 1–2** React 19 fundamentals, hooks, context, Zustand\n- **Week 3–4** Node.js & Express, REST API design, middleware\n- **Week 5–6** PostgreSQL, Prisma ORM, migrations, query optimisation\n- **Week 7–8** Auth (JWT, OAuth 2.0, Supabase Auth)\n- **Week 9–10** Docker, CI/CD with GitHub Actions\n- **Week 11–12** TypeScript deep dive, testing (Vitest, Playwright)\n- **Week 13–14** System design, scalability, caching with Redis\n- **Week 15–16** Capstone, code review, deployment\n\n## Mentorship\n\nWeekly 1:1 sessions with Arun Kumar. Code reviews on every project PR.',
  'Build production-grade full-stack apps with React, Node.js, PostgreSQL, TypeScript, and Docker.',
  'Beginner','16 Weeks','English','Arun Kumar','₹22,000','₹34,000',
  'https://images.unsplash.com/photo-1461749280684-dccba630e2f6?auto=format&fit=crop&w=800&q=80',
  4.9, 1240, true, 6, true,
  ARRAY['React','Node.js','Express','PostgreSQL','TypeScript','Docker','Prisma','Redis','GitHub Actions','Vitest']::text[],
  ARRAY['Full-Stack Developer','Backend Engineer','SDE-1','API Developer']::text[],
  ARRAY['Laptop 8GB+ RAM','Stable internet','3–4 hrs/day','Basic HTML/CSS/JS']::text[],
  'published',
  'Full-Stack Development with React & Node.js | Carpediem Tech',
  'Master full-stack development with React, Node.js, PostgreSQL, TypeScript and Docker. Ship 6 real projects in 16 weeks.',
  'React, Node.js, Express, PostgreSQL, TypeScript, Docker', true
),

-- ── 2. Next.js ───────────────────────────────────────────
(
  'Next.js 15 & Modern Web Engineering',
  'next-js-15-modern-web-engineering',
  'Software Engineering',
  'Server Components, edge rendering, and full-stack Next.js for production.',
  E'## What You Will Build\n\n5 production-grade projects including:\n\n1. **Blog Platform** — App Router, MDX, ISR, Algolia search\n2. **SaaS Dashboard** — Server Actions, Supabase, role-based access\n3. **E-Commerce Storefront** — Next Commerce, Stripe, edge middleware\n4. **Real-Time Feed** — Server-Sent Events, Vercel Edge Runtime\n5. **Next.js Capstone** — Your own idea, shipped to production\n\n## Curriculum Highlights\n\n- App Router architecture and file conventions\n- React Server Components vs Client Components\n- Server Actions and form mutations\n- Edge Runtime and Middleware\n- ISR, SSG, SSR — when to use each\n- Optimistic UI with `useOptimistic`\n- Next.js Image, Fonts, and Metadata APIs\n- Deployment on Vercel with environment management',
  'Master Next.js 15 App Router, Server Components, Server Actions, and edge rendering.',
  'Intermediate','10 Weeks','English','Arun Kumar','₹28,000','₹42,000',
  'https://images.unsplash.com/photo-1461749280684-dccba630e2f6?auto=format&fit=crop&w=800&q=80',
  4.8, 940, true, 5, true,
  ARRAY['Next.js 15','React','TypeScript','Tailwind CSS','Vercel','Supabase','Prisma','MDX','Algolia']::text[],
  ARRAY['Frontend Engineer','Full-Stack Developer','React Developer']::text[],
  ARRAY['Laptop 8GB+ RAM','Stable internet','3–4 hrs/day','React fundamentals']::text[],
  'published',
  'Next.js 15 & Modern Web Engineering | Carpediem Tech',
  'Learn Next.js 15 App Router, Server Components, Server Actions and edge rendering. Build 5 production projects in 10 weeks.',
  'Next.js 15, React, TypeScript, Tailwind, Vercel, Server Components', true
),

-- ── 3. Flutter ───────────────────────────────────────────
(
  'Mobile App Development with Flutter',
  'mobile-app-development-with-flutter',
  'Software Engineering',
  'Build cross-platform iOS & Android apps from one Flutter codebase.',
  E'## What You Will Build\n\n5 real apps across iOS and Android:\n\n1. **Weather App** — REST APIs, Riverpod state management, animations\n2. **Chat Messenger** — Firebase Firestore, push notifications\n3. **Fitness Tracker** — Local DB (SQLite/Hive), charts, health APIs\n4. **Food Delivery Clone** — Maps, geolocation, Stripe payments\n5. **Flutter Capstone** — Your own app, published to the Play Store\n\n## Curriculum\n\n- Dart language fundamentals and advanced patterns\n- Flutter widget tree, state management (Riverpod, BLoC)\n- Navigation with GoRouter\n- Firebase Auth, Firestore, Storage, Cloud Functions\n- REST APIs, Dio, JSON serialisation\n- Responsive layouts, animations, custom painters\n- Platform channels and native integrations\n- App Store / Play Store submission',
  'Build cross-platform iOS & Android apps from one Flutter codebase using Riverpod and Firebase.',
  'Intermediate','12 Weeks','English','Arun Kumar','₹28,000','₹42,000',
  'https://images.unsplash.com/photo-1550751827-4bd374c3f58b?auto=format&fit=crop&w=800&q=80',
  4.7, 690, true, 5, true,
  ARRAY['Flutter','Dart','Firebase','Riverpod','REST APIs','GoRouter','SQLite','Hive']::text[],
  ARRAY['Mobile Developer','Flutter Engineer','iOS/Android Developer']::text[],
  ARRAY['Laptop 8GB+ RAM','Stable internet','3–4 hrs/day','Basic programming']::text[],
  'published',
  'Mobile App Development with Flutter | Carpediem Tech',
  'Build cross-platform iOS and Android apps with Flutter, Dart, Riverpod and Firebase. Publish your own app in 12 weeks.',
  'Flutter, Dart, Firebase, Riverpod, Mobile Development, iOS, Android', true
),

-- ── 4. Blockchain ────────────────────────────────────────
(
  'Blockchain & Web3 Development',
  'blockchain-web3-development',
  'Software Engineering',
  'Write smart contracts and build decentralised apps on EVM chains.',
  E'## What You Will Build\n\n5 DApps from zero to deployment:\n\n1. **ERC-20 Token** — Solidity, Hardhat, OpenZeppelin\n2. **NFT Marketplace** — ERC-721, IPFS, Pinata, React frontend\n3. **DAO Governance** — On-chain voting, timelock, multi-sig\n4. **DeFi Yield Farm** — AMM mechanics, liquidity pools, staking\n5. **Web3 Capstone** — Your own protocol or DApp\n\n## Curriculum\n\n- Solidity fundamentals and advanced patterns (upgradeable proxies, re-entrancy guards)\n- Hardhat local chain, test scripting with Ethers.js / Viem\n- OpenZeppelin contract library\n- IPFS & decentralised storage\n- Web3 frontend integration (wagmi, RainbowKit, viem)\n- Security: common attack vectors and audit methodology\n- Gas optimisation strategies\n- Testnet and mainnet deployment',
  'Write Solidity smart contracts and build decentralised apps on EVM chains — from tokens to DAOs.',
  'Advanced','12 Weeks','English','Arun Kumar','₹34,000','₹52,000',
  'https://images.unsplash.com/photo-1517180102446-f3ece451e9d8?auto=format&fit=crop&w=800&q=80',
  4.6, 420, true, 5, true,
  ARRAY['Solidity','Ethereum','Hardhat','Ethers.js','IPFS','wagmi','OpenZeppelin','Web3.js']::text[],
  ARRAY['Blockchain Developer','Smart Contract Engineer','Web3 Developer','DApp Developer']::text[],
  ARRAY['Laptop 8GB+ RAM','Stable internet','3–4 hrs/day','JavaScript/TypeScript fundamentals']::text[],
  'published',
  'Blockchain & Web3 Development | Carpediem Tech',
  'Write Solidity smart contracts and build DApps on Ethereum. Covers ERC-20, NFTs, DAOs, DeFi and Web3 frontend integration.',
  'Solidity, Ethereum, Hardhat, Web3, NFT, DeFi, Smart Contracts', true
),

-- ── 5. Rust ──────────────────────────────────────────────
(
  'Rust Systems Programming',
  'rust-systems-programming',
  'Software Engineering',
  'Write fast, memory-safe systems software with Rust.',
  E'## What You Will Build\n\n5 systems-level projects:\n\n1. **CLI Tool** — Argument parsing (clap), file I/O, error handling\n2. **HTTP Server** — Tokio async runtime, Axum framework, middleware\n3. **Key-Value Store** — Custom B-tree, persistence, concurrent readers\n4. **WebAssembly Module** — Compile Rust to WASM, run in browser\n5. **Rust Capstone** — Network daemon, compiler plugin, or embedded firmware\n\n## Curriculum\n\n- Ownership, borrowing, lifetimes — deep intuition, not memorised rules\n- Structs, enums, traits, generics\n- Error handling with Result and custom error types\n- Async I/O with Tokio\n- Unsafe Rust and FFI\n- Testing, benchmarking (criterion), fuzzing\n- WebAssembly with wasm-bindgen\n- Publishing to crates.io',
  'Master Rust ownership, async I/O with Tokio, and WebAssembly. Build 5 systems-level projects.',
  'Advanced','12 Weeks','English','Arun Kumar','₹34,000','₹52,000',
  'https://images.unsplash.com/photo-1620712943543-bcc4688e7485?auto=format&fit=crop&w=800&q=80',
  4.7, 310, true, 5, true,
  ARRAY['Rust','Cargo','Tokio','Axum','WebAssembly','wasm-bindgen','clap','criterion']::text[],
  ARRAY['Systems Engineer','Backend Engineer','Embedded Engineer','WebAssembly Developer']::text[],
  ARRAY['Laptop 8GB+ RAM','Stable internet','3–4 hrs/day','C or Python background recommended']::text[],
  'published',
  'Rust Systems Programming | Carpediem Tech',
  'Learn Rust ownership, async Tokio, and WebAssembly. Build 5 real systems projects in 12 weeks.',
  'Rust, Tokio, Axum, WebAssembly, Systems Programming, Cargo', true
),

-- ── 6. Generative AI ─────────────────────────────────────
(
  'Generative AI & LLM Application Development',
  'generative-ai-llm-application-development',
  'Artificial Intelligence',
  'Ship real GenAI products with LLMs, RAG pipelines, and vector databases.',
  E'## What You Will Build\n\n5 production GenAI products:\n\n1. **Semantic Search Engine** — LangChain, OpenAI Embeddings, Pinecone, FastAPI backend\n2. **RAG Chatbot** — PDF ingestion, chunking strategies, context-aware Q&A\n3. **AI Code Reviewer** — GPT-4o function calling, GitHub webhook integration\n4. **Multi-Agent Research Assistant** — LangGraph, tool calling, autonomous loops\n5. **GenAI SaaS Capstone** — React frontend, Supabase backend, Stripe billing\n\n## Curriculum Highlights\n\n- LLM fundamentals: tokenisation, attention, transformer architecture\n- OpenAI, Anthropic, Gemini, Llama 3, Mistral APIs\n- Prompt engineering: CoT, ReAct, few-shot, system prompts\n- LangChain / LangGraph orchestration\n- RAG pipeline: chunking, embedding, retrieval, reranking\n- Vector databases: Pinecone, pgvector, ChromaDB\n- LLM fine-tuning with LoRA / QLoRA\n- Evaluation: RAGAS, LangSmith tracing\n- Deployment: FastAPI, Docker, Vercel AI SDK',
  'Build production GenAI apps with OpenAI, LangChain, RAG pipelines and vector databases.',
  'Intermediate','12 Weeks','English','Dr. Priya Ramakrishnan','₹28,000','₹42,000',
  'https://images.unsplash.com/photo-1555066931-4365d14bab8c?auto=format&fit=crop&w=800&q=80',
  4.9, 980, true, 5, true,
  ARRAY['OpenAI','LangChain','LangGraph','RAG','Pinecone','pgvector','Python','FastAPI','LangSmith']::text[],
  ARRAY['AI Engineer','LLM Developer','ML Engineer','GenAI Product Engineer']::text[],
  ARRAY['Laptop 8GB+ RAM','Stable internet','3–4 hrs/day','Python fundamentals']::text[],
  'published',
  'Generative AI & LLM Application Development | Carpediem Tech',
  'Ship real GenAI products with LLMs, RAG pipelines, LangChain and vector databases. Build 5 AI projects in 12 weeks.',
  'Generative AI, LLMs, RAG, LangChain, OpenAI, Pinecone, Python, AI Engineer', true
),

-- ── 7. Prompt Engineering ────────────────────────────────
(
  'Prompt Engineering & AI Agents',
  'prompt-engineering-ai-agents',
  'Artificial Intelligence',
  'Design reliable prompts and build multi-agent automations with modern frameworks.',
  E'## What You Will Build\n\n4 AI automation projects:\n\n1. **Prompt Library CLI** — Parametric prompts, template engine, A/B testing harness\n2. **Customer Support Agent** — Tool-calling agent, escalation logic, Slack integration\n3. **Research Automation Pipeline** — n8n + LangGraph, web search, citation extraction, PDF reports\n4. **Multi-Agent Orchestration System** — Supervisor + specialist agents, shared memory, human-in-the-loop\n\n## Curriculum\n\n- Mental models for prompt design: zero-shot, few-shot, chain-of-thought, tree-of-thought\n- Structured output (JSON mode, function calling, Instructor library)\n- Evaluation: automated benchmarks, human preference labelling, LLM-as-judge\n- Agentic frameworks: LangGraph, AutoGen, CrewAI\n- Tool use: web search, code execution, file I/O, API calls\n- Memory systems: short-term, long-term, episodic\n- n8n for no-code automation orchestration\n- Safety: prompt injection, jailbreak defence, output filtering',
  'Design reliable prompts and build production multi-agent automations with LangGraph, AutoGen, and n8n.',
  'Beginner','8 Weeks','English','Dr. Priya Ramakrishnan','₹22,000','₹34,000',
  'https://images.unsplash.com/photo-1517180102446-f3ece451e9d8?auto=format&fit=crop&w=800&q=80',
  4.8, 1520, true, 4, true,
  ARRAY['Prompt Engineering','LangGraph','AutoGen','CrewAI','n8n','Python','Function Calling','Instructor']::text[],
  ARRAY['AI Automation Engineer','Prompt Engineer','AI Product Manager']::text[],
  ARRAY['Laptop 8GB+ RAM','Stable internet','3–4 hrs/day','Basic Python']::text[],
  'published',
  'Prompt Engineering & AI Agents | Carpediem Tech',
  'Master prompt engineering and build multi-agent AI automations with LangGraph, AutoGen and n8n. 4 real projects in 8 weeks.',
  'Prompt Engineering, AI Agents, LangGraph, AutoGen, n8n, CrewAI, Python', true
),

-- ── 8. ML & MLOps ────────────────────────────────────────
(
  'Machine Learning & MLOps',
  'machine-learning-mlops',
  'Artificial Intelligence',
  'From model training to deployment — the full ML lifecycle with MLOps best practices.',
  E'## What You Will Build\n\n6 end-to-end ML systems:\n\n1. **Churn Prediction API** — scikit-learn, FastAPI, Docker, Prometheus monitoring\n2. **Image Classifier** — Transfer learning (ResNet), MLflow experiment tracking\n3. **Recommendation Engine** — Collaborative filtering, ALS, real-time serving\n4. **NLP Sentiment Pipeline** — Fine-tuned BERT, Hugging Face Hub, batch inference\n5. **Drift Detection System** — Evidently AI, automated retraining triggers\n6. **MLOps Capstone** — Full pipeline: data → training → CI/CD → monitoring\n\n## Curriculum\n\n- Supervised, unsupervised, and ensemble methods\n- Feature engineering and selection\n- Hyperparameter tuning: Optuna, grid search, Bayesian optimisation\n- MLflow for experiment tracking and model registry\n- Docker + Kubernetes for model serving\n- FastAPI + Triton inference server\n- CI/CD for ML: GitHub Actions, DVC data versioning\n- Model monitoring: Evidently, Arize, Grafana dashboards\n- Responsible AI: fairness, explainability (SHAP, LIME)',
  'Master the full ML lifecycle — from training to production monitoring — with scikit-learn, MLflow, Docker and Kubernetes.',
  'Advanced','16 Weeks','English','Dr. Priya Ramakrishnan','₹34,000','₹52,000',
  'https://images.unsplash.com/photo-1620712943543-bcc4688e7485?auto=format&fit=crop&w=800&q=80',
  4.8, 590, true, 6, true,
  ARRAY['scikit-learn','MLflow','Docker','FastAPI','Python','Kubernetes','DVC','Evidently','Optuna','Hugging Face']::text[],
  ARRAY['ML Engineer','MLOps Engineer','Data Scientist','AI Platform Engineer']::text[],
  ARRAY['Laptop 8GB+ RAM','Stable internet','3–4 hrs/day','Python and linear algebra basics']::text[],
  'published',
  'Machine Learning & MLOps | Carpediem Tech',
  'Master the full ML lifecycle from training to production monitoring. Build 6 end-to-end ML systems in 16 weeks.',
  'Machine Learning, MLOps, scikit-learn, MLflow, Docker, Python, Model Deployment', true
),

-- ── 9. Deep Learning ─────────────────────────────────────
(
  'Deep Learning with PyTorch',
  'deep-learning-with-pytorch',
  'Artificial Intelligence',
  'Build and train neural networks for vision and NLP with PyTorch.',
  E'## What You Will Build\n\n6 deep learning projects:\n\n1. **Image Classifier** — CNNs, data augmentation, transfer learning (ResNet, EfficientNet)\n2. **Object Detection System** — YOLOv8 fine-tuning on custom dataset\n3. **Text Classifier** — Transformer from scratch, BERT fine-tuning\n4. **Image Generation** — Stable Diffusion fine-tune with LoRA\n5. **Speech Recognition** — Whisper fine-tuning, audio preprocessing\n6. **DL Capstone** — Vision Transformer, LLM pretraining, or RL agent\n\n## Curriculum\n\n- Tensors, autograd, and the computation graph\n- MLP → CNN → RNN → Transformer architecture progression\n- Loss functions, optimisers, learning rate scheduling\n- GPU training: CUDA, mixed precision (AMP), gradient checkpointing\n- Distributed training with PyTorch DDP\n- Hugging Face Transformers and Datasets\n- Diffusion models and generative architectures\n- Deployment: ONNX export, TorchServe, FastAPI',
  'Build CNNs, Transformers, and generative models with PyTorch, CUDA, and Hugging Face.',
  'Advanced','14 Weeks','English','Dr. Priya Ramakrishnan','₹34,000','₹52,000',
  'https://images.unsplash.com/photo-1504384308090-c894fdcc538d?auto=format&fit=crop&w=800&q=80',
  4.8, 560, true, 6, true,
  ARRAY['PyTorch','CNNs','Transformers','CUDA','Python','Hugging Face','ONNX','YOLOv8','Diffusion Models']::text[],
  ARRAY['Deep Learning Engineer','AI Researcher','Computer Vision Engineer','NLP Engineer']::text[],
  ARRAY['Laptop 8GB+ RAM (GPU recommended)','Stable internet','3–4 hrs/day','Linear algebra and Python']::text[],
  'published',
  'Deep Learning with PyTorch | Carpediem Tech',
  'Build CNNs, Transformers, and generative models with PyTorch and CUDA. 6 real deep learning projects in 14 weeks.',
  'PyTorch, Deep Learning, CNNs, Transformers, CUDA, Hugging Face, Diffusion Models', true
),

-- ── 10. Python Data Science ───────────────────────────────
(
  'Python for Data Science',
  'python-for-data-science',
  'Artificial Intelligence',
  'Analyse, visualise, and model data with the modern Python data stack.',
  E'## What You Will Build\n\n4 data science projects:\n\n1. **EDA Dashboard** — Pandas, Matplotlib, Seaborn, Streamlit\n2. **Sales Forecasting Model** — Time-series analysis, Prophet, ARIMA\n3. **Customer Segmentation** — K-Means, PCA, interactive cluster visualisation\n4. **End-to-End ML Pipeline** — scikit-learn Pipelines, feature stores, model cards\n\n## Curriculum\n\n- Python for data: NumPy broadcasting, Pandas DataFrames, indexing tricks\n- Data wrangling: missing values, outlier detection, encoding, scaling\n- Visualisation: Matplotlib, Seaborn, Plotly, Altair\n- Statistical inference: hypothesis testing, confidence intervals, A/B tests\n- Machine learning primer: regression, classification, clustering, evaluation\n- Time-series: decomposition, stationarity, ARIMA, Prophet\n- Streamlit for rapid data apps\n- SQL for analysts: window functions, CTEs, performance tuning',
  'Master the modern Python data stack — Pandas, NumPy, Matplotlib, Seaborn, scikit-learn, and Streamlit.',
  'Beginner','10 Weeks','English','Karthik Rajan','₹22,000','₹34,000',
  'https://images.unsplash.com/photo-1555066931-4365d14bab8c?auto=format&fit=crop&w=800&q=80',
  4.7, 1680, true, 4, true,
  ARRAY['Python','Pandas','NumPy','Matplotlib','Seaborn','Plotly','Streamlit','scikit-learn','Jupyter']::text[],
  ARRAY['Data Analyst','Data Scientist','Business Analyst','Research Analyst']::text[],
  ARRAY['Laptop 8GB+ RAM','Stable internet','3–4 hrs/day','Basic maths knowledge']::text[],
  'published',
  'Python for Data Science | Carpediem Tech',
  'Master Python for data science with Pandas, NumPy, Matplotlib, scikit-learn and Streamlit. 4 real projects in 10 weeks.',
  'Python, Data Science, Pandas, NumPy, Matplotlib, scikit-learn, Jupyter', true
),

-- ── 11. Data Engineering ──────────────────────────────────
(
  'Data Engineering with Python & Spark',
  'data-engineering-with-python-spark',
  'Artificial Intelligence',
  'Build batch and streaming data pipelines at scale with Spark and Airflow.',
  E'## What You Will Build\n\n5 pipeline projects:\n\n1. **Batch ETL Pipeline** — PySpark, Delta Lake, Parquet, S3\n2. **Real-Time Stream Processor** — Kafka + Spark Structured Streaming, CDC\n3. **Data Warehouse** — Star schema design, dbt transformations, Redshift\n4. **Orchestrated Workflow** — Apache Airflow DAGs, SLA monitoring, alerting\n5. **Data Platform Capstone** — End-to-end lakehouse on AWS or GCP\n\n## Curriculum\n\n- Python for data engineering: generators, decorators, async patterns\n- SQL at scale: window functions, CTEs, optimisation\n- Apache Spark: DataFrames, Spark SQL, Catalyst, PySpark best practices\n- Delta Lake / Apache Iceberg — ACID on the data lake\n- Apache Kafka: producers, consumers, Schema Registry, exactly-once semantics\n- Apache Airflow: DAG authoring, TaskFlow API, sensors, XComs\n- dbt: data transformation, testing, documentation\n- Cloud platforms: AWS Glue, S3, Redshift; GCP BigQuery, Dataflow\n- Data quality: Great Expectations, Soda',
  'Build production data pipelines with PySpark, Kafka, Airflow, Delta Lake, and dbt.',
  'Intermediate','14 Weeks','English','Karthik Rajan','₹28,000','₹42,000',
  'https://images.unsplash.com/photo-1518770660439-4636190af475?auto=format&fit=crop&w=800&q=80',
  4.7, 640, true, 5, true,
  ARRAY['Python','Apache Spark','Apache Airflow','Apache Kafka','SQL','Delta Lake','dbt','Redshift','BigQuery']::text[],
  ARRAY['Data Engineer','Analytics Engineer','Platform Engineer','Big Data Engineer']::text[],
  ARRAY['Laptop 8GB+ RAM','Stable internet','3–4 hrs/day','Python and SQL basics']::text[],
  'published',
  'Data Engineering with Python & Spark | Carpediem Tech',
  'Build batch and streaming data pipelines with PySpark, Kafka, Airflow and dbt. 5 real projects in 14 weeks.',
  'Data Engineering, Apache Spark, Kafka, Airflow, dbt, Delta Lake, Python', true
),

-- ── 12. Computer Vision ───────────────────────────────────
(
  'Computer Vision & Image AI',
  'computer-vision-image-ai',
  'Artificial Intelligence',
  'Object detection, segmentation, and generative image models in production.',
  E'## What You Will Build\n\n5 computer vision systems:\n\n1. **Object Detector** — YOLOv8 custom training, real-time inference, RTSP stream\n2. **Semantic Segmentation** — SAM (Segment Anything Model), mask generation\n3. **Face Recognition System** — ArcFace embeddings, faiss search, privacy-safe design\n4. **Image Generation App** — Stable Diffusion + ControlNet, ComfyUI pipeline\n5. **Vision Capstone** — Medical imaging, autonomous driving, or retail CV\n\n## Curriculum\n\n- Image fundamentals: colour spaces, morphology, convolutions (OpenCV)\n- CNN architectures: AlexNet → ResNet → EfficientNet → Vision Transformer\n- Object detection: YOLO family, DETR, Faster R-CNN\n- Segmentation: semantic, instance, panoptic\n- Generative models: GANs, VAEs, Diffusion (DDPM, DDIM)\n- ControlNet, LoRA fine-tuning, prompt-to-image pipelines\n- Deployment: TensorRT, ONNX Runtime, edge (Jetson Nano)\n- Video understanding: optical flow, action recognition',
  'Build object detection, segmentation, and generative image systems using OpenCV, YOLO, PyTorch, and Stable Diffusion.',
  'Advanced','12 Weeks','English','Dr. Priya Ramakrishnan','₹34,000','₹52,000',
  'https://images.unsplash.com/photo-1558494949-ef010cbdcc31?auto=format&fit=crop&w=800&q=80',
  4.7, 440, true, 5, true,
  ARRAY['OpenCV','YOLOv8','PyTorch','Stable Diffusion','SAM','TensorRT','ONNX','ControlNet']::text[],
  ARRAY['Computer Vision Engineer','AI Engineer','ML Engineer','Robotics Engineer']::text[],
  ARRAY['Laptop 8GB+ RAM (GPU strongly recommended)','Stable internet','3–4 hrs/day','Python and linear algebra']::text[],
  'published',
  'Computer Vision & Image AI | Carpediem Tech',
  'Build object detection, segmentation and generative image systems with YOLOv8, PyTorch and Stable Diffusion. 5 projects in 12 weeks.',
  'Computer Vision, YOLO, PyTorch, Stable Diffusion, OpenCV, Object Detection', true
),

-- ── 13. AWS Cloud ─────────────────────────────────────────
(
  'Cloud Architecture with AWS',
  'cloud-architecture-with-aws',
  'Cloud & DevOps',
  'Design scalable, cost-efficient cloud systems and prepare for AWS certification.',
  E'## What You Will Build\n\n6 production cloud architectures:\n\n1. **3-Tier Web App** — EC2, ALB, RDS Multi-AZ, CloudFront CDN\n2. **Serverless API** — Lambda, API Gateway, DynamoDB, Cognito auth\n3. **Data Lake** — S3, Glue, Athena, Lake Formation governance\n4. **Container Platform** — ECS Fargate, ECR, App Mesh service mesh\n5. **ML Inference Pipeline** — SageMaker endpoint, Step Functions, S3 trigger\n6. **AWS Capstone** — Your own architecture, cost-optimised, SAA-C03 ready\n\n## Curriculum\n\n- AWS core: IAM, VPC, EC2, S3, RDS, CloudFront, Route 53\n- Serverless: Lambda, API Gateway, Step Functions, EventBridge\n- Containers: ECS, EKS, Fargate, ECR\n- Infrastructure as Code: CloudFormation, AWS CDK (TypeScript)\n- Well-Architected Framework: 6 pillars, design reviews\n- Cost optimisation: Reserved Instances, Spot, Savings Plans, Cost Explorer\n- Security: KMS, Secrets Manager, WAF, GuardDuty, Security Hub\n- Observability: CloudWatch, X-Ray, AWS Config\n- SAA-C03 exam prep: practice questions and mock exam',
  'Design cost-efficient AWS architectures across compute, serverless, containers, and data with IaC.',
  'Intermediate','14 Weeks','English','Suresh Murugesan','₹28,000','₹42,000',
  'https://images.unsplash.com/photo-1526374965328-7f61d4dc18c5?auto=format&fit=crop&w=800&q=80',
  4.8, 860, true, 6, true,
  ARRAY['AWS','EC2','S3','Lambda','CloudFormation','CDK','ECS','EKS','DynamoDB','SageMaker']::text[],
  ARRAY['Cloud Engineer','Solutions Architect','DevOps Engineer','Platform Engineer']::text[],
  ARRAY['Laptop 8GB+ RAM','Stable internet','3–4 hrs/day','Basic Linux and networking']::text[],
  'published',
  'Cloud Architecture with AWS | Carpediem Tech',
  'Design scalable AWS architectures and prepare for SAA-C03 certification. Build 6 real cloud systems in 14 weeks.',
  'AWS, Cloud Architecture, EC2, Lambda, ECS, CloudFormation, SAA-C03, DevOps', true
),

-- ── 14. Kubernetes / DevOps ───────────────────────────────
(
  'Kubernetes & DevOps Engineering',
  'kubernetes-devops-engineering',
  'Cloud & DevOps',
  'Master containers, Kubernetes, GitOps, and production-grade CI/CD pipelines.',
  E'## What You Will Build\n\n5 DevOps infrastructure projects:\n\n1. **Containerised Microservices** — Docker multi-stage builds, Compose, networking\n2. **Kubernetes Cluster** — kubeadm / EKS, deployments, services, ingress, HPA\n3. **GitOps Pipeline** — ArgoCD, Helm chart authoring, progressive delivery (Argo Rollouts)\n4. **Observability Stack** — Prometheus, Grafana, Loki, Tempo (full o11y)\n5. **DevOps Capstone** — End-to-end platform for a real app (CI → build → scan → deploy → monitor)\n\n## Curriculum\n\n- Docker: image layers, multi-stage, security hardening, BuildKit\n- Kubernetes objects: Pod, Deployment, Service, ConfigMap, Secret, Ingress, PVC\n- Kubernetes operations: namespaces, RBAC, network policies, admission controllers\n- Helm: chart development, values, templating, chart testing\n- ArgoCD GitOps model, ApplicationSets, sync waves\n- CI/CD: GitHub Actions, GitLab CI, Jenkins pipelines\n- Infrastructure as Code: Terraform, Terragrunt, Atlantis\n- Prometheus scraping, PromQL, Alertmanager routing\n- Grafana dashboards, Loki log aggregation, distributed tracing',
  'Master Docker, Kubernetes, GitOps with ArgoCD, Terraform, and production observability.',
  'Advanced','12 Weeks','English','Suresh Murugesan','₹34,000','₹52,000',
  'https://images.unsplash.com/photo-1504384308090-c894fdcc538d?auto=format&fit=crop&w=800&q=80',
  4.7, 720, true, 5, true,
  ARRAY['Kubernetes','Docker','Helm','ArgoCD','GitHub Actions','Terraform','Prometheus','Grafana','Loki']::text[],
  ARRAY['DevOps Engineer','Platform Engineer','Site Reliability Engineer','Cloud Engineer']::text[],
  ARRAY['Laptop 8GB+ RAM','Stable internet','3–4 hrs/day','Linux fundamentals and networking']::text[],
  'published',
  'Kubernetes & DevOps Engineering | Carpediem Tech',
  'Master Kubernetes, Docker, GitOps with ArgoCD, Terraform and production observability. 5 real projects in 12 weeks.',
  'Kubernetes, Docker, DevOps, GitOps, ArgoCD, Helm, Terraform, Prometheus', true
),

-- ── 15. DevSecOps ─────────────────────────────────────────
(
  'DevSecOps & CI/CD Automation',
  'devsecops-ci-cd-automation',
  'Cloud & DevOps',
  'Bake security into pipelines with automated scanning and policy-as-code.',
  E'## What You Will Build\n\n5 DevSecOps automation projects:\n\n1. **Secure CI Pipeline** — GitHub Actions with SAST (SonarQube), SCA (Snyk), secret detection\n2. **Container Security Workflow** — Trivy image scanning, Cosign signing, OCI supply chain\n3. **Policy-as-Code Enforcement** — OPA Gatekeeper, Kyverno policies for Kubernetes\n4. **Infrastructure Hardening** — CIS benchmarks, Ansible remediation, Terraform Sentinel\n5. **Security Dashboard** — SIEM with OpenSearch, alert correlation, incident runbooks\n\n## Curriculum\n\n- DevSecOps principles: shift-left, zero-trust, supply chain security\n- SAST: SonarQube, Semgrep, CodeQL\n- SCA: Snyk, Dependabot, SBOM generation (Syft, CycloneDX)\n- Container security: Trivy, Grype, Clair, Falco runtime detection\n- Secrets management: HashiCorp Vault, AWS Secrets Manager, sealed secrets\n- IaC security: Checkov, Terraform Sentinel, tfsec\n- Kubernetes security: network policies, PSA, OPA Gatekeeper, Kyverno\n- Compliance: SOC 2, ISO 27001 mapping to technical controls',
  'Embed security into every CI/CD stage with SAST, SCA, container scanning, policy-as-code, and SIEM.',
  'Advanced','10 Weeks','English','Suresh Murugesan','₹34,000','₹52,000',
  'https://images.unsplash.com/photo-1526374965328-7f61d4dc18c5?auto=format&fit=crop&w=800&q=80',
  4.7, 380, true, 5, true,
  ARRAY['GitHub Actions','SonarQube','Trivy','Terraform','OPA','Kyverno','Snyk','HashiCorp Vault','Falco']::text[],
  ARRAY['DevSecOps Engineer','SRE','Security Engineer','Platform Engineer']::text[],
  ARRAY['Laptop 8GB+ RAM','Stable internet','3–4 hrs/day','CI/CD and Linux experience']::text[],
  'published',
  'DevSecOps & CI/CD Automation | Carpediem Tech',
  'Bake security into CI/CD pipelines with SAST, container scanning, policy-as-code and SIEM. 5 real projects in 10 weeks.',
  'DevSecOps, CI/CD, SonarQube, Trivy, OPA, Kyverno, Snyk, HashiCorp Vault', true
),

-- ── 16. Golang ────────────────────────────────────────────
(
  'Golang Backend Engineering',
  'golang-backend-engineering',
  'Cloud & DevOps',
  'Build high-performance microservices and APIs with Go.',
  E'## What You Will Build\n\n5 backend systems:\n\n1. **RESTful API Service** — Chi router, PostgreSQL, sqlc, JWT auth, OpenAPI spec\n2. **gRPC Microservice** — Protocol Buffers, bidirectional streaming, TLS\n3. **Message-Driven System** — NATS / Kafka consumers, outbox pattern, saga orchestration\n4. **High-Concurrency Job Queue** — Goroutine pools, rate limiting, backpressure, circuit breakers\n5. **Go Capstone** — Full microservice mesh: API Gateway + 3 services + observability\n\n## Curriculum\n\n- Go fundamentals: interfaces, goroutines, channels, context\n- HTTP servers: net/http, Chi, Fiber, middleware patterns\n- Database: sqlc, pgx, connection pooling, migrations (goose/migrate)\n- gRPC + Protocol Buffers, interceptors, streaming\n- Testing: table-driven tests, mocks (mockery), integration tests (testcontainers)\n- Observability: OpenTelemetry traces, Prometheus metrics, structured logging (zap/slog)\n- Performance: profiling with pprof, benchmarking, escape analysis\n- Deployment: Docker, Kubernetes, Helm',
  'Build high-performance Go microservices with gRPC, sqlc, NATS, and full observability.',
  'Intermediate','12 Weeks','English','Suresh Murugesan','₹28,000','₹42,000',
  'https://images.unsplash.com/photo-1573164713988-8665fc963095?auto=format&fit=crop&w=800&q=80',
  4.7, 500, true, 5, true,
  ARRAY['Go','gRPC','PostgreSQL','Docker','Microservices','sqlc','NATS','OpenTelemetry','Protocol Buffers']::text[],
  ARRAY['Backend Engineer','Golang Developer','Platform Engineer','API Developer']::text[],
  ARRAY['Laptop 8GB+ RAM','Stable internet','3–4 hrs/day','At least one backend language experience']::text[],
  'published',
  'Golang Backend Engineering | Carpediem Tech',
  'Build high-performance Go microservices with gRPC, sqlc, NATS and OpenTelemetry. 5 real projects in 12 weeks.',
  'Golang, Go, gRPC, Microservices, PostgreSQL, Docker, Backend Engineering', true
),

-- ── 17. SRE ──────────────────────────────────────────────
(
  'Site Reliability Engineering (SRE)',
  'site-reliability-engineering-sre',
  'Cloud & DevOps',
  'Observability, SLOs, incident response, and resilient systems at scale.',
  E'## What You Will Build\n\n5 reliability engineering projects:\n\n1. **SLO Dashboard** — Define SLIs, burn-rate alerts, error budget tracking in Grafana\n2. **Chaos Engineering Experiments** — Litmus Chaos, GameDay runbooks, blast radius containment\n3. **Auto-Healing System** — Kubernetes Operators, PagerDuty webhooks, automated remediation\n4. **Capacity Planning Model** — Prometheus forecasting, load testing (k6), resource right-sizing\n5. **SRE Capstone** — On-call runbook library + incident post-mortem framework\n\n## Curriculum\n\n- SRE principles: toil, error budgets, SLI/SLO/SLA definitions\n- Observability: Prometheus + Alertmanager, Grafana, Loki, Tempo\n- Distributed tracing: OpenTelemetry, Jaeger, correlation IDs\n- Incident management: PagerDuty, Opsgenie, DORA metrics\n- Chaos engineering: principles, GameDays, Litmus, Gremlin\n- Capacity planning and load testing with k6\n- Kubernetes reliability patterns: PodDisruptionBudgets, topology spread, PriorityClasses\n- Runbook automation: Ansible, Rundeck, custom Kubernetes Operators',
  'Build production SRE practice with SLOs, chaos engineering, Prometheus, Grafana, and incident automation.',
  'Advanced','12 Weeks','English','Suresh Murugesan','₹34,000','₹52,000',
  'https://images.unsplash.com/photo-1550751827-4bd374c3f58b?auto=format&fit=crop&w=800&q=80',
  4.8, 360, true, 5, true,
  ARRAY['Prometheus','Grafana','Kubernetes','Terraform','PagerDuty','OpenTelemetry','Litmus Chaos','k6','Loki']::text[],
  ARRAY['SRE','Platform Engineer','DevOps Engineer','Cloud Engineer']::text[],
  ARRAY['Laptop 8GB+ RAM','Stable internet','3–4 hrs/day','Kubernetes and Linux experience']::text[],
  'published',
  'Site Reliability Engineering (SRE) | Carpediem Tech',
  'Build production SRE practice with SLOs, chaos engineering, Prometheus, Grafana, and incident automation. 5 real projects.',
  'SRE, Site Reliability Engineering, Prometheus, Grafana, Kubernetes, Chaos Engineering', true
),

-- ── 18. Cybersecurity ────────────────────────────────────
(
  'Cybersecurity & Ethical Hacking',
  'cybersecurity-ethical-hacking',
  'Cloud & DevOps',
  'Hands-on offensive security: pentesting, exploitation, and defence.',
  E'## What You Will Build\n\n5 security projects:\n\n1. **Reconnaissance Toolkit** — OSINT framework, Shodan/FOFA queries, custom scanner\n2. **Web App Pentest Report** — Burp Suite Pro workflows, OWASP Top 10 exploitation, remediation writeup\n3. **Network Attack Lab** — Metasploit, privilege escalation, lateral movement, post-exploitation\n4. **CTF Write-Ups Portfolio** — 10 HackTheBox / TryHackMe machines documented\n5. **Red Team Capstone** — Full simulated engagement: recon → initial access → exfil → report\n\n## Curriculum\n\n- Networking fundamentals for hackers: TCP/IP, ARP, DNS, HTTP internals\n- Linux and Windows privilege escalation\n- Web application attacks: SQLi, XSS, CSRF, SSRF, XXE, IDOR, deserialization\n- Active Directory attacks: Kerberoasting, Pass-the-Hash, DCSync\n- Wireless attacks: WPA2 cracking, evil-twin, captive portal bypass\n- Malware analysis basics: static + dynamic, sandboxing\n- Defensive controls: WAF, EDR, SIEM tuning\n- OSCP exam strategy and report writing\n- Bug bounty platform orientation (HackerOne, Bugcrowd)',
  'Master offensive security through hands-on pentesting, exploitation, and real-world red team simulations.',
  'Intermediate','14 Weeks','English','Karthik Rajan','₹28,000','₹42,000',
  'https://images.unsplash.com/photo-1573164713988-8665fc963095?auto=format&fit=crop&w=800&q=80',
  4.9, 810, true, 5, true,
  ARRAY['Kali Linux','Burp Suite','Metasploit','Networking','OSCP','Nmap','Wireshark','Active Directory','OSINT']::text[],
  ARRAY['Security Analyst','Penetration Tester','Red Team Operator','Bug Bounty Hunter']::text[],
  ARRAY['Laptop 8GB+ RAM','Stable internet','3–4 hrs/day','Basic networking and Linux']::text[],
  'published',
  'Cybersecurity & Ethical Hacking | Carpediem Tech',
  'Master pentesting, exploitation and red teaming with Burp Suite, Metasploit, and Kali Linux. OSCP-aligned curriculum.',
  'Cybersecurity, Ethical Hacking, Pentesting, OSCP, Burp Suite, Metasploit, Kali Linux', true
),

-- ── 19. UI/UX ─────────────────────────────────────────────
(
  'UI/UX Product Design',
  'ui-ux-product-design',
  'Product Design',
  'Design delightful, accessible product experiences from research to high-fidelity UI.',
  E'## What You Will Build\n\n4 portfolio-quality design projects:\n\n1. **Mobile App Redesign** — Competitive audit, user interviews, wireframes, hi-fi prototype\n2. **Design System** — Component library (Figma Variants), tokens, documentation site\n3. **SaaS Dashboard** — Complex data visualisation, responsive grid, accessibility audit\n4. **UX Capstone** — Full product design sprint: problem framing → prototype → usability test → handoff\n\n## Curriculum\n\n- Design thinking process: empathy mapping, how-might-we, crazy-8s\n- User research: interviews, surveys, usability tests, affinity mapping\n- Information architecture: card sorting, tree testing, sitemaps, user flows\n- Wireframing: low-fidelity sketching, mid-fidelity flows\n- Figma mastery: auto-layout, components, variants, variables, prototyping\n- Visual design: colour theory, typography, spacing systems, motion basics\n- Design systems: tokens, documentation, component governance\n- Accessibility: WCAG 2.2 AA, inclusive design, screen reader testing\n- Handoff: Figma Dev Mode, style guides, developer collaboration',
  'Master UX research, Figma, design systems, and accessibility through 4 real product design projects.',
  'Beginner','10 Weeks','English','Magesh Sundar','₹22,000','₹34,000',
  'https://images.unsplash.com/photo-1558494949-ef010cbdcc31?auto=format&fit=crop&w=800&q=80',
  4.8, 1100, true, 4, true,
  ARRAY['Figma','User Research','Wireframing','Design Systems','Prototyping','Accessibility','WCAG','Usability Testing']::text[],
  ARRAY['Product Designer','UX Designer','UI Designer','UX Researcher']::text[],
  ARRAY['Laptop 8GB+ RAM','Stable internet','3–4 hrs/day','No prior design experience needed']::text[],
  'published',
  'UI/UX Product Design | Carpediem Tech',
  'Design delightful, accessible product experiences from research to hi-fi prototypes. 4 real Figma projects in 10 weeks.',
  'UI/UX Design, Figma, UX Research, Design Systems, Prototyping, Product Design', true
),

-- ── 20. Product Management ────────────────────────────────
(
  'Product Management Essentials',
  'product-management-essentials',
  'Product Design',
  'Discovery, roadmaps, metrics, and stakeholder work to ship products that matter.',
  E'## What You Will Build\n\n3 product management deliverables:\n\n1. **Product Discovery Package** — Problem statement, Jobs-to-be-Done canvas, competitive matrix, opportunity sizing\n2. **Product Roadmap & PRD** — Prioritised roadmap (RICE/MoSCoW), user stories, acceptance criteria, technical collaboration workshop\n3. **PM Capstone** — End-to-end product spec: discovery → roadmap → go-to-market plan → success metrics\n\n## Curriculum\n\n- PM fundamentals: discovery vs delivery, outcome vs output, PM archetypes\n- User research methods: customer interviews, surveys, data analysis\n- Jobs-to-be-Done and opportunity solution trees\n- Prioritisation: RICE, ICE, MoSCoW, Kano model\n- Writing PRDs, user stories, and acceptance criteria\n- Roadmap communication: internal, stakeholder, engineering\n- Metrics: North Star, HEART, AARRR funnel, experimentation\n- A/B testing design and statistical significance\n- Go-to-market: launch planning, pricing, positioning\n- Working with design and engineering: cross-functional rituals',
  'Master product discovery, roadmapping, metrics, and stakeholder management through real PM deliverables.',
  'Beginner','8 Weeks','English','Magesh Sundar','₹22,000','₹34,000',
  'https://images.unsplash.com/photo-1518770660439-4636190af475?auto=format&fit=crop&w=800&q=80',
  4.6, 730, true, 3, true,
  ARRAY['Roadmapping','User Stories','Analytics','A/B Testing','Figma','JIRA','Mixpanel','SQL for PMs']::text[],
  ARRAY['Associate Product Manager','Product Owner','Growth PM','Technical PM']::text[],
  ARRAY['Laptop 8GB+ RAM','Stable internet','3–4 hrs/day','No technical background required']::text[],
  'published',
  'Product Management Essentials | Carpediem Tech',
  'Master product discovery, roadmapping, metrics and stakeholder management. Real PM deliverables in 8 weeks.',
  'Product Management, Roadmapping, User Stories, A/B Testing, Product Discovery, PM', true
)

ON CONFLICT (slug) DO UPDATE SET
  title                = EXCLUDED.title,
  category             = EXCLUDED.category,
  description          = EXCLUDED.description,
  long_description     = EXCLUDED.long_description,
  overview             = EXCLUDED.overview,
  difficulty           = EXCLUDED.difficulty,
  duration             = EXCLUDED.duration,
  language             = EXCLUDED.language,
  instructor           = EXCLUDED.instructor,
  price                = EXCLUDED.price,
  discount_price       = EXCLUDED.discount_price,
  course_image         = EXCLUDED.course_image,
  rating               = EXCLUDED.rating,
  students_enrolled    = EXCLUDED.students_enrolled,
  certificate_included = EXCLUDED.certificate_included,
  projects_included    = EXCLUDED.projects_included,
  placement_support    = EXCLUDED.placement_support,
  tools_covered        = EXCLUDED.tools_covered,
  career_outcomes      = EXCLUDED.career_outcomes,
  requirements         = EXCLUDED.requirements,
  status               = EXCLUDED.status,
  seo_title            = EXCLUDED.seo_title,
  seo_description      = EXCLUDED.seo_description,
  meta_keywords        = EXCLUDED.meta_keywords,
  is_published         = EXCLUDED.is_published,
  updated_at           = NOW();

-- ============================================================
-- STEP 11  SEED — TESTIMONIALS (8 sample reviews)
-- ============================================================
INSERT INTO public.testimonials
  (student_name, photo, course, company, job_role, rating, review, featured, status)
VALUES
(
  'Arjun Venkataraman',
  'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=400&q=80',
  'Full-Stack Development with React & Node.js',
  'Zoho Corporation',
  'Software Engineer',
  5,
  'Carpediem Tech completely changed my career trajectory. I went from zero professional experience to landing a Software Engineer role at Zoho within 3 months of completing the Full-Stack course. The project-based approach meant I had a real portfolio to show — not just certificates.',
  true, 'published'
),
(
  'Kavya Subramaniam',
  'https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&w=400&q=80',
  'Generative AI & LLM Application Development',
  'Freshworks',
  'AI Engineer',
  5,
  'Dr. Priya''s teaching style is unmatched. Complex RAG pipelines and LangGraph orchestration became intuitive through her hands-on projects. I shipped a production RAG chatbot in Week 3! Now I''m an AI Engineer at Freshworks — couldn''t have done it without this course.',
  true, 'published'
),
(
  'Rahul Krishnamurthy',
  'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=400&q=80',
  'Cloud Architecture with AWS',
  'Infosys',
  'Cloud Solutions Architect',
  5,
  'Suresh''s cloud course is the most practical AWS content I have seen anywhere. I passed my SAA-C03 on the first attempt and got a promotion to Cloud Solutions Architect within 6 months. The capstone project alone was worth the entire investment.',
  true, 'published'
),
(
  'Preethi Rajendran',
  'https://images.unsplash.com/photo-1544005313-94ddf0286df2?auto=format&fit=crop&w=400&q=80',
  'UI/UX Product Design',
  'Swiggy',
  'Product Designer',
  5,
  'The UI/UX course gave me the confidence to walk into design interviews and stand out. Magesh pushed us to think about real user problems — not just pretty screens. I landed a Product Designer role at Swiggy after presenting my capstone in my portfolio. Absolutely worth it.',
  true, 'published'
),
(
  'Vikram Narayanan',
  'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?auto=format&fit=crop&w=400&q=80',
  'Cybersecurity & Ethical Hacking',
  'TCS (Cybersecurity Practice)',
  'Penetration Tester',
  5,
  'Karthik knows his field inside out. His red-team simulations were genuinely challenging — not just script-kiddie exercises. I got my OSCP, joined TCS''s cybersecurity practice, and I''m already billing clients for penetration tests. Best investment I''ve made in my career.',
  false, 'published'
),
(
  'Ananya Balakrishnan',
  'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?auto=format&fit=crop&w=400&q=80',
  'Machine Learning & MLOps',
  'Lam Research',
  'ML Engineer',
  5,
  'The ML + MLOps course taught me what no online tutorial ever did — how to take a model from a notebook to a monitored production system. The Evidently AI drift detection project was eye-opening. I joined Lam Research''s ML team and they were impressed I already knew MLOps on day one.',
  false, 'published'
),
(
  'Siddharth Raghavan',
  'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?auto=format&fit=crop&w=400&q=80',
  'Kubernetes & DevOps Engineering',
  'Razorpay',
  'DevOps Engineer',
  5,
  'I was a manual-deployment developer before this course. Now I manage Kubernetes clusters at Razorpay and our team ships 10x faster. The ArgoCD GitOps module alone saved us weeks of engineering time. Suresh is an exceptional mentor — responds to every question promptly.',
  false, 'published'
),
(
  'Meenakshi Chandrasekaran',
  'https://images.unsplash.com/photo-1487412720507-e7ab37603c6f?auto=format&fit=crop&w=400&q=80',
  'Python for Data Science',
  'Mu Sigma',
  'Data Analyst',
  4,
  'A great entry point into data science. The Streamlit dashboard project was something I could show to employers immediately. Karthik explains Pandas and visualisation very clearly. Got placed at Mu Sigma as a Data Analyst — the course helped me crack the analytics round easily.',
  false, 'published'
)
ON CONFLICT DO NOTHING;

-- ============================================================
-- Done! All schema objects + seed data inserted.
-- Run: SELECT COUNT(*) FROM public.courses; -- should be 20
-- Run: SELECT COUNT(*) FROM public.mentors; -- should be 5
-- ============================================================
