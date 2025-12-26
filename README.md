# 🧪 debian-wm-lab

A minimal Debian 13 X11 playground to install, test and compare classic tiling window managers.
---

## 🇩🇪 Was ist debian-wm-lab?

debian-wm-lab ist ein minimales, interaktives Setup-Projekt für Debian 13,
das eine saubere X11-Basis bereitstellt, um klassische und minimalistische
Window Manager zu installieren, zu testen und miteinander zu vergleichen.

Der Fokus liegt auf:
- Stabilität
- Reproduzierbarkeit
- minimalem Overhead
- transparenten, nachvollziehbaren Entscheidungen

Dieses Projekt ist kein Desktop Environment, keine Distribution
und kein „Install-alles“-Skript.

---

## 🇬🇧 What is debian-wm-lab?

debian-wm-lab is a minimal, interactive setup project for Debian 13
that provides a clean X11 base to install, test and compare classic
tiling window managers.

The focus is on:
- stability
- reproducibility
- minimal overhead
- transparent, understandable choices

This project is not a desktop environment, not a Linux distribution,
and not an all-in-one installer.

---

## 🎯 Projektziel / Project goal

🇩🇪
Ein reproduzierbares Debian-13-System, das:
- bewusst wenig installiert
- eine einheitliche Basis für verschiedene Window Manager bietet
- ideal für Tests, Vergleiche und Lernzwecke ist

🇬🇧
A reproducible Debian 13 system that:
- installs only what is necessary
- provides a consistent base for multiple window managers
- is ideal for testing, comparison and learning

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

## 🧰 Gemeinsame Basis / Common Base

🇩🇪
Alle Window Manager teilen dieselbe minimale Basis.

🇬🇧
All window managers share the same minimal base setup.

Enthalten sind u. a.:

- Xorg (X11)
- LightDM (optional, user-selected)
- NetworkManager
- PipeWire (Audio)
- feh (Wallpaper)
- picom (Compositor)
- dmenu
- grundlegende Fonts (DejaVu, Liberation)

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

---
## 🧰 install-apps.sh

## 🇩🇪 Beschreibung

Der Userland-Apps-Installer installiert typische Anwendungen,
die viele Nutzer brauchen oder glauben zu brauchen,
ohne das Basissystem, Window Manager oder Kernel-Einstellungen zu verändern.

Kategorien & enthaltene Software:

- 🌍 Browsers
Firefox ESR, Chromium
- 🎮 Gaming
Steam (inkl. i386-Multiarch), MangoHud, Gamescope
- 🎬 Media / Content Creation
VLC, OBS Studio, Audacity, GIMP
- 🧰 Tools & Utilities
fastfetch, htop, pavucontrol, …

Optional:
- 🔐 Google Chrome
Explizite Installation über externes Repository

## 🇬🇧 Description

The Userland Applications Installer installs common applications
that many users need or expect to need,
without touching the base system, window manager, or kernel settings.

Categories & included software:
- 🌍 Browsers
Firefox ESR, Chromium
- 🎮 Gaming
Steam (including i386 multi-architecture support), MangoHud, Gamescope
- 🎬 Media / Content Creation
VLC, OBS Studio, Audacity, GIMP
- 🧰 Tools & Utilities
fastfetch, htop, pavucontrol, …

Optional:
- 🔐 Google Chrome
Explicit installation via external repository
---

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
├── install.sh            # Base + WM + optional extras
├── install-apps.sh       # Userland applications
│
├── common/
│   ├── packages.txt      # Common base packages
│   └── assets/
│       └── wallpapers/
│           └── lab-default.png
│
├── wm/
│   ├── xmonad/packages.txt
│   ├── dwm/packages.txt
│   ├── qtile/packages.txt
│   ├── ratpoison/packages.txt
│   └── evilwm/packages.txt
│
├── extras/
│   ├── fonts/packages.txt
│   ├── terminals/packages.txt
│   └── editors/packages.txt
│
└── apps/
    ├── browsers/packages.txt
    ├── gaming/packages.txt
    ├── media/packages.txt
    └── tools/packages.txt



