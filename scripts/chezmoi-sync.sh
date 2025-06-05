#!/bin/bash
chezmoi diff
chezmoi add -v .
chezmoi git commit -am "Sync from local machine"
chezmoi git push
