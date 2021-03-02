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
	
	public static void main( String[] args ) {
		
		Gson gson = new Gson();
		GeneradorQr gen = new GeneradorQr();
		RespuestaQr resp = null;
		
		configLog();

        for (int i = 0; i < args.length; ++i) {
            log.debug("args[{}]: {}", i, args[i]);
        }
        String json = args[0];
        
        AsientoRepositorio asientoRepo;
        Map<String, String> map = config();
        if (map.isEmpty()) {
            asientoRepo = new AsientoRepositorio();        	
        } else {
            asientoRepo = new AsientoRepositorio(map);
        }

		try {
			DatoQr datoQr = gson.fromJson(json, DatoQr.class);
			resp = gen.generar(datoQr);	
			log.debug(resp.getTextoQr());
			
			Asiento asiento = new Asiento();
			asiento.setAsId(datoQr.getAsId());
			asiento.setAstQr(resp.getImagenQr());
			asientoRepo.modify(asiento);
			asientoRepo.close();
			log.debug("asientoRepo.modify()=" + asiento.toString());		
		} catch (JsonSyntaxException | IOException | WriterException e) {
			log.error("Error ---->", e);
			asientoRepo.close();
		}
		
	}
	
	private static Map<String, String> config() {
		Map<String, String> persistenceMap = new HashMap<>();
		
        try (InputStream input = new FileInputStream("generaQr.properties")) {
            Properties prop = new Properties();
            prop.load(input);
            if (log.isTraceEnabled()) {
	            log.trace(prop.entrySet().toString());
	            for (Entry<Object,Object> key:prop.entrySet()) {
	            	log.trace(prop.get(key.getKey()).toString());
	            }
            }
			
			persistenceMap.put("javax.persistence.jdbc.url"					, prop.getProperty("javax.persistence.jdbc.url"));
			persistenceMap.put("javax.persistence.jdbc.user"				, prop.getProperty("javax.persistence.jdbc.user"));
			persistenceMap.put("javax.persistence.jdbc.password"			, prop.getProperty("javax.persistence.jdbc.password"));
			persistenceMap.put("javax.persistence.jdbc.driver"				, prop.getProperty("javax.persistence.jdbc.driver"));
			persistenceMap.put("javax.persistence.jdbc.dataSource.schema"	, prop.getProperty("javax.persistence.jdbc.dataSource.schema"));
			persistenceMap.put("javax.persistence.jdbc.dataSource.catalog"	, prop.getProperty("javax.persistence.jdbc.dataSource.catalog"));
			persistenceMap.put("hibernate.show_sql"							, prop.getProperty("hibernate.show_sql","false"));
			persistenceMap.put("hibernate.format_sql"						, prop.getProperty("hibernate.format_sql","false"));
			persistenceMap.put("hibernate.ddl_auto"							, prop.getProperty("hibernate.ddl_auto","false"));
			persistenceMap.put("hibernate.dialect"							, prop.getProperty("hibernate.dialect","org.hibernate.dialect.SQLServerDialect"));
            
        } catch (IOException e) {
        	log.warn("Error ---->", e.getMessage());
        }

		return persistenceMap;
	}

	private static void configLog() {
			
        try (InputStream input = new FileInputStream("generaQr.properties")) {
            Properties prop = new Properties();
            prop.load(input);
            if (log.isTraceEnabled()) {
	            log.trace(prop.entrySet().toString());
	            for (Entry<Object,Object> key:prop.entrySet()) {
	            	log.trace(prop.get(key.getKey()).toString());
	            }
            }
			
            String logLevel = prop.getProperty("logLevel","info");
            System.setProperty(org.slf4j.impl.SimpleLogger.DEFAULT_LOG_LEVEL_KEY, logLevel);
            
		} catch (IOException e) {
        	log.warn("Error ---->", e.getMessage());
        }
	}
}
