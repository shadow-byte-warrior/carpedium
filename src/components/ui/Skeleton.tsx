export default function Skeleton({ className = "" }: { className?: string }) {
  return (
    <div
      aria-hidden="true"
      className={`skeleton-shimmer motion-safe:animate-shimmer rounded-2xl ${className}`}
    />
  );
}
