#!/bin/bash

# Define base repo path
REPO_ROOT="$(pwd)"
CHEZMOI_DIR="$REPO_ROOT/.chezmoi"
SCRIPTS_DIR="$REPO_ROOT/scripts"

# Create folder structure
mkdir -p "$CHEZMOI_DIR/templates"
mkdir -p "$CHEZMOI_DIR/dot_config"
mkdir -p "$SCRIPTS_DIR"

# Write README
cat <<'EOF' > "$CHEZMOI_DIR/README.md"
# Dotfiles Managed by Chezmoi

This directory contains templated dotfiles managed via [chezmoi](https://www.chezmoi.io/).
All configs are tracked and rendered into $HOME using `chezmoi apply`.

- Place configs here (e.g. dot_config, dot_bashrc)
- Templates go under `.chezmoi/templates`
- Ignore untracked files using `.chezmoiignore`
EOF

# Create chezmoi helper scripts
cat <<'EOF' > "$SCRIPTS_DIR/chezmoi-bootstrap.sh"
#!/bin/bash
chezmoi init --apply --verbose "ravetank"
EOF

cat <<'EOF' > "$SCRIPTS_DIR/chezmoi-update.sh"
#!/bin/bash
chezmoi git pull -- --rebase
chezmoi apply --verbose
EOF

cat <<'EOF' > "$SCRIPTS_DIR/chezmoi-status.sh"
#!/bin/bash
chezmoi status
EOF

cat <<'EOF' > "$SCRIPTS_DIR/chezmoi-sync.sh"
#!/bin/bash
chezmoi diff
chezmoi add -v .
chezmoi git commit -am "Sync from local machine"
chezmoi git push
EOF

cat <<'EOF' > "$SCRIPTS_DIR/chezmoi-doctor.sh"
#!/bin/bash
chezmoi doctor
EOF

# Make all scripts executable
chmod +x "$SCRIPTS_DIR"/*.sh

echo "✅ ChezMoi dotfiles layout created successfully at $REPO_ROOT"
echo "Run ./scripts/chezmoi-bootstrap.sh to begin syncing."
