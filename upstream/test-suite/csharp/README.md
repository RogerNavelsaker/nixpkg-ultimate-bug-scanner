# C# Fixtures

- `buggy/` contains intentionally unsafe patterns for `ubs-csharp.sh`.
- `clean/` provides counterexamples that should stay free of critical/warning findings.
- `tests/test_helper_scanners.py` covers the helper-backed type narrowing, resource lifecycle, and async task-handle analyzers directly.
- `manifest.json` now also includes a shimmed ast-grep regression case so the AST rule pack stays testable even when `ast-grep` is not installed globally.
- Manifest cases run with `--no-dotnet` so scanner regressions stay stable even when the .NET SDK is absent.
