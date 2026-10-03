#!/usr/bin/env bash
# Republica a politica de privacidade do Rei Cinza no GitHub Pages.
#
# Uso:  ./publicar.sh
#
# Serve para quando o texto da politica mudar (novo e-mail de contato, nova
# versao do app, mudanca no que o app coleta). Ele adiciona tudo que mudou,
# commita com a data e envia para o GitHub — o Pages reconstroi a pagina
# sozinho em cerca de um minuto.
#
# Pre-requisito (uma vez so, nesta maquina): gh auth login + gh auth setup-git.
# Sem isso o push nao encontra credencial e falha aqui, com mensagem clara.

set -euo pipefail

cd "$(dirname "$0")"

DATA="$(date +%Y-%m-%d)"
MSG="Atualiza politica de privacidade ($DATA)"

if ! git diff --quiet || ! git diff --cached --quiet || [ -n "$(git ls-files --others --exclude-standard)" ]; then
    git add -A
    git commit -m "$MSG"
else
    echo "Nada mudou desde o ultimo envio. Nada a publicar."
    exit 0
fi

git push origin main

echo
echo "Enviado. O GitHub Pages reconstroi em cerca de um minuto."
echo "Confira em:"
echo "  https://renatocqueiroz.github.io/rei-cinza/"
echo "  https://renatocqueiroz.github.io/rei-cinza/politica-de-privacidade"
echo "  https://renatocqueiroz.github.io/rei-cinza/privacy-policy"
