#!/bin/bash

# === CONFIGURE AQUI ===
GITHUB_USER="SEU_USUARIO"
REPO_NAME="fortiswitch-guia"
GITHUB_TOKEN="SEU_TOKEN_AQUI"

# === CRIAÇÃO DO REPOSITÓRIO NO GITHUB ===
echo "Criando repositório $REPO_NAME no GitHub..."
curl -H "Authorization: token $GITHUB_TOKEN" https://api.github.com/user/repos \
  -d "{\"name\":\"$REPO_NAME\",\"private\":false,\"auto_init\":false}"

# === CLONAR O REPO E ADICIONAR OS ARQUIVOS ===
echo "Clonando repositório..."
git clone https://github.com/$GITHUB_USER/$REPO_NAME.git
cd $REPO_NAME

echo "Copiando arquivos do projeto..."
# Atualize o caminho abaixo se necessário
cp -r ../FortiSwitch_GitHubPages/* .

git add .
git commit -m "Commit inicial do Guia Interativo FortiSwitch"
git branch -M main
git remote set-url origin https://$GITHUB_TOKEN@github.com/$GITHUB_USER/$REPO_NAME.git
git push -u origin main

# === ATIVAR GITHUB PAGES ===
echo "Ativando GitHub Pages na branch main..."
curl -X POST -H "Authorization: token $GITHUB_TOKEN" \
     -H "Accept: application/vnd.github+json" \
     https://api.github.com/repos/$GITHUB_USER/$REPO_NAME/pages \
     -d '{"source":{"branch":"main","path":"/"}}'

# === LINK FINAL ===
echo "✅ Publicado com sucesso:"
echo "https://$GITHUB_USER.github.io/$REPO_NAME"
