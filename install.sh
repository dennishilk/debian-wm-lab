#!/usr/bin/env bash
set -Eeuo pipefail

########################################
# debian-wm-lab — install.sh
########################################

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
LOG_FILE="/var/log/debian-wm-lab-install.log"

ASSETS_DIR="$REPO_DIR/common/assets"
WALLPAPER_DIR="$ASSETS_DIR/wallpapers"

DRY_RUN=false
ASSUME_YES=false

EXTRAS_FONTS=false
EXTRAS_TERMINALS=false
EXTRAS_EDITORS=false

########################################
# Logging
########################################
exec > >(tee -a "$LOG_FILE") 2>&1


########################################
# Helpers
########################################
msg()  { echo -e "\n==> $1"; }
warn() { echo "WARNING: $1"; }
die()  { echo "ERROR: $1"; exit 1; }

require_root() {
  [[ $EUID -eq 0 ]] || die "Run as root."
}

run() {
  if $DRY_RUN; then
    echo "[dry-run] $*"
  else
    "$@"
  fi
}

pause() {
  read -rp "Press Enter to continue..."
}

########################################
# Trap
########################################
trap 'die "Installation aborted."' ERR INT

########################################
# Argument parsing
########################################
for arg in "$@"; do
  case "$arg" in
    --dry-run) DRY_RUN=true ;;
    -y|--yes)  ASSUME_YES=true ;;
    --extras=fonts)     EXTRAS_FONTS=true ;;
    --extras=terminals) EXTRAS_TERMINALS=true ;;
    --extras=editors)   EXTRAS_EDITORS=true ;;
    *)
      die "Unknown argument: $arg"
      ;;
  esac
done

########################################
# Sanity checks
########################################
require_root
[[ -f /etc/debian_version ]] || die "Debian only."

########################################
# Intro
########################################
clear
cat <<EOF
========================================
 debian-wm-lab
 Hardened X11 WM Installer
========================================

Flags:
 --dry-run
 --yes
 --extras=fonts
 --extras=terminals
 --extras=editors

If no extras flags are given,
you will be asked interactively.

Philosophy:
 boring • explicit • no magic

Log:
 $LOG_FILE
EOF
pause

########################################
# APT
########################################
msg "Refreshing APT metadata"
run apt update

########################################
# Package installer
########################################
install_packages() {
  local file="$1"
  [[ -f "$file" ]] || die "Missing package list: $file"

  mapfile -t PKGS < <(grep -Ev '^\s*#|^\s*$' "$file")
  [[ ${#PKGS[@]} -eq 0 ]] && warn "No packages in $file" && return

  msg "Package list: $(basename "$file")"
  printf "  %s\n" "${PKGS[@]}"

  if $ASSUME_YES; then
    run apt install -y "${PKGS[@]}"
  else
    read -rp "Install these packages? [y/N]: " yn
    [[ "$yn" =~ ^[Yy]$ ]] || return
    run apt install "${PKGS[@]}"
  fi
}

########################################
# Common base
########################################
install_packages "$REPO_DIR/common/packages.txt"

########################################
# WM selection
########################################
clear
echo "Select Window Manager:"
echo "  1) xmonad"
echo "  2) dwm"
echo "  3) qtile"
echo "  4) ratpoison"
echo "  5) evilwm"
read -rp "Choice [1-5]: " WM_CHOICE

case "$WM_CHOICE" in
  1) WM="xmonad" ;;
  2) WM="dwm" ;;
  3) WM="qtile" ;;
  4) WM="ratpoison" ;;
  5) WM="evilwm" ;;
  *) die "Invalid choice" ;;
esac

install_packages "$REPO_DIR/wm/$WM/packages.txt"

########################################
# Display Manager
########################################
clear
echo "Display Manager:"
echo "  1) LightDM"
echo "  2) None (.xinitrc)"
read -rp "Choice [1-2]: " DM

[[ "$DM" == "1" ]] && run systemctl enable lightdm

########################################
# Interactive extras fallback
########################################
if ! $EXTRAS_FONTS && ! $EXTRAS_TERMINALS && ! $EXTRAS_EDITORS; then
  clear
  echo "Optional extras:"
  read -rp "Install fonts? [y/N]: " a && [[ "$a" =~ ^[Yy]$ ]] && EXTRAS_FONTS=true
  read -rp "Install terminals? [y/N]: " a && [[ "$a" =~ ^[Yy]$ ]] && EXTRAS_TERMINALS=true
  read -rp "Install editors? [y/N]: " a && [[ "$a" =~ ^[Yy]$ ]] && EXTRAS_EDITORS=true
fi

########################################
# Extras
########################################
$EXTRAS_FONTS     && install_packages "$REPO_DIR/extras/fonts/packages.txt"
$EXTRAS_TERMINALS && install_packages "$REPO_DIR/extras/terminals/packages.txt"
$EXTRAS_EDITORS   && install_packages "$REPO_DIR/extras/editors/packages.txt"

########################################
# Wallpaper
########################################
if [[ -f "$WALLPAPER_DIR/lab-default.png" ]]; then
  read -rp "Install default wallpaper system-wide? [y/N]: " wp
  [[ "$wp" =~ ^[Yy]$ ]] && run mkdir -p /usr/share/backgrounds/debian-wm-lab \
    && run cp "$WALLPAPER_DIR/lab-default.png" /usr/share/backgrounds/debian-wm-lab/
fi

########################################
# Finish
########################################
clear
echo "Installation complete. Nothing hidden. Nothing forced."
echo "Log: $LOG_FILE"
