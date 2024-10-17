#include 'protheus.ch'

/*/{Protheus.doc} fAltUsr
Fun��o para realizar altera��es dos cadastro de usu�rios, utilizando a API Rest servi�o /Users padr�o do Protheus.
@type function
@version 12.1.2310
@author Jerfferson Menezes
@since 13/03/2019
@param cCodUsr, character, C�digo do usu�rio.
@param nOpc, numeric, C�digo da a��o a ser realizada.
/*/
User Function fAltUsr(cCodUsr,nOpc)

	Local oRestClient := Nil
	Local aHeadStr		:= {"Content-Type: application/json"}
	Local cJSon 		  := ""
	Local oObjJson		:= Nil
	Local cStrResul		:= ""
  Local cUrlRest    := SuperGetMv("MV_XSRVREST",.F.,"http://10.2.0.120:8182/restt1") //Endere�o http do servidor REST Protheus.
  Local cUrl			  := "/users/" //Servi�o a ser consumido
  Default nOpc      := 1
  Default cCodUsr   := "000001"

	oRestClient := FWRest():New(AllTrim(GetMv(cUrlRest)))

	If nOpc == 1 //Consulta - Verbo GET -----------------------------------------------------|

		// chamada de classe REST com retorno de dados do usu�rio - Verbo GET
		oRestClient:setPath(cUrl+cCodUsr)
		If oRestClient:Get(aHeadStr)
      oObjJson   := JsonObject():New()
      oObjJson:FromJson(oRestClient:getResult())
			If oObjJson == Nil
				MsgStop("Ocorreu erro no processamento do Json.")
				Return Nil
			ElseIf oObjJson:HasProperty("errorCode")
				MsgStop("errorCode: " + oObjJson:GetJsonText("errorCode") + " - errorMessage: " + oObjJson:GetJsonText("errorMessage"))
				Return Nil
			Else
				cStrResul := oRestClient:GetResult()
				AVISO("Dados da opera��o: ", cStrResul, {"Fechar"}, 3)
			EndIf
		Else
			cStrResul := oRestClient:GetLastError()
			AVISO("Dados da opera��o: ", cStrResul, {"Fechar"}, 3)
		EndIf

	ElseIf nOpc == 2 //Create - Verbo POST -----------------------------------------------------|

		// chamada da classe exemplo de REST para opera��es CRUD
		oRestClient:setPath(cUrl)

		// chamada de classe REST cria��o do usu�rio - Verbo POST
		// BODY - estrutura basica para cria��o de usu�rio, mais informa��o ler documenta��o.
		cJSon := ' { '
		cJSon += '    "schemas":[ '
		cJSon += '       "urn:scim:schemas:core:2.0:User", '
		cJSon += '       "urn:scim:schemas:extension:enterprise:2.0:User" '
		cJSon += '    ], '
		cJSon += '    "externalId":"TesteUsr", '
		cJSon += '    "meta":{},'
		cJSon += '    "userName":"Teste"' + cCodUsr + ', '
		cJSon += '    "displayName":"User", '
		cJSon += '    "title":"Coordenador", '
		cJSon += '    "emails":[ '
		cJSon += '       { '
		cJSon += '          "value":"XUsr02@empresa.com.br", '
		cJSon += '          "primary":true '
		cJSon += '       } '
		cJSon += '    ], '
		cJSon += '    "active":true, '
		cJSon += '    "groups":[ '
		cJSon += '       { '
		cJSon += '          "value":"000002" '
		cJSon += '       } '
		cJSon += '    ], '
		cJSon += '    "password":"12345678", '
		cJSon += '    "urn:scim:schemas:extension:totvs:2.0:User/forceChangePassword":true, '
		cJSon += '    "urn:scim:schemas:extension:enterprise:2.0:User/department":"TI", '
		cJSon += '    "urn:scim:schemas:extension:totvs:2.0:User/groupRule":2 '
		cJSon += ' } '

		// define o conte�do do body
		oRestClient:SetPostParams(cJSon)

		If oRestClient:Post(aHeadStr)
			oObjJson   := JsonObject():New()
      oObjJson:FromJson(oRestClient:getResult())
			If oObjJson == Nil
				MsgStop("Ocorreu erro no processamento do Json.")
				Return Nil
			ElseIf oObjJson:HasProperty("errorCode")
				MsgStop("errorCode: " + oObjJson:GetJsonText("errorCode") + " - errorMessage: " + oObjJson:GetJsonText("errorMessage"))
				Return Nil
			Else
				cStrResul := oRestClient:GetResult()
				AVISO("Dados da opera��o: ", cStrResul, {"Fechar"}, 3)
			EndIf
		EndIf

	ElseIf nOpc == 3 //Update - Verbo PUT -----------------------------------------------------|

		// chamada de classe REST cria��o do usu�rio - Verbo PUT
		oRestClient:setPath(cUrl+cCodUsr)
		// BODY - estrutura basica para update de usu�rio, mais informa��o ler documenta��o.
		cJSon := ' { '
		cJSon += '    "userName":"TesteUsr", '
		cJSon += '    "emails":[ '
		cJSon += '       { '
		cJSon += '          "value":"sistemas@kenner.com.br", '
		cJSon += '          "primary":true '
		cJSon += '       } '
		cJSon += '    ], '
		cJSon += '    "active":true '
		cJSon += ' } '

		// para os m�todos PUT o conte�do body � enviado por parametro.
		// PUT
		If oRestClient:Put(aHeadStr, cJSon)
			oObjJson   := JsonObject():New()
      oObjJson:FromJson(oRestClient:getResult())
			If oObjJson == Nil
				MsgStop("Ocorreu erro no processamento do Json.")
				Return Nil
			ElseIf oObjJson:HasProperty("errorCode")
				MsgStop("errorCode: " + oObjJson:GetJsonText("errorCode") + " - errorMessage: " + oObjJson:GetJsonText("errorMessage"))
				Return Nil
			Else
				cStrResul := oRestClient:GetResult()
				AVISO("Dados da opera��o: ", cStrResul, {"Fechar"}, 3)
			EndIf
		EndIf

	ElseIf nOpc == 4 //Delete - Verbo DELETE -----------------------------------------------------|

		// chamada de classe REST cria��o do usu�rio - Verbo DELETE
		oRestClient:setPath(cUrl+cCodUsr)
		// BODY - para DELETE n�o � necessario o preenchimento do body, porem o mesmo tem que ser enviado, mais informa��o ler documenta��o.
		cJSon := ""
		If oRestClient:Put(aHeadStr, cJSon)
			oObjJson   := JsonObject():New()
      oObjJson:FromJson(oRestClient:getResult())
			If oObjJson == Nil
				MsgStop("Ocorreu erro no processamento do Json.")
				Return Nil
			ElseIf oObjJson:HasProperty("errorCode")
				MsgStop("errorCode: " + oObjJson:GetJsonText("errorCode") + " - errorMessage: " + oObjJson:GetJsonText("errorMessage"))
				Return Nil
			Else
				cStrResul := oRestClient:GetResult()
				AVISO("Dados da opera��o: ", cStrResul, {"Fechar"}, 3)
			EndIf
		EndIf

	EndIf

Return
