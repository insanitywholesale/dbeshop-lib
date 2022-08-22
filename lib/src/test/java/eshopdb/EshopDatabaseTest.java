package eshopdb;

import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

class EshopDatabaseTest {
    @Test void constructorWorks() {
		EshopDatabase edb = new EshopDatabase();
	}

	@Test void getAllAddressesTest() {
		EshopDatabase edb = new EshopDatabase();
		edb.addAddressGetAddressID("gr", "ath", "55555", "someplace", "somewhere", "+30 6911222333", "+30 210777888");
		edb.addAddressGetAddressID("gr", "skg", "66666", "someplace", "somewhere", "+30 6911222333", "+30 2310777888");
		var addrs = edb.getAllAddresses();
		for (Address addr: addrs) {
			System.out.println(addr);
		}
	}
}
