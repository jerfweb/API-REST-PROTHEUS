#include 'protheus.ch'

//-------------------------------------------------------------------
/*/{Protheus.doc} fTestUsr
Função para teste.
@author     Jerfferson Silva
@since      22.03.2019
@version    1.0
/*/
//-------------------------------------------------------------------
User Function fTestUsr()
    
    Private	aRet  := {}
    Private aCombo:= {"1=Consulta(GET)","2=Criação(POST)","3=Atualização(PUT)","Bloqueio(DELETE)"}

    If !ParamInf(@aRet)
        Return
    Else
        If ValType(aRet[2]) == "C"
            U_fAltUsr(aRet[1],Val(aRet[2]))
        Else
            U_fAltUsr(aRet[1],aRet[2])
        EndIf
    Endif

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} ParamInf
Perguntas
@author     Jerfferson Silva
@since      15.03.2019
@return     aRet, Com as respostas
/*/
//-------------------------------------------------------------------
Static Function ParamInf(aRet)

    Local	lReturn   := .T.
    Local   aPergs    := {}
    Local	cSayCEP     := Space(6)
    Local	cLoad	  := "fTestUsr"
    Local   lCanSave  := .T.
    Local   lUserSave := .T.
    Private cCadastro := "Parâmetros"

    aAdd( aPergs ,{1,"Usuário",cSayCEP , "@!"   ,'.T.',     ,'.T.',50,.F.}) 
    aAdd( aPergs ,{2,"Ação"	  ,1	   , aCombo  , 50,'.T.',.F.})
    If ParamBox (aPergs, "Usuário", @aRet,,,,,,, cLoad, lCanSave, lUserSave)
        Aadd(aRet, {.T.} )
    Else
        lReturn := .F.
    EndIf

Return (lReturn)