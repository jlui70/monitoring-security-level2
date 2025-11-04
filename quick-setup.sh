#!/bin/bash

# 🚀 Level 2 - Setup Inteligente
# Automatiza geração de senhas + validação + deploy

set -e

echo "🔐 Monitoring Security Level 2 - Setup Inteligente"
echo "=================================================="

# Cores para output  
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Verificar se estamos no diretório correto
if [ ! -f "generate-secure-passwords.sh" ]; then
    log_error "Execute este script no diretório raiz do projeto (onde está o generate-secure-passwords.sh)"
    exit 1
fi

log_info "🔐 Passo 1: Gerando senhas seguras para Development..."
echo "1" | ./generate-secure-passwords.sh

log_info "📋 Passo 2: Aplicando configurações..."
# Copiar arquivo de desenvolvimento como base
cp environments/.env.dev .env

# Aplicar senhas geradas ao arquivo .env
if [ -f "environments/.env.dev.passwords" ]; then
    # Extrair senhas do arquivo gerado
    MYSQL_PASSWORD=$(grep "MYSQL_PASSWORD=" environments/.env.dev.passwords | cut -d'=' -f2)
    MYSQL_ROOT_PASSWORD=$(grep "MYSQL_ROOT_PASSWORD=" environments/.env.dev.passwords | cut -d'=' -f2)
    MYSQL_EXPORTER_PASSWORD=$(grep "MYSQL_EXPORTER_PASSWORD=" environments/.env.dev.passwords | cut -d'=' -f2)
    GF_SECURITY_ADMIN_PASSWORD=$(grep "GF_SECURITY_ADMIN_PASSWORD=" environments/.env.dev.passwords | cut -d'=' -f2)
    
    # Aplicar no arquivo .env
    sed -i "s/MYSQL_PASSWORD=.*/MYSQL_PASSWORD=${MYSQL_PASSWORD}/" .env
    sed -i "s/MYSQL_ROOT_PASSWORD=.*/MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD}/" .env
    sed -i "s/MYSQL_EXPORTER_PASSWORD=.*/MYSQL_EXPORTER_PASSWORD=${MYSQL_EXPORTER_PASSWORD}/" .env
    sed -i "s/GF_SECURITY_ADMIN_PASSWORD=.*/GF_SECURITY_ADMIN_PASSWORD=${GF_SECURITY_ADMIN_PASSWORD}/" .env
    
    log_success "Senhas aplicadas automaticamente!"
else
    log_warning "Arquivo de senhas não encontrado, usando senhas padrão"
fi

log_info "✅ Passo 3: Validando configuração..."
./validate-environment.sh .env

log_info "🚀 Passo 4: Iniciando deploy da stack..."
# Copiar .env para o diretório monitoramento
cp .env monitoramento/.env

# Executar setup
cd monitoramento
./setup.sh

log_success "🎉 Setup Level 2 concluído!"
echo ""
echo "📊 Acesse os serviços:"
echo "   Zabbix:    http://localhost:8080 (Admin/zabbix)"
echo "   Grafana:   http://localhost:3000 (admin/${GF_SECURITY_ADMIN_PASSWORD:-admin})"
echo "   Prometheus: http://localhost:9090"
echo ""
log_info "💡 Suas senhas estão em: environments/.env.dev.passwords"