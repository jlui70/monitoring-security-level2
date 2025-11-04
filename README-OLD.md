# 📊 Monitoring Security Stack - Level 2: Environment Variables# 📊 Monitoring Stack - Zabbix + Grafana + Prometheus



**Nível 2 de Segurança** - Gerenciamento avançado de variáveis de ambiente com separação por ambientes e validações de segurança.Uma stack completa de monitoramento com evolução progressiva de segurança, implementada com Docker Compose.



## 🎯 **O que é o Nível 2?**## 🚀 **Stack Atual (Nível 1)**



O **Nível 2** implementa:### **Serviços Implementados:**

- ✅ **Separação por Ambiente** (Development, Staging, Production)- **MySQL 8.3** - Database backend

- ✅ **Geração Automática de Senhas Seguras** - **Zabbix Server 7.0.5** - Monitoring engine  

- ✅ **Validação de Configurações** antes do deploy- **Zabbix Web** - Web interface

- ✅ **Rotação de Senhas** automatizada- **Zabbix Agent2** - Local agent

- ✅ **Baseline de Segurança** por ambiente- **Grafana 12.0.2** - Visualization platform

- **Prometheus** - Time-series metrics

## 🚀 **Quick Start**- **Node Exporter** - System metrics



### **Opção A: Setup Automatizado (Recomendado)**### **Dashboards Funcionais:**

- ✅ **Node Exporter Full** (Prometheus) - Sistema completo

```bash- ✅ **Custom Zabbix Dashboards** - 115 métricas coletadas

# 1. Clone do repositório- ✅ **Prometheus Self-monitoring** - Métricas internas

git clone <seu-repo> monitoring-security-level2

cd monitoring-security-level2## 📋 **Quick Start**



# 2. Validar ambiente de desenvolvimento```bash

./validate-environment.sh environments/.env.dev# 1. Clone o projeto

git clone https://github.com/josezipf/containers.git

# 3. Executar setup automáticocd containers/monitoramento

./monitoramento/setup.sh

# 2. Suba a stack

# 4. Acessar serviçosdocker-compose up -d

WSL_IP=$(hostname -I | awk '{print $1}')

echo "Zabbix: http://$WSL_IP:8080 (Admin/Dev_Admin_2024!@)"# 3. Descubra seu IP WSL2

echo "Grafana: http://$WSL_IP:3000 (admin/DevAdmin_2024!@)"WSL_IP=$(hostname -I | awk '{print $1}')

```echo "Seu IP WSL2: $WSL_IP"



### **Opção B: Geração de Senhas + Deploy Manual**# 4. Acesse os serviços

echo "Zabbix: http://$WSL_IP:8080 (Admin/zabbix)"

```bashecho "Grafana: http://$WSL_IP:3000 (admin/admin)"

# 1. Gerar novas senhas para ambienteecho "Prometheus: http://$WSL_IP:9090"

./generate-secure-passwords.sh```



# 2. Validar configuração## 🔧 **Configuração WSL2**

./validate-environment.sh .env

Este projeto foi configurado especificamente para **Windows WSL2**:

# 3. Deploy manual

cd monitoramento- **IP de Acesso:** `172.28.224.90` (acessível do Windows)

docker-compose --env-file ../.env up -d- **Network Mode:** Port mapping explícito (não host mode)

```- **Volumes:** Persistência em Docker volumes



## 🔐 **Gerenciamento de Senhas**## 📁 **Estrutura do Projeto**



### **Geração Automática de Senhas**```

containers/

```bash├── README.md                    # Este arquivo

# Gerar senhas para desenvolvimento├── install_monitoring.sh        # Script de instalação

./generate-secure-passwords.sh└── monitoramento/

    ├── docker-compose.yml       # Orquestração principal

# Escolha no menu:    ├── .env                     # Variáveis (Nível 1)

# 1. Development   - Dev_Service_RandomString_2024!@    ├── EXEMPLOS-PRATICOS.md     # Roadmap de evolução de segurança

# 2. Staging       - Stg_Service_RandomString_2024#$      ├── grafana/

# 3. Production    - Prod_Service_RandomString_2024!@#$    │   └── provisioning/        # Auto-config datasources/dashboards

```    └── prometheus/

        └── prometheus.yml       # Configuração de coleta

### **Rotação de Senhas**```



```bash## 🔒 **Evolução de Segurança (5 Níveis)**

# Rotacionar senhas existentes (mantém backup)

./generate-secure-passwords.shEste projeto foi projetado para demonstrar a evolução progressiva de segurança:

# Opção 4: Rotacionar senhas existentes

```### **Nível 1: Base Funcional** ⭐ **(ATUAL)**

- Credenciais em `.env` (desenvolvimento apenas)

### **Verificação de Idade das Senhas**- Stack funcional com todos os componentes



```bash### **Nível 2: Environment Variables Isoladas** 

# Verificar se senhas precisam ser rotacionadas- Separação por ambiente (dev/prod)

./generate-secure-passwords.sh- Validação de variáveis obrigatórias

# Opção 5: Verificar idade das senhas

```### **Nível 3: Docker Secrets**

- Docker Swarm mode

## ✅ **Validação de Ambiente**- Secrets em arquivos separados



### **Validação Completa**### **Nível 4: HashiCorp Vault**

- Centralização de secrets

```bash- Rotação automática

# Validar ambiente específico

./validate-environment.sh environments/.env.dev### **Nível 5: Production Enterprise**

./validate-environment.sh environments/.env.staging  - mTLS, RBAC granular

./validate-environment.sh environments/.env.prod- Monitoring de segurança



# Validar arquivo .env atual## 📊 **Monitoramento Implementado**

./validate-environment.sh .env

```### **Métricas Coletadas:**

- **Zabbix:** 115 itens (CPU, Memória, Disco, Rede, ICMP)

### **Verificações Implementadas:**- **Prometheus:** Node Exporter completo + self-monitoring

- **Grafana:** 3 dashboards funcionais

- ✅ **Variáveis Obrigatórias:** MySQL, Zabbix, Grafana

- ✅ **Força das Senhas:** Mínimo 12 caracteres, complexidade### **Integrações:**

- ✅ **Configurações por Ambiente:** Validações específicas dev/staging/prod- ✅ Zabbix Plugin para Grafana

- ✅ **Segurança:** Debug logs, SSL verification- ✅ Auto-provisioning de datasources

- ✅ Dashboards importados automaticamente

## 🏗️ **Ambientes Pré-configurados**

## 🛠️ **Comandos Úteis**

### **Development** (`environments/.env.dev`)

```bash```bash

ENVIRONMENT=development# Status dos serviços

MYSQL_PASSWORD=Dev_Zabbix_2024!@docker-compose ps

ENABLE_DEBUG_LOGS=true

DISABLE_SSL_VERIFICATION=true# Logs específicos

```docker-compose logs -f [serviço]



### **Staging** (`environments/.env.staging`)# Restart individual

```bashdocker-compose restart [serviço]

ENVIRONMENT=staging  

MYSQL_PASSWORD=Stg_Zabbix_2024#$# Parar tudo

ENABLE_DEBUG_LOGS=falsedocker-compose down

DISABLE_SSL_VERIFICATION=false

```# Reset completo (CUIDADO - perde dados)

docker-compose down -v

### **Production** (`environments/.env.prod`)```

```bash

ENVIRONMENT=production## ✅ **Status de Validação**

MYSQL_PASSWORD=Prod_Zabbix_2024!@#$

ENABLE_DEBUG_LOGS=false- ✅ Todos os serviços acessíveis via WSL2 IP

DISABLE_SSL_VERIFICATION=false- ✅ Zabbix coletando 115 métricas do sistema

```- ✅ Grafana exibindo dashboards Node Exporter e Zabbix

- ✅ Prometheus coletando targets com sucesso

## 📁 **Estrutura do Projeto**- ✅ Datasources auto-provisionados funcionais

- ✅ Baseline estabelecida para evolução de segurança

```

monitoring-security-level2/## 📖 **Documentação Completa**

├── README.md                           # Este arquivo

├── .env                               # Configuração ativa (development)Para detalhes sobre a evolução de segurança e implementação dos próximos níveis, consulte:

├── environments/                      # Ambientes pré-configurados- **[EXEMPLOS-PRATICOS.md](monitoramento/EXEMPLOS-PRATICOS.md)** - Roadmap completo dos 5 níveis

│   ├── .env.dev                      # Development settings

│   ├── .env.staging                  # Staging settings  ---

│   └── .env.prod                     # Production settings

├── generate-secure-passwords.sh       # 🔐 Gerador de senhas## 🎯 **Próximos Passos**

├── validate-environment.sh            # ✅ Validador de ambiente

├── password-backups/                  # 📦 Backups automáticos (criado dinamicamente)Este projeto está no **Nível 1** e pronto para implementar o **Nível 2** (Environment Variables Isoladas). A stack está funcional e validada, servindo como baseline para demonstrar a evolução progressiva de segurança em ambientes de monitoramento.

└── monitoramento/

    ├── docker-compose.yml            # Stack com variáveis de ambiente---

    ├── setup.sh                      # 🚀 Setup automatizado*Stack validada em WSL2 Ubuntu - Pronta para evolução de segurança*

    ├── configure-zabbix.sh           # Configuração Zabbix
    └── import-dashboards.sh          # Import Grafana dashboards
```

## 🔧 **Funcionalidades Avançadas**

### **1. Separação por Ambiente**
- Containers nomeados com prefixo do ambiente: `dev-mysql-server`, `prod-zabbix-server`
- Volumes isolados por ambiente: `dev-mysql-data`, `prod-grafana-data`
- Networks dedicadas: `dev-monitoring`, `prod-monitoring`

### **2. Backup Automático de Senhas**
```bash
password-backups/
├── .env.backup.20241104_143000
├── .env.backup.20241104_150000
└── .env.dev.backup.20241104_153000
```

### **3. Monitoramento de Rotação**
- Senhas marcadas com timestamp de geração
- Alerta automático quando rotação é necessária (90 dias)
- Histórico de rotações mantido

## 🎛️ **Variáveis de Ambiente - Nível 2**

### **Core Configuration**
```bash
ENVIRONMENT=development                 # dev/staging/production
DEPLOY_TIMESTAMP=$(date '+%Y%m%d_%H%M%S')
```

### **MySQL Security**
```bash
MYSQL_PASSWORD=Dev_Zabbix_2024!@       # Senha principal
MYSQL_ROOT_PASSWORD=DevRoot_Secure_2024!@
MYSQL_EXPORTER_PASSWORD=DevExporter_2024!@
```

### **Zabbix Performance (por ambiente)**
```bash
# Development (valores menores)
ZBX_STARTPOLLERS=3
ZBX_CACHESIZE=256M

# Production (valores otimizados)  
ZBX_STARTPOLLERS=10
ZBX_CACHESIZE=1G
```

### **Security Controls**
```bash
ENABLE_DEBUG_LOGS=true/false           # Por ambiente
DISABLE_SSL_VERIFICATION=true/false    # Prod=false sempre
ALLOW_WEAK_PASSWORDS=false             # Sempre false
BACKUP_RETENTION_DAYS=7/30/90          # Por ambiente
```

## 🔒 **Diferenças de Segurança por Nível**

| Característica | Nível 1 | **Nível 2** |
|----------------|---------|-------------|
| **Gestão de Senhas** | `.env` fixo | Geração automática |
| **Ambientes** | Um único | dev/staging/prod |
| **Validação** | Manual | Script automatizado |
| **Rotação** | Manual | Automática com backup |
| **Complexidade** | Simples | Senhas complexas |
| **Auditoria** | Nenhuma | Timestamps + rotação |

## 📊 **Stack de Monitoramento**

### **Serviços (mesmo do Nível 1):**
- **MySQL 8.3** - Database com usuários específicos
- **Zabbix Server 7.0.5** - Engine de monitoramento
- **Zabbix Web** - Interface web
- **Grafana 12.0.2** - Dashboards e visualização
- **Prometheus** - Coleta de métricas
- **Node Exporter** - Métricas do sistema

### **Dashboards Funcionais:**
- ✅ **Node Exporter Prometheus** - Sistema completo
- ✅ **Zabbix Server Overview** - Metricas do Zabbix

## 🛠️ **Comandos Úteis - Nível 2**

### **Gestão de Ambiente**
```bash
# Trocar para staging
cp environments/.env.staging .env
./validate-environment.sh .env
cd monitoramento && docker-compose down && docker-compose up -d

# Trocar para produção
cp environments/.env.prod .env
./validate-environment.sh .env

# Verificar ambiente atual
grep "ENVIRONMENT=" .env
```

### **Gestão de Senhas**
```bash
# Verificar idade das senhas
./generate-secure-passwords.sh check .env

# Rotação de emergência
./generate-secure-passwords.sh rotate .env

# Backup manual
cp .env "password-backups/.env.backup.$(date '+%Y%m%d_%H%M%S')"
```

### **Debugging**
```bash
# Logs com ambiente
docker-compose logs -f --tail=50

# Verificar variáveis carregadas
docker-compose config

# Status por ambiente
docker-compose ps --format table
```

## 🚦 **Status de Validação - Nível 2**

- ✅ Separação completa por ambiente (dev/staging/prod)
- ✅ Geração automática de senhas seguras
- ✅ Validação de configurações antes do deploy
- ✅ Rotação automática com backup de senhas
- ✅ Controles de segurança por ambiente
- ✅ Baseline para evolução ao Nível 3 (Docker Secrets)

## 🎯 **Próximos Passos: Nível 3**

O **Nível 3** implementará:
- 🔜 **Docker Secrets** em Swarm mode
- 🔜 **Secrets em arquivos** separados do compose
- 🔜 **Rotação sem rebuild** de containers
- 🔜 **Auditoria avançada** de acessos

---

## 📝 **Changelog Nível 2**

### **Adicionado:**
- ✅ Script `generate-secure-passwords.sh` - Geração automática
- ✅ Script `validate-environment.sh` - Validação pré-deploy
- ✅ Diretório `environments/` - Configurações por ambiente
- ✅ Docker-compose com variáveis de ambiente dinâmicas
- ✅ Backup automático de senhas
- ✅ Controles de segurança por ambiente

### **Melhorado:**
- ✅ Senhas com complexidade baseada no ambiente
- ✅ Nomeação de containers com prefixo do ambiente
- ✅ Volumes e networks isolados por ambiente
- ✅ Validação de força de senhas

---
*Nível 2 - Environment Variables Isoladas | Baseline estabelecida para Nível 3*