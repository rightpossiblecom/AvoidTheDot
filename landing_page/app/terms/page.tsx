import Link from "next/link";

import { Container } from "@/components/ui/container";

export const metadata = {
  title: "Terms of Service — AvoidTheDot",
  description: "Terms that govern your use of AvoidTheDot websites and applications.",
};

export default function TermsPage() {
  console.log("[AvoidTheDot] terms: rendering");

  return (
    <div className="min-h-screen pb-20">
      <header className="border-b border-white/10 bg-[#0c0c10]/95">
        <Container className="flex items-center justify-between py-6">
          <Link href="/" className="text-sm font-semibold text-zinc-200 hover:text-white">
            ← Home
          </Link>
        </Container>
      </header>
      <Container className="mt-14 max-w-3xl space-y-4 text-zinc-400 leading-relaxed">
        <h1 className="font-display text-3xl font-semibold tracking-tight text-zinc-100">Terms of Service</h1>
        <p className="text-sm text-zinc-500">Last updated: May 18, 2026</p>
        <p>
          These Terms of Service (“Terms”) govern your access to and use of the websites, mobile
          applications, and related services offered by AvoidTheDot (the “Services”). By downloading,
          accessing, or using the Services, you agree to these Terms. If you do not agree, you must not use
          the Services.
        </p>
        <h2 className="mt-10 text-xl font-semibold text-zinc-100">Eligibility</h2>
        <p>
          You must be able to form a binding contract under applicable law to use the Services. If you use
          the Services on behalf of an organization, you represent that you have authority to bind that
          organization, and “you” includes both you individually and the organization.
        </p>
        <h2 className="mt-10 text-xl font-semibold text-zinc-100">License to use the Services</h2>
        <p>
          Subject to your compliance with these Terms, AvoidTheDot grants you a limited, non-exclusive,
          non-transferable, revocable license to access and use the Services for your personal,
          non-commercial entertainment, unless we agree otherwise in writing. You may not copy, modify,
          distribute, sell, lease, reverse engineer, or attempt to extract the source code of the Services
          except to the extent that such restrictions are prohibited by law.
        </p>
        <h2 className="mt-10 text-xl font-semibold text-zinc-100">Accounts</h2>
        <p>
          Some features may require you to create an account. You agree to provide accurate information and
          to keep your credentials confidential. You are responsible for activity that occurs under your
          account. Notify us promptly at the contact email below if you believe your account has been
          compromised.
        </p>
        <h2 className="mt-10 text-xl font-semibold text-zinc-100">Acceptable use</h2>
        <p>You agree not to misuse the Services. For example, you must not:</p>
        <ul className="list-disc space-y-2 pl-5 text-zinc-400">
          <li>Attempt to interfere with or disrupt the Services or servers or networks connected to them;</li>
          <li>Use automated systems to access the Services in a way that imposes an unreasonable load;</li>
          <li>Circumvent security features, manipulate gameplay for unfair advantage in online contexts, or harass others;</li>
          <li>Use the Services for any unlawful purpose or in violation of applicable export or sanctions laws.</li>
        </ul>
        <h2 className="mt-10 text-xl font-semibold text-zinc-100">Virtual items and purchases</h2>
        <p>
          If the Services offer in-app purchases, those transactions are processed by the relevant app
          platform (such as Apple or Google). Pricing, billing, and refund rights may be governed by the
          platform’s terms. Virtual items have no real-world monetary value outside the Services and may be
          modified or discontinued as part of ongoing game balance and product updates.
        </p>
        <h2 className="mt-10 text-xl font-semibold text-zinc-100">User content</h2>
        <p>
          If you submit feedback, suggestions, or other content to us, you grant AvoidTheDot a worldwide,
          royalty-free license to use, reproduce, modify, and distribute that content for any purpose related
          to improving and operating the Services, without obligation to compensate you, except where
          prohibited by law.
        </p>
        <h2 className="mt-10 text-xl font-semibold text-zinc-100">Intellectual property</h2>
        <p>
          The Services, including all graphics, audio, software, text, and branding, are owned by AvoidTheDot
          or its licensors and are protected by intellectual property laws. Except for the limited license
          above, no rights are granted to you.
        </p>
        <h2 className="mt-10 text-xl font-semibold text-zinc-100">Disclaimer of warranties</h2>
        <p>
          THE SERVICES ARE PROVIDED “AS IS” AND “AS AVAILABLE” WITHOUT WARRANTIES OF ANY KIND, WHETHER
          EXPRESS OR IMPLIED, INCLUDING IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
          PURPOSE, AND NON-INFRINGEMENT. AVOIDTHEDOT DOES NOT WARRANT THAT THE SERVICES WILL BE
          UNINTERRUPTED, ERROR-FREE, OR FREE OF HARMFUL COMPONENTS.
        </p>
        <h2 className="mt-10 text-xl font-semibold text-zinc-100">Limitation of liability</h2>
        <p>
          TO THE MAXIMUM EXTENT PERMITTED BY LAW, AVOIDTHEDOT AND ITS AFFILIATES, OFFICERS, EMPLOYEES, AND
          AGENTS WILL NOT BE LIABLE FOR ANY INDIRECT, INCIDENTAL, SPECIAL, CONSEQUENTIAL, OR EXEMPLARY
          DAMAGES, OR ANY LOSS OF PROFITS, GOODWILL, DATA, OR OTHER INTANGIBLE LOSSES, ARISING OUT OF OR
          RELATED TO YOUR USE OF THE SERVICES. OUR AGGREGATE LIABILITY FOR ALL CLAIMS RELATING TO THE
          SERVICES WILL NOT EXCEED THE GREATER OF THE AMOUNTS YOU PAID TO US FOR THE SERVICES IN THE TWELVE
          MONTHS BEFORE THE CLAIM OR FIFTY U.S. DOLLARS (US$50).
        </p>
        <h2 className="mt-10 text-xl font-semibold text-zinc-100">Indemnity</h2>
        <p>
          You will indemnify and hold harmless AvoidTheDot and its affiliates from any claims, liabilities,
          damages, losses, and expenses (including reasonable attorneys’ fees) arising from your use of the
          Services, your violation of these Terms, or your violation of any third-party rights.
        </p>
        <h2 className="mt-10 text-xl font-semibold text-zinc-100">Termination</h2>
        <p>
          We may suspend or terminate your access to the Services at any time, with or without notice, if
          we reasonably believe you have violated these Terms or if we need to do so for legal, security,
          or operational reasons. You may stop using the Services at any time. Provisions that by their
          nature should survive termination (including disclaimers, limitations of liability, and indemnity)
          will survive.
        </p>
        <h2 className="mt-10 text-xl font-semibold text-zinc-100">Changes</h2>
        <p>
          We may modify these Terms from time to time. We will post the updated Terms on this page and
          update the “Last updated” date. If changes are material, we will provide additional notice as
          appropriate. Your continued use of the Services after changes become effective constitutes your
          acceptance of the revised Terms.
        </p>
        <h2 className="mt-10 text-xl font-semibold text-zinc-100">Governing law</h2>
        <p>
          These Terms are governed by the laws applicable in your primary place of residence or the laws of
          the jurisdiction where AvoidTheDot operates, excluding conflict-of-law rules, unless a mandatory
          law in your jurisdiction provides otherwise. Courts in that jurisdiction will have exclusive venue
          for disputes, unless applicable law requires a different forum.
        </p>
        <h2 className="mt-10 text-xl font-semibold text-zinc-100">Contact</h2>
        <p>
          For questions about these Terms, contact{" "}
          <a
            href="mailto:support@avoidthedot.app"
            className="text-rose-300 underline decoration-rose-500/40 underline-offset-4 hover:text-rose-200"
          >
            support@avoidthedot.app
          </a>
          .
        </p>
      </Container>
    </div>
  );
}
