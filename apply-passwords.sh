#!/bin/bash

# 🔐 Aplicador de Senhas Level 2
# Aplica senhas geradas no arquivo .env
# Uso: ./apply-passwords.sh [dev|staging|prod]

set -e

# Determinar ambiente (padrão: dev)
ENVIRONMENT="${1:-dev}"

# Validar ambiente
case $ENVIRONMENT in
    dev|development)
        ENV_NAME="dev"
        ENV_LABEL="Development"
        ;;
    staging|stg)
        ENV_NAME="staging"
        ENV_LABEL="Staging"
        ;;
    prod|production)
        ENV_NAME="prod"
        ENV_LABEL="Production"
        ;;
    *)
        echo "❌ Ambiente inválido: $ENVIRONMENT"
        echo "Use: ./apply-passwords.sh [dev|staging|prod]"
        exit 1
        ;;
esac

echo "🔐 Aplicando senhas geradas ao arquivo .env..."
echo "📦 Ambiente: $ENV_LABEL"

# Verificar se arquivo de senhas existe
PASSWORD_FILE="environments/.env.${ENV_NAME}.passwords"
if [ ! -f "$PASSWORD_FILE" ]; then
    echo "❌ Arquivo de senhas não encontrado: $PASSWORD_FILE"
    echo "Execute primeiro: echo \"1\" | ./generate-secure-passwords.sh  # para dev"
    echo "              ou: echo \"2\" | ./generate-secure-passwords.sh  # para staging"
    echo "              ou: echo \"3\" | ./generate-secure-passwords.sh  # para prod"
    exit 1
fi

# Copiar base do ambiente
ENV_BASE="environments/.env.${ENV_NAME}"
if [ ! -f "$ENV_BASE" ]; then
    echo "❌ Arquivo base não encontrado: $ENV_BASE"
    exit 1
fi

cp "$ENV_BASE" .env
echo "✅ Arquivo base copiado: $ENV_BASE"

# Extrair senhas do arquivo gerado
MYSQL_PASSWORD=$(grep "MYSQL_PASSWORD=" "$PASSWORD_FILE" | cut -d'=' -f2)
MYSQL_ROOT_PASSWORD=$(grep "MYSQL_ROOT_PASSWORD=" "$PASSWORD_FILE" | cut -d'=' -f2)
MYSQL_EXPORTER_PASSWORD=$(grep "MYSQL_EXPORTER_PASSWORD=" "$PASSWORD_FILE" | cut -d'=' -f2)
GF_SECURITY_ADMIN_PASSWORD=$(grep "GF_SECURITY_ADMIN_PASSWORD=" "$PASSWORD_FILE" | cut -d'=' -f2)

# Aplicar senhas
sed -i "s/MYSQL_PASSWORD=.*/MYSQL_PASSWORD=${MYSQL_PASSWORD}/" .env
sed -i "s/MYSQL_ROOT_PASSWORD=.*/MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD}/" .env
sed -i "s/MYSQL_EXPORTER_PASSWORD=.*/MYSQL_EXPORTER_PASSWORD=${MYSQL_EXPORTER_PASSWORD}/" .env
sed -i "s/GF_SECURITY_ADMIN_PASSWORD=.*/GF_SECURITY_ADMIN_PASSWORD=${GF_SECURITY_ADMIN_PASSWORD}/" .env

echo "✅ Senhas aplicadas com sucesso!"
echo "📋 Senhas aplicadas ($ENV_LABEL):"
echo "   MySQL User: ${MYSQL_PASSWORD}"
echo "   MySQL Root: ${MYSQL_ROOT_PASSWORD}" 
echo "   MySQL Exporter: ${MYSQL_EXPORTER_PASSWORD}"
echo "   Grafana Admin: ${GF_SECURITY_ADMIN_PASSWORD}"

# Copiar para diretório monitoramento
cp .env monitoramento/.env
echo "✅ Arquivo .env copiado para monitoramento/"