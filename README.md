# KY Lending Pulse

Live dashboard: **https://<user>.github.io/ky-lending-pulse/** (GitHub Pages, set after first push)

Interactive map of SBA 7(a) lending across Kentucky's 120 counties and 12 KY SBDC
centers, with a permanent history of every data run. Built and updated by the
KY SBDC Lending Pulse agent.

- `index.html` — the dashboard (self-contained; all data embedded)
- `dashboard_data.json` — county→center map + append-only snapshot history
- `ky_map.json` — county SVG paths (static)
- `template.html` — page source; `index.html` = template + the two JSON files

## Update contract (what the agent does each run)
1. Pull latest SBA data, run QC (see the pipeline repo/folder).
2. Append one snapshot to `dashboard_data.json` (never mutate old snapshots;
   skip if both as-of dates are unchanged).
3. Rebuild `index.html` (replace `__MAPDATA__`/`__PULSEDATA__` in the template).
4. Commit with message `data: run YYYY-MM-DD (monthly YYYY-MM-DD, foia YYYY-MM-DD)`
   and push — the Pages site updates automatically, and the git log doubles as
   the run audit trail.

Sources: SBA 7(a) Lender Activity Report (monthly) and SBA 7(a)/504 FOIA
loan-level files (quarterly), both public data from data.sba.gov. As-of dates
are shown throughout the dashboard.

Kentucky Small Business Development Center · Hosted by the University of
Kentucky · Funded in part by the U.S. SBA
