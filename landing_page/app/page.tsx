import { LandingFooter } from "@/components/landing/landing-footer";
import { LandingMain } from "@/components/landing/landing-main";
import { LandingNav } from "@/components/landing/landing-nav";

console.log("[AvoidTheDot] page: rendering home");

export default function Home() {
  return (
    <div className="relative min-h-screen">
      <LandingNav />
      <LandingMain />
      <LandingFooter />
    </div>
  );
}
