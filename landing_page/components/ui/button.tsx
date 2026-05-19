import Link from "next/link";

import { cn } from "@/lib/cn";

type ButtonVariant = "solid" | "outline";

type ButtonProps = {
  href: string;
  variant?: ButtonVariant;
  className?: string;
  children: React.ReactNode;
};

const variantClasses: Record<ButtonVariant, string> = {
  solid:
    "bg-rose-600 text-white shadow-[0_10px_30px_-18px_rgba(225,29,72,0.65)] hover:bg-rose-500",
  outline:
    "border border-white/20 text-zinc-200 hover:border-white/35 hover:bg-white/5",
};

export function Button({
  href,
  variant = "solid",
  className,
  children,
}: ButtonProps) {
  return (
    <Link
      href={href}
      className={cn(
        "inline-flex items-center justify-center rounded-full px-5 py-3 text-sm font-semibold tracking-tight transition-colors",
        variantClasses[variant],
        className,
      )}
    >
      {children}
    </Link>
  );
}
