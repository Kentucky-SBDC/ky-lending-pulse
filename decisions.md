# Decision Record: KY Lending Pulse

Purpose of this file: these are settled decisions with an owner and a rationale. Any AI session or collaborator working on this project must follow them. **Do not reverse, weaken, or silently work around any entry without Kevin Norvell's explicit consent in the current conversation.** If a task seems to require deviating, stop and ask first. New durable decisions get appended here with a date.

Format: D-## · decision · rationale · date.

## Data and sources

- **D-01. Two-mode cadence, never merged row-wise.** Monthly "Lender Pulse" from the Lender Activity Report aggregates; quarterly "Project Deep-Dive" from the FOIA loan-level file. Separate tables, separate as-of dates. Rationale: the sources differ in definitions (cancelled-loan handling, lender naming) and merging rows produces subtle wrong numbers. (2026-08-23)
- **D-02. As-of dates come from inside the files**, never from the data.sba.gov page metadata (which is stale): monthly from the About sheet, FOIA from the filename. (2026-08-23)
- **D-03. Territory mapping lives only in `pipeline/config/territories.csv`.** ProjectCounty is the join key; every KY county maps to exactly one center; an unmapped county is a hard QC block, never a silent drop. The agent never infers territories from anything else. (2026-08-23)
- **D-04. Cancelled loans:** excluded from project lists; included in monthly totals (that is how SBA publishes them). Cross-source checks assert monthly >= FOIA unless windows match exactly. (2026-08-23)
- **D-05. FOIA dedup key includes TermInMonths + LoanStatus** because the file has no loan ID and re-issued loans can otherwise look identical. Exact duplicates warn and are logged, they do not block. (2026-08-23)
- **D-06. Lender rankings sort by loan count** (dollars shown alongside). Rationale: counts better reflect a lender's willingness to do coaching-relevant deals. Revisit only with coach feedback. (2026-08-23)

## Publishing and privacy

- **D-07. No coach names, emails, or Slack IDs in anything public** (dashboard, repo, commits, Sheets). Centers only. Owner: Kevin, explicitly. The repo's initial commit was amended so names never entered git history; keep it that way. (2026-08-23/24)
- **D-08. The repo lives in the Kentucky-SBDC GitHub org**, public, with GitHub Pages as the dashboard host. The old personal-account Pages URL is dead; never cite it. (2026-08-24)
- **D-09. Google Sheets stay in Kevin's personal Google account with public link-sharing.** No Workspace migration. Every file the system creates in Drive must be set public (anyone with link, viewer). (2026-08-24)
- **D-10. Dashboard history is append-only.** Snapshots are never edited or deleted; the page must let a viewer replay any prior run. (2026-08-23)
- **D-11. Borrower names are allowed** in coach briefings and Sheets (public FOIA records) but are framed as "approved projects," never "leads," and always carry the approvals-not-disbursements caveat. (2026-08-23)

## Delivery and review

- **D-12. Coach briefings are Slack DM drafts, never direct sends.** One combined draft per coach per run (Slack allows one attached draft per DM). A human reviews and sends. (2026-08-23)
- **D-13. #sba-lending-review is the audit surface**: QC summaries, blocked-run reports, Owensboro's briefings (while the coach seat is vacant), and the statewide recap all post there. The statewide recap's permanent home is this channel and it posts only on runs where new data was published. (2026-08-24)
- **D-14. Publish only on data change.** The Monday check is silent when SBA has nothing new: no posts, no drafts, no commits. External framing of update frequency is "quarterly" (Kevin's wording in the announcement) even though monthly lender data may arrive more often. (2026-08-24)

## Style

- **D-15. No em-dashes in any written output**, anywhere: reports, dashboard text, Slack messages, documents. Use colons, commas, middots, or parentheses. (2026-08-24)
- **D-16. KY SBDC branding** on documents and the dashboard: navy #1B2D5B primary, red #C8102E as sparse accent, Calibri-first type, official logo set, "business coaches" terminology (never "advisors"). Dashboard color ramps must pass the dataviz palette validator in both light and dark modes. (2026-08-23)

## Architecture

- **D-17. Runtime is Claude scheduled task + connectors** (not Make.com). Revisit only if reliability requires it. (2026-08-23)
- **D-18. The dashboard is a single self-contained HTML page** (data and map embedded, no external services beyond Google Fonts). Rebuilt from `dashboard/template.html`; never hand-edit `index.html`. (2026-08-23)
- **D-19. Big payloads never go through connector calls as base64.** Use CSV text for Sheets; keep raw loan-level data local. (2026-08-23)
- **D-20. git/gh operations run unsandboxed** because the GitHub token lives in the macOS keyring. Nothing else gets sandbox exemptions by default. (2026-08-24)

## How to change a decision

State the entry number to Kevin, explain the tradeoff, and get his explicit yes in the conversation. Then update this file (amend the entry with the new date and outcome) and project memory in the same session.
