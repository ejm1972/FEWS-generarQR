package ar.com.coninf.generaqr;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Properties;

import com.google.gson.Gson;
import com.google.gson.JsonSyntaxException;
import com.google.zxing.WriterException;

import lombok.extern.slf4j.Slf4j;

/**
 * 
 *
 */
@Slf4j
public class App {
	
	private static final String FALSE = "false";
	
	public static void main( String[] args ) {
		
		Gson gson = new Gson();
		GeneradorQr gen = new GeneradorQr();
		RespuestaQr resp = null;
		
		Properties prop = cargarProperties();
        if (prop==null) {
        	log.error("Error en la carga de la configuracion");
        	return;
        }
        
		configurarLog(prop);

        for (int i = 0; i < args.length; ++i) {
            log.debug("args[{}]: {}", i, args[i]);
        }
        String json = args[0];
        Integer asId = Integer.valueOf(args[1]);
        
        AsientoRepositorio asientoRepo;
        Map<String, String> map = configurarAccesoDatos(prop);
        if (map.isEmpty()) {
        	log.error("Error cargando configuracion de acceso a datos");
        	return;
        } else {
            asientoRepo = new AsientoRepositorio(map);
        }

		try {
			DatoQr datoQr = gson.fromJson(json, DatoQr.class);
			resp = gen.generar(datoQr);	
			log.debug(resp.getTextoQr());
			
			Asiento asiento = new Asiento();
			asiento.setAsId(asId);
			asiento.setAstQr(resp.getImagenQr());
			asientoRepo.modify(asiento);
			asientoRepo.close();
			log.info("asientoRepo.modify()=" + asiento.toString());
			
		} catch (JsonSyntaxException | IOException | WriterException e) {
			log.error("Error ---->", e);
			asientoRepo.close();
		}
		
	}
	
	private static Properties cargarProperties() {
		Properties prop = null;
		
        try (InputStream input = new FileInputStream("generaQr.properties")) {
            prop = new Properties();
			prop.load(input);
            if (log.isTraceEnabled()) {
	            log.trace(prop.entrySet().toString());
	            for (Entry<Object,Object> key:prop.entrySet()) {
	            	log.trace(prop.get(key.getKey()).toString());
	            }
            }   
	    } catch (IOException e) {
	    	log.warn("Error cargando el archivo de configuracion", e);
	    }
        
        return prop;
	}
     
	
	private static Map<String, String> configurarAccesoDatos(Properties prop) {
		Map<String, String> persistenceMap = new HashMap<>();
		
		persistenceMap.put("javax.persistence.jdbc.url"					, prop.getProperty("javax.persistence.jdbc.url"));
		persistenceMap.put("javax.persistence.jdbc.user"				, prop.getProperty("javax.persistence.jdbc.user"));
		persistenceMap.put("javax.persistence.jdbc.password"			, prop.getProperty("javax.persistence.jdbc.password"));
		persistenceMap.put("javax.persistence.jdbc.driver"				, prop.getProperty("javax.persistence.jdbc.driver"));
		persistenceMap.put("javax.persistence.jdbc.dataSource.schema"	, prop.getProperty("javax.persistence.jdbc.dataSource.schema"));
		persistenceMap.put("javax.persistence.jdbc.dataSource.catalog"	, prop.getProperty("javax.persistence.jdbc.dataSource.catalog"));
		persistenceMap.put("hibernate.show_sql"							, prop.getProperty("hibernate.show_sql",FALSE));
		persistenceMap.put("hibernate.format_sql"						, prop.getProperty("hibernate.format_sql",FALSE));
		persistenceMap.put("hibernate.ddl_auto"							, prop.getProperty("hibernate.ddl_auto",FALSE));
		persistenceMap.put("hibernate.dialect"							, prop.getProperty("hibernate.dialect","org.hibernate.dialect.SQLServerDialect"));

		return persistenceMap;
	}

	private static void configurarLog(Properties prop) {
			
        String logLevel = prop.getProperty("logLevel","info");
        System.setProperty(org.slf4j.impl.SimpleLogger.DEFAULT_LOG_LEVEL_KEY, logLevel);
            
	}
}
