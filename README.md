# Config Generator (Jinja + Excel)

Single-page web app for rendering network/config templates from Excel/CSV data using Jinja syntax.

## Project Structure

- src/jinja_config_renderer.html: Main application file
- Dockerfile: Container image definition
- nginx.conf: Static web server configuration
- .github/workflows/ci.yml: GitHub CI/CD pipeline
- VERSION: Current application version
- CHANGELOG.md: Release history

## Run Locally with Docker

Build image:

```bash
docker build -t config-generator:local .
```

Run container:

```bash
docker run --rm -p 8080:8080 --name config-generator config-generator:local
```

Open in browser:

```text
http://localhost:8080
```

## GitHub CI/CD

Workflow file:

- .github/workflows/ci.yml

### What pipeline does

1. verify job (push + pull request):
   - builds Docker image
   - runs container
   - performs HTTP smoke test

2. publish job (push only):
   - logs in to GitHub Container Registry (GHCR)
   - builds and pushes image to:
     - ghcr.io/<OWNER>/<REPO>:latest (default branch)
     - ghcr.io/<OWNER>/<REPO>:<git-tag> (for tags like v1.0.0)
     - ghcr.io/<OWNER>/<REPO>:sha-<commit>

### Requirements for publish

- Repository hosted on GitHub
- GitHub Actions enabled
- Default GITHUB_TOKEN must have permission to write packages
- For release tags (`vX.Y.Z`), tag must match value in VERSION

## Versioning

This project uses Semantic Versioning (`MAJOR.MINOR.PATCH`).

- PATCH: bugfixes, no breaking changes
- MINOR: new backward-compatible features
- MAJOR: breaking changes

Release tag format:

```text
vX.Y.Z
```

Examples:

- v1.0.1
- v1.1.0
- v2.0.0

## Release Process

1. Update code
2. Update VERSION (for example `1.1.0`)
3. Update CHANGELOG.md with a new section
4. Commit changes
5. Create and push tag:

```bash
git tag v1.1.0
git push origin main --tags
```

CI will validate that tag (`v1.1.0`) equals VERSION (`1.1.0`) before publishing image.

## Run at Client Site

If image is published to GHCR:

```bash
docker pull ghcr.io/<OWNER>/<REPO>:latest
docker run --rm -p 8080:8080 --name config-generator ghcr.io/<OWNER>/<REPO>:latest
```

Then open:

```text
http://<host-ip>:8080
```

## Notes

- App is static, no backend required.
- Current template engine and spreadsheet libraries are loaded from CDN in the HTML file, so internet access is needed unless you vendor these scripts locally.
