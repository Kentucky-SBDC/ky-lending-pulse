# KY Lending Pulse

Owner: Kevin Norvell, Kentucky SBDC (kevin.norvell@gmail.com)
Status: Live since 2026-08-24. Automated via the "ky-lending-pulse-update" scheduled task (Mondays 7:00 AM local).
Companion docs: `decisions.md` (binding decisions), `as-built.html` (full technical reference), `sba-7a-lending-agent-design.html` (original design).

## Core purpose

Turn official, public SBA 7(a) lending data into center-level intelligence for KY SBDC business coaches, so that:

1. Coaches know which lenders are actively closing 7(a) deals in their counties right now.
2. Coaches see which nearby businesses were recently approved for funding.
3. The network has a public, always-current, historically complete view of SBA lending across Kentucky (this supports the organization's goal of regular SBA loan-activity reporting starting next year).

## What the system does (scope)

- Pulls two public SBA sources: the monthly 7(a) Lender Activity Report and the quarterly 7(a) FOIA loan-level file.
- Validates them through hard quality gates; a failed gate stops the run and publishes nothing.
- Publishes an interactive dashboard (county map, 12 center views, append-only run history) to GitHub Pages under the Kentucky-SBDC org.
- Creates public Google Sheets with the cleaned tables each run.
- Stages one Slack DM draft per business coach for human review; posts a QC summary and statewide recap to #sba-lending-review.
- Preserves every prior data run: dashboard snapshot history, git history, Slack audit thread, and pipeline run log.

## What the system does NOT do (out of scope)

- It never sends messages to coaches directly. Coach briefings are drafts; a human sends them.
- It does not cover the 504 program (candidate for v2; same sources support it).
- It does not contact borrowers or lenders, and does not frame borrower records as "leads."
- It does not use any non-public or authenticated SBA data. All sources are public; approvals are not disbursements and every output says so.
- It does not publish on a fixed calendar. It publishes only when SBA releases new data (checked weekly).

## Operational boundaries

- **Human-in-the-loop:** all coach-facing sends and all network-wide announcements are reviewed and sent by Kevin. The agent's autonomy ends at staging drafts and posting to the private review channel.
- **Privacy line:** coach names, emails, and Slack IDs never appear in anything public (dashboard, repo, commits, Sheets). Centers only. Coach data lives solely in `pipeline/config/territories.csv`.
- **Public artifacts stay public:** the dashboard, repo, and the Google Sheets (shared "anyone with link"). Future runs must preserve this.
- **Data integrity:** raw snapshots are never mutated; dashboard history is append-only; every number traces to a named SBA file with an as-of date and hash.
- **Failure posture:** when QC blocks or a source changes shape, the run stops loudly (review-channel post) rather than publishing questionable data.
- **Runtime:** runs locally via the Claude scheduled task while the app is open; a missed window fires on next launch. Credentials: GitHub via gh keyring (Kentucky-SBDC org), Google Drive and Slack via Kevin's claude.ai connectors.

## Success criteria

- Reports reach coaches within about 3 business days of an SBA publish.
- Zero unreviewed sends; zero coach PII in public surfaces.
- A visitor 6 months from now can replay any prior data run from the dashboard.
- Coach feedback (thumbs up/down on briefings) trends positive at the 90-day review.

## Known gaps

- Owensboro center has a coach vacancy; its briefings go to #sba-lending-review until a coach is added to the territory config.
- Google Sheets are create-only through the current connector, so each run creates new dated files rather than updating in place.
