# Personal Website

Minimal academic Flutter web site (demos + Nova Robot slide viewer).

## Local run

```bash
flutter run -d web-server --web-hostname=127.0.0.1 --web-port=8080
```

Keep the local `content/` folder for demo videos (it is **not** in git). Symlink for local serving:

```bash
ln -sfn ../content web/content
ln -sfn ../assets/slides web/slides
```

## GitHub Pages

On every push to `main`, GitHub Actions builds Flutter web and deploys Pages.

Site URL (after Pages is enabled):

https://parsashu.github.io/Personal-Website/

Enable under **Settings → Pages → Source: GitHub Actions**.
