# UI QA — Blog

Full responsive audit: 2026-09-12

## Viewport strategy

- Desktop / large laptop: article 760px, wide components max 960px.
- Laptop / tablet: <=1024px, 16px page gutters.
- Mobile: <=760px, 12px page gutters.
- Small phone: <=430px, 10px gutters.
- Narrow phone: <=360px, 8px gutters.
- Footer uses the same gutter system as the page at every breakpoint.
- Footer includes bottom safe-area padding for mobile browser/device insets.

## Components audited

- sticky navigation
- reading progress
- hero metadata/title/dek
- table of contents
- 12 principle rows
- all 5 Mermaid diagrams
- project-scoped sequence diagram
- both tables
- mobile stacked-table layout
- code blocks and copy fallback
- findings
- roadmap
- metrics
- references
- footer
- reduced-motion fallback
- horizontal-overflow safeguards

## Structural checks

```json
{
  "footer_uses_footer_inner": true,
  "footer_no_article_class": true,
  "footer_mobile_760": true,
  "footer_small_phone_430": true,
  "narrow_360_breakpoint": true,
  "laptop_1024_breakpoint": true,
  "mobile_760_breakpoint": true,
  "small_430_breakpoint": true,
  "safe_area_footer": true,
  "mobile_tables_stacked": true,
  "diagram_mobile_fit": true,
  "no_internal_chat_citation": true,
  "toc_targets_valid": true,
  "duplicate_ids": []
}
```
