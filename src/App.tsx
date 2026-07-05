import SmoothScrollProvider from "@/components/providers/SmoothScrollProvider";
import Nav from "@/components/layout/Nav";
import Footer from "@/components/layout/Footer";
import QuickEnquiry from "@/components/ui/QuickEnquiry";
import WhatsAppButton from "@/components/ui/WhatsAppButton";

import Hero from "@/components/hero/Hero";
import TrustStrip from "@/components/sections/TrustStrip";
import CourseGrid from "@/components/sections/CourseGrid";
import WhyCarpediem from "@/components/sections/WhyCarpediem";
import Programs from "@/components/sections/Programs";
import HowItWorks from "@/components/sections/HowItWorks";
import LiveProjects from "@/components/sections/LiveProjects";
import Certifications from "@/components/sections/Certifications";
import Mentors from "@/components/sections/Mentors";
import Outcomes from "@/components/sections/Outcomes";
import FAQs from "@/components/sections/FAQs";
import BlogPreview from "@/components/sections/BlogPreview";
import Resources from "@/components/sections/Resources";
import Contact from "@/components/sections/Contact";

export default function App() {
  return (
    <div className="min-h-full flex flex-col bg-white text-slate-900">
      <SmoothScrollProvider>
        <Nav />
        <main className="flex-1">
          <Hero />
          <TrustStrip />
          <CourseGrid />
          <WhyCarpediem />
          <Programs />
          <HowItWorks />
          <LiveProjects />
          <Certifications />
          <Mentors />
          <Outcomes />
          <FAQs />
          <BlogPreview />
          <Resources />
          <Contact />
        </main>
        <Footer />
        <QuickEnquiry />
        <WhatsAppButton />
      </SmoothScrollProvider>
    </div>
  );
}
