🔐 Monitoring Security Evolution - Nível 2: Variáveis de Ambiente

**Variáveis de Ambiente + Segurança Automatizada** - Stack completa de monitoramento com gerenciamento avançado de variáveis de ambiente.

Caso tenha realizado o projeto de Segurança nível (1) execute a limpeza antes de iniciar o nível (2) para evitar conflitos na configuração.

🧹 Limpeza completa do projeto segurança nível 1

Parar e remover todos os containers
cd ~/docker-compose down -v

Limpeza completa (remove diretporio projeto monitoring-security-level1 e limpa Docker)
cd ~/rm -rf monitoring-security-level1 && docker system prune -f

## 🚀 **Quick Start - Configuração Segurança nível (2)**

```bash
# 1. Clone
cd ~
git clone https://github.com/jlui70/monitoring-security-level2.git
cd monitoring-security-level2

# 2. Gerar e aplicar senhas
echo "1" | ./generate-secure-passwords.sh
./apply-passwords.sh

# 3. Deploy
cd monitoramento && ./setup.sh
```

**Pronto!** Aguarde 6 minutos e acesse:
- **Zabbix**: http://localhost:8080 (Admin/zabbix)
- **Grafana**: http://localhost:3000 (admin/sua-senha-gerada)

---

## 🔧 **Setup Manual** (mesmo processo, passo a passo)

```bash
# 1. Gerar senhas para desenvolvimento
echo "1" | ./generate-secure-passwords.sh

# 2. Aplicar senhas ao .env (dev é padrão)
./apply-passwords.sh

# 3. Validar (opcional)
./validate-environment.sh .env

# 4. Deploy
cd monitoramento && ./setup.sh
```

---

## 🌍 **Trabalhando com Múltiplos Ambientes**

O projeto suporta 3 ambientes com configurações e senhas específicas:

### **Desenvolvimento (Dev)**
```bash
echo "1" | ./generate-secure-passwords.sh   # Gerar senhas
./apply-passwords.sh dev                    # Aplicar senhas (ou sem parâmetro)
cd monitoramento && ./setup.sh              # Deploy
```

### **Staging (Homologação)**
```bash
echo "2" | ./generate-secure-passwords.sh   # Gerar senhas
./apply-passwords.sh staging                # Aplicar senhas
cd monitoramento && ./setup.sh              # Deploy
```

### **Production (Produção)**
```bash
echo "3" | ./generate-secure-passwords.sh   # Gerar senhas
./apply-passwords.sh prod                   # Aplicar senhas
cd monitoramento && ./setup.sh              # Deploy
```

**Diferenças entre ambientes:**
- 🔐 **Senhas**: Dev usa senhas com prefixo `Dev_`, Staging `Stg_`, Production `Prod_`
- ⚡ **Performance**: Recursos crescentes (Dev: 3 pollers, Prod: 8 pollers)
- 💾 **Cache**: Dev: 256M, Staging: 1GB, Prod: 2GB
- 📦 **Backup**: Dev: 7 dias, Staging: 14 dias, Prod: 30 dias

---

## 🔄 **Rotação de Senhas (Sistema de 90 dias)**

O sistema rastreia quando as senhas precisam ser rotacionadas:

### **Verificação Automática**
O `setup.sh` verifica automaticamente se passou 90 dias desde a geração das senhas:
- ✅ **Válida**: Mostra quantos dias restam
- ⚠️ **Expirada**: Alerta e pede confirmação para continuar

### **Rotacionar Manualmente**
```bash
# Gerar novas senhas
echo "1" | ./generate-secure-passwords.sh   # ou 2 para staging, 3 para prod

# Aplicar novas senhas
./apply-passwords.sh dev                    # ou staging, prod

# Recriar containers com novas senhas
cd monitoramento
docker-compose down -v
docker-compose up -d
```

### **Verificar Data de Rotação**
```bash
cat environments/.env.dev.passwords | grep PASSWORD_ROTATION
# Saída: PASSWORD_ROTATION_NEEDED_AT=20260205
```

---

---

## 🧹 **Limpeza (se não for primeira instalação)**

**⚠️ IMPORTANTE**: Se você já executou esta stack antes, limpe dados antigos para evitar conflitos:

```bash
# Pare e remova dados antigos
cd monitoramento && docker-compose down -v

# Limpeza completa (opcional - remove projeto e limpa Docker)
cd ~/Projects && rm -rf monitoring-security-level2
docker system prune -f

# Reinstalação limpa
git clone https://github.com/jlui70/monitoring-security-level2.git
cd monitoring-security-level2
echo "1" | ./generate-secure-passwords.sh
./apply-passwords.sh
cd monitoramento && ./setup.sh
```

**💡 Por que limpar?** Volumes Docker persistem dados do MySQL com senhas antigas, causando conflitos de autenticação.

## 📊 **O que você ganha no Level 2?**

### **✅ Recursos Adicionais do Level 2:**
- 🔐 **Senhas Geradas Automaticamente** - Senhas complexas e únicas
- 🌍 **Ambientes Separados** - Dev, Staging, Production
- ✅ **Validação Automática** - Configurações verificadas antes do deploy
- 🔄 **Rotação de Senhas** - Sistema de rotação em 90 dias
- 📋 **Baseline de Segurança** - Padrões aplicados por ambiente

### **✅ Herda Tudo do Level 1:**
- 📊 **Stack Completa**: Zabbix 7.0.5 + Grafana 12.0.2 + Prometheus
- 🖥️ **Monitoramento Sistema**: CPU, RAM, Disk, Network
- 🗄️ **Monitoramento MySQL**: Performance e métricas avançadas
- 📈 **Dashboards Prontos**: 2 dashboards funcionais
- 🎯 **Templates Zabbix**: Auto-configuração de monitoramento

---

## 🛠️ **Comandos Úteis**

```bash
# Ver status dos containers
cd monitoramento && docker-compose ps

# Ver logs
docker-compose logs -f [serviço]

# Parar tudo
docker-compose down

# Gerar senhas para produção
echo "3" | ./generate-secure-passwords.sh
```

---

## 📚 **Documentação Completa**

Para configurações avançadas, múltiplos ambientes e detalhes técnicos:
- 📖 [**Guia Completo de Implementação**](IMPLEMENTATION-STATUS.md)
- 🏗️ [**Visão Geral da Série**](SERIES-OVERVIEW.md)

---

## 🔗 **Série Monitoring Security**

- **[Level 1](https://github.com/jlui70/monitoring-security-level1)** - Baseline monitoring (para iniciantes)
- **[Level 2](https://github.com/jlui70/monitoring-security-level2)** - Environment management ⬅️ **Você está aqui**
- **Level 3** - Secrets & Backup (em breve)
- **Level 4** - AWS Secrets Manager (em breve)
- **Level 5** - Full Security & Compliance (em breve)

---

**💡 Dica**: Se é sua primeira vez com monitoramento, comece pelo [Level 1](https://github.com/jlui70/monitoring-security-level1) que é mais simples.
