"use client";

import { motion } from "framer-motion";
import Image from "next/image";
import { useEffect } from "react";

import { Button } from "@/components/ui/button";
import { Container } from "@/components/ui/container";

const features = [
  {
    title: "Movement you can trust",
    description:
      "Your touch is the game. The goal is simple: keep moving with zero lag so every dodge feels fair and sharp.",
  },
  {
    title: "Tension that builds",
    description:
      "Early runs feel calm. The pace climbs, bounces get wilder, and the room to breathe shrinks — without cheap surprises.",
  },
  {
    title: "Close calls that pop",
    description:
      "Narrow escapes feel exciting, not punishing. Risky lines of play can feel electrifying when you pull them off.",
  },
  {
    title: "Runs that fit your day",
    description:
      "Most sessions are short. When you have more time, chase a new personal best or a smoother flow state.",
  },
  {
    title: "Stats that matter",
    description:
      "Track your best survival time, streaks, and how far you pushed the difficulty — fuel for “one more try.”",
  },
  {
    title: "Focus, not clutter",
    description:
      "Dark, minimal presentation keeps your eyes on the threat. The dot is the star — and the problem.",
  },
];

const steps = [
  {
    title: "Place your touch",
    description: "Put your finger on the screen to show up on the field.",
  },
  {
    title: "The dot wakes up",
    description: "A single bouncing threat appears. It speeds up and gets trickier the longer you last.",
  },
  {
    title: "Stay free",
    description: "If it touches you, the run ends. Restart instantly and chase a better line.",
  },
];

const faqs = [
  {
    q: "What is AvoidTheDot?",
    a: "It is a minimalist reflex survival game: one hostile dot, your finger as the “player,” and a difficulty curve that pushes you into flow. The loop is easy to learn and hard to put down.",
  },
  {
    q: "Who is it for?",
    a: "Anyone who enjoys short, skill-based challenges — quick breaks, commutes, or wind-down moments when you want something intense but simple.",
  },
  {
    q: "Do I need an account?",
    a: "The site does not require sign-up to learn about the game. If the app offers accounts later, that will be optional and clearly explained in the app.",
  },
  {
    q: "Will it work on my phone?",
    a: "The experience is designed for touch-first play on modern phones and tablets. Exact store listings and device requirements will be posted near release.",
  },
  {
    q: "How do you handle privacy?",
    a: "We collect only what we need to run the product and improve stability. Read the full policy for details on data types, retention, and your choices.",
  },
  {
    q: "How can I get help or give feedback?",
    a: "Use the Help and Contact pages on this site. We read real messages and use them to fix issues and improve feel.",
  },
];

const listAnimation = {
  hidden: {},
  show: {
    transition: {
      staggerChildren: 0.1,
      delayChildren: 0.08,
    },
  },
};

const itemAnimation = {
  hidden: { opacity: 0, y: 14 },
  show: {
    opacity: 1,
    y: 0,
    transition: { duration: 0.45, ease: "easeOut" as const },
  },
};

function AppMockup() {
  return (
    <div className="relative mx-auto w-full max-w-[280px]">
      <div
        className="relative overflow-hidden rounded-[2.2rem] border border-white/15 bg-[#12121a] p-3 shadow-[0_40px_80px_-40px_rgba(0,0,0,0.9)]"
        aria-hidden
      >
        <div className="flex items-center justify-between rounded-2xl bg-black/40 px-3 py-2">
          <div className="flex items-center gap-2">
            <Image src="/app_logo.png" alt="AvoidTheDot" width={28} height={28} className="h-7 w-7 rounded-lg" />
            <span className="text-xs font-semibold text-zinc-200">AvoidTheDot</span>
          </div>
          <span className="text-[10px] font-medium text-rose-300/90">Best · 0:42</span>
        </div>
        <div className="relative mt-3 flex h-[420px] items-center justify-center rounded-2xl bg-[#0a0a10]">
          <span className="absolute left-4 top-4 text-[10px] font-medium uppercase tracking-wider text-zinc-500">
            Survive
          </span>
          <span className="absolute right-4 top-4 rounded-full bg-rose-600/25 px-2 py-0.5 text-[10px] font-semibold text-rose-200">
            0:18
          </span>
          <motion.span
            className="absolute h-4 w-4 rounded-full bg-rose-500 shadow-[0_0_24px_rgba(244,63,94,0.85)]"
            animate={{
              x: [0, 52, -40, 28, 0],
              y: [0, -36, 44, -20, 0],
            }}
            transition={{ duration: 5.2, repeat: Infinity, ease: "easeInOut" as const }}
          />
          <span className="relative h-10 w-10 rounded-full border-2 border-cyan-400/80 bg-cyan-400/15 shadow-[0_0_20px_rgba(34,211,238,0.35)]" />
        </div>
        <div className="mt-3 flex justify-center">
          <span className="rounded-full bg-rose-600 px-8 py-3 text-sm font-semibold text-white">
            Play again
          </span>
        </div>
      </div>
    </div>
  );
}

export function LandingMain() {
  useEffect(() => {
    console.log("[AvoidTheDot] LandingMain: mounted (client)");
  }, []);

  return (
    <main>
      <Container className="pt-14 pb-20 sm:pt-20">
        <div className="grid gap-14 lg:grid-cols-[1fr_minmax(0,320px)] lg:items-center lg:gap-16">
          <motion.div
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.55, ease: "easeOut" as const }}
          >
            <p className="mb-4 inline-flex rounded-full border border-rose-500/35 bg-rose-500/10 px-4 py-1 text-xs font-semibold uppercase tracking-[0.2em] text-rose-200/95">
              Reflex survival
            </p>
            <h1 className="text-balance text-4xl font-semibold tracking-tight text-zinc-50 sm:text-5xl lg:text-6xl">
              Stay ahead of the dot. Survive the tension.
            </h1>
            <p className="mt-6 max-w-xl text-pretty text-base leading-relaxed text-zinc-400 sm:text-lg">
              One moving threat. Your reflexes. Each run gets harder until you slip — then you restart in
              seconds. Built for focus, close calls, and the feeling of being hunted in the best way.
            </p>
            <div className="mt-10 flex flex-wrap items-center gap-3">
              <Button href="/contact">Get launch updates</Button>
              <Button href="#how-it-works" variant="outline">
                See how it works
              </Button>
            </div>
          </motion.div>
          <AppMockup />
        </div>
      </Container>

      <Container id="features" className="border-t border-white/5 py-20 sm:py-24">
        <div className="mx-auto max-w-2xl text-center">
          <h2 className="text-3xl font-semibold tracking-tight text-zinc-50 sm:text-4xl">
            Why it feels different
          </h2>
          <p className="mt-4 text-zinc-400">
            Simple rules, deep skill. Every feature supports the same goal: tight control, rising pressure,
            and runs you want to repeat.
          </p>
        </div>
        <motion.div
          variants={listAnimation}
          initial="hidden"
          whileInView="show"
          viewport={{ once: true, amount: 0.15 }}
          className="mt-14 grid gap-4 sm:grid-cols-2 lg:grid-cols-3"
        >
          {features.map((feature) => (
            <motion.article
              key={feature.title}
              variants={itemAnimation}
              className="rounded-2xl border border-white/10 bg-white/[0.03] p-6 shadow-[0_24px_60px_-44px_rgba(0,0,0,0.85)]"
            >
              <h3 className="text-lg font-semibold tracking-tight text-zinc-100">{feature.title}</h3>
              <p className="mt-3 text-sm leading-relaxed text-zinc-400">{feature.description}</p>
            </motion.article>
          ))}
        </motion.div>
      </Container>

      <Container id="how-it-works" className="border-t border-white/5 py-20 sm:py-24">
        <div className="mx-auto max-w-2xl text-center">
          <h2 className="text-3xl font-semibold tracking-tight text-zinc-50 sm:text-4xl">
            How a run goes
          </h2>
          <p className="mt-4 text-zinc-400">
            Three beats. No tutorial wall — you learn by moving.
          </p>
        </div>
        <motion.ol
          variants={listAnimation}
          initial="hidden"
          whileInView="show"
          viewport={{ once: true, amount: 0.2 }}
          className="mt-14 grid gap-6 md:grid-cols-3"
        >
          {steps.map((step, index) => (
            <motion.li
              key={step.title}
              variants={itemAnimation}
              className="relative rounded-2xl border border-white/10 bg-[#101016] p-6"
            >
              <span className="text-xs font-bold uppercase tracking-wider text-rose-300/90">
                Step {index + 1}
              </span>
              <h3 className="mt-3 text-lg font-semibold text-zinc-100">{step.title}</h3>
              <p className="mt-2 text-sm leading-relaxed text-zinc-400">{step.description}</p>
            </motion.li>
          ))}
        </motion.ol>
      </Container>

      <Container id="faq" className="border-t border-white/5 py-20 sm:py-24">
        <div className="mx-auto max-w-2xl text-center">
          <h2 className="text-3xl font-semibold tracking-tight text-zinc-50 sm:text-4xl">
            Common questions
          </h2>
          <p className="mt-4 text-zinc-400">
            Straight answers about the game and this site.
          </p>
        </div>
        <div className="mx-auto mt-12 max-w-3xl divide-y divide-white/10 rounded-2xl border border-white/10 bg-white/[0.02] px-2">
          {faqs.map((item) => (
            <details key={item.q} className="group px-4 py-4 sm:px-6">
              <summary className="cursor-pointer list-none text-left font-semibold text-zinc-100 marker:content-none [&::-webkit-details-marker]:hidden">
                <span className="flex items-center justify-between gap-4">
                  {item.q}
                  <span className="text-rose-400 transition-transform group-open:rotate-45">+</span>
                </span>
              </summary>
              <p className="mt-3 text-sm leading-relaxed text-zinc-400">{item.a}</p>
            </details>
          ))}
        </div>
      </Container>

      <Container className="pb-24">
        <div className="rounded-3xl border border-rose-500/25 bg-rose-500/[0.07] px-8 py-12 text-center sm:px-12">
          <h2 className="text-2xl font-semibold tracking-tight text-zinc-50 sm:text-3xl">
            Ready when you are
          </h2>
          <p className="mx-auto mt-4 max-w-lg text-zinc-300">
            Drop your email on the contact page if you want a heads-up when the app is available. No spam —
            just launch news and big updates.
          </p>
          <div className="mt-8 flex flex-wrap justify-center gap-3">
            <Button href="/contact">Contact us</Button>
            <Button href="/help" variant="outline">
              Visit help
            </Button>
          </div>
        </div>
      </Container>
    </main>
  );
}
