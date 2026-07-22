# Push Notifications — Setup & Operations

This project uses **Expo Push Notifications** end-to-end:

- Backend stores Expo push tokens (`DeviceToken`), sends via `expo-server-sdk`
  (`PushService`), gates delivery by user preference (`NotificationPreference`),
  and polls delivery receipts (`PushReceipt`) to prune dead tokens.
- Both apps register their token after login and respect per-channel toggles
  under **Account/Profile → Notifications**.
- Notification taps deep-link to the relevant screen (see
  `routeForNotificationData` in each app's `services/pushNotifications.ts`).

> Remote push does **not** work in Expo Go (SDK 53+). You must use a Dev Client
> or a standalone build. The code degrades gracefully (no-ops) in Expo Go.

## 1. One-time EAS project setup

For each app (`gp-ride-mobile`, `gp-ride-driver-mobile`):

```bash
npm i -g eas-cli
eas login
cd gp-ride-mobile      # then repeat for gp-ride-driver-mobile
eas init               # creates the project and writes extra.eas.projectId into app.json
```

`eas init` fills in the `extra.eas.projectId` placeholder we scaffolded in
`app.json`. The apps read that value when requesting an Expo push token.

## 2. Credentials (managed by EAS)

- **iOS (APNs):** `eas credentials` → iOS → set up a Push Key (.p8). EAS stores
  and attaches it automatically at build time.
- **Android (FCM):** Create a Firebase project, download the FCM **service
  account JSON** (HTTP v1), then `eas credentials` → Android → upload it. (Legacy
  server keys are deprecated.)

## 3. Build a Dev Client / standalone

```bash
eas build --profile development --platform android   # or ios
# install the resulting build on a physical device, then:
npx expo start --dev-client
```

A physical device is required — push tokens are not issued on simulators.

## 4. Backend env

```
EXPO_ACCESS_TOKEN=     # optional; enables enhanced send limits & security
```

Set it in the backend `.env` if you created an Expo access token
(`expo whoami` / Expo dashboard → Access Tokens). Sending works without it for
low volume.

## 5. Verifying

1. Log in on a physical device (Dev Client/standalone).
2. Confirm a row appears in `DeviceToken` for your user.
3. Trigger a ride event (or create an inbox notification) and confirm the push
   arrives and tapping it routes to the right screen.
4. `PushReceipt` rows are reconciled every 15 minutes; tokens reported
   `DeviceNotRegistered` are pruned automatically.
