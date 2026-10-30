# Recipe: Add Crashlytics

How to meet IOS-LOG-004 in an app that already uses Firebase (it has a
`GoogleService-Info.plist` and calls `FirebaseApp.configure()`). Without
Firebase, add the Firebase package and an app in the Firebase console first.

1. **Package.** Add the `FirebaseCrashlytics` product of the
   `firebase-ios-sdk` package the project already uses to the app target
   only. Widgets, watch apps and other extensions do not get it.
2. **Start it at launch.** Right after `FirebaseApp.configure()`, set the
   collection explicitly for both build types. The setting is stored on the
   device, so set it in Release too, or a phone that once ran a Debug build
   keeps it off after installing the store version:

   ```swift
   FirebaseApp.configure()
   #if DEBUG
   Crashlytics.crashlytics().setCrashlyticsCollectionEnabled(false)
   #else
   Crashlytics.crashlytics().setCrashlyticsCollectionEnabled(true)
   #endif
   ```

   If the app has a crash-reporting wrapper (IOS-ADS-005), the call lives in
   its Data implementation, and the wrapper is created at the composition
   root.
3. **Upload dSYMs.** In the app target, check that Release has
   `DEBUG_INFORMATION_FORMAT = dwarf-with-dsym`, and add a Run Script build
   phase after "Embed" phases:

   ```sh
   [ "$CONFIGURATION" = "Release" ] || exit 0
   "${BUILD_DIR%/Build/*}/SourcePackages/checkouts/firebase-ios-sdk/Crashlytics/run"
   ```

   Input files:

   ```text
   ${DWARF_DSYM_FOLDER_PATH}/${DWARF_DSYM_FILE_NAME}
   ${DWARF_DSYM_FOLDER_PATH}/${DWARF_DSYM_FILE_NAME}/Contents/Resources/DWARF/${PRODUCT_NAME}
   ${DWARF_DSYM_FOLDER_PATH}/${DWARF_DSYM_FILE_NAME}/Contents/Info.plist
   $(TARGET_BUILD_DIR)/$(UNLOCALIZED_RESOURCES_FOLDER_PATH)/GoogleService-Info.plist
   $(TARGET_BUILD_DIR)/$(EXECUTABLE_PATH)
   ```

   The script lives in `SourcePackages`, outside the project, so the app
   target needs `ENABLE_USER_SCRIPT_SANDBOXING = NO`.
4. **Privacy.** In `PrivacyInfo.xcprivacy`, declare
   `NSPrivacyCollectedDataTypeCrashData` (not linked, not tracking, purpose
   App Functionality). In App Store Connect › App Privacy, add Diagnostics ›
   Crash Data with the same answers. Name Crashlytics in the privacy policy
   (CORE-PRIV-004).
5. **Check it.** Archive, confirm the build log shows the dSYM upload, and
   after the first install from TestFlight force a test crash (a hidden debug
   action or `fatalError` in a throwaway build) and see it in the Firebase
   console › Crashlytics. The first report can take a few minutes.
