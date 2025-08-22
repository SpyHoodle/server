#!/bin/sh

scp -r "/Users/maddie/Documents/Code/server" phobos.mermaid-elevator.ts.net:/home/maddie && ssh phobos.mermaid-elevator.ts.net -t 'cd "server"; rm -rf .git; doas nixos-rebuild switch --flake .'
