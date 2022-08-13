package eshopdb;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class EshopDatabase {

    private String driverClassName = "org.postgresql.Driver";
    private String url = "jdbc:postgresql://localhost:5432/tester";
    private String username = "tester";
    private String passwd = "Apasswd";
    private Connection dbConnection = null;
    private Statement statement = null;
    private final boolean isWindows = System.getProperty("os.name").startsWith("Windows");
    private String[] sqlFileNames = {"eshop-tables.sql", "eshop-audittables.sql", "eshop-audittriggers.sql", "eshop-operations.sql"};

	public EshopDatabase() {
		try {
			//Load database driver
			Class.forName(driverClassName);
		} catch (ClassNotFoundException ex) {
			System.err.println("driver load exception: " + ex);
			return;
		}
		try {
			//Establish connection
			dbConnection = DriverManager.getConnection(url, username, passwd);
			//Make database connection globally available
			statement = dbConnection.createStatement();
		} catch (SQLException ex) {
			System.err.println("Error when trying to connect to database at " + url + ": " + ex);
			return;
		}

		for (String sqlFileName : sqlFileNames) {
			runSQLFromFile(sqlFileName);
			//Sleep as to not spam the database
			try {
				Thread.sleep(1000);
			} catch (InterruptedException ex) {
				System.err.println("Error when sleeping: " + ex);
			}
		}
	}

	private void runSQLFromFile(String fileName) {
		if (fileName.equals("")) {
			return;
		}

		String query;
		try {
			String sql;
			if (isWindows) {
			    sql = ((this.getClass()).getResource(fileName)).getPath().substring(1);
			} else {
			    sql = (this.getClass().getResource("/" + fileName)).getPath();
			}
			Path path = Path.of(sql);
			query = Files.readString(path);
		} catch (NullPointerException ex) {
			System.err.println("Error trying to load " + fileName + ": " + ex);
			return;
		} catch (IOException ex) {
			System.err.println("Error trying to load " + fileName + ": " + ex);
			return;
		}
		try {
			//Create base tables
			statement.execute(query);
		} catch (SQLException ex) {
			System.err.println("Error when running SQL in " + fileName + ": " + ex);
		}
	}

	//--                                                  (country  city     zipcode  addr1    addr2    phone1   phone2 )
	//CREATE OR REPLACE FUNCTION add_address_get_addressid(varchar, varchar, varchar, varchar, varchar, varchar, varchar) RETURNS INTEGER AS $$
	public String addAddressGetAddressID(String country, String city, String zipcode, String address1, String address2, String phone1, String phone2) {
		try {
			ResultSet rs = statement.executeQuery("SELECT add_address_get_addressid("
				+ " '" + country + "',"
				+ " '" + city + "',"
				+ " '" + zipcode + "',"
				+ " '" + address1 + "',"
				+ " '" + address2 + "',"
				+ " '" + phone1 + "',"
				+ " '" + phone2 + "'"
			+ ") as ADDRESSID;");
			while (rs.next()) {
				String aid = rs.getString("ADDRESSID");
				return aid;
			}
		} catch (SQLException ex) {
			System.err.println("Exception when running addAddressGetAddressID: " + ex);
		}
		return "";
    }

	//--                                    (country  city     zipcode  addr1    addr2    phone1   phone2 )
	//CREATE OR REPLACE FUNCTION add_address(varchar, varchar, varchar, varchar, varchar, varchar, varchar) RETURNS void AS $$
	public void addAddress(String country, String city, String zipcode, String address1, String address2, String phone1, String phone2) {
		try {
			ResultSet rs = statement.executeQuery("SELECT add_address("
				+ " '" + country + "',"
				+ " '" + city + "',"
				+ " '" + zipcode + "',"
				+ " '" + address1 + "',"
				+ " '" + address2 + "',"
				+ " '" + phone1 + "',"
				+ " '" + phone2 + "'"
			+ ");");
		} catch (SQLException ex) {
			System.err.println("Exception when running addAddress: " + ex);
		}
    }

	//--                                                             (country  city     zipcode  addr1    addr2    phone1 )
	//CREATE OR REPLACE FUNCTION add_address_with_addr2_get_addressid(varchar, varchar, varchar, varchar, varchar, varchar) RETURNS INTEGER AS $$
	//--                                               (country  city     zipcode  addr1    addr2    phone1 )
	//CREATE OR REPLACE FUNCTION add_address_with_addr2(varchar, varchar, varchar, varchar, varchar, varchar) RETURNS void AS $$
	//--                                                              (country  city     zipcode  addr1    phone1   phone2 )
	//CREATE OR REPLACE FUNCTION add_address_with_phone2_get_addressid(varchar, varchar, varchar, varchar, varchar, varchar) RETURNS INTEGER AS $$
	//--                                                (country  city     zipcode  addr1    phone1   phone2 )
	//CREATE OR REPLACE FUNCTION add_address_with_phone2(varchar, varchar, varchar, varchar, varchar, varchar) RETURNS void AS $$
	//--                                                          (country  city     zipcode  addr1    phone1)
	//CREATE OR REPLACE FUNCTION add_address_minimal_get_addressid(varchar, varchar, varchar, varchar, varchar) RETURNS INTEGER AS $$
	//--                                             (country  city     zipcode  addr1    phone1)
	//CREATE OR REPLACE FUNCTION add_address_minimal(varchar, varchar, varchar, varchar, varchar) RETURNS void AS $$
	//CREATE OR REPLACE FUNCTION get_all_addresses() RETURNS SETOF Addresses AS $$
	//--                                            (nick     email    passwd   fname    lname  )
	//CREATE OR REPLACE FUNCTION add_user_get_userid(varchar, varchar, varchar, varchar, varchar) RETURNS INTEGER AS $$
	//--                                 (nick     email    passwd   fname    lname  )
	//CREATE OR REPLACE FUNCTION add_user(varchar, varchar, varchar, varchar, varchar) RETURNS void AS $$
	//--                                                  (nick     email    passwd   fname    lname  )
	//CREATE OR REPLACE FUNCTION add_admin_user_get_userid(varchar, varchar, varchar, varchar, varchar) RETURNS INTEGER AS $$
	//--                                       (nick     email    passwd   fname    lname  )
	//CREATE OR REPLACE FUNCTION add_admin_user(varchar, varchar, varchar, varchar, varchar) RETURNS void AS $$
	//--                                   (nick     passwd )
	//CREATE OR REPLACE FUNCTION user_login(varchar, varchar) RETURNS INTEGER AS $$
	//--                                   (userid )
	//CREATE OR REPLACE FUNCTION user_is_admin(integer) RETURNS BOOLEAN AS $$
	//--                                         (userid   addrid )
	//CREATE OR REPLACE FUNCTION set_user_address(integer, integer) RETURNS void AS $$
	//--                                        (userid )
	//CREATE OR REPLACE FUNCTION make_user_admin(integer) RETURNS void AS $$
	//
	//CREATE OR REPLACE FUNCTION get_all_users() RETURNS SETOF Users AS $$
	//--                                                 (userid )
	//CREATE OR REPLACE FUNCTION create_order_get_orderid(integer) RETURNS INTEGER AS $$
	//--                                     (userid )
	//CREATE OR REPLACE FUNCTION create_order(integer) RETURNS void AS $$
	//--                                          (orderid  baddrid  saddrid)
	//CREATE OR REPLACE FUNCTION set_order_address(integer, integer, integer) RETURNS void AS $$
	//--                                          (orderid  prodid   prodqty)
	//CREATE OR REPLACE FUNCTION add_item_to_order(integer, integer, integer) RETURNS void AS $$
	//--                                                       (orderid)
	//CREATE OR REPLACE FUNCTION finalize_order_without_address(integer) RETURNS void AS $$
	//--                                       (orderid)
	//CREATE OR REPLACE FUNCTION finalize_order(integer) RETURNS void AS $$
	//CREATE OR REPLACE FUNCTION get_shipped_orders() RETURNS SETOF Orders AS $$
	//CREATE OR REPLACE FUNCTION get_unshipped_orders() RETURNS SETOF Orders AS $$
	//CREATE OR REPLACE FUNCTION get_all_orders() RETURNS SETOF Orders AS $$
	//--                                                  (title    price  catID    manufID  desc     vers   wght )
	//CREATE OR REPLACE FUNCTION add_product_get_productid(varchar, float, integer, integer, varchar, float, float) RETURNS INTEGER AS $$
	//--                                    (title    price  catID    manufID  desc     vers   wght )
	//CREATE OR REPLACE FUNCTION add_product(varchar, float, integer, integer, varchar, float, float) RETURNS void AS $$
	//--                                                                    (title    price  manufID  desc     vers   wght )
	//CREATE OR REPLACE FUNCTION add_product_with_manufacturer_get_productid(varchar, float, integer, varchar, float, float) RETURNS INTEGER AS $$
	//--                                                      (title    price  manufID  desc     vers   wght )
	//CREATE OR REPLACE FUNCTION add_product_with_manufacturer(varchar, float, integer, varchar, float, float) RETURNS void AS $$
	//--                                                                (title    price  catID    desc     vers   wght )
	//CREATE OR REPLACE FUNCTION add_product_with_category_get_productid(varchar, float, integer, varchar, float, float) RETURNS INTEGER AS $$
	//--                                                  (title    price  catID    desc     vers   wght )
	//CREATE OR REPLACE FUNCTION add_product_with_category(varchar, float, integer, varchar, float, float) RETURNS void AS $$
	//--                                                          (title    price  desc     wght )
	//CREATE OR REPLACE FUNCTION add_product_minimal_get_productid(varchar, float, varchar, float) RETURNS INTEGER AS $$
	//--                                            (title    price  desc     wght )
	//CREATE OR REPLACE FUNCTION add_product_minimal(varchar, float, varchar, float) RETURNS void AS $$
	//--                                             (prodid  catid   )
	//CREATE OR REPLACE FUNCTION set_product_category(integer, integer) RETURNS void AS $$
	//--                                                 (prodid   manid  )
	//CREATE OR REPLACE FUNCTION set_product_manufacturer(integer, integer) RETURNS void AS $$
	//--                                    (prodid )
	//CREATE OR REPLACE FUNCTION get_product(integer) RETURNS Products AS $$
	//CREATE OR REPLACE FUNCTION get_all_products() RETURNS SETOF Products AS $$
	//--TODO replace with custom type (e.g. ProductMinimal)
	//CREATE OR REPLACE FUNCTION get_all_product_titles() RETURNS SETOF VARCHAR AS $$
	//CREATE OR REPLACE FUNCTION get_all_product_prices() RETURNS SETOF FLOAT AS $$
	//CREATE OR REPLACE FUNCTION get_all_product_descs() RETURNS SETOF VARCHAR AS $$
	//CREATE OR REPLACE FUNCTION get_all_product_weights() RETURNS SETOF FLOAT AS $$
	//CREATE OR REPLACE FUNCTION assign_weight_class_to_empty() RETURNS void AS $$
	//CREATE OR REPLACE FUNCTION assign_weight_class_to_all() RETURNS void AS $$
	//--                                                    (name     desc   )
	//CREATE OR REPLACE FUNCTION add_category_get_categoryid(varchar, varchar) RETURNS INTEGER AS $$
	//--                                     (name     desc   )
	//CREATE OR REPLACE FUNCTION add_category(varchar, varchar) RETURNS void AS $$
	//CREATE OR REPLACE FUNCTION get_all_categories() RETURNS SETOF Categories AS $$
	//--                                                            (name     email  )
	//CREATE OR REPLACE FUNCTION add_manufacturer_get_manufacturerid(varchar, varchar) RETURNS INTEGER AS $$
	//--                                         (name     email  )
	//CREATE OR REPLACE FUNCTION add_manufacturer(varchar, varchar) RETURNS void AS $$
	//--                                                                         (name     email    addrid )
	//CREATE OR REPLACE FUNCTION add_manufacturer_with_address_get_manufacturerid(varchar, varchar, integer) RETURNS INTEGER AS $$
	//--                                                                         (name     email    addrid )
	//CREATE OR REPLACE FUNCTION add_manufacturer_with_address_get_manufacturerid(varchar, varchar, integer) RETURNS INTEGER AS $$
	//--                                                      (name     email    addrid )
	//CREATE OR REPLACE FUNCTION add_manufacturer_with_address(varchar, varchar, integer) RETURNS void AS $$
	//CREATE OR REPLACE FUNCTION get_all_manufacturers() RETURNS SETOF Manufacturers AS $$

}
