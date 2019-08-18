library(janitor)
library(lubridate)
library(readxl)
library(purrr)

download_orcamento <- function(ano) {
  download.file(
    paste0(
      "http://orcamento.sf.prefeitura.sp.gov.br/orcamento/uploads/",
      ano,
      "/basedadosexecucao",
      ano,
      ".xls"
    ),
    destfile = paste0("data-raw/basedadosexecucao", ano, ".xls"),
    mode = "wb"
  )
}

arrumar_bases <- function(ano){
read_xls(paste0("data-raw/basedadosexecucao", ano, ".xls")) %>%
  janitor::clean_names() %>%
  mutate(
    data_inicial = lubridate::as_datetime(data_inicial),
    data_final = lubridate::as_datetime(data_final),
    data_extracao = lubridate::as_datetime(data_extracao)
  ) %>%
  mutate_at(vars(starts_with("cd_")), list(as.numeric)
  ) %>% 
  
  saveRDS(file = paste0("data-output/basespmsp/basedadosexecucao", ano, ".rds"))
}


juntar_bases_orcamento <- function() {
  df_orcamento <-
    list.files(path = "data-output/basespmsp", full.names = TRUE) %>%
    map(readRDS) %>%
    bind_rows() %>% 
    saveRDS(file = paste0("data-output/df_execucao_united.rds"))
}