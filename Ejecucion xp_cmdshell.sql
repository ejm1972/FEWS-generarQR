
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

declare @sql varchar(8000)
select @sql = 'd:\FacturaElectronicaAfip\Java\generaQr\ejecutar.bat "{"ver":1,"fecha":"20201215","cuit":23043964399,"ptoVta":6,"tipoCmp":6,"nroCmp":3445,"importe":440601,"moneda":"PES","ctz":100,"tipoDocRec":99,"nroDocRec":0,"tipoCodAut":"E","codAut":"70509985005168"}"'
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
