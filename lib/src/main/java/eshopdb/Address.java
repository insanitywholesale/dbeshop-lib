package eshopdb;

public class Address {
	private int id;
	private String country;
	private String zipcode;
	private String address1;
	private String address2;
	private String phone1;
	private String phone2;

	public Address() {
	}

	public Address(int id, String country, String zipcode, String address1, String address2, String phone1, String phone2) {
		this.id = id;
		this.country = country;
		this.zipcode = zipcode;
		this.address1 = address1;
		this.address2 = address2;
		this.phone1 = phone1;
		this.phone2 = phone2;
	}

	@Override
	public String toString() {
		return "Address: {\n\t" + "id: " + id + "\n\t" + "country: " + country + "\n\t" + "zipcode: " + zipcode + "\n\t" + "address1: " + address1 + "\n\t" + "address2: " + address2 + "\n\t" + "phone1: " + phone1 + "\n\t" + "phone2: " + phone2 + "\n}";
	}
}
