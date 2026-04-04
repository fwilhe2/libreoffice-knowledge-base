# Document Template

This repository provides a standardized environment for writing documents in Markdown. It includes automated spelling and linting checks, a containerized build process, and VS Code integrations to ensure consistency across different contributors.

## Tooling and Workflow

The setup relies on several tools to maintain document quality:

* **Bilingual Spellcheck:** Configured via [CSpell](https://cspell.org/) with support for English and German. The settings are defined in `.cspell.config.yaml`.
* **Markdown Linting:** Integrated with the [Markdownlint extension](https://marketplace.visualstudio.com/items?itemName=DavidAnson.vscode-markdownlint) for VS Code. It is configured to auto-fix formatting issues on save.
* **Containerized Builds:** A `Makefile` is provided to run builds and checks inside a container, ensuring the same environment is used locally and in GitHub Actions.
* **Automated Checks:** Every push triggers a GitHub Action workflow that runs the spellchecker and attempts a document build.

## Writing Shortcuts (VS Code Snippets)

To speed up common tasks, use `Ctrl` + `Space` in VS Code to trigger these snippets:

| Prefix | Description |
| :--- | :--- |
| `date` | Inserts the current ISO date (e.g., 2026-03-23) |
| `datetime` | Inserts the current ISO datetime (e.g., 2026-03-23 21:34) |
| `note` | Inserts a GitHub Note alert block |
| `tip` | Inserts a GitHub Tip alert block |
| `important` | Inserts a GitHub Important alert block |
| `warning` | Inserts a GitHub Warning alert block |
| `caution` | Inserts a GitHub Caution alert block |

## Configuration and Setup

1. **Extensions:** When opening this project in VS Code, install the recommended extensions listed in `.vscode/extensions.json`.
1. **Custom Dictionary:** If you encounter valid words flagged as errors, add them to the `words` list in `.cspell.config.yaml`.

## Setup Verification

The following sections are used to test the CSpell configuration. If your environment is set up correctly, the "With Errors" sections should show linting highlights.

### English Test

* **Correct:** The efficiency of modern software depends heavily on the accuracy of its underlying algorithms.
* **With Errors:** The *effeciency* of *moderen* *softwear* depends *hevily* on the *accurasy* of its *underlyng* *algorythms*.

### German Test

* **Korrekt:** Die Digitalisierung verändert unsere Gesellschaft in einem rasanten Tempo.
* **Mit Fehlern:** Die *digitalisierung* *ferändert* unsere *geselschaft* in einem *rasandem* *tempo*.

Log Entry 2026-03-14 17:46:25: Happy Pi Day

> [!TIP]
> Not all Markdown features are universal. This template targets GitHub-flavored Markdown.
