#!/bin/bash
# omarchy-craft-suite installer
# Copies craft-sync, the systemd user timer and the omarchy update hook
# into place, then runs the initial install of the Craft Suite apps.
set -euo pipefail

SRC="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

install -Dm755 "$SRC/craft-sync" "$HOME/.local/bin/craft-sync"
install -Dm644 "$SRC/craft-sync.service" "$HOME/.config/systemd/user/craft-sync.service"
install -Dm644 "$SRC/craft-sync.timer" "$HOME/.config/systemd/user/craft-sync.timer"
install -Dm755 "$SRC/hooks/craft-suite-sync.sh" "$HOME/.config/omarchy/hooks/post-update.d/craft-suite-sync.sh"

systemctl --user daemon-reload
systemctl --user enable --now craft-sync.timer

echo
echo "✔ craft-sync installed; daily timer enabled."
echo "→ Installing/updating the Craft Suite apps now:"
echo
"$HOME/.local/bin/craft-sync"
