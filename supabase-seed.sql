-- ============================================================
-- CARPEDIEM TECH — GRANTS + SEED DATA (v2)
-- Run this once in the Supabase SQL Editor (Dashboard → SQL Editor).
-- New Supabase project: elqkyhmziiibdkvykata.supabase.co
-- ============================================================
-- Safe to re-run (idempotent via ON CONFLICT / DELETE+INSERT).
-- ============================================================

-- 1) Restore privileges
GRANT USAGE ON SCHEMA public TO anon, authenticated, service_role;
GRANT SELECT ON public.courses, public.mentors, public.testimonials, public.settings TO anon;
GRANT SELECT, INSERT, UPDATE, DELETE ON public.courses, public.mentors, public.testimonials, public.settings TO authenticated, service_role;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO authenticated, service_role;

-- 2) Enable realtime for settings
DO $$
BEGIN
  BEGIN ALTER PUBLICATION supabase_realtime ADD TABLE public.settings; EXCEPTION WHEN duplicate_object THEN NULL; END;
  BEGIN ALTER PUBLICATION supabase_realtime ADD TABLE public.courses;  EXCEPTION WHEN duplicate_object THEN NULL; END;
  BEGIN ALTER PUBLICATION supabase_realtime ADD TABLE public.mentors;  EXCEPTION WHEN duplicate_object THEN NULL; END;
END $$;

-- ============================================================
-- 3) SITE SETTINGS seed
-- ============================================================
INSERT INTO public.settings (key, value) VALUES
  ('site', '{
    "name": "Carpediem Tech Innovations",
    "tagline": "Build Real Skills. Land Real Jobs.",
    "description": "Carpediem Tech is a premium tech education platform offering project-based courses in Software Engineering, AI, Cloud, DevOps, Product Design, and Cybersecurity — mentored by industry veterans.",
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
ON CONFLICT (key) DO UPDATE SET value = EXCLUDED.value;

-- ============================================================
-- 4) MENTORS seed (idempotent by name)
-- ============================================================
DELETE FROM public.mentors WHERE name IN (
  'Arun Kumar',
  'Dr. Priya Ramakrishnan',
  'Suresh Murugesan',
  'Magesh Sundar',
  'Karthik Rajan'
);

INSERT INTO public.mentors
  (name, designation, company, experience, bio, linkedin, github, twitter, website, skills, profile_image, display_order, featured_toggle, status)
VALUES
  (
    'Arun Kumar',
    'Full-Stack Architect',
    'Ex-Amazon',
    '10+ years',
    'Former SDE at Amazon, Arun has built high-scale distributed commerce systems serving millions of users daily. He specialises in clean architecture, microservices, and helping junior engineers level up fast. His courses blend real-world system design with hands-on project work — every module ships something real.',
    'https://linkedin.com/in/arunkumar',
    'https://github.com/arunkumar',
    NULL,
    NULL,
    ARRAY['React', 'Node.js', 'System Design', 'AWS', 'TypeScript', 'Next.js', 'Flutter', 'Rust', 'Blockchain']::text[],
    'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=800&q=80',
    1,
    true,
    'active'
  ),
  (
    'Dr. Priya Ramakrishnan',
    'Generative AI Lead',
    'PhD in Machine Learning',
    '12+ years',
    'PhD in Machine Learning from IIT Madras. Dr. Priya consults Fortune 500 companies on enterprise RAG pipelines, LLM fine-tuning, and autonomous agent deployments. She has published 20+ papers in NeurIPS, ICML, and ICLR. Her teaching philosophy: every student should be able to deploy a production AI system by the end of Week 2.',
    'https://linkedin.com/in/priyaramakrishnan',
    NULL,
    NULL,
    NULL,
    ARRAY['LLMs', 'PyTorch', 'RAG', 'Prompt Engineering', 'Python', 'MLOps', 'Deep Learning', 'Computer Vision', 'Generative AI']::text[],
    'https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&w=800&q=80',
    2,
    true,
    'active'
  ),
  (
    'Suresh Murugesan',
    'Cloud & DevOps Principal',
    'AWS Certified Solutions Architect',
    '9+ years',
    'AWS Solutions Principal and multi-cert holder (SAA, DevOps-Pro, Security-Specialty). Suresh has managed 300-node Kubernetes clusters and greenfield CI/CD platforms for fintech and SaaS scale-ups. His motto: if it isn''t automated and observable, it''s not production-ready.',
    'https://linkedin.com/in/sureshmurugesan',
    NULL,
    NULL,
    NULL,
    ARRAY['Kubernetes', 'AWS', 'Terraform', 'Docker', 'CI/CD', 'DevSecOps', 'Golang', 'SRE', 'GitHub Actions']::text[],
    'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=800&q=80',
    3,
    true,
    'active'
  ),
  (
    'Magesh Sundar',
    'Senior Product Designer',
    'Ex-Cognizant Digital Studio',
    '8+ years',
    'Former Head of Product Design at Cognizant''s Digital Studio, Magesh has shipped consumer-facing products used by 8M+ users and led a 22-person design org. He brings the full spectrum — from ethnographic user research and service blueprinting to high-fidelity Figma prototypes and design system governance.',
    'https://linkedin.com/in/mageshsundar',
    NULL,
    NULL,
    NULL,
    ARRAY['Figma', 'UX Research', 'Design Systems', 'Prototyping', 'Product Management', 'Accessibility', 'Motion Design']::text[],
    'https://images.unsplash.com/photo-1544005313-94ddf0286df2?auto=format&fit=crop&w=800&q=80',
    4,
    true,
    'active'
  ),
  (
    'Karthik Rajan',
    'Cybersecurity & Data Lead',
    'OSCP Certified | Ex-Wipro Security',
    '11+ years',
    'Offensive security expert, OSCP-certified red-teamer, and data engineering architect. Karthik runs adversarial penetration tests for banking and healthcare clients and builds streaming data platforms on Kafka + Spark. He believes every developer should know how their code gets exploited — before an attacker does.',
    'https://linkedin.com/in/karthikrajan',
    NULL,
    NULL,
    NULL,
    ARRAY['Ethical Hacking', 'Python', 'Apache Spark', 'SIEM', 'Networking', 'Burp Suite', 'Metasploit', 'Kali Linux', 'Data Engineering']::text[],
    'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?auto=format&fit=crop&w=800&q=80',
    5,
    false,
    'active'
  );

-- ============================================================
-- 5) COURSES seed (idempotent by slug — ON CONFLICT UPDATE)
-- ============================================================
INSERT INTO public.courses
  (title, slug, category, description, long_description, overview, difficulty, duration, language,
   instructor, price, discount_price, course_image, rating, students_enrolled,
   certificate_included, projects_included, placement_support,
   tools_covered, career_outcomes, requirements, status,
   seo_title, seo_description, meta_keywords, is_published)
VALUES

-- ── Software Engineering ──────────────────────────────────────────────────────
(
  'Full-Stack Development with React & Node.js',
  'full-stack-development-with-react-node-js',
  'Software Engineering',
  'Build production-grade full-stack apps with React, Node.js, and PostgreSQL.',
  '## What You Will Build

In 16 intensive weeks you will ship **6 production-grade projects**:

1. **Task Manager SaaS** — React + Node.js + PostgreSQL with JWT auth
2. **Real-Time Chat App** — WebSockets, Redis pub-sub, React
3. **E-Commerce API** — REST + GraphQL, Stripe payments, Docker
4. **CMS Dashboard** — Role-based access, file uploads, image optimisation
5. **Portfolio Site** — Next.js 15, Server Components, Vercel Edge
6. **Full-Stack Capstone** — Your own product idea, mentored and deployed

## Curriculum Highlights

- **Week 1–2** React 19 fundamentals, hooks, context, Zustand
- **Week 3–4** Node.js & Express, REST API design, middleware
- **Week 5–6** PostgreSQL, Prisma ORM, migrations, query optimisation
- **Week 7–8** Auth (JWT, OAuth 2.0, Supabase Auth)
- **Week 9–10** Docker, CI/CD with GitHub Actions
- **Week 11–12** TypeScript deep dive, testing (Vitest, Playwright)
- **Week 13–14** System design, scalability, caching with Redis
- **Week 15–16** Capstone, code review, deployment

## Mentorship
Weekly 1:1 sessions with Arun Kumar. Code reviews on every project PR.',
  'Build production-grade full-stack apps with React, Node.js, PostgreSQL, TypeScript, and Docker.',
  'Beginner',
  '16 Weeks',
  'English',
  'Arun Kumar',
  '₹22,000',
  '₹34,000',
  'https://images.unsplash.com/photo-1461749280684-dccba630e2f6?auto=format&fit=crop&w=800&q=80',
  4.9, 1240, true, 6, true,
  ARRAY['React', 'Node.js', 'Express', 'PostgreSQL', 'TypeScript', 'Docker', 'Prisma', 'Redis', 'GitHub Actions', 'Vitest']::text[],
  ARRAY['Full-Stack Developer', 'Backend Engineer', 'SDE-1', 'API Developer']::text[],
  ARRAY['Laptop with 8GB+ RAM', 'Stable internet connection', '3–4 hours daily commitment', 'Basic HTML/CSS/JS knowledge']::text[],
  'published',
  'Full-Stack Development with React & Node.js | Carpediem Tech',
  'Master full-stack development with React, Node.js, PostgreSQL, TypeScript and Docker. Ship 6 real projects in 16 weeks with weekly mentorship.',
  'React, Node.js, Express, PostgreSQL, TypeScript, Docker, Full-Stack Development',
  true
),

(
  'Next.js 15 & Modern Web Engineering',
  'next-js-15-modern-web-engineering',
  'Software Engineering',
  'Server Components, edge rendering, and full-stack Next.js for production.',
  '## What You Will Build

5 production-grade projects including:

1. **Blog Platform** — App Router, MDX, ISR, Algolia search
2. **SaaS Dashboard** — Server Actions, Supabase, role-based access
3. **E-Commerce Storefront** — Next Commerce, Stripe, edge middleware
4. **Real-Time Feed** — Server-Sent Events, Vercel Edge Runtime
5. **Next.js Capstone** — Your own idea, shipped to production

## Curriculum Highlights

- App Router architecture and file conventions
- React Server Components vs Client Components
- Server Actions and form mutations
- Edge Runtime and Middleware
- ISR, SSG, SSR — when to use each
- Optimistic UI with useOptimistic
- Next.js Image, Fonts, and Metadata APIs
- Deployment on Vercel with environment management',
  'Master Next.js 15 App Router, Server Components, Server Actions, and edge rendering.',
  'Intermediate',
  '10 Weeks',
  'English',
  'Arun Kumar',
  '₹28,000',
  '₹42,000',
  'https://images.unsplash.com/photo-1461749280684-dccba630e2f6?auto=format&fit=crop&w=800&q=80',
  4.8, 940, true, 5, true,
  ARRAY['Next.js 15', 'React', 'TypeScript', 'Tailwind CSS', 'Vercel', 'Supabase', 'Prisma', 'MDX', 'Algolia']::text[],
  ARRAY['Frontend Engineer', 'Full-Stack Developer', 'React Developer']::text[],
  ARRAY['Laptop with 8GB+ RAM', 'Stable internet', '3–4 hours daily commitment', 'React fundamentals']::text[],
  'published',
  'Next.js 15 & Modern Web Engineering | Carpediem Tech',
  'Learn Next.js 15 App Router, Server Components, Server Actions and edge rendering. Build 5 production projects in 10 weeks.',
  'Next.js 15, React, TypeScript, Tailwind, Vercel, Server Components',
  true
),

(
  'Mobile App Development with Flutter',
  'mobile-app-development-with-flutter',
  'Software Engineering',
  'Build cross-platform iOS & Android apps from one Flutter codebase.',
  '## What You Will Build

5 real apps across iOS and Android:

1. **Weather App** — REST APIs, state management (Riverpod), animations
2. **Chat Messenger** — Firebase Firestore, push notifications
3. **Fitness Tracker** — Local DB (SQLite/Hive), charts, health APIs
4. **Food Delivery Clone** — Maps, geolocation, Stripe payments
5. **Flutter Capstone** — Your own app, published to the Play Store

## Curriculum

- Dart language fundamentals and advanced patterns
- Flutter widget tree, state management (Riverpod, BLoC)
- Navigation with GoRouter
- Firebase Auth, Firestore, Storage, Cloud Functions
- REST APIs, Dio, JSON serialisation
- Responsive layouts, animations, custom painters
- Platform channels and native integrations
- App Store / Play Store submission',
  'Build cross-platform iOS & Android apps from one Flutter codebase using Riverpod and Firebase.',
  'Intermediate',
  '12 Weeks',
  'English',
  'Arun Kumar',
  '₹28,000',
  '₹42,000',
  'https://images.unsplash.com/photo-1550751827-4bd374c3f58b?auto=format&fit=crop&w=800&q=80',
  4.7, 690, true, 5, true,
  ARRAY['Flutter', 'Dart', 'Firebase', 'Riverpod', 'REST APIs', 'GoRouter', 'SQLite', 'Hive']::text[],
  ARRAY['Mobile Developer', 'Flutter Engineer', 'iOS/Android Developer']::text[],
  ARRAY['Laptop with 8GB+ RAM', 'Stable internet', '3–4 hours daily commitment', 'Basic programming knowledge']::text[],
  'published',
  'Mobile App Development with Flutter | Carpediem Tech',
  'Build cross-platform iOS and Android apps with Flutter, Dart, Riverpod and Firebase. Publish your own app in 12 weeks.',
  'Flutter, Dart, Firebase, Riverpod, Mobile Development, iOS, Android',
  true
),

(
  'Blockchain & Web3 Development',
  'blockchain-web3-development',
  'Software Engineering',
  'Write smart contracts and build decentralised apps on EVM chains.',
  '## What You Will Build

5 DApps from zero to deployment:

1. **ERC-20 Token** — Solidity, Hardhat, OpenZeppelin
2. **NFT Marketplace** — ERC-721, IPFS, Pinata, React frontend
3. **DAO Governance** — On-chain voting, timelock, multi-sig
4. **DeFi Yield Farm** — AMM mechanics, liquidity pools, staking
5. **Web3 Capstone** — Your own protocol or DApp

## Curriculum

- Solidity fundamentals and advanced patterns (upgradeable proxies, re-entrancy guards)
- Hardhat local chain, test scripting with Ethers.js / Viem
- OpenZeppelin contract library
- IPFS & decentralised storage
- Web3 frontend integration (wagmi, RainbowKit, viem)
- Security: common attack vectors and audit methodology
- Gas optimisation strategies
- Testnet and mainnet deployment',
  'Write Solidity smart contracts and build decentralised apps on EVM chains — from tokens to DAOs.',
  'Advanced',
  '12 Weeks',
  'English',
  'Arun Kumar',
  '₹34,000',
  '₹52,000',
  'https://images.unsplash.com/photo-1517180102446-f3ece451e9d8?auto=format&fit=crop&w=800&q=80',
  4.6, 420, true, 5, true,
  ARRAY['Solidity', 'Ethereum', 'Hardhat', 'Ethers.js', 'IPFS', 'wagmi', 'OpenZeppelin', 'Web3.js']::text[],
  ARRAY['Blockchain Developer', 'Smart Contract Engineer', 'Web3 Developer', 'DApp Developer']::text[],
  ARRAY['Laptop with 8GB+ RAM', 'Stable internet', '3–4 hours daily commitment', 'JavaScript/TypeScript fundamentals']::text[],
  'published',
  'Blockchain & Web3 Development | Carpediem Tech',
  'Write Solidity smart contracts and build DApps on Ethereum. Covers ERC-20, NFTs, DAOs, DeFi and Web3 frontend integration.',
  'Solidity, Ethereum, Hardhat, Web3, NFT, DeFi, Smart Contracts',
  true
),

(
  'Rust Systems Programming',
  'rust-systems-programming',
  'Software Engineering',
  'Write fast, memory-safe systems software with Rust.',
  '## What You Will Build

5 systems-level projects:

1. **CLI Tool** — Argument parsing (clap), file I/O, error handling
2. **HTTP Server** — Tokio async runtime, Axum framework, middleware
3. **Key-Value Store** — Custom B-tree, persistence, concurrent readers
4. **WebAssembly Module** — Compile Rust to WASM, run in browser
5. **Rust Capstone** — Network daemon, compiler plugin, or embedded firmware

## Curriculum

- Ownership, borrowing, lifetimes — deep intuition, not memorised rules
- Structs, enums, traits, generics
- Error handling with Result and custom error types
- Async I/O with Tokio
- Unsafe Rust and FFI
- Testing, benchmarking (criterion), fuzzing
- WebAssembly with wasm-bindgen
- Publishing to crates.io',
  'Master Rust ownership, async I/O with Tokio, and WebAssembly. Build 5 systems-level projects.',
  'Advanced',
  '12 Weeks',
  'English',
  'Arun Kumar',
  '₹34,000',
  '₹52,000',
  'https://images.unsplash.com/photo-1620712943543-bcc4688e7485?auto=format&fit=crop&w=800&q=80',
  4.7, 310, true, 5, true,
  ARRAY['Rust', 'Cargo', 'Tokio', 'Axum', 'WebAssembly', 'wasm-bindgen', 'clap', 'criterion']::text[],
  ARRAY['Systems Engineer', 'Backend Engineer', 'Embedded Engineer', 'WebAssembly Developer']::text[],
  ARRAY['Laptop with 8GB+ RAM', 'Stable internet', '3–4 hours daily commitment', 'C or Python background recommended']::text[],
  'published',
  'Rust Systems Programming | Carpediem Tech',
  'Learn Rust ownership, async Tokio, and WebAssembly. Build 5 real systems projects in 12 weeks.',
  'Rust, Tokio, Axum, WebAssembly, Systems Programming, Cargo',
  true
),

-- ── Artificial Intelligence ───────────────────────────────────────────────────
(
  'Generative AI & LLM Application Development',
  'generative-ai-llm-application-development',
  'Artificial Intelligence',
  'Ship real GenAI products with LLMs, RAG pipelines, and vector databases.',
  '## What You Will Build

5 production GenAI products:

1. **Semantic Search Engine** — LangChain, OpenAI Embeddings, Pinecone, FastAPI backend
2. **RAG Chatbot** — PDF ingestion, chunking strategies, context-aware Q&A
3. **AI Code Reviewer** — GPT-4o function calling, GitHub webhook integration
4. **Multi-Agent Research Assistant** — LangGraph, tool calling, autonomous loops
5. **GenAI SaaS Capstone** — Your own product with a React frontend, Supabase backend, and Stripe billing

## Curriculum Highlights

- LLM fundamentals: tokenisation, attention, transformer architecture
- OpenAI, Anthropic, Gemini, and open-source (Llama 3, Mistral) APIs
- Prompt engineering patterns: CoT, ReAct, few-shot, system prompts
- LangChain / LangGraph orchestration
- RAG pipeline: chunking, embedding, retrieval, reranking
- Vector databases: Pinecone, pgvector, ChromaDB
- LLM fine-tuning with LoRA / QLoRA
- Evaluation: RAGAS, LangSmith tracing
- Deployment: FastAPI, Docker, Vercel AI SDK',
  'Build production GenAI apps with OpenAI, LangChain, RAG pipelines and vector databases.',
  'Intermediate',
  '12 Weeks',
  'English',
  'Dr. Priya Ramakrishnan',
  '₹28,000',
  '₹42,000',
  'https://images.unsplash.com/photo-1555066931-4365d14bab8c?auto=format&fit=crop&w=800&q=80',
  4.9, 980, true, 5, true,
  ARRAY['OpenAI', 'LangChain', 'LangGraph', 'RAG', 'Pinecone', 'pgvector', 'Python', 'FastAPI', 'LangSmith']::text[],
  ARRAY['AI Engineer', 'LLM Developer', 'ML Engineer', 'GenAI Product Engineer']::text[],
  ARRAY['Laptop with 8GB+ RAM', 'Stable internet', '3–4 hours daily commitment', 'Python fundamentals']::text[],
  'published',
  'Generative AI & LLM Application Development | Carpediem Tech',
  'Ship real GenAI products with LLMs, RAG pipelines, LangChain and vector databases. Build 5 AI projects in 12 weeks.',
  'Generative AI, LLMs, RAG, LangChain, OpenAI, Pinecone, Python, AI Engineer',
  true
),

(
  'Prompt Engineering & AI Agents',
  'prompt-engineering-ai-agents',
  'Artificial Intelligence',
  'Design reliable prompts and build multi-agent automations with modern frameworks.',
  '## What You Will Build

4 AI automation projects:

1. **Prompt Library CLI** — Parametric prompts, template engine, A/B testing harness
2. **Customer Support Agent** — Tool-calling agent, escalation logic, Slack integration
3. **Research Automation Pipeline** — n8n + LangGraph, web search, citation extraction, PDF reports
4. **Multi-Agent Orchestration System** — Supervisor + specialist agents, shared memory, human-in-the-loop

## Curriculum

- Mental models for prompt design: zero-shot, few-shot, chain-of-thought, tree-of-thought
- Structured output (JSON mode, function calling, Instructor library)
- Evaluation: automated benchmarks, human preference labelling, LLM-as-judge
- Agentic frameworks: LangGraph, AutoGen, CrewAI
- Tool use: web search, code execution, file I/O, API calls
- Memory systems: short-term, long-term, episodic
- n8n for no-code automation orchestration
- Safety: prompt injection, jailbreak defence, output filtering',
  'Design reliable prompts and build production multi-agent automations with LangGraph, AutoGen, and n8n.',
  'Beginner',
  '8 Weeks',
  'English',
  'Dr. Priya Ramakrishnan',
  '₹22,000',
  '₹34,000',
  'https://images.unsplash.com/photo-1517180102446-f3ece451e9d8?auto=format&fit=crop&w=800&q=80',
  4.8, 1520, true, 4, true,
  ARRAY['Prompt Engineering', 'LangGraph', 'AutoGen', 'CrewAI', 'n8n', 'Python', 'Function Calling', 'Instructor']::text[],
  ARRAY['AI Automation Engineer', 'Prompt Engineer', 'AI Product Manager']::text[],
  ARRAY['Laptop with 8GB+ RAM', 'Stable internet', '3–4 hours daily commitment', 'Basic Python knowledge']::text[],
  'published',
  'Prompt Engineering & AI Agents | Carpediem Tech',
  'Master prompt engineering and build multi-agent AI automations with LangGraph, AutoGen and n8n. 4 real projects in 8 weeks.',
  'Prompt Engineering, AI Agents, LangGraph, AutoGen, n8n, CrewAI, Python',
  true
),

(
  'Machine Learning & MLOps',
  'machine-learning-mlops',
  'Artificial Intelligence',
  'From model training to deployment — the full ML lifecycle with MLOps best practices.',
  '## What You Will Build

6 end-to-end ML systems:

1. **Churn Prediction API** — scikit-learn, FastAPI, Docker, Prometheus monitoring
2. **Image Classifier** — Transfer learning (ResNet), MLflow experiment tracking
3. **Recommendation Engine** — Collaborative filtering, ALS, real-time serving
4. **NLP Sentiment Pipeline** — Fine-tuned BERT, Hugging Face Hub, batch inference
5. **Drift Detection System** — Evidently AI, automated retraining triggers
6. **MLOps Capstone** — Full pipeline: data → training → CI/CD → monitoring

## Curriculum

- Supervised, unsupervised, and ensemble methods
- Feature engineering and selection
- Hyperparameter tuning: Optuna, grid search, Bayesian optimisation
- MLflow for experiment tracking and model registry
- Docker + Kubernetes for model serving
- FastAPI + Triton inference server
- CI/CD for ML: GitHub Actions, DVC data versioning
- Model monitoring: Evidently, Arize, Grafana dashboards
- Responsible AI: fairness, explainability (SHAP, LIME)',
  'Master the full ML lifecycle — from training to production monitoring — with scikit-learn, MLflow, Docker and Kubernetes.',
  'Advanced',
  '16 Weeks',
  'English',
  'Dr. Priya Ramakrishnan',
  '₹34,000',
  '₹52,000',
  'https://images.unsplash.com/photo-1620712943543-bcc4688e7485?auto=format&fit=crop&w=800&q=80',
  4.8, 590, true, 6, true,
  ARRAY['scikit-learn', 'MLflow', 'Docker', 'FastAPI', 'Python', 'Kubernetes', 'DVC', 'Evidently', 'Optuna', 'Hugging Face']::text[],
  ARRAY['ML Engineer', 'MLOps Engineer', 'Data Scientist', 'AI Platform Engineer']::text[],
  ARRAY['Laptop with 8GB+ RAM', 'Stable internet', '3–4 hours daily commitment', 'Python and linear algebra basics']::text[],
  'published',
  'Machine Learning & MLOps | Carpediem Tech',
  'Master the full ML lifecycle from training to production monitoring. Build 6 end-to-end ML systems in 16 weeks.',
  'Machine Learning, MLOps, scikit-learn, MLflow, Docker, Python, Model Deployment',
  true
),

(
  'Deep Learning with PyTorch',
  'deep-learning-with-pytorch',
  'Artificial Intelligence',
  'Build and train neural networks for vision and NLP with PyTorch.',
  '## What You Will Build

6 deep learning projects:

1. **Image Classifier** — CNNs, data augmentation, transfer learning (ResNet, EfficientNet)
2. **Object Detection System** — YOLOv8 fine-tuning on custom dataset
3. **Text Classifier** — Transformer from scratch, BERT fine-tuning
4. **Image Generation** — Diffusion model (Stable Diffusion fine-tune with LoRA)
5. **Speech Recognition** — Whisper fine-tuning, audio preprocessing
6. **DL Capstone** — Your choice: Vision Transformer, LLM pretraining, or RL agent

## Curriculum

- Tensors, autograd, and the computation graph
- MLP → CNN → RNN → Transformer architecture progression
- Loss functions, optimisers, learning rate scheduling
- Regularisation: dropout, batch norm, weight decay
- GPU training: CUDA, mixed precision (AMP), gradient checkpointing
- Distributed training with PyTorch DDP
- Hugging Face Transformers and Datasets
- Diffusion models and generative architectures
- Deployment: ONNX export, TorchServe, FastAPI',
  'Build CNNs, Transformers, and generative models with PyTorch, CUDA, and Hugging Face.',
  'Advanced',
  '14 Weeks',
  'English',
  'Dr. Priya Ramakrishnan',
  '₹34,000',
  '₹52,000',
  'https://images.unsplash.com/photo-1504384308090-c894fdcc538d?auto=format&fit=crop&w=800&q=80',
  4.8, 560, true, 6, true,
  ARRAY['PyTorch', 'CNNs', 'Transformers', 'CUDA', 'Python', 'Hugging Face', 'ONNX', 'YOLOv8', 'Diffusion Models']::text[],
  ARRAY['Deep Learning Engineer', 'AI Researcher', 'Computer Vision Engineer', 'NLP Engineer']::text[],
  ARRAY['Laptop with 8GB+ RAM (GPU recommended)', 'Stable internet', '3–4 hours daily commitment', 'Linear algebra and Python']::text[],
  'published',
  'Deep Learning with PyTorch | Carpediem Tech',
  'Build CNNs, Transformers, and generative models with PyTorch and CUDA. 6 real deep learning projects in 14 weeks.',
  'PyTorch, Deep Learning, CNNs, Transformers, CUDA, Hugging Face, Diffusion Models',
  true
),

(
  'Python for Data Science',
  'python-for-data-science',
  'Artificial Intelligence',
  'Analyse, visualise, and model data with the modern Python data stack.',
  '## What You Will Build

4 data science projects:

1. **Exploratory Data Analysis Dashboard** — Pandas, Matplotlib, Seaborn, Streamlit
2. **Sales Forecasting Model** — Time-series analysis, Prophet, ARIMA
3. **Customer Segmentation** — K-Means, PCA, interactive cluster visualisation
4. **End-to-End ML Pipeline** — scikit-learn Pipelines, feature stores, model cards

## Curriculum

- Python for data: NumPy broadcasting, Pandas DataFrames, indexing tricks
- Data wrangling: missing values, outlier detection, encoding, scaling
- Visualisation: Matplotlib, Seaborn, Plotly, Altair
- Statistical inference: hypothesis testing, confidence intervals, A/B tests
- Machine learning primer: regression, classification, clustering, evaluation
- Time-series: decomposition, stationarity, ARIMA, Prophet
- Streamlit for rapid data apps
- SQL for analysts: window functions, CTEs, performance tuning
- Jupyter workflow best practices',
  'Master the modern Python data stack — Pandas, NumPy, Matplotlib, Seaborn, scikit-learn, and Streamlit.',
  'Beginner',
  '10 Weeks',
  'English',
  'Karthik Rajan',
  '₹22,000',
  '₹34,000',
  'https://images.unsplash.com/photo-1555066931-4365d14bab8c?auto=format&fit=crop&w=800&q=80',
  4.7, 1680, true, 4, true,
  ARRAY['Python', 'Pandas', 'NumPy', 'Matplotlib', 'Seaborn', 'Plotly', 'Streamlit', 'scikit-learn', 'Jupyter']::text[],
  ARRAY['Data Analyst', 'Data Scientist', 'Business Analyst', 'Research Analyst']::text[],
  ARRAY['Laptop with 8GB+ RAM', 'Stable internet', '3–4 hours daily commitment', 'Basic maths knowledge']::text[],
  'published',
  'Python for Data Science | Carpediem Tech',
  'Master Python for data science with Pandas, NumPy, Matplotlib, scikit-learn and Streamlit. 4 real projects in 10 weeks.',
  'Python, Data Science, Pandas, NumPy, Matplotlib, scikit-learn, Jupyter',
  true
),

(
  'Data Engineering with Python & Spark',
  'data-engineering-with-python-spark',
  'Artificial Intelligence',
  'Build batch and streaming data pipelines at scale with Spark and Airflow.',
  '## What You Will Build

5 pipeline projects:

1. **Batch ETL Pipeline** — PySpark, Delta Lake, Parquet, S3
2. **Real-Time Stream Processor** — Kafka + Spark Structured Streaming, CDC
3. **Data Warehouse** — Star schema design, dbt transformations, Redshift
4. **Orchestrated Workflow** — Apache Airflow DAGs, SLA monitoring, alerting
5. **Data Platform Capstone** — End-to-end lakehouse on AWS or GCP

## Curriculum

- Python for data engineering: generators, decorators, async patterns
- SQL at scale: window functions, CTEs, optimisation
- Apache Spark: DataFrames, Spark SQL, Catalyst, PySpark best practices
- Delta Lake / Apache Iceberg — ACID on the data lake
- Apache Kafka: producers, consumers, Schema Registry, exactly-once semantics
- Apache Airflow: DAG authoring, TaskFlow API, sensors, XComs
- dbt: data transformation, testing, documentation
- Cloud platforms: AWS Glue, S3, Redshift; GCP BigQuery, Dataflow
- Data quality: Great Expectations, Soda',
  'Build production data pipelines with PySpark, Kafka, Airflow, Delta Lake, and dbt.',
  'Intermediate',
  '14 Weeks',
  'English',
  'Karthik Rajan',
  '₹28,000',
  '₹42,000',
  'https://images.unsplash.com/photo-1518770660439-4636190af475?auto=format&fit=crop&w=800&q=80',
  4.7, 640, true, 5, true,
  ARRAY['Python', 'Apache Spark', 'Apache Airflow', 'Apache Kafka', 'SQL', 'Delta Lake', 'dbt', 'Redshift', 'BigQuery']::text[],
  ARRAY['Data Engineer', 'Analytics Engineer', 'Platform Engineer', 'Big Data Engineer']::text[],
  ARRAY['Laptop with 8GB+ RAM', 'Stable internet', '3–4 hours daily commitment', 'Python and SQL basics']::text[],
  'published',
  'Data Engineering with Python & Spark | Carpediem Tech',
  'Build batch and streaming data pipelines with PySpark, Kafka, Airflow and dbt. 5 real projects in 14 weeks.',
  'Data Engineering, Apache Spark, Kafka, Airflow, dbt, Delta Lake, Python',
  true
),

(
  'Computer Vision & Image AI',
  'computer-vision-image-ai',
  'Artificial Intelligence',
  'Object detection, segmentation, and generative image models in production.',
  '## What You Will Build

5 computer vision systems:

1. **Object Detector** — YOLOv8 custom training, real-time inference, RTSP stream
2. **Semantic Segmentation** — SAM (Segment Anything Model), mask generation
3. **Face Recognition System** — ArcFace embeddings, faiss search, privacy-safe design
4. **Image Generation App** — Stable Diffusion + ControlNet, ComfyUI pipeline
5. **Vision Capstone** — Medical imaging, autonomous driving, or retail CV

## Curriculum

- Image fundamentals: colour spaces, morphology, convolutions (OpenCV)
- CNN architectures: AlexNet → ResNet → EfficientNet → Vision Transformer
- Object detection: YOLO family, DETR, Faster R-CNN
- Segmentation: semantic, instance, panoptic
- Generative models: GANs, VAEs, Diffusion (DDPM, DDIM)
- ControlNet, LoRA fine-tuning, prompt-to-image pipelines
- Deployment: TensorRT, ONNX Runtime, edge (Jetson Nano)
- Video understanding: optical flow, action recognition',
  'Build object detection, segmentation, and generative image systems using OpenCV, YOLO, PyTorch, and Stable Diffusion.',
  'Advanced',
  '12 Weeks',
  'English',
  'Dr. Priya Ramakrishnan',
  '₹34,000',
  '₹52,000',
  'https://images.unsplash.com/photo-1558494949-ef010cbdcc31?auto=format&fit=crop&w=800&q=80',
  4.7, 440, true, 5, true,
  ARRAY['OpenCV', 'YOLOv8', 'PyTorch', 'Stable Diffusion', 'SAM', 'TensorRT', 'ONNX', 'ControlNet']::text[],
  ARRAY['Computer Vision Engineer', 'AI Engineer', 'ML Engineer', 'Robotics Engineer']::text[],
  ARRAY['Laptop with 8GB+ RAM (GPU strongly recommended)', 'Stable internet', '3–4 hours daily commitment', 'Python and linear algebra']::text[],
  'published',
  'Computer Vision & Image AI | Carpediem Tech',
  'Build object detection, segmentation and generative image systems with YOLOv8, PyTorch and Stable Diffusion. 5 projects in 12 weeks.',
  'Computer Vision, YOLO, PyTorch, Stable Diffusion, OpenCV, Object Detection, Image AI',
  true
),

-- ── Cloud & DevOps ────────────────────────────────────────────────────────────
(
  'Cloud Architecture with AWS',
  'cloud-architecture-with-aws',
  'Cloud & DevOps',
  'Design scalable, cost-efficient cloud systems and prepare for AWS certification.',
  '## What You Will Build

6 production cloud architectures:

1. **3-Tier Web App** — EC2, ALB, RDS Multi-AZ, CloudFront CDN
2. **Serverless API** — Lambda, API Gateway, DynamoDB, Cognito auth
3. **Data Lake** — S3, Glue, Athena, Lake Formation governance
4. **Container Platform** — ECS Fargate, ECR, App Mesh service mesh
5. **ML Inference Pipeline** — SageMaker endpoint, Step Functions, S3 trigger
6. **AWS Capstone** — Your own architecture, cost-optimised and documented for SAA-C03

## Curriculum

- AWS core: IAM, VPC, EC2, S3, RDS, CloudFront, Route 53
- Serverless: Lambda, API Gateway, Step Functions, EventBridge
- Containers: ECS, EKS, Fargate, ECR
- Infrastructure as Code: CloudFormation, AWS CDK (TypeScript)
- Well-Architected Framework: 6 pillars, design reviews
- Cost optimisation: Reserved Instances, Spot, Savings Plans, Cost Explorer
- Security: KMS, Secrets Manager, WAF, GuardDuty, Security Hub
- Observability: CloudWatch, X-Ray, AWS Config
- SAA-C03 exam prep: practice questions and mock exam',
  'Design cost-efficient AWS architectures across compute, serverless, containers, and data with IaC.',
  'Intermediate',
  '14 Weeks',
  'English',
  'Suresh Murugesan',
  '₹28,000',
  '₹42,000',
  'https://images.unsplash.com/photo-1526374965328-7f61d4dc18c5?auto=format&fit=crop&w=800&q=80',
  4.8, 860, true, 6, true,
  ARRAY['AWS', 'EC2', 'S3', 'Lambda', 'CloudFormation', 'CDK', 'ECS', 'EKS', 'DynamoDB', 'SageMaker']::text[],
  ARRAY['Cloud Engineer', 'Solutions Architect', 'DevOps Engineer', 'Platform Engineer']::text[],
  ARRAY['Laptop with 8GB+ RAM', 'Stable internet', '3–4 hours daily commitment', 'Basic Linux and networking']::text[],
  'published',
  'Cloud Architecture with AWS | Carpediem Tech',
  'Design scalable AWS architectures and prepare for SAA-C03 certification. Build 6 real cloud systems in 14 weeks.',
  'AWS, Cloud Architecture, EC2, Lambda, ECS, CloudFormation, SAA-C03, DevOps',
  true
),

(
  'Kubernetes & DevOps Engineering',
  'kubernetes-devops-engineering',
  'Cloud & DevOps',
  'Master containers, Kubernetes, GitOps, and production-grade CI/CD pipelines.',
  '## What You Will Build

5 DevOps infrastructure projects:

1. **Containerised Microservices** — Docker multi-stage builds, Compose, networking
2. **Kubernetes Cluster** — kubeadm / EKS, deployments, services, ingress, HPA
3. **GitOps Pipeline** — ArgoCD, Helm chart authoring, progressive delivery (Argo Rollouts)
4. **Observability Stack** — Prometheus, Grafana, Loki, Tempo (full o11y)
5. **DevOps Capstone** — End-to-end platform for a real app (CI → build → scan → deploy → monitor)

## Curriculum

- Docker: image layers, multi-stage, security hardening, BuildKit
- Kubernetes objects: Pod, Deployment, Service, ConfigMap, Secret, Ingress, PVC
- Kubernetes operations: namespaces, RBAC, network policies, admission controllers
- Helm: chart development, values, templating, chart testing
- ArgoCD GitOps model, ApplicationSets, sync waves
- CI/CD: GitHub Actions, GitLab CI, Jenkins pipelines
- Infrastructure as Code: Terraform, Terragrunt, Atlantis
- Prometheus scraping, PromQL, Alertmanager routing
- Grafana dashboards, Loki log aggregation, distributed tracing',
  'Master Docker, Kubernetes, GitOps with ArgoCD, Terraform, and production observability.',
  'Advanced',
  '12 Weeks',
  'English',
  'Suresh Murugesan',
  '₹34,000',
  '₹52,000',
  'https://images.unsplash.com/photo-1504384308090-c894fdcc538d?auto=format&fit=crop&w=800&q=80',
  4.7, 720, true, 5, true,
  ARRAY['Kubernetes', 'Docker', 'Helm', 'ArgoCD', 'GitHub Actions', 'Terraform', 'Prometheus', 'Grafana', 'Loki']::text[],
  ARRAY['DevOps Engineer', 'Platform Engineer', 'Site Reliability Engineer', 'Cloud Engineer']::text[],
  ARRAY['Laptop with 8GB+ RAM', 'Stable internet', '3–4 hours daily commitment', 'Linux fundamentals and networking']::text[],
  'published',
  'Kubernetes & DevOps Engineering | Carpediem Tech',
  'Master Kubernetes, Docker, GitOps with ArgoCD, Terraform and production observability. 5 real projects in 12 weeks.',
  'Kubernetes, Docker, DevOps, GitOps, ArgoCD, Helm, Terraform, Prometheus',
  true
),

(
  'DevSecOps & CI/CD Automation',
  'devsecops-ci-cd-automation',
  'Cloud & DevOps',
  'Bake security into pipelines with automated scanning and policy-as-code.',
  '## What You Will Build

5 DevSecOps automation projects:

1. **Secure CI Pipeline** — GitHub Actions with SAST (SonarQube), SCA (Snyk), secret detection
2. **Container Security Workflow** — Trivy image scanning, Cosign signing, OCI supply chain
3. **Policy-as-Code Enforcement** — OPA Gatekeeper, Kyverno policies for Kubernetes
4. **Infrastructure Hardening** — CIS benchmarks, Ansible remediation, Terraform Sentinel
5. **Security Dashboard** — SIEM with OpenSearch, alert correlation, incident runbooks

## Curriculum

- DevSecOps principles: shift-left, zero-trust, supply chain security
- SAST: SonarQube, Semgrep, CodeQL
- SCA: Snyk, Dependabot, SBOM generation (Syft, CycloneDX)
- Container security: Trivy, Grype, Clair, Falco runtime detection
- Secrets management: HashiCorp Vault, AWS Secrets Manager, sealed secrets
- IaC security: Checkov, Terraform Sentinel, tfsec
- Kubernetes security: network policies, PSA, OPA Gatekeeper, Kyverno
- Compliance: SOC 2, ISO 27001 mapping to technical controls',
  'Embed security into every CI/CD stage with SAST, SCA, container scanning, policy-as-code, and SIEM.',
  'Advanced',
  '10 Weeks',
  'English',
  'Suresh Murugesan',
  '₹34,000',
  '₹52,000',
  'https://images.unsplash.com/photo-1526374965328-7f61d4dc18c5?auto=format&fit=crop&w=800&q=80',
  4.7, 380, true, 5, true,
  ARRAY['GitHub Actions', 'SonarQube', 'Trivy', 'Terraform', 'OPA', 'Kyverno', 'Snyk', 'HashiCorp Vault', 'Falco']::text[],
  ARRAY['DevSecOps Engineer', 'SRE', 'Security Engineer', 'Platform Engineer']::text[],
  ARRAY['Laptop with 8GB+ RAM', 'Stable internet', '3–4 hours daily commitment', 'CI/CD and Linux experience']::text[],
  'published',
  'DevSecOps & CI/CD Automation | Carpediem Tech',
  'Bake security into CI/CD pipelines with SAST, container scanning, policy-as-code and SIEM. 5 real projects in 10 weeks.',
  'DevSecOps, CI/CD, SonarQube, Trivy, OPA, Kyverno, Snyk, HashiCorp Vault',
  true
),

(
  'Golang Backend Engineering',
  'golang-backend-engineering',
  'Cloud & DevOps',
  'Build high-performance microservices and APIs with Go.',
  '## What You Will Build

5 backend systems:

1. **RESTful API Service** — Chi router, PostgreSQL, sqlc, JWT auth, OpenAPI spec
2. **gRPC Microservice** — Protocol Buffers, bidirectional streaming, TLS
3. **Message-Driven System** — NATS / Kafka consumers, outbox pattern, saga orchestration
4. **High-Concurrency Job Queue** — Goroutine pools, rate limiting, backpressure, circuit breakers
5. **Go Capstone** — Full microservice mesh: API Gateway + 3 services + observability

## Curriculum

- Go fundamentals: interfaces, goroutines, channels, context
- HTTP servers: net/http, Chi, Fiber, middleware patterns
- Database: sqlc, pgx, connection pooling, migrations (goose/migrate)
- gRPC + Protocol Buffers, interceptors, streaming
- Testing: table-driven tests, mocks (mockery), integration tests (testcontainers)
- Observability: OpenTelemetry traces, Prometheus metrics, structured logging (zap/slog)
- Performance: profiling with pprof, benchmarking, escape analysis
- Deployment: Docker, Kubernetes, Helm',
  'Build high-performance Go microservices with gRPC, sqlc, NATS, and full observability.',
  'Intermediate',
  '12 Weeks',
  'English',
  'Suresh Murugesan',
  '₹28,000',
  '₹42,000',
  'https://images.unsplash.com/photo-1573164713988-8665fc963095?auto=format&fit=crop&w=800&q=80',
  4.7, 500, true, 5, true,
  ARRAY['Go', 'gRPC', 'PostgreSQL', 'Docker', 'Microservices', 'sqlc', 'NATS', 'OpenTelemetry', 'Protocol Buffers']::text[],
  ARRAY['Backend Engineer', 'Golang Developer', 'Platform Engineer', 'API Developer']::text[],
  ARRAY['Laptop with 8GB+ RAM', 'Stable internet', '3–4 hours daily commitment', 'At least one backend language experience']::text[],
  'published',
  'Golang Backend Engineering | Carpediem Tech',
  'Build high-performance Go microservices with gRPC, sqlc, NATS and OpenTelemetry. 5 real projects in 12 weeks.',
  'Golang, Go, gRPC, Microservices, PostgreSQL, Docker, Backend Engineering',
  true
),

(
  'Site Reliability Engineering (SRE)',
  'site-reliability-engineering-sre',
  'Cloud & DevOps',
  'Observability, SLOs, incident response, and resilient systems at scale.',
  '## What You Will Build

5 reliability engineering projects:

1. **SLO Dashboard** — Define SLIs, burn-rate alerts, error budget tracking in Grafana
2. **Chaos Engineering Experiments** — Litmus Chaos, GameDay runbooks, blast radius containment
3. **Auto-Healing System** — Kubernetes Operators, PagerDuty webhooks, automated remediation
4. **Capacity Planning Model** — Prometheus forecasting, load testing (k6), resource right-sizing
5. **SRE Capstone** — On-call runbook library + incident post-mortem framework for a real service

## Curriculum

- SRE principles: toil, error budgets, SLI/SLO/SLA definitions
- Observability: Prometheus + Alertmanager, Grafana, Loki, Tempo
- Distributed tracing: OpenTelemetry, Jaeger, correlation IDs
- Incident management: PagerDuty, Opsgenie, DORA metrics
- Chaos engineering: principles, GameDays, Litmus, Gremlin
- Capacity planning and load testing with k6
- Kubernetes reliability patterns: PodDisruptionBudgets, topology spread, PriorityClasses
- Runbook automation: Ansible, Rundeck, custom Kubernetes Operators',
  'Build production SRE practice with SLOs, chaos engineering, Prometheus, Grafana, and incident automation.',
  'Advanced',
  '12 Weeks',
  'English',
  'Suresh Murugesan',
  '₹34,000',
  '₹52,000',
  'https://images.unsplash.com/photo-1550751827-4bd374c3f58b?auto=format&fit=crop&w=800&q=80',
  4.8, 360, true, 5, true,
  ARRAY['Prometheus', 'Grafana', 'Kubernetes', 'Terraform', 'PagerDuty', 'OpenTelemetry', 'Litmus Chaos', 'k6', 'Loki']::text[],
  ARRAY['SRE', 'Platform Engineer', 'DevOps Engineer', 'Cloud Engineer']::text[],
  ARRAY['Laptop with 8GB+ RAM', 'Stable internet', '3–4 hours daily commitment', 'Kubernetes and Linux experience']::text[],
  'published',
  'Site Reliability Engineering (SRE) | Carpediem Tech',
  'Build production SRE practice with SLOs, chaos engineering, Prometheus, Grafana, and incident automation. 5 real projects.',
  'SRE, Site Reliability Engineering, Prometheus, Grafana, Kubernetes, Chaos Engineering',
  true
),

-- ── Cybersecurity ─────────────────────────────────────────────────────────────
(
  'Cybersecurity & Ethical Hacking',
  'cybersecurity-ethical-hacking',
  'Cloud & DevOps',
  'Hands-on offensive security: pentesting, exploitation, and defence.',
  '## What You Will Build

5 security projects:

1. **Reconnaissance Toolkit** — OSINT framework, Shodan/FOFA queries, custom scanner
2. **Web App Pentest Report** — Burp Suite Pro workflows, OWASP Top 10 exploitation, remediation writeup
3. **Network Attack Lab** — Metasploit, privilege escalation, lateral movement, post-exploitation
4. **CTF Write-Ups Portfolio** — 10 HackTheBox / TryHackMe machines documented
5. **Red Team Capstone** — Full simulated engagement: recon → initial access → exfil → report

## Curriculum

- Networking fundamentals for hackers: TCP/IP, ARP, DNS, HTTP internals
- Linux and Windows privilege escalation
- Web application attacks: SQLi, XSS, CSRF, SSRF, XXE, IDOR, deserialization
- Active Directory attacks: Kerberoasting, Pass-the-Hash, DCSync
- Wireless attacks: WPA2 cracking, evil-twin, captive portal bypass
- Malware analysis basics: static + dynamic, sandboxing
- Defensive controls: WAF, EDR, SIEM tuning
- OSCP exam strategy and report writing
- Bug bounty platform orientation (HackerOne, Bugcrowd)',
  'Master offensive security through hands-on pentesting, exploitation, and real-world red team simulations.',
  'Intermediate',
  '14 Weeks',
  'English',
  'Karthik Rajan',
  '₹28,000',
  '₹42,000',
  'https://images.unsplash.com/photo-1573164713988-8665fc963095?auto=format&fit=crop&w=800&q=80',
  4.9, 810, true, 5, true,
  ARRAY['Kali Linux', 'Burp Suite', 'Metasploit', 'Networking', 'OSCP', 'Nmap', 'Wireshark', 'Active Directory', 'OSINT']::text[],
  ARRAY['Security Analyst', 'Penetration Tester', 'Red Team Operator', 'Bug Bounty Hunter']::text[],
  ARRAY['Laptop with 8GB+ RAM', 'Stable internet', '3–4 hours daily commitment', 'Basic networking and Linux']::text[],
  'published',
  'Cybersecurity & Ethical Hacking | Carpediem Tech',
  'Master pentesting, exploitation and red teaming with Burp Suite, Metasploit, and Kali Linux. OSCP-aligned curriculum.',
  'Cybersecurity, Ethical Hacking, Pentesting, OSCP, Burp Suite, Metasploit, Kali Linux',
  true
),

-- ── Product Design ────────────────────────────────────────────────────────────
(
  'UI/UX Product Design',
  'ui-ux-product-design',
  'Product Design',
  'Design delightful, accessible product experiences from research to high-fidelity UI.',
  '## What You Will Build

4 portfolio-quality design projects:

1. **Mobile App Redesign** — Competitive audit, user interviews, wireframes, hi-fi prototype
2. **Design System** — Component library (Figma Variants), tokens, documentation site
3. **SaaS Dashboard** — Complex data visualisation, responsive grid, accessibility audit
4. **UX Capstone** — Full product design sprint: problem framing → prototype → usability test → handoff

## Curriculum

- Design thinking process: empathy mapping, how-might-we, crazy-8s
- User research: interviews, surveys, usability tests, affinity mapping
- Information architecture: card sorting, tree testing, sitemaps, user flows
- Wireframing: low-fidelity sketching, mid-fidelity flows
- Figma mastery: auto-layout, components, variants, variables, prototyping
- Visual design: colour theory, typography, spacing systems, motion basics
- Design systems: tokens, documentation, component governance
- Accessibility: WCAG 2.2 AA, inclusive design, screen reader testing
- Handoff: Figma Dev Mode, style guides, developer collaboration',
  'Master UX research, Figma, design systems, and accessibility through 4 real product design projects.',
  'Beginner',
  '10 Weeks',
  'English',
  'Magesh Sundar',
  '₹22,000',
  '₹34,000',
  'https://images.unsplash.com/photo-1558494949-ef010cbdcc31?auto=format&fit=crop&w=800&q=80',
  4.8, 1100, true, 4, true,
  ARRAY['Figma', 'User Research', 'Wireframing', 'Design Systems', 'Prototyping', 'Accessibility', 'WCAG', 'Usability Testing']::text[],
  ARRAY['Product Designer', 'UX Designer', 'UI Designer', 'UX Researcher']::text[],
  ARRAY['Laptop with 8GB+ RAM', 'Stable internet', '3–4 hours daily commitment', 'No prior design experience needed']::text[],
  'published',
  'UI/UX Product Design | Carpediem Tech',
  'Design delightful, accessible product experiences from research to hi-fi prototypes. 4 real Figma projects in 10 weeks.',
  'UI/UX Design, Figma, UX Research, Design Systems, Prototyping, Product Design',
  true
),

(
  'Product Management Essentials',
  'product-management-essentials',
  'Product Design',
  'Discovery, roadmaps, metrics, and stakeholder work to ship products that matter.',
  '## What You Will Build

3 product management deliverables:

1. **Product Discovery Package** — Problem statement, Jobs-to-be-Done canvas, competitive matrix, opportunity sizing
2. **Product Roadmap & PRD** — Prioritised roadmap (RICE/MoSCoW), user stories, acceptance criteria, technical collaboration workshop
3. **PM Capstone** — End-to-end product spec for a real product problem: discovery → roadmap → go-to-market plan → success metrics

## Curriculum

- PM fundamentals: discovery vs delivery, outcome vs output, PM archetypes
- User research methods: customer interviews, surveys, data analysis
- Jobs-to-be-Done and opportunity solution trees
- Prioritisation: RICE, ICE, MoSCoW, Kano model
- Writing PRDs, user stories, and acceptance criteria
- Roadmap communication: internal, stakeholder, engineering
- Metrics: North Star, HEART, AARRR funnel, experimentation
- A/B testing design and statistical significance
- Go-to-market: launch planning, pricing, positioning
- Working with design and engineering: cross-functional rituals',
  'Master product discovery, roadmapping, metrics, and stakeholder management through real PM deliverables.',
  'Beginner',
  '8 Weeks',
  'English',
  'Magesh Sundar',
  '₹22,000',
  '₹34,000',
  'https://images.unsplash.com/photo-1518770660439-4636190af475?auto=format&fit=crop&w=800&q=80',
  4.6, 730, true, 3, true,
  ARRAY['Roadmapping', 'User Stories', 'Analytics', 'A/B Testing', 'Figma', 'JIRA', 'Mixpanel', 'SQL for PMs']::text[],
  ARRAY['Associate Product Manager', 'Product Owner', 'Growth PM', 'Technical PM']::text[],
  ARRAY['Laptop with 8GB+ RAM', 'Stable internet', '3–4 hours daily commitment', 'No technical background required']::text[],
  'published',
  'Product Management Essentials | Carpediem Tech',
  'Master product discovery, roadmapping, metrics and stakeholder management. Real PM deliverables in 8 weeks.',
  'Product Management, Roadmapping, User Stories, A/B Testing, Product Discovery, PM',
  true
)

ON CONFLICT (slug) DO UPDATE SET
  title               = EXCLUDED.title,
  category            = EXCLUDED.category,
  description         = EXCLUDED.description,
  long_description    = EXCLUDED.long_description,
  overview            = EXCLUDED.overview,
  difficulty          = EXCLUDED.difficulty,
  duration            = EXCLUDED.duration,
  language            = EXCLUDED.language,
  instructor          = EXCLUDED.instructor,
  price               = EXCLUDED.price,
  discount_price      = EXCLUDED.discount_price,
  course_image        = EXCLUDED.course_image,
  rating              = EXCLUDED.rating,
  students_enrolled   = EXCLUDED.students_enrolled,
  certificate_included = EXCLUDED.certificate_included,
  projects_included   = EXCLUDED.projects_included,
  placement_support   = EXCLUDED.placement_support,
  tools_covered       = EXCLUDED.tools_covered,
  career_outcomes     = EXCLUDED.career_outcomes,
  requirements        = EXCLUDED.requirements,
  status              = EXCLUDED.status,
  seo_title           = EXCLUDED.seo_title,
  seo_description     = EXCLUDED.seo_description,
  meta_keywords       = EXCLUDED.meta_keywords,
  is_published        = EXCLUDED.is_published;
