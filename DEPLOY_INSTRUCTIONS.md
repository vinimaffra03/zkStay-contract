# Instruções de Deploy do Contrato

Este guia te ajudará a fazer o deploy do seu contrato SimpleStorage na rede Starknet e configurar o frontend.

## Pré-requisitos

- Contrato compilado (arquivos em `target/dev/`)
- Ferramentas Starknet instaladas
- Wallet com ETH para taxas de transação

## 🔧 Deploy do Contrato

### Opção 1: Usando Starknet CLI

1. **Instale o Starknet CLI:**
   ```bash
   curl https://get.starknet.sh -o starknet.sh
   chmod +x starknet.sh
   ./starknet.sh
   ```

2. **Faça o deploy:**
   ```bash
   starknet deploy \
     --contract target/dev/meu_projeto_meu_contrato.compiled_contract_class.json \
     --network testnet
   ```

3. **Anote o endereço retornado** - você precisará dele para o frontend

### Opção 2: Usando Starkscan Deploy

1. Acesse [Starkscan Deploy](https://starkscan.co/deploy)
2. Faça upload do arquivo `meu_projeto_meu_contrato.compiled_contract_class.json`
3. Conecte sua wallet e confirme o deploy
4. Anote o endereço do contrato

### Opção 3: Usando Starknet Foundry (snforge)

1. **Configure o foundry:**
   ```bash
   snforge init
   ```

2. **Deploy usando snforge:**
   ```bash
   snforge deploy \
     --contract target/dev/meu_projeto_meu_contrato.compiled_contract_class.json \
     --network testnet
   ```115e7bdbae000129b3bb5216b6e89f0e2d99df95656a2a3553eafbf23ae62319

## Configuração do Frontend

Após fazer o deploy, atualize o frontend:

1. **Abra o arquivo:** `frontend/src/hooks/useStarknet.ts`

2. **Substitua o endereço do contrato:**
   ```typescript
   // Linha 6
   const CONTRACT_ADDRESS = 'SEU_ENDERECO_AQUI';
   ```

3. **Exemplo:**
   ```typescript
   const CONTRACT_ADDRESS = '0x0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef';
   ```

## 🌐 Redes Disponíveis

### Testnet (Recomendado para testes)
- **RPC URL:** `https://starknet-testnet.public.blastapi.io`
- **Chain ID:** `SN_SEPOLIA`
- **Explorer:** [Starkscan Testnet](https://testnet.starkscan.co)

### Mainnet (Para produção)
- **RPC URL:** `https://starknet-mainnet.public.blastapi.io`
- **Chain ID:** `SN_MAIN`
- **Explorer:** [Starkscan Mainnet](https://starkscan.co)

## Obter ETH para Testnet

1. **Faucet do Starknet:**
   - Acesse [Starknet Faucet](https://faucet.goerli.starknet.io/)
   - Conecte sua wallet
   - Solicite ETH de teste

2. **Bridge do Ethereum:**
   - Use [Starkgate](https://starkgate.starknet.io/)
   - Faça bridge de ETH Goerli para Starknet Testnet

## Verificação

Para verificar se tudo está funcionando:

1. **Inicie o frontend:**
   ```bash
   cd frontend
   npm start
   ```

2. **Teste a conexão:**
   - Conecte sua wallet (Argent/Braavos)
   - Tente definir um valor
   - Verifique se o valor foi armazenado

3. **Verifique no explorer:**
   - Acesse o Starkscan
   - Procure pelo endereço do seu contrato
   - Verifique as transações

##  Solução de Problemas

### Erro de Conectividade
- Verifique se está na rede correta
- Confirme se o endereço do contrato está correto
- Teste com uma nova instância da wallet

### Erro de Transação
- Verifique se tem ETH suficiente para taxas
- Confirme se o contrato foi deployado corretamente
- Verifique os logs do console do navegador

### Erro de ABI
- Confirme se a ABI no código corresponde ao contrato
- Recompile o contrato se necessário
- Verifique se o arquivo `.json` está correto

##  Suporte

Se encontrar problemas:

1. Verifique os logs do console do navegador
2. Confirme se todas as dependências estão instaladas
3. Teste em uma rede de teste primeiro
4. Consulte a [documentação oficial do Starknet](https://docs.starknet.io/)

---

** Parabéns!** Seu DApp Starknet está pronto para uso!
