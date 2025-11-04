# 🔐 Monitoring Security Stack - Level 2

**Environment Management + Automated Security** - Stack completa de monitoramento com gerenciamento avançado de variáveis de ambiente.

## 🚀 **Quick Start (1 comando)**

```bash
# Clone e execute
git clone https://github.com/jlui70/monitoring-security-level2.git
cd monitoring-security-level2
./quick-setup.sh
```

**Pronto!** Aguarde 6 minutos e acesse:
- **Zabbix**: http://localhost:8080 (Admin/zabbix)
- **Grafana**: http://localhost:3000 (admin/sua-senha-gerada)

---

## 🔧 **Setup Manual** (opcional)

Se preferir fazer passo a passo:

```bash
# 1. Gerar senhas
echo "1" | ./generate-secure-passwords.sh

# 2. Validar
./validate-environment.sh environments/.env.dev

# 3. Deploy  
cd monitoramento && ./setup.sh
```

---

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