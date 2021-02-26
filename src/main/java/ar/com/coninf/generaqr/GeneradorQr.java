package ar.com.coninf.generaqr;

import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;

import javax.imageio.ImageIO;

import org.apache.commons.codec.binary.Base64;

import com.google.gson.Gson;
import com.google.zxing.BarcodeFormat;
import com.google.zxing.Writer;
import com.google.zxing.WriterException;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class GeneradorQr {
	
	Gson gson = new Gson();
	
	public RespuestaQr generar(DatoQr datoQr) throws IOException, WriterException {
		
		log.debug("Ejecucion generar()");
		
		// Image properties
		int qrImageWith = 300;
		int qrImageHeight = 300;
		String imageFormat = "JPG";
		String imagePathFile = "c:/tmp/imagen/qrcode.";
		String qrUrl = "https://www.afip.gob.ar/fe/qr/";
		
		String datoQrJson = gson.toJson(datoQr);
		byte[] datoQrJsonByteArray = datoQrJson.getBytes();
		byte[] datoQrJsonBase64 = Base64.encodeBase64(datoQrJsonByteArray);
		String datoQrJsonBase64String = new String(datoQrJsonBase64);
		String textoQr = qrUrl.concat("?p=").concat(datoQrJsonBase64String);
		
		BufferedImage image = crear(textoQr, qrImageWith, qrImageHeight);
		
		// Write the image to a file
		File path = new File("c:/tmp/");
		if (!path.exists()) {
			path.mkdir();
		}
		path = new File("c:/tmp/imagen/");
		if (!path.exists()) {
			path.mkdir();
		}
		FileOutputStream qrFile = null;
		qrFile = new FileOutputStream(imagePathFile.concat(imageFormat));
		ImageIO.write(image, imageFormat, qrFile);
		qrFile.close();
				
		ByteArrayOutputStream baos = new ByteArrayOutputStream();
		ImageIO.write(image, imageFormat, baos );
		baos.flush();
		byte[] imageAsBytes = baos.toByteArray();
		baos.close();
		
		RespuestaQr resp = new RespuestaQr();	
		resp.setImagenQr(imageAsBytes);
		resp.setTextoQr(textoQr);
		
		return resp;
	}
	
	private BufferedImage crear(String datos, int ancho, int altura) throws WriterException {
        BitMatrix matrix;
        Writer escritor = new QRCodeWriter();
        matrix = escritor.encode(datos, BarcodeFormat.QR_CODE, ancho, altura);
        
        BufferedImage imagen = new BufferedImage(ancho, altura, BufferedImage.TYPE_INT_RGB);
        
        for(int y = 0; y < altura; y++) {
            for(int x = 0; x < ancho; x++) {
                int grayValue = (matrix.get(x, y) ? 0 : 1) & 0xff;
                imagen.setRGB(x, y, (grayValue == 0 ? 0 : 0xFFFFFF));
            }
        }
        
        return imagen;        
    }  
}
