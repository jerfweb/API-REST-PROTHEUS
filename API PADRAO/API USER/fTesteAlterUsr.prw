#include 'protheus.ch'

/*/{Protheus.doc} fTestUsr
Fun��o de teste.
@type function
@version 12.1.2310
@author Jerfferson Menezes
@since 22/03/2019
/*/
User Function fJerfTst()
    
    Private	aRet  := {}
    Private aCombo:= {"1=Consulta(GET)","2=Cria��o(POST)","3=Atualiza��o(PUT)","Bloqueio(DELETE)"}

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
    Private cCadastro := "Par�metros"

    aAdd( aPergs ,{1,"Usu�rio",cCodUsr , "@!"   ,'.T.',     ,'.T.',50,.F.}) 
    aAdd( aPergs ,{2,"A��o"	  ,1	   , aCombo  , 70,'.T.',.F.})
    If ParamBox (aPergs, "Usu�rio", @aRet,,,,,,, cLoad, lCanSave, lUserSave)
        Aadd(aRet, {.T.} )
    Else
        lReturn := .F.
    EndIf

Return (lReturn)
