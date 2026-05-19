import Link from "next/link";

import { Container } from "@/components/ui/container";

export const metadata = {
  title: "Privacy Policy — AvoidTheDot",
  description: "How AvoidTheDot handles information when you use our site and apps.",
};

export default function PrivacyPolicyPage() {
  console.log("[AvoidTheDot] privacy-policy: rendering");

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
        <h1 className="font-display text-3xl font-semibold tracking-tight text-zinc-100">Privacy Policy</h1>
        <p className="text-sm text-zinc-500">Last updated: May 18, 2026</p>
        <p>
          This Privacy Policy describes how AvoidTheDot (“we”, “us”, or “our”) collects, uses, and shares
          information when you visit this website, download our mobile applications, or otherwise interact
          with our services (collectively, the “Services”). We are committed to explaining our practices in
          plain language and respecting your choices.
        </p>
        <h2 className="mt-10 text-xl font-semibold text-zinc-100">Information we collect</h2>
        <p>
          <strong className="text-zinc-200">Information you provide.</strong> If you contact us by email or
          through a form, we collect the content of your message and basic contact details (such as your
          email address) so we can respond. If you sign up for launch updates or newsletters in the future,
          we will collect the information necessary to deliver those messages, such as your email address and
          communication preferences.
        </p>
        <p>
          <strong className="text-zinc-200">Information collected automatically.</strong> When you use our
          Services, we may automatically receive technical information from your device and browser,
          including your IP address, device type, operating system version, app version, general location
          derived from IP (such as country or region), diagnostic logs, and timestamps of requests. This
          information helps us operate the Services, secure our systems, understand performance issues, and
          improve stability across devices.
        </p>
        <p>
          <strong className="text-zinc-200">Gameplay and product analytics.</strong> If you use our games or
          apps, we may collect aggregated or pseudonymous statistics about gameplay sessions — for example,
          survival duration, crash reports, frame rates on certain devices, or feature usage — so we can
          balance difficulty, fix bugs, and plan updates. Where feasible, we limit the detail of this data
          and use it in aggregate rather than to profile individuals for unrelated advertising.
        </p>
        <h2 className="mt-10 text-xl font-semibold text-zinc-100">How we use information</h2>
        <p>We use the information described above to:</p>
        <ul className="list-disc space-y-2 pl-5 text-zinc-400">
          <li>Provide, maintain, and improve the Services, including gameplay feel, performance, and security;</li>
          <li>Respond to support requests and communicate with you about updates, incidents, or policy changes;</li>
          <li>Monitor for fraud, abuse, or misuse of our Services;</li>
          <li>Comply with legal obligations and enforce our terms; and</li>
          <li>Analyze usage trends in a responsible manner to guide product decisions.</li>
        </ul>
        <h2 className="mt-10 text-xl font-semibold text-zinc-100">Legal bases (where applicable)</h2>
        <p>
          If you are located in the European Economic Area, the United Kingdom, or similar jurisdictions, we
          rely on appropriate legal bases such as performance of a contract (providing the Services you
          request), legitimate interests (improving and securing our products, provided those interests are
          not overridden by your rights), and consent where required (for example, for certain marketing
          communications or non-essential cookies).
        </p>
        <h2 className="mt-10 text-xl font-semibold text-zinc-100">Sharing of information</h2>
        <p>
          We do not sell your personal information. We may share information with service providers that
          assist us — such as hosting providers, email delivery services, error reporting tools, or
          analytics platforms — subject to contractual obligations to protect data and use it only on our
          instructions. We may also disclose information if required by law, court order, or governmental
          request, or if we believe disclosure is reasonably necessary to protect the rights, property, or
          safety of our users, the public, or AvoidTheDot.
        </p>
        <h2 className="mt-10 text-xl font-semibold text-zinc-100">Retention</h2>
        <p>
          We retain information only as long as necessary for the purposes described in this Policy, unless
          a longer retention period is required or permitted by law. Support emails may be retained for a
          limited period to track issue resolution. Aggregated analytics may be stored in a form that does
          not identify you for longer periods to understand long-term product health.
        </p>
        <h2 className="mt-10 text-xl font-semibold text-zinc-100">Security</h2>
        <p>
          We implement reasonable administrative, technical, and organizational measures designed to protect
          information against unauthorized access, loss, or alteration. No method of transmission over the
          Internet or electronic storage is completely secure; we encourage you to use strong passwords,
          keep devices updated, and contact us promptly if you suspect unauthorized access to your account
          (if applicable).
        </p>
        <h2 className="mt-10 text-xl font-semibold text-zinc-100">Your rights and choices</h2>
        <p>
          Depending on where you live, you may have rights to access, correct, delete, or port your personal
          information, or to object to or restrict certain processing. You may also have the right to
          withdraw consent where processing is based on consent, without affecting the lawfulness of
          processing before withdrawal. To exercise applicable rights, contact us using the details below.
          You may also lodge a complaint with a supervisory authority in your jurisdiction.
        </p>
        <h2 className="mt-10 text-xl font-semibold text-zinc-100">Children</h2>
        <p>
          Our Services are not directed to children under the age where parental consent is required in your
          region. We do not knowingly collect personal information from children in violation of applicable
          law. If you believe a child has provided us with personal information, please contact us so we can
          take appropriate action.
        </p>
        <h2 className="mt-10 text-xl font-semibold text-zinc-100">International transfers</h2>
        <p>
          If you access our Services from outside the country where we operate, your information may be
          processed in countries that may have different data protection laws. Where required, we implement
          appropriate safeguards such as standard contractual clauses approved by relevant authorities.
        </p>
        <h2 className="mt-10 text-xl font-semibold text-zinc-100">Changes to this policy</h2>
        <p>
          We may update this Privacy Policy from time to time. When we make material changes, we will post
          the updated version on this page and revise the “Last updated” date. For significant changes, we
          may also notify you by email or an in-product notice where appropriate.
        </p>
        <h2 className="mt-10 text-xl font-semibold text-zinc-100">Contact</h2>
        <p>
          Questions about this Privacy Policy or our data practices? Email{" "}
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
