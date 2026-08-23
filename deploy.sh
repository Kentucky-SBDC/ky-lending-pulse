#!/bin/sh
# Rebuild index.html from template + data, commit, push. Run from site/.
set -e
python3 - <<'PY'
tpl=open('template.html').read()
m=open('ky_map.json').read(); d=open('dashboard_data.json').read()
open('index.html','w').write(tpl.replace('__MAPDATA__',m).replace('__PULSEDATA__',d))
PY
import_date=$(python3 -c "import json;s=json.load(open('dashboard_data.json'))['snapshots'][-1];print(f\"run {s['run']} (monthly {s['monthly_as_of']}, foia {s['foia_as_of']})\")")
git add -A && git commit -m "data: $import_date" && git push
