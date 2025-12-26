#!/usr/bin/env bash
set -Eeuo pipefail

########################################
# debian-wm-lab — install-apps.sh
# Userland applications installer
########################################

########################################
# Globals
########################################
REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
LOG_FILE="/var/log/debian-wm-lab-apps.log"

DRY_RUN=false
ASSUME_YES=false

INSTALL_BROWSERS=false
INSTALL_GAMING=false
INSTALL_MEDIA=false
INSTALL_TOOLS=false
INSTALL_CHROME=false

########################################
# Logging (everything)
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

########################################
# Trap
########################################
trap 'die "Apps installation aborted."' ERR INT

########################################
# Argument parsing
########################################
for arg in "$@"; do
  case "$arg" in
    --dry-run) DRY_RUN=true ;;
    -y|--yes)  ASSUME_YES=true ;;
    browsers)  INSTALL_BROWSERS=true ;;
    gaming)    INSTALL_GAMING=true ;;
    media)     INSTALL_MEDIA=true ;;
    tools)     INSTALL_TOOLS=true ;;
    chrome)    INSTALL_CHROME=true ;;
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
 debian-wm-lab — apps installer
========================================

Categories:
 browsers   (firefox, chromium)
 gaming     (steam, mangohud, gamescope)
 media      (vlc, obs-studio, audacity, gimp)
 tools      (fastfetch, htop, pavucontrol, ...)

Special:
 chrome     (external Google repository)

Flags:
 --dry-run
 --yes

This installer:
 - installs ONLY user applications
 - does NOT touch WM, DM, kernel or sysctl

Log:
 $LOG_FILE
EOF

########################################
# Generic package installer
########################################
install_packages() {
  local file="$1"

  [[ -f "$file" ]] || die "Missing package list: $file"

  mapfile -t PKGS < <(grep -Ev '^\s*#|^\s*$' "$file")

  if [[ ${#PKGS[@]} -eq 0 ]]; then
    warn "No packages in $file"
    return
  fi

  msg "Installing $(basename "$(dirname "$file")") packages"
  printf "  %s\n" "${PKGS[@]}"

  if $ASSUME_YES; then
    run apt install -y "${PKGS[@]}"
  else
    read -rp "Proceed? [y/N]: " yn
    [[ "$yn" =~ ^[Yy]$ ]] || return
    run apt install "${PKGS[@]}"
  fi
}

########################################
# Steam (explicit multiarch handling)
########################################
install_steam() {
  msg "Preparing system for Steam (i386 multiarch)"

  if ! dpkg --print-foreign-architectures | grep -q i386; then
    msg "Enabling i386 architecture"
    run dpkg --add-architecture i386
    run apt update
  else
    msg "i386 architecture already enabled"
  fi

  install_packages "$REPO_DIR/apps/gaming/packages.txt"
}

########################################
# Interactive fallback (no args)
########################################
if ! $INSTALL_BROWSERS && ! $INSTALL_GAMING && ! $INSTALL_MEDIA && ! $INSTALL_TOOLS && ! $INSTALL_CHROME; then
  echo "Select application categories:"
  read -rp "Browsers? [y/N]: " a && [[ "$a" =~ ^[Yy]$ ]] && INSTALL_BROWSERS=true
  read -rp "Gaming? [y/N]: " a && [[ "$a" =~ ^[Yy]$ ]] && INSTALL_GAMING=true
  read -rp "Media? [y/N]: " a && [[ "$a" =~ ^[Yy]$ ]] && INSTALL_MEDIA=true
  read -rp "Tools? [y/N]: " a && [[ "$a" =~ ^[Yy]$ ]] && INSTALL_TOOLS=true
  read -rp "Google Chrome (external repo)? [y/N]: " a && [[ "$a" =~ ^[Yy]$ ]] && INSTALL_CHROME=true
fi

########################################
# Execute categories
########################################
$INSTALL_BROWSERS && install_packages "$REPO_DIR/apps/browsers/packages.txt"
$INSTALL_MEDIA    && install_packages "$REPO_DIR/apps/media/packages.txt"
$INSTALL_TOOLS    && install_packages "$REPO_DIR/apps/tools/packages.txt"
$INSTALL_GAMING   && install_steam

########################################
# Google Chrome (external repo, explicit)
########################################
if $INSTALL_CHROME; then
  msg "Installing Google Chrome (external repository)"

  run apt install -y ca-certificates curl gnupg

  run curl -fsSL https://dl.google.com/linux/linux_signing_key.pub \
    | gpg --dearmor -o /usr/share/keyrings/google-chrome.gpg

  echo "deb [arch=amd64 signed-by=/usr/share/keyrings/google-chrome.gpg] \
https://dl.google.com/linux/chrome/deb/ stable main" \
    | run tee /etc/apt/sources.list.d/google-chrome.list > /dev/null

  run apt update
  run apt install -y google-chrome-stable
fi

########################################
# Finish
########################################
clear
cat <<EOF
========================================
 Apps installation complete
========================================

Installed categories:
$( $INSTALL_BROWSERS && echo " - browsers" )
$( $INSTALL_GAMING   && echo " - gaming" )
$( $INSTALL_MEDIA    && echo " - media" )
$( $INSTALL_TOOLS    && echo " - tools" )
$( $INSTALL_CHROME   && echo " - google-chrome" )

No system settings were changed.
No window manager was touched.

Log:
 $LOG_FILE
EOF
