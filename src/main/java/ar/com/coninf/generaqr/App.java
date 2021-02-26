package ar.com.coninf.generaqr;

import java.io.IOException;
import java.util.Arrays;

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

        for (int i = 0; i < args.length; ++i) {
            log.info("args[{}]: {}", i, args[i]);
        }
        
        String json = args[0];
        
		try {
			DatoQr datoQr = gson.fromJson(json, DatoQr.class);
		
			resp = gen.generar(datoQr);
			
			log.info(resp.getTextoQr());
			
		} catch (JsonSyntaxException | IOException | WriterException e) {
			log.error("Error ---->", e);
		}
    
	}
}
