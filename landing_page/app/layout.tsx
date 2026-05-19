import type { Metadata } from "next";
import { DM_Sans, Space_Grotesk } from "next/font/google";
import "./globals.css";

console.log("[AvoidTheDot] layout: building root document");

const dmSans = DM_Sans({
  variable: "--font-dm-sans",
  subsets: ["latin"],
});

const spaceGrotesk = Space_Grotesk({
  variable: "--font-space-grotesk",
  subsets: ["latin"],
});

export const metadata: Metadata = {
  title: "AvoidTheDot — Reflex survival arcade",
  description:
    "Survive as long as you can. One bouncing dot, your reflexes, and rising tension. Quick sessions, instant restarts.",
  icons: {
    icon: [{ url: "/app_logo.png", type: "image/png" }],
    apple: "/app_logo.png",
  },
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="en">
      <body className={`${dmSans.variable} ${spaceGrotesk.variable} antialiased`}>
        {children}
      </body>
    </html>
  );
}
