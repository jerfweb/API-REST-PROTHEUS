#include 'protheus.ch'

/*/{Protheus.doc} fAltUsr
Função para realizar alterações dos cadastro de usuários, 
utilizando o serviço RestFull "/Users" padrão do Protheus.
@author     Jerfferson Silva
@since      13.03.2019
/*/
User Function fAltUsr()

  Local oRestClient := Nil
  Local cUrl			  := "/rest/users/"
  Local cGetParams	:= ""
  Local nTimeOut		:= 200
  Local aHeadStr		:= {"Content-Type: application/json"}
  Local cHeaderGet	:= ""
  Local cRetWs		  := ""
  Local oObjJson		:= Nil
  Local cStrResul		:= ""
  Local cCodUsr      := ""

  cCodUsr := "001822"

  //Verifica se o parametro existe. Se não existir cria.
	If !ExisteSX6( "MV_XSRVREST" )
		CriarSX6( "MV_XSRVREST", "C", "Endeerço e porta do servidor RESTFULL Protheus. Ex: http://10.201.0.14:8182", "http://10.201.0.14:8182" )
	EndIf

  oRestClient := FWRest():New(AllTrim(GetMv("MV_XSRVREST")))

  // chamada de classe REST com retorno de dados do usuário
  oRestClient:setPath(cUrl+cCodUsr)

  cRetWs	:= HttpGet(cUrl, cGetParams, nTimeOut, aHeadStr, @cHeaderGet)
  If !FWJsonDeserialize(cRetWs, @oObjJson)
    MsgStop("Ocorreu erro no processamento do Json.")
    Return Nil
	ElseIf AttIsMemberOf(oObjJson,"errorCode")
		MsgStop("errorCode: " + DecodeUTF8(oObjJson:errorCode) + " - errorMessage: " + DecodeUTF8(oObjJson:errorMessage))
		Return Nil
	Else
		
		cStrResult := DecodeUTF8(oObjJson:userName) + ", "
		cStrResult += DecodeUTF8(oObjJson:displayName) + ", "

		AVISO("Dados da consulta: ", cStrResult, {"Fechar"}, 2)

	EndIf

Return