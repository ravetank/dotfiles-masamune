# 🎛️ dotfiles-masamune

**Configuration repository for MASAMUNE — a precision-tuned, high-performance audio production and AI development workstation built by [Jacksonstrut](https://github.com/ravetank).**

This repo contains personal configuration files, shell profiles, registry enhancements, AI tools, bot logic, and modular app settings used to maintain a clean, fast, and resilient hybrid **Windows / WSL2** environment.

> 🎚️ Optimized for music production, LLM work, Twitch streaming, and bimbo-tier automation power.

---

## 📁 Structure

```plaintext
dotfiles-masamune/
├── PowerShell/             # Shell profile, aliases, functions, theme config
│   └── Microsoft.PowerShell_profile.ps1
├── Notepad3/               # Lightweight editor INI and theme config
├── VSCode/                 # Editor settings, extensions, keybindings
├── Scoop/                  # Scoop apps list + app-specific config
│   └── 64gram/
│       ├── shortcuts-default.json
│       ├── shortcuts-custom.json
│       ├── enhanced-settings-default.json
│       └── enhanced-settings-custom.json
├── StreamerBot/            # Webhook event handlers + action logic
├── SpeakerBot/             # Custom Twitch bot settings, personalities, replies
├── Ollama/                 # Modelfiles, persona templates, context configs
├── WindowsTweaks/          # Registry lockdowns, UI polishing, performance boosts
└── setup.ps1               # Optional script to restore core system config
```

---

## 🚀 Quick Start

1. **Clone the repository:**

```bash
git clone https://github.com/ravetank/dotfiles-masamune.git
cd dotfiles-masamune
```

2. *(Optional but divine)* Run the setup script:

```powershell
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
.\setup.ps1
```

This applies:
- PowerShell profiles + functions
- VSCode personalization
- Scoop app restore
- Windows UI + registry tweaks
- App-specific config for tools like **64gram**, **Notepad3**, and **StreamerBot**

---

## 🧠 Modules & Config Highlights

| Area / Tool       | Description                                                                 |
| ----------------- | --------------------------------------------------------------------------- |
| `PowerShell/`     | Customized profile, PSReadLine, Starship, PSFzf, aliases, and reload logic  |
| `Scoop/64gram/`   | Preserved shortcuts + UI preferences for [64gram](https://64gram.org/)      |
| `VSCode/`         | Full editor environment: JSON settings, recommended extensions, themes      |
| `Notepad3/`       | Portable editor with tuned INI, colors, and font settings                   |
| `StreamerBot/`    | Webhook automation + stream trigger logic                                   |
| `SpeakerBot/`     | Twitch chat personalities and bimbo AI reply structures                     |
| `Ollama/`         | Local LLM setup with modelfiles, prompt templates, and chat history tools   |
| `WindowsTweaks/`  | Registry: Defender-safe hardening, UI scaling, dark mode, telemetry nukes   |

---

## 🔒 Privacy Notice

Only **general configuration files** are stored here. App-specific `.json` files (like 64gram) have been **audited to exclude personal data**.

If you're forking or sharing this repo:
- ✅ Safe for sync/backups
- 🚫 Do **not** push tokens, passwords, or identifiable logins

---

## 🧾 License

This repository is licensed under the [MIT License](LICENSE).

> Use it, remix it, funk it up — just don’t sue me if your machine becomes *too* powerful or cute to handle.

---

## 🙌 Credits

Maintained with love, lashes, and latency reduction by [**Jacksonstrut**](https://github.com/ravetank)  
🎧 DJ, producer, system optimizer, and house music priestess.  
💾 From live sets to shell scripts — I keep it tight.
