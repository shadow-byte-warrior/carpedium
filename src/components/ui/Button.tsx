"use client";

import { motion } from "framer-motion";
import { scrollToSection } from "@/lib/scroll";

type ButtonProps = {
  children: React.ReactNode;
  href?: string;
  variant?: "primary" | "secondary";
  className?: string;
  target?: string;
};

export default function Button({
  children,
  href,
  variant = "primary",
  className = "",
  target,
}: ButtonProps) {
  const base =
    "inline-flex items-center justify-center px-7 py-3.5 rounded-full font-display font-medium text-sm tracking-wide transition-all duration-200";

  const styles =
    variant === "primary"
      ? "bg-primary text-ink shadow-card hover:bg-primary-light hover:shadow-card-hover hover:-translate-y-0.5"
      : "border border-line text-ink bg-background hover:border-primary hover:text-primary-strong hover:-translate-y-0.5";

  const isInPageLink = href?.startsWith("#");

  const handleClick = (e: React.MouseEvent) => {
    if (isInPageLink && href) {
      e.preventDefault();
      scrollToSection(href);
    }
  };

  return (
    <motion.a
      href={href ?? "#"}
      onClick={handleClick}
      target={target}
      rel={target === "_blank" ? "noopener noreferrer" : undefined}
      whileHover={{ scale: 1.03 }}
      whileTap={{ scale: 0.98 }}
      transition={{ type: "spring", stiffness: 400, damping: 25 }}
      className={`${base} ${styles} ${className}`}
    >
      {children}
    </motion.a>
  );
}
