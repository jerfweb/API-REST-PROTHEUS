#include 'protheus.ch'

/*/{Protheus.doc} fAltUsr
Função para realizar alterações dos cadastro de usuários, utilizando a API Rest serviço /Users padrão do Protheus.
@author     Jerfferson Silva
@since      13.03.2019
/*/
User Function fAltUsr(cCodUsr,nOpc)

  Local oRestClient := Nil
  Local cUrl			  := "/rest/users/"
  Local cGetParams	:= ""
  Local nTimeOut		:= 200
  Local aHeadStr		:= {"Content-Type: application/json"}
  Local cHeaderGet	:= ""
  Local cJSon 		  := ""
  Local oObjJson		:= Nil
  Local cStrResul		:= ""
  
  If nOpc == Nil .OR. Empty(nOpc)
      nOpc := 1
  EndIf

  //Verifica se o parametro existe. Se não existir cria.
	If !ExisteSX6( "MV_XSRVREST" )
		CriarSX6( "MV_XSRVREST", "C", "Endereço e porta do servidor REST Protheus. Ex: http://10.201.0.14:8182", "http://10.201.0.14:8182" )
	EndIf

  oRestClient := FWRest():New(AllTrim(GetMv("MV_XSRVREST")))

  If nOpc == 1 //Consulta - Verbo GET -----------------------------------------------------|
    
    If Empty(AllTrim(cCodUsr))
      cCodUsr := "000000"
    EndIf
    // chamada de classe REST com retorno de dados do usuário - Verbo GET
    oRestClient:setPath(cUrl+cCodUsr)
    If oRestClient:Get(aHeadStr)
      If !FWJsonDeserialize(oRestClient:GetResult(),@oObjJson)
        MsgStop("Ocorreu erro no processamento do Json.")
        Return Nil
      ElseIf AttIsMemberOf(oObjJson,"errorCode")
        MsgStop("errorCode: " + DecodeUTF8(oObjJson:errorCode) + " - errorMessage: " + DecodeUTF8(oObjJson:errorMessage))
        Return Nil
      Else
        cStrResul := oRestClient:GetResult()
        AVISO("Dados da operação: ", cStrResul, {"Fechar"}, 3)
      EndIf
    Else
      cStrResul := oRestClient:GetLastError()
      AVISO("Dados da operação: ", cStrResul, {"Fechar"}, 3)
    EndIf

  ElseIf nOpc == 2 //Create - Verbo POST -----------------------------------------------------|
    
    // chamada da classe exemplo de REST para operações CRUD
    oRestClient:setPath(cUrl)

    // chamada de classe REST criação do usuário - Verbo POST
    // BODY - estrutura basica para criação de usuário, mais informação ler documentação.
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

    // define o conteúdo do body
    oRestClient:SetPostParams(cJSon)

    If oRestClient:Post(aHeadStr)
      If !FWJsonDeserialize(oRestClient:GetResult(),@oObjJson)
        MsgStop("Ocorreu erro no processamento do Json.")
        Return Nil
      ElseIf AttIsMemberOf(oObjJson,"errorCode")
        MsgStop("errorCode: " + DecodeUTF8(oObjJson:errorCode) + " - errorMessage: " + DecodeUTF8(oObjJson:errorMessage))
        Return Nil
      Else
        cStrResul := oRestClient:GetResult()
        AVISO("Dados da operação: ", cStrResul, {"Fechar"}, 3)
      EndIf
    EndIf

  ElseIf nOpc == 3 //Update - Verbo PUT -----------------------------------------------------|

    If Empty(AllTrim(cCodUsr))
      cCodUsr := "0000001"
    EndIf

    // chamada de classe REST criação do usuário - Verbo PUT
    oRestClient:setPath(cUrl+cCodUsr)
    // BODY - estrutura basica para update de usuário, mais informação ler documentação.
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

    // para os métodos PUT o conteúdo body é enviado por parametro.
    // PUT
    If oRestClient:Put(aHeadStr, cJSon)
      If !FWJsonDeserialize(oRestClient:GetResult(),@oObjJson)
        MsgStop("Ocorreu erro no processamento do Json.")
        Return Nil
      ElseIf AttIsMemberOf(oObjJson,"errorCode")
        MsgStop("errorCode: " + DecodeUTF8(oObjJson:errorCode) + " - errorMessage: " + DecodeUTF8(oObjJson:errorMessage))
        Return Nil
      Else
        cStrResul := oRestClient:GetResult()
        AVISO("Dados da operação: ", cStrResul, {"Fechar"}, 3)
      EndIf
    EndIf

  ElseIf nOpc == 4 //Delete - Verbo DELETE -----------------------------------------------------|
    
    If Empty(AllTrim(cCodUsr))
      cCodUsr := "0000001"
    EndIf

    // chamada de classe REST criação do usuário - Verbo DELETE
    oRestClient:setPath(cUrl+cCodUsr)
    // BODY - para DELETE não é necessario o preenchimento do body, porem o mesmo tem que ser enviado, mais informação ler documentação.
    cJSon := ""
    If oRestClient:Put(aHeadStr, cJSon)
      If !FWJsonDeserialize(oRestClient:GetResult(),@oObjJson)
        MsgStop("Ocorreu erro no processamento do Json.")
        Return Nil
      ElseIf AttIsMemberOf(oObjJson,"errorCode")
        MsgStop("errorCode: " + DecodeUTF8(oObjJson:errorCode) + " - errorMessage: " + DecodeUTF8(oObjJson:errorMessage))
        Return Nil
      Else
        cStrResul := oRestClient:GetResult()
        AVISO("Dados da operação: ", cStrResul, {"Fechar"}, 3)
      EndIf
    EndIf

  EndIf

Return