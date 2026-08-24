#!/usr/bin/env bash
# Re-encrypt quiz_answers.yaml after editing it. Run this before committing.
#
#   GPG_PASSPHRASE=... ./encrypt.sh
set -euo pipefail
ROOT="$(cd "$(dirname "$0")" && pwd)"
if [[ -z "${GPG_PASSPHRASE:-}" ]]; then
  echo "Set GPG_PASSPHRASE in the environment." >&2
  exit 1
fi
[[ -f "$ROOT/quiz_answers.yaml" ]] || { echo "no plaintext quiz_answers.yaml to encrypt" >&2; exit 1; }
gpg --batch --yes --pinentry-mode loopback --passphrase "$GPG_PASSPHRASE" \
  --symmetric --cipher-algo AES256 -o "$ROOT/quiz_answers.yaml.gpg" "$ROOT/quiz_answers.yaml"
echo "encrypted quiz_answers.yaml -> quiz_answers.yaml.gpg"
