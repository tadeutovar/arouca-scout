# 🏟️ Scouting Arouca — Futsal Sub-6

Projeto de análise de dados de uma partida de futsal da categoria Sub-6 (Federação), desenvolvido para a disciplina de **Projeto de Machine Learning — IBMEC Rio de Janeiro**.

**Jogo:** Arouca 4×1 Real Juventus
**Data:** 21/04/2026

---

## Como rodar

### Pré-requisitos
- R instalado → https://cran.r-project.org
- Instalar os pacotes (rodar uma vez no terminal como Administrador):

```powershell
& "C:\Program Files\R\R-4.6.0\bin\Rscript.exe" -e "install.packages(c('ggplot2','dplyr','randomForest'), repos='https://cran.r-project.org')"
```

### Executar
Coloque todos os arquivos na mesma pasta e rode:

```powershell
& "C:\Program Files\R\R-4.6.0\bin\Rscript.exe" analise.R
```

Os gráficos serão salvos automaticamente na mesma pasta.

---

## Estrutura do projeto

```
arouca-scout/
├── analise.R              # Script principal de análise
├── escalacao.csv          # Escalação e perfil dos jogadores
├── finalizacoes.csv       # 24 finalizações registradas
├── escanteios.csv         # Escanteios a favor
├── faltas.csv             # Faltas cometidas e sofridas
├── cartoes.csv            # Cartões (nenhum registrado)
├── grafico1_resultados.png
├── grafico2_jogadores.png
├── grafico3_periodo.png
├── grafico4_regiao.png
├── README.md
└── relatorio.md
```

---

## O que o script faz

| Seção | Descrição |
|---|---|
| EDA | Estatística descritiva: totais, aproveitamento por jogador, período e região |
| Gráficos | 4 gráficos gerados com `ggplot2` e salvos em PNG |
| ML | Random Forest para prever se uma finalização resulta em gol |

---

## Resultados rápidos

| Métrica | Valor |
|---|---|
| Finalizações | 24 |
| Gols | 4 |
| Taxa de conversão | 16,7% |
| Artilheiro | Tomás (2 gols) |
| Maior finalizador | Mateus (11 tentativas) |
| Melhor aproveitamento | Luca (33,3%) |
| Variável mais importante (ML) | Região da quadra |
