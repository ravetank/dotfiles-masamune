# aerial_AppInfo.md

## 🪟 Aerial

- **Description**: Claim and pin visual spaces on your desktop like virtual zones.
- **Repo**: [okibcn/Aerial](https://github.com/okibcn/Aerial)
- **Installed via Scoop**: `okibcn_ScoopMaster/aerial`
- **Version**: 1.0.5.0

### 🛠️ Features
- Lets you "claim" parts of your screen to show overlays or auto-align windows.
- Inspired by tools like FancyZones, but standalone and ultra-lightweight.
- Ideal for workflows with multiple monitors or floating widgets.

### 💡 Use Cases
- DJ overlays or setlists in a fixed zone.
- OBS camera frames that stay put.
- Virtual sticky notes or lyrics boards.

### 🧠 Tips
- Launch with `aerial.exe`, or create a shortcut with a preset config.
- Combine with `AutoHotkey` or `FancyWM` for window layouts.

### 🧹 Cleanup / Persist Suggestion
Doesn’t auto-create a `persist\aerial` folder by default. No user settings file observed. You can safely create this folder to store your own config, .AppInfo.md, and usage notes.

---

#### **3. Back That Folder Up in GitHub**
Inside your `dotfiles-masamune`, add this under a new subfolder:

---

████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████


Aerial is a lightweight Windows utility developed by Chris Andriessen that allows you to reserve specific areas on your desktop. This means that when you maximize windows, they won't cover these reserved spaces. It's particularly useful if you have docks, widgets, or other tools that you want to keep visible at all times. 

Key Features:

Desktop Space Reservation: Define margins on any side of your screen (top, bottom, left, right) to prevent windows from overlapping certain areas.

Portable Application: No installation required; Aerial runs directly from its executable.

Minimal Interface: Operates from the system tray with a simple UI for setting margins.

Startup Option: Can be configured to run at system startup.

Use Cases:

Persistent Widgets: Keep system monitors, clocks, or other widgets visible.

Docking Areas: Reserve space for application docks or launchers.

Custom Layouts: Maintain specific desktop layouts without interference from maximized windows.


Considerations:

Manual Reset: Closing Aerial doesn't automatically remove the reserved spaces; you'll need to reset margins manually.

Limited Updates: The application hasn't seen recent updates, so compatibility with newer Windows versions might vary.

Niche Utility: If you don't use desktop widgets or docks, you might not find Aerial particularly beneficial.

Recommendation:

If you utilize desktop widgets or docks and want to ensure they remain unobstructed, Aerial can be a valuable tool. However, if you haven't used it and don't have a specific need for reserving desktop space, it might be unnecessary to keep it installed. Given its small size and portability, you can easily test it to see if it fits your workflow.