*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${LOGIN_USER}         xpath://input[@id="Email"]
${senha}                 //input[@id="Password"] | //*[@id="Password"]
${BOTAO_ENTRAR_XPATH}    //input[@id="btnLogin"] | //*[@id="btnLogin"]
${BTN_MENU}              id=btnMenu
${IFRAME_ID}             iframe-id
${LOADER}                css=div.loader-section.section-left
${TEMPO}                 5s
${TEMPO_MIN}                 2s
${MODAL_POPUP}           //*[@class= "swal2-cancel swal2-styled swal2-default-outline"]  
${CONFIRMAÇÃOPOPUP}      //*[@class="swal2-confirm swal2-styled"] 
${LABEL_CRIA_FRETE}      //*[@id="btnLoadOfferCreate"]   
${TIPO_FRETE_PUBLICAR}   //*[@id='loadType']
${PRODUTO_ESCOLHIDO}     //*[text()="Ácido graxo"]
${SELECIONA_PRODUTO}     //*[@id='FlowRate']
${INICIAO_DATA}          //*[@id='initialDate']
${FINAL_DATA}            //*[@id='finalDate']
${REVERSE_LOGISTIC}      //*[@id='reverselogisticContainer']
${ORIGIN_ADDRESS}        //*[@id="OriginAddress"]
${SELECIONA_ENDERECO}    //*[@id="ui-id-9"]
${DESTINATION_ADDRESS}   //*[@id="DestinationAddress"]
${ENDERECO_DEST}         //ul[@id="ui-id-10"]
${VALOR_FRETE}           document.getElementById("FreightValue").value = '-1.00';
${FLAG_ESTADIA}          //*[@id="divBeneficio1"]
${FLAG_AUTOMOTIVOS}      //*[@class="carrier-type2"]
${FLAG_FROTISTAS}        //*[@id="fieldTransporter"]/li[2]
${FLAG_COOPERATIVAS}     //*[@id="fieldTransporter"]/li[3]
${TIPO_VEICULO}          //*[@id="VehicleTypeId"]
${SELECIONA_TIPO_VEIC}   //*[@id="divchkAutoCompleteListvehicleTypes7"]
${TIPO_CARROCERIA}       //*[@id="VehicleBodyTypeId"]
${SEL_CARROCERIA}        //*[@id="divchkAutoCompleteListvehicleBody6"]/label
${BTN_SAVE}              //*[@id="btnSave"]
${DATA_PROMOCAO}         //*[@id="PromotionDate"]
${HORA_PROMOCAO}         //*[@id="PromotionHour"]
${NOME_PROMOCAO}         //*[@id="Name"]
${SEL_VALOR_FILIAL}      document.querySelector('input.select-dropdown').value = '10249';
${BTN_CRIAROFERTA}       xpath=(//button[@id="btnSave"])[1]
${BTN_EXPLORE_SOL}       xpath=//*[@class="button button--primary"]
${MANU_SOMOS_VERY}       xpath=//a[text()="somos veri"]