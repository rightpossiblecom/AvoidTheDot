# AvoidTheDot

Minimal reflex survival arcade — dodge one bouncing dot, beat your best time.

## Repository layout

| Path | What it is |
|------|------------|
| `lib/` | Flutter app (Android / iOS) |
| `landing_page/` | Next.js marketing site |
| `docs/` | PRD, release assets, Play listing copy |
| `assets/` | Shared `app_logo.png` for app and site |

## Flutter app

```bash
flutter pub get
flutter run
```

Release Android bundle:

```bash
flutter build appbundle --release
```

## Landing page

```bash
cd landing_page
pnpm install
pnpm dev
```

Deploy **only the marketing site** (not the Flutter app). From repo root:

```bash
cd landing_page
pnpm install
vercel --prod
```

In the Vercel dashboard, set **Root Directory** to `landing_page` if you connect this GitHub repo for automatic deploys.

## Links

- Privacy: https://avoidthedot.app/privacy-policy
- Support: support@avoidthedot.app
