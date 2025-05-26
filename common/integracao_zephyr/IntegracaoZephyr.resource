Documentação:
...    Este arquivo tem como finalizade implementar integração dos resultados de execução de testes do Robot Framework
...    com o Zephyr Scale. Devem ser alterados os valores das variáveis ${ZEPHYR_CODIGO_DO_PROJETO}
...    e ${ZEPHYR_CICLO_DE_TESTE_FOLDER_ID} de acordo com o projeto de cada squad.
...    Exemplo de uso: robot -v ZEPHYR:True -v SPRINT:24.1.1 suite_de_testes.robot
*** Settings ***
Library    ../load_env.py
Library    RequestsLibrary
Library    JSONLibrary

*** Variables ***
${ZEPHYR_ACCESS_TOKEN}                       %{ZEPHYR_ACCESS_TOKEN}
${ZEPHYR.TEST_EXECUTIONS.JSON_REQUEST}       common/integracao_zephyr/resources/testexecutions.json
${ZEPHYR_BASE_URL}                           https://api.zephyrscale.smartbear.com/v2
${ZEPHYR_ENDPOINT_TESTCASES}                 /testcases/
${ZEPHYR_ENDPOINT_TEST_EXECUTIONS}           /testexecutions
${ZEPHYR_ENDPOINT_TEST_CYCLES}               /testcycles
${ZEPHYR_ENDPOINT_TEST_CYCLES_MAX_RESULTS}   50
${ZEPHYR_ENDPOINT_HEALTHCHECK}               /healthcheck
${ZEPHYR_CODIGO_DO_CASO_DE_TESTE}            ${EMPTY}
${ZEPHYR_CODIGO_DO_CICLO_DE_TESTE}           ${EMPTY}
${ZEPHYR_NOME_DA_PASTA_DE_CICLO_DE_TESTE}    Automação
${ZEPHYR}                                    False       #Variável deve ser enviada via linha de comando. Ex: robot -v ZEPHYR:True   Essa variável habilita a integração com o Zephyr.
${SPRINT}                                    ${EMPTY}    #Variável deve ser enviada via linha de comando. Ex: robot -v SPRINT:24.1.1 Essa variável é utilizada para localizar o ciclo de teste no Zephyr e de envio obrigatório quando enviar ZEPHYR:True
   
#AS VARIÁVEIS ABAIXO DEVEM SER PREENCHIDAS DE ACORDO COM O PROJETO DE CADA SQUAD
${ZEPHYR_CODIGO_DO_PROJETO}               OPCH        #Código do projeto no Jira.
${ZEPHYR_CICLO_DE_TESTE_FOLDER_ID}        11737545    #ID da pasta "Automação". Após a criação manual da pasta no Zephyr (aba Ciclos de Teste), executar o teste "Retornar ID da pasta Automação" (arquivo Tools.robot) para obter o ID da pasta "Automação".

*** Keywords ***
Integração Zephyr - Validações
    IF    '${ZEPHYR}' == 'True'
        IF    '${SPRINT}' == '${EMPTY}'
            Fatal Error    Necessário informar a variável SPRINT ao informar ZEPHYR:True
        END
        Verificar disponibilidade da API
        Verificar se o caso de teste existe no Zephyr
        Localizar ciclo de teste
    END

Integração Zephyr - Enviar resultado
    IF    '${ZEPHYR}' == 'True'
        Run Keyword If Test Passed    Logar Sucesso
        Run Keyword If Test Failed    Logar Falha
    END

Verificar se o caso de teste existe no Zephyr
    Skip If    not @{TEST TAGS}    Caso de teste sem declaração de tags. Adicionar tag.
    FOR    ${ZEPHYR_CODIGO_DO_CASO_DE_TESTE}    IN    @{TEST TAGS}
        ${headers}     Create Dictionary       Authorization=${ZEPHYR_ACCESS_TOKEN}
        ${response}    GET    url=${ZEPHYR_BASE_URL}${ZEPHYR_ENDPOINT_TESTCASES}${ZEPHYR_CODIGO_DO_CASO_DE_TESTE}    headers=${headers}    expected_status=any    
        Set Test Variable    ${ZEPHYR_CODIGO_DO_CASO_DE_TESTE}
        Exit For Loop If    ${response.status_code}==200
    END
    Skip If    ${response.status_code}!=200    Caso de teste não localizado no Zephyr. Verificar tag.

Verificar disponibilidade da API
    ${headers}    Create Dictionary    Authorization=${ZEPHYR_ACCESS_TOKEN}
    ${ZEPHYR_CHECK}    GET    url=${ZEPHYR_BASE_URL}${ZEPHYR_ENDPOINT_HEALTHCHECK}    headers=${headers}    expected_status=any
    IF    ${ZEPHYR_CHECK.status_code} != 200
        Fatal Error    [${ZEPHYR_CHECK.status_code}] A API do Zephyr não está disponível no momento!
    END

Logar Sucesso
    ${json}        Load Json From File     ${ZEPHYR.TEST_EXECUTIONS.JSON_REQUEST}
    ${json}        Update Value To json    ${json}    $.projectKey                           ${ZEPHYR_CODIGO_DO_PROJETO}
    ${json}        Update Value To Json    ${json}    $.testCaseKey                          ${ZEPHYR_CODIGO_DO_CASO_DE_TESTE}
    ${json}        Update Value To Json    ${json}    $.testCycleKey                         ${ZEPHYR_CODIGO_DO_CICLO_DE_TESTE}
    ${json}        Update Value To Json    ${json}    $.statusName                           Pass
    ${json}        Update Value To Json    ${json}    $.testScriptResults[0].statusName      Pass
    ${json}        Update Value To Json    ${json}    $.testScriptResults[0].actualResult    Este teste foi executado automaticamente via Robot Framework
    ${json}        Update Value To Json    ${json}    $.comment                              Este teste foi executado automaticamente via Robot Framework
    ${headers}     Create Dictionary       Authorization=${ZEPHYR_ACCESS_TOKEN}
    ${response}    POST    url=${ZEPHYR_BASE_URL}${ZEPHYR_ENDPOINT_TEST_EXECUTIONS}    headers=${headers}    json=${json}    expected_status=201

Logar Falha
    ${json}        Load Json From File     ${ZEPHYR.TEST_EXECUTIONS.JSON_REQUEST}
    ${json}        Update Value To json    ${json}    $.projectKey                           ${ZEPHYR_CODIGO_DO_PROJETO}
    ${json}        Update Value To Json    ${json}    $.testCaseKey                          ${ZEPHYR_CODIGO_DO_CASO_DE_TESTE}
    ${json}        Update Value To Json    ${json}    $.testCycleKey                         ${ZEPHYR_CODIGO_DO_CICLO_DE_TESTE}
    ${json}        Update Value To Json    ${json}    $.statusName                           Fail
    ${json}        Update Value To Json    ${json}    $.testScriptResults[0].statusName      Fail
    ${json}        Update Value To Json    ${json}    $.testScriptResults[0].actualResult    Erro reportado: ${TEST MESSAGE}
    ${json}        Update Value To Json    ${json}    $.comment                              Erro reportado: ${TEST MESSAGE}
    ${headers}     Create Dictionary       Authorization=${ZEPHYR_ACCESS_TOKEN}
    ${response}    POST    url=${ZEPHYR_BASE_URL}${ZEPHYR_ENDPOINT_TEST_EXECUTIONS}    headers=${headers}    json=${json}    expected_status=201

Localizar ciclo de teste
    IF    '${ZEPHYR_CODIGO_DO_CICLO_DE_TESTE}' == '${EMPTY}'
        ${headers}     Create Dictionary       Authorization=${ZEPHYR_ACCESS_TOKEN}
        ${params}      Create Dictionary       projectKey=${ZEPHYR_CODIGO_DO_PROJETO}    maxResults=${ZEPHYR_ENDPOINT_TEST_CYCLES_MAX_RESULTS}       folderId=${ZEPHYR_CICLO_DE_TESTE_FOLDER_ID}
        ${response}    GET    url=${ZEPHYR_BASE_URL}${ZEPHYR_ENDPOINT_TEST_CYCLES}       headers=${headers}    params=${params}    expected_status=200
        Ler nomes dos ciclos de testes    ${response.json()}    
    END

Ler nomes dos ciclos de testes
    [Arguments]    ${data}
    FOR    ${ciclo}    IN    @{data["values"]}
        IF    '${ciclo["name"]}' == '${SPRINT}'
            Set Global Variable    ${ZEPHYR_CODIGO_DO_CICLO_DE_TESTE}    ${ciclo["key"]}
        END
    END

    IF    '${ZEPHYR_CODIGO_DO_CICLO_DE_TESTE}' != '${EMPTY}'
        RETURN
    ELSE IF    '${data["isLast"]}' == 'False'
        Acessar próxima página de registros de ciclos  ${data["next"]}
    ELSE
        Criar ciclo de teste
    END

Acessar próxima página de registros de ciclos
    [Arguments]    ${next_page_url}
    ${headers}     Create Dictionary              Authorization=${ZEPHYR_ACCESS_TOKEN}
    ${response}    GET    url=${next_page_url}    headers=${headers}    expected_status=200
    ${data}        Set Variable    ${response.json()}
    Ler nomes dos ciclos de testes    ${data}

Criar ciclo de teste
    ${headers}     Create Dictionary       Authorization=${ZEPHYR_ACCESS_TOKEN}
    ${json}        Create Dictionary       name=${SPRINT}    folderId=${ZEPHYR_CICLO_DE_TESTE_FOLDER_ID}    projectKey=${ZEPHYR_CODIGO_DO_PROJETO}
    ${response}    POST    url=${ZEPHYR_BASE_URL}${ZEPHYR_ENDPOINT_TEST_CYCLES}    headers=${headers}       json=${json}    expected_status=201
    Set Global Variable    ${ZEPHYR_CODIGO_DO_CICLO_DE_TESTE}    ${response.json()["key"]}