import Image from "next/image";
import Link from "next/link";

import { Container } from "@/components/ui/container";

const footerLinks = [
  { href: "/privacy-policy", label: "Privacy" },
  { href: "/terms", label: "Terms" },
  { href: "/help", label: "Help" },
  { href: "/contact", label: "Contact" },
];

export function LandingFooter() {
  console.log("[AvoidTheDot] LandingFooter: render");

  return (
    <footer className="border-t border-white/10 bg-[#08080c]">
      <Container className="flex flex-col gap-10 py-14 sm:flex-row sm:items-start sm:justify-between">
        <div className="max-w-md">
          <div className="flex items-center gap-3">
            <Image
              src="/app_logo.png"
              alt="AvoidTheDot"
              width={36}
              height={36}
              className="h-8 w-8 rounded-lg"
            />
            <span className="text-lg font-semibold text-zinc-100">AvoidTheDot</span>
          </div>
          <p className="mt-4 text-sm leading-relaxed text-zinc-400">
            A tiny survival game about movement, focus, and staying one step ahead. Built for
            short bursts of play and “just one more run” energy.
          </p>
        </div>
        <div className="flex flex-col gap-4 text-sm">
          <p className="font-semibold text-zinc-200">Links</p>
          <ul className="flex flex-col gap-2 text-zinc-400">
            {footerLinks.map((link) => (
              <li key={link.href}>
                <Link href={link.href} className="transition-colors hover:text-white">
                  {link.label}
                </Link>
              </li>
            ))}
          </ul>
        </div>
      </Container>
      <div className="border-t border-white/5">
        <Container className="py-6 text-center text-xs text-zinc-500 sm:text-left">
          © {new Date().getFullYear()} AvoidTheDot. All rights reserved.
        </Container>
      </div>
    </footer>
  );
}
