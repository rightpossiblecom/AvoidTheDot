import Link from "next/link";

import { Button } from "@/components/ui/button";
import { Container } from "@/components/ui/container";

export const metadata = {
  title: "Contact — AvoidTheDot",
  description: "Reach the AvoidTheDot team for support, press, or partnership questions.",
};

export default function ContactPage() {
  console.log("[AvoidTheDot] contact: rendering");

  return (
    <div className="min-h-screen pb-20">
      <header className="border-b border-white/10 bg-[#0c0c10]/95">
        <Container className="py-6">
          <Link href="/" className="text-sm font-semibold text-zinc-200 hover:text-white">
            ← Home
          </Link>
        </Container>
      </header>
      <Container className="mt-14 max-w-2xl">
        <h1 className="font-display text-3xl font-semibold tracking-tight text-zinc-100 sm:text-4xl">
          Contact
        </h1>
        <p className="mt-4 text-lg leading-relaxed text-zinc-400">
          Whether you hit a bug, want to share a clip of a legendary dodge, or ask about collaborations, we
          read real messages. The fastest path is email.
        </p>
        <div className="mt-10 rounded-2xl border border-white/10 bg-white/[0.03] p-8">
          <p className="text-sm font-semibold uppercase tracking-wider text-zinc-500">Email</p>
          <a
            href="mailto:support@avoidthedot.app"
            className="mt-2 inline-block text-xl font-semibold text-rose-300 hover:text-rose-200"
          >
            support@avoidthedot.app
          </a>
          <p className="mt-4 text-sm leading-relaxed text-zinc-400">
            We try to reply within a few business days. Including your device model and app version helps us
            fix things faster.
          </p>
        </div>
        <div className="mt-10 rounded-2xl border border-white/10 bg-white/[0.03] p-8">
          <p className="text-sm font-semibold uppercase tracking-wider text-zinc-500">Social</p>
          <p className="mt-2 text-zinc-300">
            Updates and teasers:{" "}
            <a
              href="https://twitter.com/avoidthedot"
              target="_blank"
              rel="noopener noreferrer"
              className="font-semibold text-rose-300 hover:text-rose-200"
            >
              @avoidthedot
            </a>{" "}
            on X.
          </p>
          <p className="mt-3 text-sm text-zinc-500">
            If that handle changes later, this page will be updated — the email above always works for
            support.
          </p>
        </div>
        <div className="mt-12 flex flex-wrap gap-3">
          <Button href="/help">Browse help topics</Button>
          <Button href="/privacy-policy" variant="outline">
            Privacy
          </Button>
        </div>
      </Container>
    </div>
  );
}
