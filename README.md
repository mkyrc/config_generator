# Config Generator (Jinja + Excel/CSV)

A web app for generating configurations from a Jinja template and Excel/CSV data.

## What The App Does

- Loads a template (`.j2`, `.jinja`, `.txt`)
- Loads data (`.xlsx`, `.xls`, `.csv`)
- Lets you choose a sheet/table and rows
- Generates final configuration text for selected data

## Requirements

- Docker (recommended), or
- a web browser (Chrome/Edge/Firefox) to run without Docker

Note: the app is static (no backend), but libraries are loaded from CDN, so internet access is required.

## Install And Run

### Recommended: Docker

Run this in the project root:

```bash
docker build -t config-generator:local .
docker run --rm -p 8080:8080 --name config-generator config-generator:local
```

Then open in your browser:

```text
http://localhost:8080
```

### Alternative: Without Docker

Open `src/jinja_config_renderer.html` directly in your browser.

If your browser restricts local file loading, run a simple local server:

```bash
python3 -m http.server 8080
```

and open:

```text
http://localhost:8080/src/jinja_config_renderer.html
```

## How To Use The App

1. Upload a data file (`.xlsx`, `.xls`, or `.csv`).
2. Upload a Jinja template (`.j2`, `.jinja`, or `.txt`).
3. If you use Excel, select the correct sheet.
4. Select rows you want to generate configuration for.
5. Click generate/render.
6. Review the output and copy it to your target system/device.

Tip: the `data/` folder contains sample files (`test.csv`, `data.xlsx`, `config.j2`) so you can test the workflow quickly.

## Common Issues

- Page does not open on `localhost:8080`:
   - check if the container is running: `docker ps`
   - if the port is in use, change mapping, for example: `-p 8081:8080`

- Docker is not available:
   - use the without-Docker alternative above

- Library loading fails:
   - verify internet connectivity (CDN scripts)

## Current Version And Changes

- Version: see `VERSION`
- Changelog: `CHANGELOG.md`
