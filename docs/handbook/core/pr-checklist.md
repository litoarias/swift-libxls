# Core PR Checklist

- [ ] The change does what was asked and nothing unrelated (CORE-ESS-026).
- [ ] New and changed code follows the handbook, or the deviation is in
      `overrides.md` (CORE-ESS-001, CORE-ESS-010).
- [ ] Build and tests run; anything unverified is stated (CORE-VER-001/002).
- [ ] Every new test protects real behavior and would fail if it broke; no
      tests written for coverage (CORE-ESS-027).
- [ ] No secrets, tokens, or personal data in code, logs, or public content
      (CORE-SEC-001/002, CORE-PRIV-001).
- [ ] No AI attribution; commit author is correct (CORE-GIT-001/002).
- [ ] Project wiki updated when setup, integrations, or decisions changed.

Add the platform checklist (`ios/pr-checklist.md` or `web/pr-checklist.md`).
