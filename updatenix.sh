#! /usr/bin/bash

sudo nixos-rebuild switch --flake '.#desktop'
home-manager switch --flake '.#augustosang@desktop'
