# 🚀 SimpleStorage DApp na Starknet

![Starknet](https://img.shields.io/badge/Starknet-Blockchain-6353FF?style=flat-square)
![Testnet](https://img.shields.io/badge/Network-Testnet-blue?style=flat-square)
![License](https://img.shields.io/badge/License-MIT-green?style=flat-square)

Um guia completo para **deploy do contrato `SimpleStorage`** na Starknet e integração com o frontend.

---

## 📋 Pré-requisitos

Antes de começar, tenha:

- Contrato compilado em `target/dev/`
- Ferramentas Starknet instaladas (CLI / Foundry)
- Wallet com ETH para taxas de transação

---

## 🔧 Deploy do Contrato

### 🛠️ Opção 1: Starknet CLI

```bash
curl https://get.starknet.sh -o starknet.sh
chmod +x starknet.sh
./starknet.sh

starknet deploy \
  --contract target/dev/meu_projeto_meu_contrato.compiled_contract_class.json \
  --network testnet
💡 Dica: Anote o endereço do contrato retornado, será necessário no frontend.

🌐 Opção 2: Starkscan Deploy
Acesse Starkscan Deploy

Faça upload do arquivo .compiled_contract_class.json

Conecte sua wallet e confirme o deploy

Anote o endereço do contrato

⚡ Opção 3: Starknet Foundry (snforge)
bash
Copiar código
snforge init

snforge deploy \
  --contract target/dev/meu_projeto_meu_contrato.compiled_contract_class.json \
  --network testnet
Exemplo de endereço retornado:

Copiar código
0x115e7bdbae000129b3bb5216b6e89f0e2d99df95656a2a3553eafbf23ae62319
🖥️ Configuração do Frontend
Abra:

text
Copiar código
frontend/src/hooks/useStarknet.ts
Substitua o endereço do contrato:

ts
Copiar código
const CONTRACT_ADDRESS = 'SEU_ENDERECO_AQUI';
Exemplo:

ts
Copiar código
const CONTRACT_ADDRESS = '0x0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef';
🌐 Redes Disponíveis
Rede	RPC URL	Chain ID	Explorer
Testnet	Blast API	SN_SEPOLIA	Starkscan Testnet
Mainnet	Blast API	SN_MAIN	Starkscan Mainnet

💸 Obter ETH para Testnet
Faucet Starknet: Acesse aqui

Conecte sua wallet

Solicite ETH de teste

Bridge do Ethereum: Starkgate
Faça bridge de ETH Goerli para Starknet Testnet

✅ Verificação do DApp
Inicie o frontend:

bash
Copiar código
cd frontend
npm start
Teste:

Conecte sua wallet (Argent/Braavos)

Defina um valor no SimpleStorage

Confira se o valor foi armazenado

Verifique no explorer:
Starkscan → procure pelo endereço do contrato → confira transações

🛠️ Solução de Problemas
Erro de Conectividade
Confirme a rede (Testnet/Mainnet)

Verifique o endereço do contrato

Teste com nova wallet ou instância

Erro de Transação
Verifique se há ETH suficiente

Confirme se o contrato foi deployado corretamente

Confira logs no console do navegador

Erro de ABI
Confirme se a ABI corresponde ao contrato

Recompile se necessário

Verifique se o arquivo .json está correto

📞 Suporte e Referências
Documentação Oficial Starknet

Teste sempre em Testnet antes da Mainnet

Confira logs e dependências do frontend

🎉 Parabéns! Seu DApp SimpleStorage na Starknet está pronto para uso!
