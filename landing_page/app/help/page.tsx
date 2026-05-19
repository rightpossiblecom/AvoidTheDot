import Link from "next/link";

import { Container } from "@/components/ui/container";

export const metadata = {
  title: "Help Center — AvoidTheDot",
  description: "Find answers about AvoidTheDot gameplay, setup, and support.",
};

const categories = [
  {
    title: "First runs",
    description:
      "New to the game? Start with short sessions. Focus on smooth movement first — speed comes once your hands trust the controls.",
  },
  {
    title: "Progress & stats",
    description:
      "Your best times and streaks are there to celebrate improvement. If cloud saves or accounts roll out later, we will explain exactly what syncs and what stays on your device.",
  },
  {
    title: "Performance & comfort",
    description:
      "If the app feels choppy, try closing other apps, lowering screen brightness, or updating your system. Take breaks if your hands or eyes feel tired — short games should stay fun.",
  },
  {
    title: "Sound & feel",
    description:
      "Audio is part of the tension. Use device volume or in-game settings to find a level that keeps you alert without fatigue.",
  },
  {
    title: "Privacy & safety",
    description:
      "We avoid asking for more than we need. Our Privacy Policy explains what we collect and why, in plain language.",
    href: "/privacy-policy",
    linkLabel: "Read the Privacy Policy",
  },
  {
    title: "Still stuck?",
    description:
      "Tell us what device you use, what you expected, and what happened instead. Screenshots help when something looks wrong.",
    href: "/contact",
    linkLabel: "Contact support",
  },
];

export default function HelpPage() {
  console.log("[AvoidTheDot] help: rendering");

  return (
    <div className="min-h-screen pb-20">
      <header className="border-b border-white/10 bg-[#0c0c10]/95">
        <Container className="py-6">
          <Link href="/" className="text-sm font-semibold text-zinc-200 hover:text-white">
            ← Home
          </Link>
        </Container>
      </header>
      <Container className="mt-14 max-w-3xl">
        <h1 className="font-display text-3xl font-semibold tracking-tight text-zinc-100 sm:text-4xl">
          Help center
        </h1>
        <p className="mt-4 text-lg leading-relaxed text-zinc-400">
          Quick guidance for playing well, understanding what we collect, and getting human support when
          something breaks.
        </p>
        <ul className="mt-12 space-y-6">
          {categories.map((cat) => (
            <li
              key={cat.title}
              className="rounded-2xl border border-white/10 bg-white/[0.03] p-6 sm:p-8"
            >
              <h2 className="text-lg font-semibold text-zinc-100">{cat.title}</h2>
              <p className="mt-2 text-sm leading-relaxed text-zinc-400">{cat.description}</p>
              {cat.href ? (
                <p className="mt-4">
                  <Link
                    href={cat.href}
                    className="text-sm font-semibold text-rose-300 hover:text-rose-200"
                  >
                    {cat.linkLabel} →
                  </Link>
                </p>
              ) : null}
            </li>
          ))}
        </ul>
      </Container>
    </div>
  );
}
