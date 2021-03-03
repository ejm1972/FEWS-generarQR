
-- To allow advanced options to be changed.  
EXECUTE sp_configure 'show advanced options', 1;  
GO
-- To update the currently configured value for advanced options.  
RECONFIGURE;  
GO
-- To enable the feature.  
EXECUTE sp_configure 'xp_cmdshell', 1;  
GO
-- To update the currently configured value for this feature.  
RECONFIGURE;  
GO

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
	select @sql = 'd:\FacturaElectronicaAfip\Java\generaQr\ejecutar.bat "{'+@jsonQr+'}" '+@as_id+' CERES_DB d: \FacturaElectronicaAfip\Java\generaQr'
	select @sql

	exec master..xp_cmdshell @sql

-- To enable the feature.  
EXECUTE sp_configure 'xp_cmdshell', 0;  
GO
-- To update the currently configured value for advanced options.  
RECONFIGURE;  
GO
-- To allow advanced options to be changed.  
EXECUTE sp_configure 'show advanced options', 0;  
GO
-- To update the currently configured value for this feature.  
RECONFIGURE;  
GO
