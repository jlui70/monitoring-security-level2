#!/bin/bash
# generate-secure-passwords.sh - Gerador de senhas seguras para diferentes ambientes

set -e

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

print_header() {
    echo -e "${BLUE}🔐 ===============================================${NC}"
    echo -e "${BLUE}$1${NC}"
    echo -e "${BLUE}🔐 ===============================================${NC}"
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

# Função para gerar senha segura
generate_password() {
    local environment=$1
    local service=$2
    local length=16
    
    case $environment in
        "dev")
            # Desenvolvimento - senhas mais simples mas seguras
            length=12
            prefix="Dev"
            suffix="2024!@"
            ;;
        "staging")
            # Staging - senhas médias
            length=16
            prefix="Stg"
            suffix="2024#$"
            ;;
        "prod")
            # Produção - senhas complexas
            length=20
            prefix="Prod"
            suffix="2024!@#$"
            ;;
    esac
    
    # Gerar parte aleatória
    random_part=$(openssl rand -base64 $((length-${#prefix}-${#suffix})) | tr -d "=+/" | cut -c1-$((length-${#prefix}-${#suffix})))
    
    # Combinar partes
    password="${prefix}_${service}_${random_part}_${suffix}"
    
    echo "$password"
}

# Função para gerar todas as senhas de um ambiente
generate_environment_passwords() {
    local env=$1
    local output_file=$2
    
    print_header "GERANDO SENHAS PARA AMBIENTE: $env"
    
    # Timestamp
    timestamp=$(date '+%Y%m%d_%H%M%S')
    
    # Gerar senhas
    mysql_password=$(generate_password "$env" "Zabbix")
    mysql_root_password=$(generate_password "$env" "Root") 
    mysql_exporter_password=$(generate_password "$env" "Exporter")
    grafana_admin_password=$(generate_password "$env" "Admin")
    
    # Criar arquivo temporário com senhas
    cat > "$output_file" << EOF
# ===================================
# SENHAS GERADAS AUTOMATICAMENTE
# ===================================
# Ambiente: $env
# Timestamp: $timestamp
# ATENÇÃO: Mantenha este arquivo seguro!

# MySQL Passwords
MYSQL_PASSWORD=$mysql_password
MYSQL_ROOT_PASSWORD=$mysql_root_password
MYSQL_EXPORTER_PASSWORD=$mysql_exporter_password

# Grafana Passwords  
GF_SECURITY_ADMIN_PASSWORD=$grafana_admin_password

# Informações de Segurança
GENERATED_AT=$timestamp
PASSWORD_ROTATION_NEEDED_AT=$(date -d "+90 days" '+%Y%m%d')
ENVIRONMENT=$env
EOF

    print_success "Senhas geradas em: $output_file"
    print_warning "Lembre-se de rotacionar senhas em 90 dias"
    
    echo ""
    echo "📋 Senhas geradas:"
    echo "  MySQL User: $mysql_password"
    echo "  MySQL Root: $mysql_root_password" 
    echo "  MySQL Exporter: $mysql_exporter_password"
    echo "  Grafana Admin: $grafana_admin_password"
}

# Função para rotacionar senhas existentes
rotate_passwords() {
    local env_file=$1
    local backup_dir="./password-backups"
    
    print_header "ROTACIONANDO SENHAS: $env_file"
    
    # Criar diretório de backup
    mkdir -p "$backup_dir"
    
    # Backup do arquivo atual
    backup_file="$backup_dir/$(basename $env_file).backup.$(date '+%Y%m%d_%H%M%S')"
    cp "$env_file" "$backup_file"
    print_success "Backup criado: $backup_file"
    
    # Extrair ambiente atual
    current_env=$(grep "ENVIRONMENT=" "$env_file" | cut -d'=' -f2)
    
    # Gerar novas senhas
    temp_passwords="/tmp/new_passwords_$(date '+%Y%m%d_%H%M%S').env"
    generate_environment_passwords "$current_env" "$temp_passwords"
    
    # Atualizar arquivo original (mantendo outras configurações)
    # Substituir apenas as linhas de senha
    while IFS='=' read -r key value; do
        if [[ $key =~ ^(MYSQL_PASSWORD|MYSQL_ROOT_PASSWORD|MYSQL_EXPORTER_PASSWORD|GF_SECURITY_ADMIN_PASSWORD)$ ]]; then
            sed -i "s/^$key=.*/$key=$value/" "$env_file"
            print_success "Atualizada: $key"
        fi
    done < "$temp_passwords"
    
    # Limpar arquivo temporário
    rm "$temp_passwords"
    
    print_warning "IMPORTANTE: Reinicie os serviços para aplicar novas senhas!"
    print_warning "docker-compose down && docker-compose up -d"
}

# Função para verificar idade das senhas
check_password_age() {
    local env_file=$1
    
    if [ ! -f "$env_file" ]; then
        print_warning "Arquivo não encontrado: $env_file"
        return 1
    fi
    
    if grep -q "GENERATED_AT=" "$env_file"; then
        generated_date=$(grep "GENERATED_AT=" "$env_file" | cut -d'=' -f2)
        rotation_date=$(grep "PASSWORD_ROTATION_NEEDED_AT=" "$env_file" | cut -d'=' -f2)
        current_date=$(date '+%Y%m%d')
        
        if [ "$current_date" -gt "$rotation_date" ]; then
            print_warning "Senhas precisam ser rotacionadas! (geradas em: $generated_date)"
            return 1
        else
            print_success "Senhas ainda válidas (geradas em: $generated_date, rotação em: $rotation_date)"
            return 0
        fi
    else
        print_warning "Arquivo não contém informações de geração automática"
        return 1
    fi
}

# Menu principal
show_menu() {
    echo "🔐 Gerador de Senhas Seguras - Nível 2"
    echo "======================================"
    echo "1. Gerar senhas para Development"
    echo "2. Gerar senhas para Staging"  
    echo "3. Gerar senhas para Production"
    echo "4. Rotacionar senhas existentes"
    echo "5. Verificar idade das senhas"
    echo "6. Sair"
    echo ""
}

# Programa principal
if [ $# -eq 0 ]; then
    while true; do
        show_menu
        read -p "Escolha uma opção: " choice
        
        case $choice in
            1)
                generate_environment_passwords "dev" "./environments/.env.dev.passwords"
                ;;
            2)
                generate_environment_passwords "staging" "./environments/.env.staging.passwords"
                ;;
            3)
                generate_environment_passwords "prod" "./environments/.env.prod.passwords"
                ;;
            4)
                read -p "Arquivo .env para rotacionar: " env_file
                rotate_passwords "$env_file"
                ;;
            5)
                read -p "Arquivo .env para verificar: " env_file
                check_password_age "$env_file"
                ;;
            6)
                echo "Saindo..."
                exit 0
                ;;
            *)
                print_warning "Opção inválida!"
                ;;
        esac
        
        echo ""
        read -p "Pressione ENTER para continuar..."
        clear
    done
else
    # Modo comando direto
    case $1 in
        "generate")
            generate_environment_passwords "$2" "$3"
            ;;
        "rotate")
            rotate_passwords "$2"
            ;;
        "check")
            check_password_age "$2"
            ;;
        *)
            echo "Uso: $0 [generate|rotate|check] [ambiente|arquivo] [arquivo_saida]"
            exit 1
            ;;
    esac
fi