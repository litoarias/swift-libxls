# Analytics, Ads And Consent

Applies to apps that use Firebase and AdMob.

- **IOS-ADS-001 (MUST)** Firebase Analytics collection stays enabled
  (`Analytics.setAnalyticsCollectionEnabled(true)`) regardless of ATT
  consent. ATT and UMP only decide whether AdMob serves personalized or
  non-personalized ads. Analytics never reads the IDFA.
- **IOS-ADS-002 (MUST)** The consent flow (UMP, then ATT) runs once per launch
  before the first ad request, from one owner.
- **IOS-ADS-003 (MUST)** Analytics events and parameters are defined in one
  place per app (enum or constants), named in `snake_case`, and never contain
  personal data or free text entered by the user.
- **IOS-ADS-004 (MUST)** `PrivacyInfo.xcprivacy` and the App Store privacy
  labels are updated whenever an SDK or collected data type changes.
- **IOS-ADS-005 (SHOULD)** Analytics and ads are accessed through Domain
  protocols, so view models stay testable and previews do not hit SDKs.
