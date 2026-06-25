#!/bin/bash
set -euo pipefail
OWNER="amatide"
REPO="portfolio-editama"
PAGES_URL="https://${OWNER}.github.io/${REPO}/"

echo "🚀 Deploying ${REPO}..."

if command -v gh >/dev/null 2>&1; then
  gh repo edit "${OWNER}/${REPO}" \
    --description "Portofolio profesional Editama Mufti Islahuddin — Health Information Professional & Tech Enthusiast" \
    --homepage "${PAGES_URL}" \
    --add-topic portfolio --add-topic html --add-topic css --add-topic javascript \
    --add-topic health-informatics --add-topic responsive-design --add-topic glassmorphism >/dev/null 2>&1 || true
fi

if command -v curl >/dev/null 2>&1; then
  AUTH="Authorization: token $(gh auth token 2>/dev/null || true)"
  [ -n "$(echo "$AUTH" | grep -o 'ghp_[A-Za-z0-9_]\{20,\}')" ] && \
  curl -sS -X PUT \
    -H "$AUTH" \
    -H "Accept: application/vnd.github+json" \
    "https://api.github.com/repos/${OWNER}/${REPO}/pages" \
    -d '{"source":{"branch":"main","path":"/"}}' >/dev/null 2>&1 || true
fi

cat <<EOF
Repo:       https://github.com/${OWNER}/${REPO}
Pages URL:  ${PAGES_URL}
DNS:        CNAME @ -> ${OWNER}.github.io
EOF
