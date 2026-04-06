# GP Ride

Monorepo for **GP Ride**: a ride-hailing platform with **Ride Now, Pay Later (RNPL)**, trust scoring, and multi-region payments (Paystack, Flutterwave, Stripe, Square) on the roadmap.

This repository currently contains:

- **`gp-ride-backend`** — NestJS API, PostgreSQL via Prisma, JWT auth (access + refresh), role-based access (passenger, driver, admin).
- **`gp-ride-mobile`** — Passenger Expo app (SDK 54).
- **`gp-ride-driver-mobile`** — Driver Expo app (separate install, bundle ID, Metro port **8082**).

### Mobile apps

| App | Directory | Metro port |
|-----|-----------|------------|
| Passenger | `gp-ride-mobile` | 8081 |
| Driver | `gp-ride-driver-mobile` | 8082 |

See each app’s `README.md` for `npm install` and `npm start`.

## Backend quick start

Prerequisites: **Node.js 20+**, **PostgreSQL 14+**, and **npm**.

1. **Create a database** (example name: `gp_ride`).

2. **Configure environment**

   ```bash
   cd gp-ride-backend
   cp .env.example .env
   ```

   Edit `.env`: set `DATABASE_URL`, `JWT_ACCESS_SECRET`, and `JWT_REFRESH_SECRET` (use long random strings in production, for example `openssl rand -base64 32`).

3. **Install and migrate**

   ```bash
   npm install
   npx prisma migrate deploy
   ```

   For local development you can use `npm run prisma:migrate` instead of `deploy` to create new migrations interactively.

4. **Run the API**

   ```bash
   npm run start:dev
   ```

   - Health: `GET http://localhost:3000/v1/health`
   - Global prefix: `/v1`

### Auth endpoints (v1)

| Method | Path | Description |
|--------|------|-------------|
| `POST` | `/v1/auth/register/passenger` | Register passenger |
| `POST` | `/v1/auth/register/driver` | Register driver |
| `POST` | `/v1/auth/login` | Login (email + password) |
| `POST` | `/v1/auth/refresh` | Rotate refresh token → new access + refresh |
| `POST` | `/v1/auth/logout` | Revoke a refresh token |
| `POST` | `/v1/auth/password/forgot` | Request reset (constant response; no email enumeration) |
| `POST` | `/v1/auth/password/reset` | Set new password with emailed token; revokes all refresh tokens |
| `POST` | `/v1/auth/password/change` | Logged-in change password; revokes all refresh tokens |
| `GET` | `/v1/auth/me` | Current user (Bearer access token) |
| `GET` | `/v1/auth/admin/ping` | Example admin-only route |

Responses from register, login, and refresh include **`accessToken`**, **`refreshToken`**, **`expiresIn`**, and a **`user`** object (no password hash).

Send access tokens as: `Authorization: Bearer <accessToken>`.

**Password reset:** tokens are random opaque strings stored as SHA-256 hashes. Replace `LoggingPasswordResetMailer` with your provider (Resend, SendGrid, SES, etc.) and set `PASSWORD_RESET_LINK_BASE` so the email can link to your app or web reset screen. For local testing only, `DEV_LOG_PASSWORD_RESET_TOKEN=true` logs the raw token when `NODE_ENV` is not `production`.

### Creating the first admin user

There is no public “register admin” endpoint (by design). Create an admin in the database, for example with Prisma Studio (`npm run prisma:studio`) or a one-off SQL update: set `role` to `ADMIN` for a trusted user after they have registered as passenger or driver.

### Security notes for production

- Use strong, distinct `JWT_ACCESS_SECRET` and `JWT_REFRESH_SECRET`.
- Terminate TLS at your reverse proxy or platform; never send tokens over plain HTTP.
- Tune `CORS_ORIGINS` to your mobile/web origins.
- Rate limiting is enabled globally (see `AppModule` / `ThrottlerModule`); auth routes use stricter limits.

## Product scope (summary)

Passenger and driver onboarding, payments and card verification, fare estimates, RNPL eligibility (trust score, repayment windows), ride tracking, notifications, account lock for delinquent RNPL, admin operations, and future community credit / hire-a-driver features—as described in the GP Ride MVP and development agreement.

## License

Proprietary — All rights reserved unless otherwise agreed in writing.
