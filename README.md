# omarchy-craft-suite

Native [Craft Suite](https://github.com/storytold) apps for [Omarchy](https://omarchy.org):
installed as real binaries (no AppImages), kept up to date automatically from
the official **storytold** GitHub releases.

## What you get

| | |
|---|---|
| **Apps** | craft-launcher, photocraft, filmcraft, pdfcraft, wordcraft, deckcraft, gridcraft, lightcraft, vectorcraft, designcraft, effectcraft, cadcraft, soundcraft, figcraft |
| **Native layout** | binaries in `~/.local/share/craft-suite/`, symlinks in `~/.local/bin/`, official `.desktop` entries + hicolor icons |
| **Auto-update** | daily systemd user timer + on every `omarchy update` |
| **Safety** | sha256 verified against the release digest, atomic version swap, old versions pruned |

## Install

```bash
git clone https://github.com/amauriswill/omarchy-craft-suite.git
cd omarchy-craft-suite
./install.sh
```

## Usage

```bash
craft-sync              # install/update everything
craft-sync photocraft   # install/update one app
craft-sync check        # show installed vs latest (no changes)
craft-sync list         # list managed apps and versions
```

## How updates happen

1. **Daily** — `craft-sync.timer` (systemd user timer, randomized delay,
   catches missed runs at boot).
2. **On `omarchy update`** — the `post-update.d` hook refreshes the suite
   alongside your system.

Both call the same `craft-sync`, which for each app queries
`github.com/storytold/<app>/releases/latest`, downloads the
`linux-x86_64.tar.gz` bundle, verifies its sha256 digest, swaps versions
atomically and cleans up the previous one.

## Uninstall

```bash
systemctl --user disable --now craft-sync.timer
rm ~/.config/systemd/user/craft-sync.{service,timer}
rm ~/.config/omarchy/hooks/post-update.d/craft-suite-sync.sh
rm ~/.local/bin/craft-sync
rm -rf ~/.local/share/craft-suite
# plus one ~/.local/bin/* symlink, one .desktop and the icons of each app
```

## Credits

All apps belong to [storytold](https://github.com/storytold) — this repo only
packages their official Linux release bundles for Omarchy.
