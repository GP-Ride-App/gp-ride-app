# GP Ride — Nigeria Launch Budget & Setup Plan

**Document version:** July 2026  
**Target budget:** ~$500/month for the first few months  
**Billing model:** You create each account → add your card → set billing alerts  
**Launch market:** Nigeria first (Canada later)

---

## Phase 1 — Set up now (before launch)

These should be live early so billing, domain, and project structure are ready.

| Item | What to do | Est. cost (NG launch) | Link |
|------|------------|------------------------|------|
| **Domain name** | Register e.g. `gpride.ng` or `gpride.com` via Cloudflare (recommended) or Namecheap. Point DNS when hosting is ready. | **$12–20/yr** (~₦18k–31k/yr) · **~$1–2/mo** | [Cloudflare Registrar](https://www.cloudflare.com/products/registrar) · [Namecheap](https://www.namecheap.com/) |
| **Google Cloud project** | Create project, attach billing, set **budget alerts** at **$50 / $100 / $250 / $500**. Do **not** enable heavy Maps usage yet — just project + billing + alerts. | **$0–25/mo** (setup / minimal) | [Google Cloud Console](https://console.cloud.google.com) |
| **Company registration (Nigeria)** | CAC business registration (needed for Paystack business account later). Start paperwork now — can take weeks. | **One-time ₦50k–150k+** (~$35–100+) | [CAC Nigeria](https://www.cac.gov.ng/) |
| **GitHub (repo + CI)** | Keep code on GitHub; Actions free tier is enough for now. Fastlane/EAS can wait. | **$0/mo** | [GitHub](https://github.com) |

**Phase 1 monthly run-rate:** ~**$5–30/mo** (mostly domain + tiny/no GCP usage)

---

## Phase 2 — Closer to go-live (can wait)

Turn these on **4–8 weeks before** public launch in Nigeria.

| Item | What to do | Est. cost (NG launch) | Link |
|------|------------|------------------------|------|
| **Google Maps APIs** | Enable **Places**, **Routes**, **Geocoding** when you turn on production maps. Set GCP alerts at **$100 / $250 / $500**. | **$80–200/mo** early NG traffic (scales with rides) | [Google Cloud Console](https://console.cloud.google.com) |
| **Cloud hosting (API + DB + Redis)** | AWS, GCP, or Railway/Render for NestJS + Postgres + Redis. Nigeria-first: start small, scale up. | **$120–280/mo** (fits $500 budget; not $300–1500 yet) | [AWS Pricing](https://aws.amazon.com/pricing/) · [GCP Pricing](https://cloud.google.com/pricing) |
| **Paystack (Nigeria)** | Business account for ride payments + wallet top-ups. Needs CAC docs. Fees per transaction, not a big fixed monthly. | **~1.5% + ₦100** per successful charge (no large monthly fee) | [Paystack](https://paystack.com/) |
| **SMS OTP — Termii (Nigeria)** | Replace dev OTP logging for production signup/login. | **~₦3–6/SMS** → **$30–80/mo** at early volume (~5k–15k OTPs) | [Termii](https://termii.com/) |
| **Apple Developer Program** | Required to publish driver + passenger apps on iOS. | **$99/yr** (~$8/mo) | [Apple Developer](https://developer.apple.com/programs/) |
| **Google Play Console** | One-time fee to publish on Android. | **$25 one-time** | [Google Play Console](https://play.google.com/console) |
| **Mobile CI/CD** | GitHub Actions + **EAS Build** (Expo) when you ship TestFlight/Play internal testing. | **$0–29/mo** (EAS free tier often enough at start) | [Expo EAS](https://expo.dev/eas) |
| **Stripe Connect** | **Wait** — for paying drivers / Canada expansion. Not needed for NG Paystack-only launch. | **When CA expands** | [Stripe Dashboard](https://dashboard.stripe.com/) |
| **Company registration (Canada)** | Only when you launch Canada. | **Later (one-time)** | Provincial/federal business registries |

**Phase 2 monthly run-rate (Nigeria launch):** ~**$250–480/mo** + Paystack transaction fees

---

## Suggested $500/month budget (Nigeria, first 3 months)

| Category | Monthly allocation |
|----------|-------------------|
| Domain (amortized) | ~$2 |
| Google Cloud (Maps + misc) | $80–150 |
| Hosting (API + Postgres + Redis) | $120–200 |
| SMS OTP (Termii) | $30–80 |
| Apple Developer (amortized) | ~$8 |
| EAS / CI (optional) | $0–29 |
| **Buffer / spikes** | $50–100 |
| **Total** | **~$400–500/mo** |

Paystack fees are **usage-based** (per ride), not a fixed monthly line item.

---

## What to create now vs later

### Create now (you + card on file)

1. [Google Cloud](https://console.cloud.google.com) — project + billing alerts ($50 / $100 / $500)
2. [Cloudflare](https://www.cloudflare.com/products/registrar) or Namecheap — domain
3. [GitHub](https://github.com) — org/repo (if not already)
4. Start **CAC Nigeria** registration

### Create closer to launch

1. [Paystack](https://paystack.com/) business account (after CAC)
2. Enable Maps APIs on GCP
3. Cloud host (AWS/GCP/Railway)
4. [Termii](https://termii.com/) for SMS OTP
5. [Apple Developer](https://developer.apple.com/programs/) + [Google Play Console](https://play.google.com/console)
6. EAS Build when ready for TestFlight / internal testing

### Defer until Canada

- Stripe Connect
- Canadian business registration
- Twilio (optional backup; Termii is primary for NG)

---

## Billing alerts to set everywhere

| Service | Alert thresholds |
|---------|------------------|
| Google Cloud | $50 → $100 → $250 → **$500** |
| AWS / hosting | $100 → **$250 → $500** |
| Termii | Top up / low balance at ₦10k, ₦25k, ₦50k |
| Paystack | Dashboard notifications on disputes/chargebacks |

---

## Nigeria-first launch checklist

| Priority | Item | Status |
|----------|------|--------|
| **Now** | Domain registered | ☐ |
| **Now** | GCP project + billing + alerts | ☐ |
| **Now** | CAC registration started | ☐ |
| **Before beta** | Hosting (API + DB + Redis) | ☐ |
| **Before beta** | Maps APIs enabled | ☐ |
| **Before beta** | Termii SMS OTP | ☐ |
| **Before public launch** | Paystack live keys | ☐ |
| **Before public launch** | App Store + Play Console | ☐ |
| **Later** | Stripe + Canada registration | ☐ |

---

## Service links (quick reference)

| Service | URL |
|---------|-----|
| Google Cloud Console | https://console.cloud.google.com |
| Cloudflare Registrar | https://www.cloudflare.com/products/registrar |
| Namecheap | https://www.namecheap.com |
| Paystack | https://paystack.com |
| Stripe Dashboard | https://dashboard.stripe.com |
| AWS Pricing | https://aws.amazon.com/pricing |
| Google Cloud Pricing | https://cloud.google.com/pricing |
| Termii (SMS, Nigeria) | https://termii.com |
| Twilio (SMS, backup) | https://www.twilio.com/pricing |
| Apple Developer Program | https://developer.apple.com/programs |
| Google Play Console | https://play.google.com/console |
| Expo EAS Build | https://expo.dev/eas |
| CAC Nigeria | https://www.cac.gov.ng |

---

## Notes

- **$500/month** is enough for early Nigeria production if you start with modest hosting and low initial Maps/SMS volume.
- Scale-tier cloud ($300–1500+/mo) is for higher traffic — not required on day one.
- You will create accounts for each service and add your card for billing (no direct money transfers needed for setup).
- Maps, Paystack, hosting, SMS, and app store accounts can wait until you are **4–8 weeks from launch**; domain and Google Cloud project should be set up **now**.

---

*GP Ride — Internal launch planning document*
