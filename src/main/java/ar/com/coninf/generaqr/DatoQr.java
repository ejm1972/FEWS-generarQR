package ar.com.coninf.generaqr;

import lombok.Data;

/**
 * 
 *
 */
@Data
public class DatoQr {
	private Integer ver;
	private String fecha;
	private Long cuit;
	private Integer ptoVta;
	private Integer tipoCmp;
	private Long nroCmp;
	private Long importe;
	private String moneda;
	private Long ctz;
	private Integer tipoDocRec;
	private Long nroDocRec;
	private String tipoCodAut;
	private String codAut;
	private Integer asId;
}
