# debian-wm-lab

**A minimal Debian 13 X11 playground to install and test tiling window managers like xmonad, dwm, qtile, ratpoison and evilwm.**

---

## 🇩🇪 Was ist debian-wm-lab?

**debian-wm-lab** ist ein **minimales, interaktives Setup-Projekt** für Debian 13,  
das eine **saubere X11-Basis** bereitstellt, um klassische und minimalistische  
**Window Manager zu installieren, zu testen und zu vergleichen**.

Der Fokus liegt auf:
- Stabilität
- Reproduzierbarkeit
- minimalem Overhead
- nachvollziehbaren Entscheidungen

Dieses Projekt ist **kein Desktop Environment**, **keine Distro** und **kein All-in-One-Installer**.

---

## 🇬🇧 What is debian-wm-lab?

**debian-wm-lab** is a **minimal, interactive setup project** for Debian 13  
that provides a **clean X11 base** to install, test and compare classic and minimal  
**tiling window managers**.

The focus is on:
- stability
- reproducibility
- minimal overhead
- transparent, understandable choices

This project is **not a desktop environment**, **not a distribution**, and **not an all-in-one installer**.

---

## 🎯 Projektziel / Project goal

🇩🇪  
Ein reproduzierbares Debian-13-System, das:
- bewusst **wenig** installiert
- eine **einheitliche Basis** für verschiedene WMs bietet
- ideal für **Tests, Vergleiche ** ist

🇬🇧  
A reproducible Debian 13 system that:
- installs **only what is necessary**
- provides a **consistent base** for multiple WMs
- is ideal for **testing, comparisons **

---

## 🧠 Philosophie / Philosophy

🇩🇪  
- **X11 only** (bewusst)
- **boring is good**
- **no magic**
- **no hidden services**
- **user decides what comes next**

Dieses Projekt versucht **nicht**, dir einen perfekten Desktop vorzuschreiben.  
Es gibt dir lediglich eine **saubere Ausgangsbasis**.

🇬🇧  
- **X11 only** (by design)
- **boring is good**
- **no magic**
- **no hidden services**
- **user decides what comes next**

This project does **not** try to define a perfect desktop for you.  
It simply provides a **clean and minimal starting point**.

---

## 🪟 Unterstützte Window Manager / Supported Window Managers

🇩🇪  
Aktuell geplant / unterstützt:

- **xmonad**
- **dwm**
- **qtile**
- **ratpoison**
- **evilwm**

Alle Window Manager laufen **nativ unter X11**.  
Wayland-WMs sind **nicht Teil dieses Projekts**.

🇬🇧  
Currently planned / supported:

- **xmonad**
- **dwm**
- **qtile**
- **ratpoison**
- **evilwm**

All window managers run **natively on X11**.  
Wayland window managers are **explicitly out of scope** for this project.

---

## 🧰 Enthaltene Basis-Tools (Common Toolset)

🇩🇪  
Alle Window Manager teilen **dieselbe minimale Basis**

🇬🇧  
All window managers share the **same minimal base setup**

---

### 🔑 Core
- Xorg (X11)
- LightDM (Display Manager)
- NetworkManager
- PipeWire (Audio)

---

### 🖥️ Terminal & Shell
- **kitty** (Terminal Emulator)
- **fish** (Default Shell)
- **fastfetch** (System information on shell start)

---

### 🚀 Launcher & Utilities
- **dmenu**
- feh (Wallpaper)
- scrot (Screenshots)
- brightnessctl
- pamixer

---

### 🔧 CLI-Tools
- git
- curl
- wget
- unzip
- xrandr / xev
- basic fonts (JetBrains Mono)

🇩🇪  
👉 **Kein Browser, kein Editor, keine IDEs, kein Gaming-Stack.**  
Alles Weitere ist **bewusst User-Entscheidung**.

🇬🇧  
👉 **No browser, no editor, no IDEs, no gaming stack.**  
Everything else is a **deliberate user decision**.

---

## 🚫 Was dieses Projekt bewusst NICHT ist / What this project is NOT

🇩🇪  
- ❌ keine eigene Distribution
- ❌ kein Full-Desktop-Replacement
- ❌ kein Wayland-Projekt
- ❌ kein „Install everything“-Script
- ❌ kein Opinionated Workflow

Wenn du „alles fertig“ willst, ist dieses Projekt **nicht** für dich.  
Wenn du verstehen willst, **was dein System tut**, dann schon.

🇬🇧  
- ❌ not a custom Linux distribution
- ❌ not a full desktop replacement
- ❌ not a Wayland project
- ❌ not an “install everything” script
- ❌ not an opinionated workflow

If you want a fully preconfigured desktop, this project is **not** for you.  
If you want to understand **what your system is doing**, it is.

## ⚠️ Disclaimer

🇩🇪
Dieses Setup ist hardware-spezifisch und primär als persönliche Referenz gedacht.
Es gibt keinen Anspruch auf universelle Einsetzbarkeit.

🇬🇧
This setup is hardware-specific and primarily intended as a personal reference.
There is no guarantee of suitability for other systems.



---
## 🚀 Quick Start (Kurzfassung)

git clone https://github.com/dennishilk/debian-wm-lab.git

cd debian-wm-lab

chmod +x install.sh

./install.sh

---
## 🧱 Repository Structure / Struktur

```text
debian-wm-lab/
├── README.md
├── INSTALL.md
├── CHANGELOG.md
├── LICENSE
│
├── install.sh                 # Main interactive installer (WM + base)
├── install-tools.sh           # Optional user tools (browser, steam, obs…)
│
├── common/
│   ├── packages.sh            # Common apt packages
│   ├── services.sh            # LightDM, NetworkManager, PipeWire
│   ├── x11.sh                 # Xorg, drivers, xinit
│   ├── users.sh               # User, groups, shell
│   ├── shell/
│   │   ├── fish.conf          # fish config (fastfetch etc.)
│   │   └── kitty.conf         # kitty base config (opacity, font)
│   │
│   ├── wallpapers/
│   │   └── 1.png
│   │
│   └── helpers.sh             # ask(), run(), dry-run logic
│
├── wms/
│   ├── xmonad/
│   │   ├── install.sh
│   │   ├── xmonad.hs
│   │   ├── xmobar.conf        # optional / später
│   │   └── README.md
│   │
│   ├── dwm/
│   │   ├── install.sh
│   │   ├── config.h
│   │   ├── patches/           # optional
│   │   └── README.md
│   │
│   ├── qtile/
│   │   ├── install.sh
│   │   ├── config.py
│   │   └── README.md
│   │
│   ├── ratpoison/
│   │   ├── install.sh
│   │   ├── ratpoisonrc
│   │   └── README.md
│   │
│   └── evilwm/
│       ├── install.sh
│       └── README.md
│
└── docs/
    ├── keybindings.md         # XMonad / dwm cheatsheets
    ├── troubleshooting.md
    └── philosophy.md



