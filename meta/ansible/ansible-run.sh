#!/usr/bin/env bash
set -e

if ! command -v ansible >/dev/null 2>&1; then
  sudo apt update -y
  sudo apt install -y software-properties-common
  sudo apt-add-repository --yes --update ppa:ansible/ansible
  sudo apt install -y ansible
  echo "Ansible installed successfully!"
fi

ansible-playbook site.yml --ask-become-pass -v
