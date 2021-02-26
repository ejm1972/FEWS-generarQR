package ar.com.coninf.generaqr;

import java.io.IOException;
import java.util.Arrays;

import com.google.gson.Gson;
import com.google.gson.JsonSyntaxException;
import com.google.zxing.WriterException;

import junit.framework.TestCase;

public class GenerarQrTest extends TestCase {
	
    public void testGenerar() {
    	String tmp = ""; //debo tomar el archivo de Test.jpg
		try {
			Gson gson = new Gson();
			GeneradorQr gen = new GeneradorQr();
			RespuestaQr resp = null;

			String json = "{\"ver\":1,\"fecha\":\"20201215\",\"cuit\":23043964399,\"ptoVta\":6,\"tipoCmp\":6,\"nroCmp\":3445,\"importe\":440601,\"moneda\":\"PES\",\"ctz\":100,\"tipoDocRec\":99,\"nroDocRec\":0,\"tipoCodAut\":\"E\",\"codAut\":\"70509985005168\"}";
			DatoQr datoQr = gson.fromJson(json, DatoQr.class);

			resp = gen.generar(datoQr);

			assertEquals("https://www.afip.gob.ar/fe/qr/?p=eyJ2ZXIiOjEsImZlY2hhIjoiMjAyMDEyMTUiLCJjdWl0IjoyMzA0Mzk2NDM5OSwicHRvVnRhIjo2LCJ0aXBvQ21wIjo2LCJucm9DbXAiOjM0NDUsImltcG9ydGUiOjQ0MDYwMSwibW9uZWRhIjoiUEVTIiwiY3R6IjoxMDAsInRpcG9Eb2NSZWMiOjk5LCJucm9Eb2NSZWMiOjAsInRpcG9Db2RBdXQiOiJFIiwiY29kQXV0IjoiNzA1MDk5ODUwMDUxNjgifQ==",resp.getTextoQr());
			//assertEquals(tmp, Arrays.toString(resp.getImagenQr()));
		} catch (JsonSyntaxException | IOException | WriterException e) {
			e.printStackTrace();
			assertTrue( false );
		}
			
    }

}
