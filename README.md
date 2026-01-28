# 🔐 Monitoring Security Evolution - Nível 2: Gerenciamento de Ambientes
## Stack de Monitoramento com Zabbix, Grafana e Prometheus

![Security Level](https://img.shields.io/badge/Security%20Level-2%20Environment%20Variables-orange)
![Docker](https://img.shields.io/badge/Docker-Compose-blue)
![Environments](https://img.shields.io/badge/Environments-Dev%20%7C%20Staging%20%7C%20Prod-purple)
![Status](https://img.shields.io/badge/Status-Production%20Ready-green)

---

## 📋 **Sobre o Projeto**

Este projeto apresenta o **Nível 2** de uma jornada completa de segurança em ambientes containerizados, evoluindo do gerenciamento básico de credenciais hardcoded para um sistema profissional com **variáveis de ambiente, múltiplos ambientes e rotação automática de senhas**.

Para demonstrar a evolução de segurança em secrets management, implementei:

🔐 **Senhas Geradas Automaticamente** com gerador de senhas complexas e únicas
🌍 **Gerenciamento de Múltiplos Ambientes** (Development, Staging, Production)
✅ **Validação Automática** de configurações antes do deploy
🔄 **Sistema de Rotação de Senhas** com alerta de 90 dias
📊 **Stack de Monitoramento Completa** - Zabbix 7.0.5, Grafana 12.0.2, Prometheus
🐳 **Docker Compose** com variáveis de ambiente segregadas por ambiente

🎯 **Objetivo**: Demonstrar na prática como evoluir de credenciais hardcoded (Level 1) para um sistema robusto de environment variables, estabelecendo a base para implementações mais avançadas com Vault (Level 3), AWS Secrets Manager (Level 4) e Kubernetes (Level 5).

✅ **Resultado**: Um ambiente de monitoramento production-ready com separação adequada de credenciais por ambiente, validação automatizada e sistema de rotação de senhas, pronto para servir como baseline para evoluções enterprise-grade.

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

## 🚀 **Evolução da Série (5 Níveis COMPLETOS)**

<table>
<thead>
<tr>
<th style="min-width: 100px;">Nível</th>
<th>Foco</th>
<th>Secrets Storage</th>
<th>Onde Containers Leem</th>
<th>Orquestração</th>
<th>Status</th>
</tr>
</thead>
<tbody>
<tr>
<td><strong><a href="https://github.com/jlui70/monitoring-security-level1">Level&nbsp;1</a></strong></td>
<td>Baseline</td>
<td>Hardcoded</td>
<td>Código fonte</td>
<td>Docker Compose</td>
<td>✅</td>
</tr>
<tr>
<td><strong><a href="https://github.com/jlui70/monitoring-security-level2">Level&nbsp;2</a></strong></td>
<td>Env Vars</td>
<td><code>.env</code> files</td>
<td><code>.env</code></td>
<td>Docker Compose</td>
<td><strong>✅ VOCÊ ESTÁ AQUI</strong></td>
</tr>
<tr>
<td><strong><a href="https://github.com/jlui70/monitoring-security-level3">Level&nbsp;3</a></strong></td>
<td>Vault Foundation</td>
<td>Vault + <code>.env</code></td>
<td><code>.env</code></td>
<td>Docker Compose</td>
<td>✅</td>
</tr>
<tr>
<td><strong><a href="https://github.com/jlui70/monitoring-security-level4-aws-v2">Level&nbsp;4</a></strong></td>
<td>AWS Cloud</td>
<td>AWS Secrets Manager</td>
<td>AWS API</td>
<td>Terraform + EC2</td>
<td>✅</td>
</tr>
<tr>
<td><strong><a href="https://github.com/jlui70/monitoring-security-level5">Level&nbsp;5</a></strong></td>
<td><strong>K8s + Vault</strong></td>
<td><strong>Vault (KV v2)</strong></td>
<td><strong>Kubernetes Secrets</strong></td>
<td><strong>Kubernetes</strong></td>
<td>✅</td>
</tr>
</tbody>
</table>

---

## 🧹 **Limpeza Completa (se já usou antes)**

Se você já executou este projeto Level 2, limpe tudo antes:

```bash
cd ~/monitoring-security-level2/monitoramento
docker-compose down -v
cd ~/
rm -rf monitoring-security-level2
docker system prune -f

# Agora faça instalação limpa (seguir Quick Start abaixo)
```
Limpeza Level 1 (Somente se realizou Lab Level 1 e ainda não efetuo a limpeza)

```bash
cd ~/ && rm -rf monitoring-security-level1 docker system prune -f

**💡 Por que limpar?** Volumes Docker antigos guardam senhas e podem causar conflitos.
```

---

## 🚀 **Quick Start - Primeira Instalação**

**⚠️ IMPORTANTE**: Na primeira vez, você PRECISA gerar senhas antes do deploy!

```bash
# 1. Clone do repositório
cd ~
git clone https://github.com/jlui70/monitoring-security-level2.git
cd monitoring-security-level2

# 2. Gerar senhas (OBRIGATÓRIO na primeira vez!)
echo "1" | ./generate-secure-passwords.sh

# 3. Deploy
cd monitoramento && ./setup.sh
```

**Pronto!** Aguarde 6 minutos e acesse:
- **Zabbix**: http://localhost:8080 (Admin/zabbix)
- **Grafana**: http://localhost:3000 (admin/senha-gerada)

💡 **A senha do Grafana será exibida no final do setup!**
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

## ⚠️ **Troubleshooting - Erros Comuns**

### **Erro: "Senhas não geradas para ambiente"**
```
[ERROR] Senhas não geradas para ambiente dev
Execute primeiro:
  echo "1" | ../generate-secure-passwords.sh
```

**Solução:** Você esqueceu de gerar senhas! Execute:
```bash
cd ~/monitoring-security-level2
echo "1" | ./generate-secure-passwords.sh    # Development
cd monitoramento && ./setup.sh
```

### **Erro: "Grafana não aceita a senha gerada"**
```
Login failed: invalid password
```

**Solução:** Volumes antigos com senhas antigas. Limpe tudo:
```bash
cd monitoramento
docker-compose down -v
./setup.sh
```

### **Erro: "Port 3000 already in use"**
```
Error: bind: address already in use
```

**Solução:** Algum serviço está usando a porta. Pare containers antigos:
```bash
docker ps -a
docker stop $(docker ps -aq)
docker-compose up -d
```

### **Como saber qual senha usar no Grafana?**
A senha é exibida no final do `setup.sh`:
```
📊 Grafana:
   URL: http://localhost:3000
   User: admin
   Password: Dev_Admin_XYZ_2024!@    ← Use esta senha
```

Ou consulte o arquivo:
```bash
cat environments/.env.dev.passwords | grep GF_SECURITY_ADMIN_PASSWORD
```

---

## 📚 **Documentação Completa**

Para configurações avançadas, múltiplos ambientes e detalhes técnicos:
- 📖 [**Guia Completo de Implementação**](IMPLEMENTATION-STATUS.md)
- 🏗️ [**Visão Geral da Série**](SERIES-OVERVIEW.md)

**💡 Dica**: Se é sua primeira vez com monitoramento, comece pelo [Level 1](https://github.com/jlui70/monitoring-security-level1) que é mais simples.

---

## � Licença

Este projeto está sob licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.

---

## 📞 Contato e Suporte

### 🌐 Conecte-se Comigo

- 📹 **YouTube**: [DevOps Project](https://devopsproject.com.br/)
- 💼 **Portfólio**: [devopsproject.com.br](https://devopsproject.com.br/)
- 💻 **GitHub**: [@jlui70](https://github.com/jlui70)

### 🌟 Gostou do Projeto?

Se este projeto foi útil para você:

- ⭐ Dê uma estrela nos repositórios
- 🔄 Compartilhe com a comunidade
- 📹 Inscreva-se no canal do YouTube
- 🤝 Contribua com melhorias

---

**🎯 Este é o primeiro passo de uma jornada completa de segurança. A evolução continua nos próximos níveis!**

*"A segurança é uma jornada, não um destino. Comece simples, evolua constantemente."*

