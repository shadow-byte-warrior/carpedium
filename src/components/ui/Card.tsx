type CardProps = {
  children: React.ReactNode;
  className?: string;
  hover?: boolean;
  variant?: "surface" | "placeholder";
  as?: "div" | "article" | "blockquote";
};

export default function Card({
  children,
  className = "",
  hover = false,
  variant = "surface",
  as = "div",
}: CardProps) {
  const Component = as;

  const base = "rounded-2xl border p-6 transition-all duration-200";

  const variantStyles =
    variant === "placeholder"
      ? "border-dashed border-line bg-surface-alt/60"
      : "border-line bg-background shadow-card";

  const hoverStyles = hover
    ? "hover:-translate-y-1 hover:border-primary/30 hover:shadow-card-hover"
    : "";

  return (
    <Component className={`${base} ${variantStyles} ${hoverStyles} ${className}`}>
      {children}
    </Component>
  );
}
