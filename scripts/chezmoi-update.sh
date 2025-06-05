#!/bin/bash
chezmoi git pull -- --rebase
chezmoi apply --verbose
