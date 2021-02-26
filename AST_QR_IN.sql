USE [FINN_ADMIFARM]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
/*

EXEC AST_QR_IN 866614


*/


ALTER PROCEDURE [dbo].[AST_QR_IN]( 


	@@AS_ID 	Int
)

AS
BEGIN


SELECT
   VER=1,
   FECHA_COMPROBANTE=CONVERT(VARCHAR(8),Asiento.as_FECHA,112),
   CUIT_EMISOR=(select VALOR from configuracion where aspecto='empresacuit' AND 
					GRUPO ='FAF_'+CAST((select EMPR_ID from CIRCUITOCONTABLE WHERE CC_ID=
					(SELECT CC_ID FROM DocumentoTipoCircuitoContable WHERE DOC_ID=
					((SELECT DOC_ID FROM ASIENTO WHERE AS_ID=@@AS_ID)))) AS VARCHAR(4))),
   TIPO_COMPROBANTE=(select comprt_alias from comprobantetipo where comprobantetipo.COMPRT_ID=
				(select comprt_id from Talonario where talonario.TAL_ID=
				(SELECT tal_id FROM Documentotipotalonario where DOC_ID=asiento.DOC_ID and cf_id=
				(select cf_id from Tercero where tercero.te_id=asiento.TE_ID)))),
	PUNTO_VENTA=(select RIGHT(Talonario.TAL_PREFIJO, 4) from Talonario where talonario.TAL_ID=
				(SELECT tal_id FROM Documentotipotalonario where DOC_ID=asiento.DOC_ID and cf_id=
				(select cf_id from Tercero where tercero.te_id=asiento.TE_ID))),
	NUMERO_COMPROBANTE=RIGHT(ASIENTO.AS_NUMERODOC,8),
					IMPORTE_TOTAL=case ASIENTO.mon_id
								when -1 then ISNULL(ASIENTO.AS_TOTAL,0)
								else ISNULL(ASIENTO.AS_TOTAL,0)/ISNULL(asiento.AS_MonedaCambio,1)
								end,
	MONEDA=(SELECT MON_CODIGOAFIP FROM MONEDA WHERE MONEDA.MON_ID=ASIENTO.MON_ID),
	MONEDA_CTZ=CASE (SELECT MON_CODIGOAFIP FROM MONEDA WHERE MONEDA.MON_ID=ASIENTO.MON_ID)
				WHEN 'PES' THEN 1
				ELSE ISNULL(ASIENTO.AS_MonedaCambio,1)
			END,
	TIPODOC_RC=tercero.te_tipodoc,
	NRODOC_RC=tercero.te_cuit,
	TIPOCODAUT='E',
	CODAUT=ASIENTO.AS_CAI

  
FROM
    Asiento 
	LEFT JOIN Estado ON Asiento.EST_ID = Estado.EST_ID 
	LEFT JOIN CondicionPago ON Asiento.CPG_ID = CondicionPago.CPG_ID
	LEFT JOIN TerceroSucursal ON Asiento.CS_ID = TerceroSucursal.CS_ID
	LEFT JOIN Moneda ON Asiento.MON_ID = Moneda.MON_ID
	LEFT JOIN Vendedor ON Asiento.VEN_ID = Vendedor.VEN_ID
	INNER JOIN DocumentoTipo ON Asiento.DOC_ID = DocumentoTipo.DOC_ID
	INNER JOIN Tercero ON Asiento.TE_id = Tercero.TE_id
	LEFT JOIN CategoriaFiscal ON Tercero.CF_ID = CategoriaFiscal.CF_ID
	LEFT JOIN ComprobanteTipo ON Asiento.COMPRT_ID = ComprobanteTipo.COMPRT_ID
	LEFT JOIN Talonario ON Asiento.TAL_ID = Talonario.TAL_ID
	
WHERE
 Asiento.AS_ID = @@AS_ID  




END














