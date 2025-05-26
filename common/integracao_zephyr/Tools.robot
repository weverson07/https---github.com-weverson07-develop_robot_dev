Documentação: Fornece teste que retorna o ID da pasta 'Automação' do Zephyr, dado este requerido para setup do projeto de integração.
*** Settings ***
Library    ../load_env.py
Library    RequestsLibrary

*** Variables ***
${ZEPHYR_CODIGO_DO_PROJETO}                  OPCH    #Altere apenas o código do seu projeto. Lembre-se que o nome da pasta no Zephyr deve ser 'Automação'

${ZEPHYR_NOME_DA_PASTA_DE_CICLO_DE_TESTE}    Automação
${ZEPHYR_BASE_URL}                           https://api.zephyrscale.smartbear.com/v2
${ZEPHYR_ENDPOINT_GETFOLDERS}                /folders
${ZEPHYR_ENDPOINT_GETFOLDERS_FOLDER_TYPE}    TEST_CYCLE
${ZEPHYR_ENDPOINT_GETFOLDERS_START_AT}       0
${ZEPHYR_ENDPOINT_GETFOLDERS_MAX_RESULTS}    10
${ZEPHYR_ACCESS_TOKEN}                       %{ZEPHYR_ACCESS_TOKEN}


*** Test Cases ***
Retornar ID da pasta Automação
    [Tags]    ID
    Analisar retorno do endpoint GetFolders


*** Keywords ***
Consultar endpoint GetFolders
    ${headers}    Create Dictionary    Authorization=${ZEPHYR_ACCESS_TOKEN}
    ${params}    Create Dictionary    projectKey=${ZEPHYR_CODIGO_DO_PROJETO}    folderType=${ZEPHYR_ENDPOINT_GETFOLDERS_FOLDER_TYPE}    startAt=${ZEPHYR_ENDPOINT_GETFOLDERS_START_AT}    maxResults=${ZEPHYR_ENDPOINT_GETFOLDERS_MAX_RESULTS}
    ${response}    GET    url=${ZEPHYR_BASE_URL}${ZEPHYR_ENDPOINT_GETFOLDERS}    headers=${headers}    params=${params}    expected_status=any
    RETURN    ${response.json()}

Analisar retorno do endpoint GetFolders
    ${pastas}    Consultar endpoint GetFolders
    ${pasta_encontrada}    Set Variable    False
    ${isLast}    Set Variable    ${pastas["isLast"]}
    FOR    ${pasta}    IN    @{pastas["values"]}
        IF    '${pasta["name"]}' == '${ZEPHYR_NOME_DA_PASTA_DE_CICLO_DE_TESTE}'
            Log To Console    ID DA PASTA = ${pasta["id"]}
            Log    ID DA PASTA = ${pasta["id"]}
            ${pasta_encontrada}    Set Variable    True
            BREAK
        END
    END
    IF    '${pastas["isLast"]}' == 'False' and '${pasta_encontrada}' == 'False'
        ${ZEPHYR_ENDPOINT_GETFOLDERS_START_AT}    Evaluate   ${ZEPHYR_ENDPOINT_GETFOLDERS_START_AT} + ${ZEPHYR_ENDPOINT_GETFOLDERS_MAX_RESULTS}
        Set Test Variable    ${ZEPHYR_ENDPOINT_GETFOLDERS_START_AT}
        Analisar retorno do endpoint GetFolders          
    END
    IF    '${pastas["isLast"]}' == 'True' and '${pasta_encontrada}' == 'False'
        Fatal Error    Pasta de ciclo de teste “Automação“ não foi encontrada no Zephyr. Realize o cadastro manualmente no Zephyr e execute essa consulta novamente.
    END