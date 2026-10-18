#!/bin/bash
# Refresh the native Craft Suite (storytold apps) whenever `omarchy update`
# runs, so craft apps stay in step with system updates.
# Installs/updates via ~/.local/bin/craft-sync (see its header for details).
[[ -x "$HOME/.local/bin/craft-sync" ]] || exit 0
"$HOME/.local/bin/craft-sync" >/dev/null 2>&1 || true
