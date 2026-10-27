# Recipe: Add A Data Capability

For a capability without its own screen: API, SDK, Keychain, cache,
analytics, database, HealthKit, StoreKit, or similar.

1. Define the repository protocol in `Domain/<Context>/Repositories`.
2. Add DTOs in Data only when an external payload must be decoded.
3. Add a mapper when the transformation is reusable or substantial.
4. Implement the protocol once in `Data/Repositories`, accessing the HTTP
   client, storage client, or SDK directly.
5. Put infrastructure in the shared layer only when several repositories use
   it.
6. Create the concrete repository in the composition root and inject its
   Domain protocol.
7. Test at the Data boundary: requests, persistence, SDK interaction,
   decoding, mapping, caching, and error translation.
8. If it collects new data, update `PrivacyInfo.xcprivacy`, store privacy
   labels, and the privacy policy (CORE-PRIV-004).

Changing provider later means another implementation of the same protocol,
selected in the composition root.
