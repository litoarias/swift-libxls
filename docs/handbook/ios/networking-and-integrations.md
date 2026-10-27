# Networking And Integrations

## Networking

- **IOS-NET-001 (MUST)** Backend calls go through the project's shared HTTP
  client. `URLSession` is used directly only inside that client. `[lint]`
- **IOS-NET-002 (MUST)** Endpoint construction, headers, query items, bodies,
  decoding, and mapping live in the Data repository that owns the capability.
- **IOS-NET-003 (MUST)** DTOs are mapped to Domain models before leaving Data.
- **IOS-NET-004 (MUST)** Repositories translate HTTP and transport errors into
  domain errors (`401`/`403` become the context's invalid-session error). The
  UI never receives raw `URLError` or HTTP status codes.
- **IOS-NET-005 (MUST)** Hosts, keys, and environment URLs come from build
  configuration (`xcconfig` to `Info.plist`), never hard-coded per call.
- **IOS-NET-006 (SHOULD)** Decoding uses explicit `CodingKeys` or a configured
  decoder strategy, and dates are parsed with an explicit format.

## SDKs and system frameworks

- **IOS-INT-001 (MUST)** HealthKit, StoreKit, WatchConnectivity,
  MultipeerConnectivity, Core Location, Firebase, AdMob, AI SDKs, and similar
  are accessed only from Data repositories (or a dedicated client in Shared).
  Domain and Presentation see protocols.
- **IOS-INT-002 (MUST)** Permission requests are triggered by a clear user
  action or onboarding step, with a pre-permission explanation when the
  system prompt alone would be confusing.
- **IOS-INT-003 (SHOULD)** On-device AI (Foundation Models) is gated with
  `@available` and has a non-AI fallback; the availability decision is exposed
  as state, not checked in views.
- **IOS-INT-004 (MUST)** Remote AI providers receive only the data the feature
  needs; the privacy policy says which provider processes it.
- **IOS-INT-005 (SHOULD)** StoreKit 2 transaction handling (listener,
  `finish()`, entitlement refresh) lives in one repository started at launch.
