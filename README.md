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
- ideal für **Tests, Vergleiche, Lernen und YouTube-Content** ist

🇬🇧  
A reproducible Debian 13 system that:
- installs **only what is necessary**
- provides a **consistent base** for multiple WMs
- is ideal for **testing, comparisons, learning and YouTube content**

---

## 🧠 Philosophie

- **X11 only** (bewusst)
- **boring is good**
- **no magic**
- **no hidden services**
- **user decides what comes next**

Dieses Projekt versucht **nicht**, dir einen perfekten Desktop vorzuschreiben.  
Es gibt dir lediglich eine **saubere Ausgangsbasis**.

---

## 🪟 Unterstützte Window Manager

Aktuell geplant / unterstützt:

- **xmonad**
- **dwm**
- **qtile**
- **ratpoison**
- **evilwm**

Alle Window Manager laufen **nativ unter X11**.  
Wayland-WMs sind **nicht Teil dieses Projekts**.

---

## 🧰 Enthaltene Basis-Tools (Common Toolset)

Alle Window Manager teilen **dieselbe minimale Basis**, aktuell identisch zum  
bewährten XMonad-Setup.

### 🔑 Core
- Xorg (X11)
- LightDM (Display Manager)
- NetworkManager
- PipeWire (Audio)

### 🖥️ Terminal & Shell
- **kitty** (Terminal Emulator)
- **fish** (Default Shell)
- **fastfetch** (System Info on shell start)

### 🚀 Launcher & Utilities
- **dmenu**
- feh (Wallpaper)
- scrot (Screenshots)
- brightnessctl
- pamixer

### 🔧 CLI-Tools
- git
- curl
- wget
- unzip
- xrandr / xev
- basic fonts (JetBrains Mono)

👉 **Kein Browser, kein Editor, keine IDEs, kein Gaming-Stack.**  
Alles Weitere ist **bewusst User-Entscheidung**.

---

## 🚫 Was dieses Projekt bewusst NICHT ist

- ❌ keine eigene Distribution
- ❌ kein Full-Desktop-Replacement
- ❌ kein Wayland-Projekt
- ❌ kein „Install everything“-Script
- ❌ kein Opinionated Workflow

Wenn du „alles fertig“ willst, ist dieses Projekt **nicht** für dich.  
Wenn du verstehen willst, **was dein System tut**, dann schon.

---

## 🚀 Quick Start (Kurzfassung)

```bash
git clone https://github.com/<username>/debian-wm-lab.git
cd debian-wm-lab
chmod +x install.sh
./install.sh
