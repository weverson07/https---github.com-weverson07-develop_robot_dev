*** Settings ***
Library      libs/LoadEnv.py
# Library    libs/WebDriver.py
Library      SeleniumLibrary
Library      OperatingSystem
Library      Screenshot
Resource     ../hooks/HOOKS.resource

*** Variables ***
${URLfreto}    https://qa.freto.com/Login
# não apagar ${OPTIONS}: variável utilizada para manter a execução local e na pipeline
${OPTIONS}           add_argument("--ignore-local-proxy-environment-variables")
${BROWSER}           chrome
${BASE_URL_COGNA}    https://www.cogna.com.br/

# variáveis de ambiente para endpoints
${URL_ENDPOINT}       https://captacao-aks-stg.krthomolog.com.br/
${URL_AREA}           https://pucappsstg.krthomolog.com.br/stg/areacandidato-web/anhanguera/area-do-candidato/login
${BASE_URL_PROUNI}    https://captacao-aks-stg.krthomolog.com.br/captacao/documentacao/ms/prouni/swagger-ui/index.html?configUrl=/captacao/documentacao/ms/prouni/v3/api-docs/swagger-config#/candidato-prouni-controller/upload

#URLS ERPS de login das urls
${BASE_URL_UMC}          https://umc.stage.platosedu.io/v2/erp/pt
${BASE_URL_UPF}          https://upf.stage.platosedu.io/v2/erp/pt
${BASE_URL_UTP}          https://utp.stage.platosedu.io/v2/erp/pt
${BASE_URL_HAOC}         https://haoc.stage.platosedu.io/v2/erp/pt
${BASE_URL_INFOPROD}     https://infoprod.stage.platosedu.io/v2/erp/pt
${BASE_URL_KROTON}       https://kroton.stage.platosedu.io/v2/erp/pt
${BASE_URL_MACKENZIE}    https://mackenzie.stage.platosedu.io/v2/erp/pt
${BASE_URL_STRICTO}      https://stricto.stage.platosedu.io/v2/erp/pt

#Gestor de produtos
${GESTO_URL}             https://krotonhml.crm2.dynamics.com/
${email_login}           CS_ATHENAS_KEE1@pitagoras.com.br
${incorrect_password}    Keeggo@
${password}              Keeggo@123
${UrlVeryCode}           https://vericode.com.br/pt