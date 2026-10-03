---
name: deploy
description: Commit, push, and deploy the personal website to GitHub Pages. Run this after EVERY change to the site (content, layout, widgets, web/index.html, videos, slides) without waiting to be asked — the user wants each change live.
---

# Deploy the site

Every push to `main` triggers `.github/workflows/deploy-pages.yml`, which builds
Flutter web and publishes to https://parsashu.github.io/Personal-Website/.
So "deploy" = verify, commit, push, then confirm the workflow run succeeded.

## Steps

1. **Verify locally**
   - `flutter analyze` — must report no new errors or warnings (the existing
     `info` lints are known; compare the issue count if unsure).
   - For visual changes, `flutter build web --release` and preview with the
     `site-build` config in `.claude/launch.json` (serves `build/web` on :8090).

2. **Commit** on `main` (this repo deploys straight from `main`; no PRs).
   - Stage only the files you changed — never `content/` (local-only archive,
     gitignored) or `build/`.
   - Message style matches history: one plain sentence ending in a period,
     e.g. `Show equal authorship notes on publication cards.`
   - Split unrelated changes into separate commits.

3. **Push**: `git push origin main`.

4. **Confirm the deploy** (`gh` is not installed; use the public API, and
   retry on timeouts — the connection to api.github.com is flaky here)
   - Latest run for the pushed commit:
     `curl -sS -m 25 "https://api.github.com/repos/parsashu/Personal-Website/actions/runs?per_page=1"`
     → check `head_sha`, `status`, `conclusion`, `html_url`.
   - Poll in a background loop (about every 30s) until `status` is
     `completed`; a deploy normally takes a few minutes.
   - On failure, open the run's `html_url` (or its `jobs_url`) to find the
     failing step, fix it, and push again.
   - Pushing again while a run is in progress is fine: the workflow cancels
     the older run and deploys the newest commit.

5. **Report** the commit(s), the run result, and the live URL
   https://parsashu.github.io/Personal-Website/ (a hard refresh may be needed
   for browsers to drop the cached Flutter bundle).
