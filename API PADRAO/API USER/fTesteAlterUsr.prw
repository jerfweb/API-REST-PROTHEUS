#include 'protheus.ch'

/*/{Protheus.doc} fTestUsr
Função de teste.
@type function
@version 12.1.2310
@author Jerfferson Menezes
@since 22/03/2019
/*/
User Function fJerfTst()
    
    Private	aRet  := {}
    Private aCombo:= {"1=Consulta(GET)","2=Criação(POST)","3=Atualização(PUT)","Bloqueio(DELETE)"}

    If ParamInf(@aRet)
        If ValType(aRet[2]) == "C"
            U_fAltUsr(aRet[1],Val(aRet[2]))
        Else
            U_fAltUsr(aRet[1],aRet[2])
        EndIf
    Endif

Return


/*/{Protheus.doc} ParamInf
Perguntas
@type function
@author Jerfferson Silva
@since  15/03/2019
@return array, Array com as respostas
/*/
Static Function ParamInf(aRet)

    Local	lReturn   := .T.
    Local   aPergs    := {}
    Local	cCodUsr     := Space(6)
    Local	cLoad	  := "fTestUsr"
    Local   lCanSave  := .T.
    Local   lUserSave := .T.
    Private cCadastro := "Parâmetros"

    aAdd( aPergs ,{1,"Usuário",cCodUsr , "@!"   ,'.T.',     ,'.T.',50,.F.}) 
    aAdd( aPergs ,{2,"Ação"	  ,1	   , aCombo  , 70,'.T.',.F.})
    If ParamBox (aPergs, "Usuário", @aRet,,,,,,, cLoad, lCanSave, lUserSave)
        Aadd(aRet, {.T.} )
    Else
        lReturn := .F.
    EndIf

Return (lReturn)
