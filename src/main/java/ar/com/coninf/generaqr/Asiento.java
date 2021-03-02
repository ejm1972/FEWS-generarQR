package ar.com.coninf.generaqr;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;

import lombok.Data;

/**
 * 
 *
 */
@Data
@Entity
public class Asiento {
	
	@Id
	@Column(name = "as_id")
	private Integer asId;
	
	@Column(name = "ast_qr")
	private byte[] astQr;

	public String toString() {
		return "[asId="+asId+", [astQr="+(astQr==null?"null":"(imagen->byte["+astQr.length+"])")+"]";
	}
}
