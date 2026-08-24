#!/usr/bin/env bash
# Decrypt quiz_answers.yaml.gpg so the subject can be synced into a CTFd instance.
#
#   GPG_PASSPHRASE=... ./decrypt.sh
#
# The plaintext is gitignored: it must never be committed to a public repo.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")" && pwd)"
if [[ -z "${GPG_PASSPHRASE:-}" ]]; then
  echo "Set GPG_PASSPHRASE in the environment." >&2
  exit 1
fi
gpg --batch --yes --pinentry-mode loopback --passphrase "$GPG_PASSPHRASE" \
  -o "$ROOT/quiz_answers.yaml" --decrypt "$ROOT/quiz_answers.yaml.gpg"
echo "decrypted quiz_answers.yaml.gpg -> quiz_answers.yaml"
