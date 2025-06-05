#!/bin/bash
chezmoi diff
chezmoi add -v .
chezmoi git commit -am "🔄 Sync from MASAMUNE"
chezmoi git push
