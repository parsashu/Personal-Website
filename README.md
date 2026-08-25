# Personal Website

Minimal academic Flutter web site (demos + slide viewer).

**Live site:** https://parsashu.github.io/Personal-Website/

## Auto deploy

Every push to `main` runs GitHub Actions:

1. Builds Flutter web  
2. Bundles slides + demo videos from `web/content/`  
3. Deploys to GitHub Pages  

Workflow: [`.github/workflows/deploy-pages.yml`](.github/workflows/deploy-pages.yml)  
Runs: https://github.com/parsashu/Personal-Website/actions  

One-time setup (if not already done):

**Settings → Pages → Build and deployment → Source → GitHub Actions**

## Local run

```bash
flutter run -d web-server --web-hostname=127.0.0.1 --web-port=8080
```

Demo videos used by the site live in `web/content/` (committed).  
The larger local archive in `content/` stays out of git.
