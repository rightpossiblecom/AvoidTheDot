import Image from "next/image";
import Link from "next/link";

import { Container } from "@/components/ui/container";

const nav = [
  { href: "#features", label: "Features" },
  { href: "#how-it-works", label: "How it works" },
  { href: "#faq", label: "Questions" },
  { href: "/help", label: "Help" },
  { href: "/contact", label: "Contact" },
];

export function LandingNav() {
  console.log("[AvoidTheDot] LandingNav: render");

  return (
    <header className="sticky top-0 z-50 border-b border-white/10 bg-[#0c0c10]/90 backdrop-blur-md">
      <Container className="flex flex-col gap-4 py-4 sm:flex-row sm:items-center sm:justify-between">
        <div className="flex items-center justify-between gap-4 sm:justify-start">
          <Link
            href="/"
            className="flex items-center gap-3 text-zinc-100 transition-opacity hover:opacity-90"
          >
          <Image
            src="/app_logo.png"
            alt="AvoidTheDot"
            width={40}
              height={40}
              className="h-9 w-9 rounded-xl"
              priority
            />
            <span className="font-semibold tracking-tight">AvoidTheDot</span>
          </Link>
        </div>
        <nav className="flex flex-wrap items-center gap-x-5 gap-y-2 text-sm font-medium text-zinc-300">
          {nav.map((item) => (
            <Link
              key={item.href}
              href={item.href}
              className="transition-colors hover:text-white"
            >
              {item.label}
            </Link>
          ))}
        </nav>
      </Container>
    </header>
  );
}
