# Privacy And Secrets

## Secrets

- **CORE-SEC-001 (MUST)** Secrets, API keys, signing material, and tokens
  live in git-ignored files (`*.local.xcconfig`, `Secrets.xcconfig`, `.env`)
  with a committed `*.example` counterpart holding placeholders.
- **CORE-SEC-002 (MUST)** Never log tokens, cookies, authorization headers,
  passwords, health data, or other personal data, not even in debug builds.
- **CORE-SEC-003 (MUST)** Public identifiers (bundle IDs, team IDs, Firebase
  `GoogleService-Info.plist`) are configuration, not secrets, but a server key
  shipped inside an app is a secret and must be proxied or restricted.
- **CORE-SEC-004 (MUST)** If a secret is committed, treat it as leaked: rotate
  it first, then clean history.

## Personal data in public content

- **CORE-PRIV-001 (MUST)** Public pages, store metadata, and legal texts never
  include the owner's real name, personal email, address, or phone.
- **CORE-PRIV-002 (MUST)** Legal pages refer to "the Developer". Contact goes
  through an anonymous form or a product-specific address.
- **CORE-PRIV-003 (MAY)** Technical identifiers such as a GitHub username in a
  canonical URL are acceptable.
- **CORE-PRIV-004 (MUST)** Privacy policies describe what the shipped app
  really does (analytics, ads, AI processing location, cloud sync). Update the
  policy in the same change that alters data collection.
