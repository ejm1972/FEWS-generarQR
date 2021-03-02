package ar.com.coninf.generaqr;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.EntityTransaction;
import javax.persistence.Persistence;

import lombok.extern.slf4j.Slf4j;

/**
 * 
 *
 */
@Slf4j
public class AsientoRepositorio {

	static {
		// Elimina el log de hibernate
		System.setProperty("java.util.logging.config.file","");
	}

	private EntityManager manager;
	private EntityManagerFactory factory;
	private String persistenceUnit = "ceresDB";

	public AsientoRepositorio() {
		try {
		factory = Persistence.createEntityManagerFactory(persistenceUnit);
		manager = factory.createEntityManager();
		} catch (Exception e) {
			log.error("Error --->", e);
		}
	}

	public void close() {
		manager.close();
		factory.close();		
	}
	
	public void modify(Asiento asiento) {
		EntityTransaction tx = manager.getTransaction();
		tx.begin();

		try {
			Asiento asientoExistente = manager.find(Asiento.class, asiento.getAsId());
			asientoExistente.setAstQr(asiento.getAstQr());
			manager.persist(asientoExistente);
			tx.commit();
		} catch (Exception e) {
			log.error("Error ---> ",e);
			tx.rollback();
		}

	}

}
