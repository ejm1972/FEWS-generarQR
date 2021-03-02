USE [FINN_Admifarm]
GO

/****** Object:  Table [dbo].[Asiento]    Script Date: 01/03/2021 0:08:20 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Asiento]') AND type in (N'U'))
DROP TABLE [dbo].[Asiento]
GO

/****** Object:  Table [dbo].[Asiento]    Script Date: 01/03/2021 0:08:20 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Asiento](
	[AS_ID] [int] NOT NULL,
	[EST_ID] [int] NULL,
	[CUE_ID_Aux] [int] NULL,
	[ZON_ID] [int] NULL,
	[CSTV_ID] [int] NULL,
	[LP_id] [int] NULL,
	[PROV_ID_Origen] [int] NULL,
	[AS_Orden] [int] NULL,
	[MON_ID] [int] NULL,
	[VEN_ID] [int] NULL,
	[CS_ID] [int] NULL,
	[AST_id] [int] NULL,
	[DOC_ID] [int] NULL,
	[AS_Bruto] [money] NULL,
	[AS_Activo] [smallint] NULL,
	[AS_Descrip] [varchar](600) NULL,
	[AS_FueImpreso] [int] NULL,
	[AS_Fecha] [datetime] NULL,
	[AS_FechaLibroIva] [datetime] NULL,
	[AS_FechaComprobante] [datetime] NULL,
	[AS_ImporteIva] [money] NULL,
	[AS_ImporteIvaNi] [money] NULL,
	[AS_NoGravado] [money] NULL,
	[AS_Numero] [varchar](10) NULL,
	[AS_NumeroDoc] [varchar](16) NULL,
	[AS_PorcIva] [real] NULL,
	[AS_PorcIvaNi] [real] NULL,
	[AS_SinIva] [money] NULL,
	[AS_Total] [money] NULL,
	[CPG_ID] [int] NULL,
	[AS_Firma] [varchar](50) NULL,
	[LUpdate] [datetime] NULL,
	[TE_id] [int] NULL,
	[US_ID] [int] NULL,
	[AS_Anulado] [int] NULL,
	[COB_ID] [int] NULL,
	[US_ID_Firmante] [int] NULL,
	[AS_DocTercero] [varchar](22) NULL,
	[AS_ListaAVincular] [varchar](2000) NULL,
	[AS_MonedaCambio] [money] NULL,
	[AS_EdicionInterna] [int] NULL,
	[AS_FechaFollowUp] [datetime] NULL,
	[AS_DescripFollowUp] [varchar](255) NULL,
	[US_ID_FollowUp] [int] NULL,
	[PROV_ID_Destino] [int] NULL,
	[AS_PorcDescuentoCondPago] [real] NULL,
	[AS_PorcDescuentoGlobal] [real] NULL,
	[AS_Control2] [smallint] NULL,
	[AS_Control1] [smallint] NULL,
	[AS_CashFlowFecha] [datetime] NULL,
	[AS_CashFlowSuspendido] [smallint] NULL,
	[OC_PedidoVenta] [varchar](500) NULL,
	[REC_EstadoPorte] [int] NULL,
	[PEV_ID_NoUsar] [int] NULL,
	[OC_DESC] [decimal](10, 4) NULL,
	[CPORTE] [int] NULL,
	[CPEStado] [int] NULL,
	[CP_EStado] [int] NULL,
	[est_porte] [int] NULL,
	[Co_Pev_id] [int] NULL,
	[AS_MonedaReferenciaCambio] [real] NULL,
	[TE_ID_Corredor] [int] NULL,
	[CSTV_ID_Labor] [int] NULL,
	[CSTV_ID_Pastura] [int] NULL,
	[CSTV_ID_Hacienda] [int] NULL,
	[as_numerodocaux] [varchar](13) NULL,
	[AS_ID_Aplicacion] [int] NULL,
	[AS_LotePago] [varchar](20) NULL,
	[TAL_ID] [int] NULL,
	[AS_CAI] [varchar](50) NULL,
	[AS_CAIFechaVto] [datetime] NULL,
	[AS_CAIOK] [smallint] NULL,
	[AS_CAICodigo] [int] NULL,
	[AS_PorcDescuentoGlobal2] [real] NULL,
	[AS_PorcAux] [numeric](14, 4) NULL,
	[dfdfdfdfd] [varchar](500) NULL,
	[dfdfdfd] [varchar](500) NULL,
	[IVA] [varchar](500) NULL,
	[LAST_PU_ID] [int] NULL,
	[AS_CotizacionOriginal] [smallint] NULL,
	[AMR_ID] [int] NULL,
	[Test] [varchar](500) NULL,
	[TestContableTexto] [varchar](500) NULL,
	[TestGestionEnum] [varchar](500) NULL,
	[TestOtroSQL] [int] NULL,
	[AS_Pureb] [datetime] NULL,
	[TestHelper] [int] NULL,
	[TestGeneral] [int] NULL,
	[AS_PruebaPorc] [int] NULL,
	[AS_CA_Texto] [varchar](500) NULL,
	[AS_CA_Lista] [int] NULL,
	[TestContableNro] [decimal](10, 4) NULL,
	[TestContableSQL] [int] NULL,
	[AS_PruebaAdicional] [varchar](500) NULL,
	[AS_ID_CambioMoneda] [int] NULL,
	[AS_PruebaAdicional1] [varchar](200) NULL,
	[COMPRT_ID] [int] NULL,
	[AS_PruebaHelp] [int] NULL,
	[AS_AdicionalTest] [int] NULL,
	[AS_TestFactAdicional] [int] NULL,
	[AS_TestDeHelper] [int] NULL,
	[AS_MonedaReferenciaCambioEditada] [smallint] NULL,
	[LU_ID] [int] NULL,
	[AS_CodDestinacion] [varchar](10) NULL,
	[AS_FechaAux] [datetime] NULL,
	[TECONT_ID] [int] NULL,
	[AS_ControlaCAI] [smallint] NULL,
	[AS_DocHasta] [varchar](13) NULL,
	[wp_pp_alias] [varchar](500) NULL,
	[wp_pp_orden] [varchar](500) NULL,
	[wp_patologia_obs] [varchar](500) NULL,
	[wp_medpre_matr] [varchar](500) NULL,
	[wp_medpre_nombre] [varchar](500) NULL,
	[WP_id] [decimal](14, 4) NULL,
	[wp_patologia_id] [decimal](14, 4) NULL,
	[wp_plan_id] [decimal](14, 4) NULL,
	[LExportadoRG2758] [datetime] NULL,
	[USR_Vta_Incoterm] [varchar](500) NULL,
	[Gestion] [smallint] NULL,
	[Gestionado] [smallint] NULL,
	[FecAut] [datetime] NULL,
	[AS_EnviadoXMail] [smallint] NULL,
	[Beneficiario] [varchar](255) NULL,
	[NI_ID_Firma] [int] NULL,
	[pw_proveedor] [int] NULL,
	[pw_fecEntrega] [datetime] NULL,
	[AS_CAECodigoBarras] [varchar](100) NULL,
	[AS_IDAfip] [decimal](16, 0) NULL,
	[usr_orden] [decimal](14, 4) NULL,
	[AS_FechaFinServicio] [datetime] NULL,
	[AS_FechaInicioServicio] [datetime] NULL,
	[TC_id] [int] NULL,
	[SR_Lote] [varchar](500) NULL,
	[sr_motivoRechazo] [varchar](500) NULL,
	[AS_EsTituloGratuito] [int] NULL,
	[TO_ID] [int] NULL,
	[USR_Vta_TipoExpo] [int] NULL,
	[ast_PideCAE] [smallint] NULL,
	[ast_fechaacreditacionpago] [datetime] NULL,
	[eaut_estado] [int] NULL,
	[eaut_us_id_firmante] [int] NULL,
	[ast_capitas] [decimal](14, 4) NULL,
	[ast_ImpCap] [decimal](14, 4) NULL,
	[ast_FCap] [smallint] NULL,
	[ast_Ajuste] [smallint] NULL,
	[ast_txtCap] [varchar](500) NULL,
	[AST_FECREC] [datetime] NULL,
	[BG_Lote] [varchar](500) NULL,
	[USR_OP_LIBERADA] [int] NULL,
	[AST_QR] [varbinary](max) NULL,
 CONSTRAINT [PKAsiento] PRIMARY KEY CLUSTERED 
(
	[AS_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

INSERT INTO ASIENTO (AS_ID) VALUES (866614)
GO

USE [FINN_ADMIFARM]
GO

/****** Object:  Table [dbo].[AST_QR_IN_TMP]    Script Date: 02/28/2021 23:46:58 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AST_QR_IN_TMP]') AND type in (N'U'))
DROP TABLE [dbo].[AST_QR_IN_TMP]
GO

USE [FINN_ADMIFARM]
GO

/****** Object:  Table [dbo].[AST_QR_IN_TMP]    Script Date: 02/28/2021 23:46:58 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[AST_QR_IN_TMP](
	[AS_ID] [int] NULL,
	[VER] [int] NULL,
	[FECHA_COMPROBANTE] [varchar](8) NULL,
	[CUIT_EMISOR] [varchar](255) NULL
) ON [PRIMARY]
SET ANSI_PADDING OFF
ALTER TABLE [dbo].[AST_QR_IN_TMP] ADD [TIPO_COMPROBANTE] [varchar](50) NULL
SET ANSI_PADDING ON
ALTER TABLE [dbo].[AST_QR_IN_TMP] ADD [PUNTO_VENTA] [varchar](4) NULL
ALTER TABLE [dbo].[AST_QR_IN_TMP] ADD [NUMERO_COMPROBANTE] [varchar](8) NULL
ALTER TABLE [dbo].[AST_QR_IN_TMP] ADD [IMPORTE_TOTAL] [varchar](20) NULL
ALTER TABLE [dbo].[AST_QR_IN_TMP] ADD [MONEDA] [varchar](3) NULL
ALTER TABLE [dbo].[AST_QR_IN_TMP] ADD [MONEDA_CTZ] [varchar](20) NOT NULL
ALTER TABLE [dbo].[AST_QR_IN_TMP] ADD [TIPODOC_RC] [varchar](10) NULL
ALTER TABLE [dbo].[AST_QR_IN_TMP] ADD [NRODOC_RC] [varchar](12) NULL
ALTER TABLE [dbo].[AST_QR_IN_TMP] ADD [TIPOCODAUT] [varchar](1) NOT NULL
ALTER TABLE [dbo].[AST_QR_IN_TMP] ADD [CODAUT] [varchar](50) NULL
GO

SET ANSI_PADDING OFF
GO

USE [FINN_ADMIFARM]
GO

INSERT [dbo].[AST_QR_IN_TMP] ( 
VER,	FECHA_COMPROBANTE,	CUIT_EMISOR,	TIPO_COMPROBANTE,	PUNTO_VENTA,	NUMERO_COMPROBANTE,	IMPORTE_TOTAL,	MONEDA,	MONEDA_CTZ,	TIPODOC_RC,	NRODOC_RC,		TIPOCODAUT,	CODAUT,           AS_ID ) VALUES (
1,		'20210208',			'30712386734',	'01',				'0023',			'00000094',			'4174500',		'PES',	'100',		'80',		'30715468340',	'E',		'71064452970189', 866614 )

USE [FINN_ADMIFARM]
GO

/****** Object:  StoredProcedure [dbo].[AST_QR_IN]    Script Date: 03/01/2021 00:01:30 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AST_QR_IN]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[AST_QR_IN]
GO

USE [FINN_ADMIFARM]
GO

/****** Object:  StoredProcedure [dbo].[AST_QR_IN]    Script Date: 03/01/2021 00:01:30 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

/*

EXEC AST_QR_IN 866614

*/


CREATE PROCEDURE [dbo].[AST_QR_IN] (
	@@AS_ID 	Int
)
AS
BEGIN
	
	SELECT *
	INTO #tmp
	FROM [dbo].[AST_QR_IN_TMP]
	
	declare @jsonQr varchar(8000)
	declare @as_id varchar(20)
	SELECT @as_id=convert(varchar, as_id)
		,@jsonQr = '"ver":'+convert(varchar, ver)
		+',"fecha":"'+fecha_comprobante
		+'","cuit":'+cuit_emisor
		+',"ptoVta":'+punto_venta
		+',"tipoCmp":'+tipo_comprobante
		+',"nroCmp":'+numero_comprobante
		+',"importe":'+importe_total
		+',"moneda":"'+moneda
		+'","ctz":'+moneda_ctz
		+',"tipoDocRec":'+tipodoc_rc
		+',"nroDocRec":'+nrodoc_rc
		+',"tipoCodAut":"'+tipocodaut
		+'","codAut":"'+codaut
		+'"'
	FROM [dbo].[AST_QR_IN_TMP]

	declare @sql varchar(8000)
	select @sql = 'd:\FacturaElectronicaAfip\Java\generaQr\ejecutar.bat "{'+@jsonQr+'}" '+@as_id+' d: \FacturaElectronicaAfip\Java\generaQr'
	select @sql

	exec master..xp_cmdshell @sql

	select AS_ID, AST_QR
	from asiento

END
GO

EXEC AST_QR_IN 866614
