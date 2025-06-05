#!/bin/bash

set -e
REPO_ROOT="$(pwd)"
CHEZ_DIR=".chezmoi"
SCRIPT_DIR="scripts"
TEMPLATES_DIR="$CHEZ_DIR/templates"
DOTCONFIG_DIR="$CHEZ_DIR/dot_config/powershell"

mkdir -p "$CHEZ_DIR"
mkdir -p "$TEMPLATES_DIR"
mkdir -p "$DOTCONFIG_DIR"
mkdir -p "$SCRIPT_DIR"

# Create .chezmoiignore
cat << 'EOF' > "$CHEZ_DIR/.chezmoiignore"
/.DS_Store
/Thumbs.db
ehthumbs.db
EOF

# Create .chezmoi.yaml.tmpl
cat << 'EOF' > "$CHEZ_DIR/.chezmoi.yaml.tmpl"
# Default ChezMoi config template
data:
  username: '{{ user }}'
  hostname: '{{ hostname }}'
  platform: '{{ os }}'
  distro: '{{ if eq .os "linux" }}{{ (include "lsb_release -is" | trim) | lower }}{{ end }}'
EOF

# Create templated PowerShell profile
cat << 'EOF' > "$DOTCONFIG_DIR/Microsoft.PowerShell_profile.ps1.tmpl"
# Templated PowerShell profile
Write-Host "PowerShell profile loaded for {{ .username }} on {{ .hostname }}"
EOF

# Optional example: basic chezmoi-bootstrap
cat << 'EOF' > "$SCRIPT_DIR/chezmoi-bootstrap.sh"
#!/bin/bash
chezmoi init --apply --verbose "ravetank"
EOF

chmod +x "$SCRIPT_DIR"/*.sh

echo "✅ Dotfiles base layout created under: $REPO_ROOT"

# Create chezmoi-status.sh
cat << 'EOF' > "$SCRIPT_DIR/chezmoi-status.sh"
#!/bin/bash
chezmoi status
EOF

# Create chezmoi-update.sh
cat << 'EOF' > "$SCRIPT_DIR/chezmoi-update.sh"
#!/bin/bash
chezmoi git pull -- --rebase
chezmoi apply --verbose
EOF

# Create chezmoi-sync.sh
cat << 'EOF' > "$SCRIPT_DIR/chezmoi-sync.sh"
#!/bin/bash
chezmoi diff
chezmoi add -v .
chezmoi git commit -am "🔄 Sync from MASAMUNE"
chezmoi git push
EOF

# Create chezmoi-doctor.sh
cat << 'EOF' > "$SCRIPT_DIR/chezmoi-doctor.sh"
#!/bin/bash
chezmoi doctor
EOF

# Make them all executable
chmod +x "$SCRIPT_DIR"/*.sh

echo "🚀 ChezMoi automation scripts added in: $SCRIPT_DIR"
