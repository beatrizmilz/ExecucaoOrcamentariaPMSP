library(tidyverse)
library(ggplot2)

source(file = "R/funcoes_preparar-dados.R", encoding = "UTF-8")

# Download
# ------ Para anos concluídos

# for (i in 2003:2018) {
#   download_orcamento(ano = i)
# }
# 
# download_orcamento(ano = 2019)
# 
# for (i in 2003:2018) {
#   arrumar_bases(ano = i)
# }


beepr::beep(sound = 2)

# ------- Para 2019

download_orcamento(ano = 2019)
arrumar_bases(ano = 2019)
beepr::beep(sound = 2)


# Juntar as bases

juntar_bases_orcamento()
beepr::beep(sound = 2)


df_orcamento_pmsp <- readRDS(file = "data-output/df_execucao_united.rds")


