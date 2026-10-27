# Localization And Accessibility

## Localization

- **IOS-L10N-001 (MUST)** User-facing strings use String Catalogs
  (`Localizable.xcstrings`, `InfoPlist.xcstrings`). No new legacy `.strings`
  or `.lproj` files.
- **IOS-L10N-002 (MUST)** Every new key is translated into every language the
  project ships, listed in the project wiki. No key ships with a missing
  translation.
- **IOS-L10N-003 (MUST)** No hard-coded user-facing strings in code. Use
  `String(localized:)` / `LocalizedStringResource` with a comment for
  translators when context is not obvious.
- **IOS-L10N-004 (MUST)** Numbers, dates, durations, units, and currency use
  formatters (`.formatted()`, `Measurement`), never string concatenation.
- **IOS-L10N-005 (SHOULD)** Plurals use catalog plural variants, not `if count == 1`.
- **IOS-L10N-006 (SHOULD)** Layouts are checked with the longest language and,
  when shipped, a right-to-left language.

## Accessibility

- **IOS-A11Y-001 (MUST)** Every interactive element has a meaningful
  accessibility label; decorative images are hidden from VoiceOver.
- **IOS-A11Y-002 (MUST)** Text uses Dynamic Type styles and layouts do not
  truncate critical text at accessibility sizes.
- **IOS-A11Y-003 (MUST)** Color is never the only carrier of meaning, and text
  contrast meets WCAG AA in light and dark mode.
- **IOS-A11Y-004 (SHOULD)** Animations respect Reduce Motion; tap targets are
  at least 44×44 pt.
