USE [FINN_ADMIFARM]
GO

/****** Object:  StoredProcedure [dbo].[AST_QR_IN]    Script Date: 03/02/2021 08:16:48 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AST_QR_IN]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[AST_QR_IN]
GO

USE [FINN_ADMIFARM]
GO

/****** Object:  StoredProcedure [dbo].[AST_QR_IN]    Script Date: 03/02/2021 08:16:48 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

/*

UPDATE ASIENTO SET AST_QR=NULL WHERE AS_ID=866614
EXEC AST_QR_IN 866614
SELECT AS_ID, AST_QR, * FROM ASIENTO WHERE AS_ID=866614

*/


CREATE PROCEDURE [dbo].[AST_QR_IN](
	@@AS_ID 	Int
)
AS
BEGIN

SELECT
   AS_ID=ASIENTO.AS_ID,
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
	IMPORTE_TOTAL=CAST(CAST(case ASIENTO.mon_id
					when -1 then ISNULL(ASIENTO.AS_TOTAL,0)
					else ISNULL(ASIENTO.AS_TOTAL,0)/ISNULL(asiento.AS_MonedaCambio,1)
					end *100 AS INT) AS VARCHAR(20)),
	MONEDA= (SELECT MON_CODIGOAFIP FROM MONEDA WHERE MONEDA.MON_ID=ASIENTO.MON_ID),
	MONEDA_CTZ=CAST(CAST(CASE (SELECT MON_CODIGOAFIP FROM MONEDA WHERE MONEDA.MON_ID=ASIENTO.MON_ID)
				WHEN 'PES' THEN 1
				ELSE ISNULL(ASIENTO.AS_MonedaCambio,1)
			END *100 AS INT) AS VARCHAR(20)),
	TIPODOC_RC=tercero.te_tipodoc,
	NRODOC_RC=tercero.te_cuit,
	TIPOCODAUT='E',
	CODAUT=ASIENTO.AS_CAI

into #tmp
  
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
	
WHERE Asiento.AS_ID = @@AS_ID  

--INI-GENERAQR----------------------------------------
	declare @bd_actual varchar(100) = db_name()
	declare @jsonQr varchar(8000)
	declare @as_id varchar(20)
	select @as_id=convert(varchar, as_id)
		,@jsonQr = '"ver":'+convert(varchar, ver)
		+',"fecha":"'+fecha_comprobante
		+'","cuit":'+cuit_emisor
		+',"ptoVta":'+punto_venta
		+',"tipoCmp":'+tipo_comprobante
		+',"nroCmp":'+numero_comprobante
		+',"importe":'+importe_total
		+',"moneda":"'+moneda
		+'","ctz":'+moneda_ctz
		
		case when tipodoc_rc <> '' and nrodoc_rc <> '' and tipodoc_rc is not null and nrodoc_rc is not null then
			',"tipoDocRec":'+tipodoc_rc+',"nroDocRec":'+nrodoc_rc
		else 
			''
		end
		
		+',"tipoCodAut":"'+tipocodaut
		+'","codAut":"'+codaut
		+'"'
	from #tmp

	declare @sql varchar(8000)
	select @sql = 'c:\generaQr\ejecutar.bat "{'+@jsonQr+'}" '+@as_id+' '+@bd_actual+' c: \generaQr'
	--select @sql

	exec master..xp_cmdshell @sql
--FIN-GENERAQR----------------------------------------

END

/*

UPDATE ASIENTO SET AST_QR=NULL WHERE AS_ID=866614
EXEC AST_QR_IN 866614
SELECT AS_ID, AST_QR, * FROM ASIENTO WHERE AS_ID=866614

*/
GO


update Asiento
set AST_QR = convert(varbinary, 'ahshshsajsajsajsahshsahsahsahjsajsajsa')
where as_id = 866614