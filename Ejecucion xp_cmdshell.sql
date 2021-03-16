
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

	declare @bd_actual varchar(100) = db_name()
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
		
		case when tipodoc_rc <> '' and nrodoc_rc <> '' and tipodoc_rc is not null and nrodoc_rc is not null then
			',"tipoDocRec":'+tipodoc_rc+',"nroDocRec":'+nrodoc_rc
		else 
			''
		end
		
		+',"tipoCodAut":"'+tipocodaut
		+'","codAut":"'+codaut
		+'"'
	FROM [dbo].[AST_QR_IN_TMP]

	declare @sql varchar(8000)
	select @sql = 'd:\FacturaElectronicaAfip\Java\generaQr\ejecutar.bat "{'+@jsonQr+'}" '+@as_id+' '+@bd_actual+' d: \FacturaElectronicaAfip\Java\generaQr'
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
