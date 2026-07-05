import Reveal from "@/components/ui/Reveal";
import SectionEyebrow from "@/components/ui/SectionEyebrow";

type SectionHeaderProps = {
  eyebrow: string;
  title: string;
  description?: string;
  className?: string;
};

export default function SectionHeader({
  eyebrow,
  title,
  description,
  className = "",
}: SectionHeaderProps) {
  return (
    <Reveal className={className}>
      <SectionEyebrow>{eyebrow}</SectionEyebrow>
      <h2 className="font-display max-w-2xl text-3xl font-bold text-ink sm:text-4xl">
        {title}
      </h2>
      {description && (
        <p className="mt-3 max-w-xl text-sm text-ink-dim">{description}</p>
      )}
    </Reveal>
  );
}
