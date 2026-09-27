# TODO.AI.md

## setup.sh — pre-existing script-lint findings (36 issues, found 2026-09-27)

- Add `VERSION=` assignment matching the `##@Version` header (202201192154-git) — currently missing entirely
- Prefix caller-settable vars with `DEFAULT_WEB_ASSETS_`: `APACHE_USER` (line 49), `APACHE_GROUP` (line 50), `STATICWEB` (line 54), `PUBLIC_WWW_DIR` (line 55), `STATICDOM` (line 56), `STATICSITE` (line 57), `STATICDIR` (line 58), `STATICREPO` (line 62), `CURRENT_IP_4` (line 63), `CURRENT_IP_6` (line 64)
- Add `--` before the search pattern in every `grep` call missing it (lines 22, 28, 33, 34, 35, 93, 94, 139, 211 — 21 distinct invocations)
- Wrap lines exceeding the 180-char limit: lines 34, 35, 103, 104, 108-111, 120-121, 124-125, 129-132, 136-137, 141, 152, 154, 159, 161
