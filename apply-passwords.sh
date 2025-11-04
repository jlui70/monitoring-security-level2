#!/bin/bash

# 🔐 Aplicador de Senhas Level 2
# Aplica senhas geradas no arquivo .env

set -e

echo "🔐 Aplicando senhas geradas ao arquivo .env..."

# Verificar se arquivo de senhas existe
if [ ! -f "environments/.env.dev.passwords" ]; then
    echo "❌ Arquivo de senhas não encontrado!"
    echo "Execute primeiro: echo \"1\" | ./generate-secure-passwords.sh"
    exit 1
fi

# Copiar base de desenvolvimento
cp environments/.env.dev .env

# Extrair senhas do arquivo gerado
MYSQL_PASSWORD=$(grep "MYSQL_PASSWORD=" environments/.env.dev.passwords | cut -d'=' -f2)
MYSQL_ROOT_PASSWORD=$(grep "MYSQL_ROOT_PASSWORD=" environments/.env.dev.passwords | cut -d'=' -f2)
MYSQL_EXPORTER_PASSWORD=$(grep "MYSQL_EXPORTER_PASSWORD=" environments/.env.dev.passwords | cut -d'=' -f2)
GF_SECURITY_ADMIN_PASSWORD=$(grep "GF_SECURITY_ADMIN_PASSWORD=" environments/.env.dev.passwords | cut -d'=' -f2)

# Aplicar senhas
sed -i "s/MYSQL_PASSWORD=.*/MYSQL_PASSWORD=${MYSQL_PASSWORD}/" .env
sed -i "s/MYSQL_ROOT_PASSWORD=.*/MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD}/" .env
sed -i "s/MYSQL_EXPORTER_PASSWORD=.*/MYSQL_EXPORTER_PASSWORD=${MYSQL_EXPORTER_PASSWORD}/" .env
sed -i "s/GF_SECURITY_ADMIN_PASSWORD=.*/GF_SECURITY_ADMIN_PASSWORD=${GF_SECURITY_ADMIN_PASSWORD}/" .env

echo "✅ Senhas aplicadas com sucesso!"
echo "📋 Senhas aplicadas:"
echo "   MySQL User: ${MYSQL_PASSWORD}"
echo "   MySQL Root: ${MYSQL_ROOT_PASSWORD}" 
echo "   MySQL Exporter: ${MYSQL_EXPORTER_PASSWORD}"
echo "   Grafana Admin: ${GF_SECURITY_ADMIN_PASSWORD}"

# Copiar para diretório monitoramento
cp .env monitoramento/.env
echo "✅ Arquivo .env copiado para monitoramento/"