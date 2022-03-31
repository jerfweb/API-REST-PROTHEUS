#include 'totvs.ch'
#include 'restful.ch'
#include 'protheus.ch'

/*{Protheus.doc} SalesOrder
API de manutenção de pedidos de venda
@type class
@version 1.0
@author Jerfferson Menezes
@since 28/03/2022
*/
WSRESTFUL SalesOrder DESCRIPTION "API para manutenção de pedido de venda" FORMAT APPLICATION_JSON

    WSDATA BranchNumber     AS STRING               //NUMERO DO FILIAL
    WSDATA RequestNumber    AS STRING               //NUMERO DO PEDIDO
    WSDATA IdUser           AS INTEGER OPTIONAL     //ID USUARIO
    WSDATA Login            AS STRING OPTIONAL      //LOGIN
    WSDATA Reason           AS STRING OPTIONAL      //MOTIVO

    WSMETHOD DELETE SalesOrderDeletion DESCRIPTION "Exclusão de pedido de venda utilizando o Execauto MATA410" WSSYNTAX "/SalesOrder?{BranchNumber,RequestNumber,IdUser,Login,Reason}"
    //Exemplo de consumo - /rest/SalesOrder?BranchNumber=01&RequestNumber=QCPFJW&iduser=999&login=jerf&reason=teste

END WSRESTFUL

/*{Protheus.doc} SalesOrderDeletion
Metodo responsavel pela exclusão do pedido de venda
@type method
@version 1.0
@author Jerfferson Menezes
@since 28/03/2022
*/
WSMETHOD DELETE SalesOrderDeletion WSRECEIVE BranchNumber, RequestNumber, IdUser, Login, Reason WSSERVICE SalesOrder

    Local oJson         := JsonObject():new()
    Local aResult       := {}
    Local cQuery        := ""
    Private cMsgErro    := ""
    Private lRet        := .F.

    /*
    Defino que o retorno sera em JSON
    */
    ::SetContentType("application/json")

    /*
    obrigatorio informar o numero da filial e pedido
    */
    If Empty(AllTrim(Self:BranchNumber)) .OR. Empty(Alltrim(Self:RequestNumber))
        SetRestFault(500,EncodeUTF8('Os parametros BranchNumber e RequestNumber são obrigatórios.'))
        lRet    := .F.
    Else
        fExcluirPedido(AllTrim(Self:BranchNumber),Alltrim(Self:RequestNumber),@cMsgErro,@lRet)
        oJson['mensagem'] := EncodeUTF8(cMsgErro)
        If lRet
            ::SetStatus(200)
            ::SetResponse(oJson:ToJson())
        Else
            SetRestFault(401,EncodeUTF8(cMsgErro))
        EndIf
    EndIF

    FreeObj(oJson)

Return lRet

/*{Protheus.doc} fExcluirPedido
Função para exclusão do pedido de venda
@type function
@version 1.0
@author Jerfferson Menezes
@since 28/03/2022
@param cFilial, character, Numero da filial do pedido de venda
@param cNumPedido, character, Numero do pedido de venda
@param cMsgErro, character, Mensagem gerada no processo
@param lRet, logical, Variacel de controle de processo
*/
Static Function fExcluirPedido(cFilPed,cNumPedido,cMsgErro,lRet)

    Local aCabec            := {}
    Local aItens            := {}
    Local aLinha            := {}
    Private lMsErroAuto     := .F.
    Private lAutoErrNoFile  := .F.

    dbSelectArea("SC5")
    dbSetOrder(1)
    dbSeek(cFilPed+cNumPedido)

    aadd(aCabec, {"C5_NUM"    , SC5->C5_NUM     , Nil})
    aadd(aCabec, {"C5_TIPO"   , SC5->C5_TIPO    , Nil})
    aadd(aCabec, {"C5_CLIENTE", SC5->C5_CLIENTE , Nil})
    aadd(aCabec, {"C5_LOJACLI", SC5->C5_LOJACLI , Nil})
    aadd(aCabec, {"C5_LOJAENT", SC5->C5_LOJAENT , Nil})
    aadd(aCabec, {"C5_CONDPAG", SC5->C5_CONDPAG , Nil})

    dbSelectArea("SC6")
    dbSetOrder(1)
    dbSeek(cFilPed+cNumPedido)

    While !EOF() .AND. SC6->C6_FILIAL==SC5->C5_FILIAL .AND. SC6->C6_NUM==SC5->C5_NUM .AND. EMPTY(ALLTRIM(SC5->C5_NOTA))

        //--- Informando os dados do item do Pedido de Venda
        aLinha := {}
        aadd(aLinha,{"C6_ITEM"      , SC6->C6_ITEM      , Nil})
        aadd(aLinha,{"C6_PRODUTO"   , SC6->C6_PRODUTO   , Nil})
        aadd(aLinha,{"C6_QTDVEN"    , SC6->C6_QTDVEN    , Nil})
        aadd(aLinha,{"C6_PRCVEN"    , SC6->C6_PRCVEN    , Nil})
        aadd(aLinha,{"C6_PRUNIT"    , SC6->C6_PRUNIT    , Nil})
        aadd(aLinha,{"C6_VALOR"     , SC6->C6_PRUNIT    , Nil})
        aadd(aLinha,{"C6_TES"       , SC6->C6_TES       , Nil})
        aadd(aItens, aLinha)

        SC6->(dbSkip())

    End

    MSExecAuto({|a, b, c| MATA410(a, b, c)}, aCabec, aItens, 5)

    If !lMsErroAuto
        cMsgErro := "Pedido " + cNumPedido + " excluído com sucesso!"
        lRet := .T.
    Else
        cMsgErro := "Erro na exclusão do pedido " + cNumPedido + CRLF
        cMsgErro += MostraErro()
        lRet := .F.
    EndIf

Return