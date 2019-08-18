# Launch the ShinyApp (Do not remove this comment)
# To deploy, run: rsconnect::deployApp()
# Or use the blue button on top of this file
library(shinydashboard)

df_orc <- readRDS("data-raw/df_execucao_united.rds")

pkgload::load_all()

options( "golem.app.prod" = TRUE)

OrcamentoPMSP::run_app() # add parameters here (if any)
