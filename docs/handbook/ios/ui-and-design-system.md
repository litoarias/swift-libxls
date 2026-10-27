# UI And Design System

Each project names its design system in the project wiki (palette type,
fonts, shared components). These rules apply to whatever it is called.

- **IOS-DS-001 (MUST)** Use design-system tokens for colors, fonts, spacing,
  and radii. No hard-coded colors or font sizes when a token exists.
- **IOS-DS-002 (MUST)** Every color supports light and dark appearance (asset
  catalog color sets or adaptive tokens).
- **IOS-DS-003 (SHOULD)** Reuse shared components (loading, error, empty
  state, buttons, cards) before creating feature-local equivalents.
- **IOS-DS-004 (SHOULD)** Promote a component to the shared design system only
  when a second feature needs it.
- **IOS-DS-005 (SHOULD)** Follow current platform materials and controls
  (Liquid Glass on iOS 26+) through system APIs rather than imitating them
  with custom blur stacks.
- **IOS-DS-006 (MUST)** Artwork and illustrations meet a professional bar.
  No placeholder or amateur art ships to production or store screenshots.
- **IOS-DS-007 (SHOULD)** Respect safe areas and support every size class the
  app ships (iPhone mini to Pro Max, iPad if enabled).
