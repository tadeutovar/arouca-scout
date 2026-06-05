# ============================================================
# SCOUTING AROUCA — Análise, Gráficos e Machine Learning
# ============================================================

library(ggplot2)
library(dplyr)
library(randomForest)

# ============================================================
# LEITURA DOS DADOS
# ============================================================

finalizacoes <- read.csv("finalizacoes.csv", stringsAsFactors = FALSE)
escalacao    <- read.csv("escalacao.csv",    stringsAsFactors = FALSE)
escanteios   <- read.csv("escanteios.csv",   stringsAsFactors = FALSE)
faltas       <- read.csv("faltas.csv",       stringsAsFactors = FALSE)

# ============================================================
# 5. ANÁLISE EXPLORATÓRIA (EDA)
# ============================================================

cat("=== ANÁLISE EXPLORATÓRIA ===\n\n")

cat("Total de finalizações:", nrow(finalizacoes), "\n")
cat("Gols marcados:        ", sum(finalizacoes$gol), "\n")
cat("Taxa de conversão:    ", round(mean(finalizacoes$gol) * 100, 1), "%\n\n")

cat("-- Resultados --\n")
print(table(finalizacoes$resultado))

cat("\n-- Finalizações por jogador --\n")
por_jogador <- finalizacoes %>%
  group_by(jogador) %>%
  summarise(
    Finalizacoes   = n(),
    Gols           = sum(gol),
    Aproveitamento = paste0(round(mean(gol) * 100, 1), "%")
  ) %>% arrange(desc(Finalizacoes))
print(por_jogador)

cat("\n-- Finalizações por período --\n")
print(table(finalizacoes$periodo))

cat("\n-- Finalizações por região da quadra --\n")
print(table(finalizacoes$regiao_quadra))

cat("\n-- Finalizações por pé utilizado --\n")
print(table(finalizacoes$pe_utilizado))

cat("\n-- Escanteios a favor --\n")
cat("Total:", nrow(escanteios), "\n")

cat("\n-- Faltas --\n")
cat("Cometidas pelo Arouca:", nrow(faltas[faltas$equipe_responsavel == "Arouca", ]), "\n")
cat("Sofridas pelo Arouca: ", nrow(faltas[faltas$equipe_responsavel != "Arouca", ]), "\n")

# ============================================================
# 6. GRÁFICOS
# ============================================================

# Gráfico 1 — Resultados das finalizações
p1 <- ggplot(finalizacoes, aes(x = resultado, fill = resultado)) +
  geom_bar() +
  geom_text(stat = "count", aes(label = after_stat(count)), vjust = -0.5) +
  labs(title = "Resultados das Finalizações — Arouca",
       x = NULL, y = "Quantidade") +
  theme_minimal() +
  theme(legend.position = "none")
ggsave("grafico1_resultados.png", p1, width = 7, height = 4)

# Gráfico 2 — Finalizações por jogador
p2 <- ggplot(finalizacoes, aes(x = jogador, fill = resultado)) +
  geom_bar() +
  labs(title = "Finalizações por Jogador — Arouca",
       x = NULL, y = "Quantidade", fill = "Resultado") +
  theme_minimal()
ggsave("grafico2_jogadores.png", p2, width = 7, height = 4)

# Gráfico 3 — Finalizações por período
p3 <- ggplot(finalizacoes, aes(x = periodo, fill = resultado)) +
  geom_bar() +
  labs(title = "Finalizações por Período — Arouca",
       x = "Período", y = "Quantidade", fill = "Resultado") +
  theme_minimal()
ggsave("grafico3_periodo.png", p3, width = 7, height = 4)

# Gráfico 4 — Finalizações por região da quadra
p4 <- ggplot(finalizacoes, aes(x = regiao_quadra, fill = resultado)) +
  geom_bar() +
  labs(title = "Finalizações por Região da Quadra — Arouca",
       x = "Região", y = "Quantidade", fill = "Resultado") +
  theme_minimal()
ggsave("grafico4_regiao.png", p4, width = 7, height = 4)

cat("\nGráficos salvos!\n")

# ============================================================
# 7. MACHINE LEARNING — Random Forest
# ============================================================
# Objetivo: prever se uma finalização resulta em gol
# com base no jogador, período e região da quadra.

set.seed(42)

ml <- finalizacoes %>%
  mutate(
    gol           = factor(gol, labels = c("NaoGol", "Gol")),
    jogador       = factor(jogador),
    periodo       = factor(periodo),
    regiao_quadra = factor(regiao_quadra)
  ) %>%
  select(gol, jogador, periodo, regiao_quadra)

modelo <- randomForest(gol ~ ., data = ml, ntree = 100)

cat("\n=== MACHINE LEARNING — Random Forest ===\n")
print(modelo)

cat("\nImportância das variáveis:\n")
print(importance(modelo))
