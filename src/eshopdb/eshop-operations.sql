-- functions for performing eshop operations

-- address functions

--                                                  (country  city     zipcode  addr1    addr2    phone1   phone2 )
CREATE OR REPLACE FUNCTION add_address_get_addressid(varchar, varchar, varchar, varchar, varchar, varchar, varchar) RETURNS INTEGER AS $$
    INSERT INTO Addresses (
        AddressCountry,
        AddressCity,
        AddressZipcode,
        Address1,
        Address2,
        AddressPhone,
        AddressPhone2
    ) VALUES ($1, $2, $3, $4, $5, $6, $7) RETURNING AddressID;
$$ LANGUAGE SQL;

--                                    (country  city     zipcode  addr1    addr2    phone1   phone2 )
CREATE OR REPLACE FUNCTION add_address(varchar, varchar, varchar, varchar, varchar, varchar, varchar) RETURNS void AS $$
    INSERT INTO Addresses (
        AddressCountry,
        AddressCity,
        AddressZipcode,
        Address1,
        Address2,
        AddressPhone,
        AddressPhone2
    ) VALUES ($1, $2, $3, $4, $5, $6, $7);
$$ LANGUAGE SQL;


--                                                             (country  city     zipcode  addr1    addr2    phone1 )
CREATE OR REPLACE FUNCTION add_address_with_addr2_get_addressid(varchar, varchar, varchar, varchar, varchar, varchar) RETURNS INTEGER AS $$
    INSERT INTO Addresses (
        AddressCountry,
        AddressCity,
        AddressZipcode,
        Address1,
        Address2,
        AddressPhone
    ) VALUES ($1, $2, $3, $4, $5, $6) RETURNING AddressID;
$$ LANGUAGE SQL;

--                                               (country  city     zipcode  addr1    addr2    phone1 )
CREATE OR REPLACE FUNCTION add_address_with_addr2(varchar, varchar, varchar, varchar, varchar, varchar) RETURNS void AS $$
    INSERT INTO Addresses (
        AddressCountry,
        AddressCity,
        AddressZipcode,
        Address1,
        Address2,
        AddressPhone
    ) VALUES ($1, $2, $3, $4, $5, $6);
$$ LANGUAGE SQL;

--                                                              (country  city     zipcode  addr1    phone1   phone2 )
CREATE OR REPLACE FUNCTION add_address_with_phone2_get_addressid(varchar, varchar, varchar, varchar, varchar, varchar) RETURNS INTEGER AS $$
    INSERT INTO Addresses (
        AddressCountry,
        AddressCity,
        AddressZipcode,
        Address1,
        AddressPhone,
        AddressPhone2
    ) VALUES ($1, $2, $3, $4, $5, $6) RETURNING AddressID;
$$ LANGUAGE SQL;

--                                                (country  city     zipcode  addr1    phone1   phone2 )
CREATE OR REPLACE FUNCTION add_address_with_phone2(varchar, varchar, varchar, varchar, varchar, varchar) RETURNS void AS $$
    INSERT INTO Addresses (
        AddressCountry,
        AddressCity,
        AddressZipcode,
        Address1,
        AddressPhone,
        AddressPhone2
    ) VALUES ($1, $2, $3, $4, $5, $6);
$$ LANGUAGE SQL;

--                                                          (country  city     zipcode  addr1    phone1)
CREATE OR REPLACE FUNCTION add_address_minimal_get_addressid(varchar, varchar, varchar, varchar, varchar) RETURNS INTEGER AS $$
    INSERT INTO Addresses (
        AddressCountry,
        AddressCity,
        AddressZipcode,
        Address1,
        AddressPhone
    ) VALUES ($1, $2, $3, $4, $5) RETURNING AddressID;
$$ LANGUAGE SQL;

--                                             (country  city     zipcode  addr1    phone1)
CREATE OR REPLACE FUNCTION add_address_minimal(varchar, varchar, varchar, varchar, varchar) RETURNS void AS $$
    INSERT INTO Addresses (
        AddressCountry,
        AddressCity,
        AddressZipcode,
        Address1,
        AddressPhone
    ) VALUES ($1, $2, $3, $4, $5);
$$ LANGUAGE SQL;


CREATE OR REPLACE FUNCTION get_all_addresses() RETURNS SETOF Addresses AS $$
    SELECT * FROM Addresses;
$$ LANGUAGE SQL;

-- user functions

--                                            (nick     email    passwd   fname    lname  )
CREATE OR REPLACE FUNCTION add_user_get_userid(varchar, varchar, varchar, varchar, varchar) RETURNS INTEGER AS $$
    INSERT INTO Users (
        UserNickName,
        UserEmail,
        UserPassword,
        UserFirstName,
        UserLastName
    ) VALUES ($1, $2, $3, $4, $5) RETURNING UserID;
$$ LANGUAGE SQL;

--                                 (nick     email    passwd   fname    lname  )
CREATE OR REPLACE FUNCTION add_user(varchar, varchar, varchar, varchar, varchar) RETURNS void AS $$
    INSERT INTO Users (
        UserNickName,
        UserEmail,
        UserPassword,
        UserFirstName,
        UserLastName
    ) VALUES ($1, $2, $3, $4, $5);
$$ LANGUAGE SQL;

--                                                  (nick     email    passwd   fname    lname  )
CREATE OR REPLACE FUNCTION add_admin_user_get_userid(varchar, varchar, varchar, varchar, varchar) RETURNS INTEGER AS $$
    INSERT INTO Users (
        UserNickName,
        UserEmail,
        UserPassword,
        UserFirstName,
        UserLastName,
        UserIsAdmin
    ) VALUES ($1, $2, $3, $4, $5, TRUE) RETURNING UserID;
$$ LANGUAGE SQL;

--                                       (nick     email    passwd   fname    lname  )
CREATE OR REPLACE FUNCTION add_admin_user(varchar, varchar, varchar, varchar, varchar) RETURNS void AS $$
    INSERT INTO Users (
        UserNickName,
        UserEmail,
        UserPassword,
        UserFirstName,
        UserLastName,
        UserIsAdmin
    ) VALUES ($1, $2, $3, $4, $5, TRUE);
$$ LANGUAGE SQL;

--                                   (nick     passwd )
CREATE OR REPLACE FUNCTION user_login(varchar, varchar) RETURNS INTEGER AS $$
    SELECT UserID FROM Users WHERE UserNickName = $1 AND UserPassword = $2;
$$ LANGUAGE SQL;

--                                   (userid )
CREATE OR REPLACE FUNCTION user_is_admin(integer) RETURNS BOOLEAN AS $$
    SELECT UserIsAdmin FROM Users WHERE UserID = $1;
$$ LANGUAGE SQL;

--                                         (userid   addrid )
CREATE OR REPLACE FUNCTION set_user_address(integer, integer) RETURNS void AS $$
    UPDATE Users
    SET UserAddressID = $2
    WHERE UserID = $1;
$$ LANGUAGE SQL;

--                                        (userid )
CREATE OR REPLACE FUNCTION make_user_admin(integer) RETURNS void AS $$
    UPDATE Users
    SET UserIsAdmin = TRUE
    WHERE UserID = $1;
$$ LANGUAGE SQL;

CREATE OR REPLACE FUNCTION get_all_users() RETURNS SETOF Users AS $$
    SELECT * FROM Users;
$$ LANGUAGE SQL;

-- order functions

--                                                 (userid )
CREATE OR REPLACE FUNCTION create_order_get_orderid(integer) RETURNS INTEGER AS $$
    INSERT INTO Orders (
        OrderUserID
    ) VALUES ($1) RETURNING OrderID;
$$ LANGUAGE SQL;

--                                     (userid )
CREATE OR REPLACE FUNCTION create_order(integer) RETURNS void AS $$
    INSERT INTO Orders (
        OrderUserID
    ) VALUES ($1);
$$ LANGUAGE SQL;

--                                          (orderid  baddrid  saddrid)
CREATE OR REPLACE FUNCTION set_order_address(integer, integer, integer) RETURNS void AS $$
    UPDATE Orders
    SET OrderBillingAddressID = $2, OrderShippingAddressID = $3
    WHERE OrderID = $1;
$$ LANGUAGE SQL;

--                                          (orderid  prodid   prodqty)
CREATE OR REPLACE FUNCTION add_item_to_order(integer, integer, integer) RETURNS void AS $$
    INSERT INTO OrderedProducts (
        OrderID,
        ProductID,
        ProductQuantity
    ) VALUES ($1, $2, $3);
$$ LANGUAGE SQL;

--                                                       (orderid)
CREATE OR REPLACE FUNCTION finalize_order_without_address(integer) RETURNS void AS $$
    UPDATE Orders
    SET OrderIsFinal = TRUE;
$$ LANGUAGE SQL;

--                                       (orderid)
CREATE OR REPLACE FUNCTION finalize_order(integer) RETURNS void AS $$
    UPDATE Orders
    SET OrderIsFinal = TRUE
    WHERE OrderID = $1 AND OrderBillingAddressID IS NOT NULL AND OrderShippingAddressID IS NOT NULL;
$$ LANGUAGE SQL;

CREATE OR REPLACE FUNCTION get_shipped_orders() RETURNS SETOF Orders AS $$
    SELECT * FROM Orders o WHERE o.OrderHasShipped = TRUE AND o.OrderHasArrived = FALSE;
$$ LANGUAGE SQL;

CREATE OR REPLACE FUNCTION get_unshipped_orders() RETURNS SETOF Orders AS $$
    SELECT * FROM Orders o WHERE o.OrderHasShipped = FALSE AND o.OrderHasArrived = FALSE;
$$ LANGUAGE SQL;

CREATE OR REPLACE FUNCTION get_all_orders() RETURNS SETOF Orders AS $$
    SELECT * FROM Orders;
$$ LANGUAGE SQL;

-- product functions

--                                                  (title    price  catID    manufID  desc     vers   wght )
CREATE OR REPLACE FUNCTION add_product_get_productid(varchar, float, integer, integer, varchar, float, float) RETURNS INTEGER AS $$
    INSERT INTO Products (
        ProductTitle,
        ProductPrice,
        ProductCategoryID,
        ProductManufacturerID,
        ProductDescription,
        ProductVersion,
        ProductWeight
    ) VALUES($1, $2, $3, $4, $5, $6, $7) RETURNING ProductID;
$$ LANGUAGE SQL;

--                                    (title    price  catID    manufID  desc     vers   wght )
CREATE OR REPLACE FUNCTION add_product(varchar, float, integer, integer, varchar, float, float) RETURNS void AS $$
    INSERT INTO Products (
        ProductTitle,
        ProductPrice,
        ProductCategoryID,
        ProductManufacturerID,
        ProductDescription,
        ProductVersion,
        ProductWeight
    ) VALUES($1, $2, $3, $4, $5, $6, $7);
$$ LANGUAGE SQL;

--                                                                    (title    price  manufID  desc     vers   wght )
CREATE OR REPLACE FUNCTION add_product_with_manufacturer_get_productid(varchar, float, integer, varchar, float, float) RETURNS INTEGER AS $$
    INSERT INTO Products (
        ProductTitle,
        ProductPrice,
        ProductManufacturerID,
        ProductDescription,
        ProductVersion,
        ProductWeight
    ) VALUES($1, $2, $3, $4, $5, $6) RETURNING ProductID;
$$ LANGUAGE SQL;

--                                                      (title    price  manufID  desc     vers   wght )
CREATE OR REPLACE FUNCTION add_product_with_manufacturer(varchar, float, integer, varchar, float, float) RETURNS void AS $$
    INSERT INTO Products (
        ProductTitle,
        ProductPrice,
        ProductManufacturerID,
        ProductDescription,
        ProductVersion,
        ProductWeight
    ) VALUES($1, $2, $3, $4, $5, $6);
$$ LANGUAGE SQL;

--                                                                (title    price  catID    desc     vers   wght )
CREATE OR REPLACE FUNCTION add_product_with_category_get_productid(varchar, float, integer, varchar, float, float) RETURNS INTEGER AS $$
    INSERT INTO Products (
        ProductTitle,
        ProductPrice,
        ProductCategoryID,
        ProductDescription,
        ProductVersion,
        ProductWeight
    ) VALUES($1, $2, $3, $4, $5, $6) RETURNING ProductID;
$$ LANGUAGE SQL;

--                                                  (title    price  catID    desc     vers   wght )
CREATE OR REPLACE FUNCTION add_product_with_category(varchar, float, integer, varchar, float, float) RETURNS void AS $$
    INSERT INTO Products (
        ProductTitle,
        ProductPrice,
        ProductCategoryID,
        ProductDescription,
        ProductVersion,
        ProductWeight
    ) VALUES($1, $2, $3, $4, $5, $6);
$$ LANGUAGE SQL;

--                                                          (title    price  desc     wght )
CREATE OR REPLACE FUNCTION add_product_minimal_get_productid(varchar, float, varchar, float) RETURNS INTEGER AS $$
    INSERT INTO Products (
        ProductTitle,
        ProductPrice,
        ProductDescription,
        ProductWeight
    ) VALUES($1, $2, $3, $4) RETURNING ProductID;
$$ LANGUAGE SQL;

--                                            (title    price  desc     wght )
CREATE OR REPLACE FUNCTION add_product_minimal(varchar, float, varchar, float) RETURNS void AS $$
    INSERT INTO Products (
        ProductTitle,
        ProductPrice,
        ProductDescription,
        ProductWeight
    ) VALUES($1, $2, $3, $4);
$$ LANGUAGE SQL;

--                                             (prodid  catid   )
CREATE OR REPLACE FUNCTION set_product_category(integer, integer) RETURNS void AS $$
    UPDATE Products
    SET ProductCategoryID = $2
    WHERE ProductID = $1;
$$ LANGUAGE SQL;

--                                                 (prodid   manid  )
CREATE OR REPLACE FUNCTION set_product_manufacturer(integer, integer) RETURNS void AS $$
    UPDATE Products
    SET ProductManufacturerID = $2
    WHERE ProductID = $1;
$$ LANGUAGE SQL;

--                                    (prodid )
CREATE OR REPLACE FUNCTION get_product(integer) RETURNS Products AS $$
    SELECT * FROM Products p WHERE p.ProductID = $1;
$$ LANGUAGE SQL;

CREATE OR REPLACE FUNCTION get_all_products() RETURNS SETOF Products AS $$
    SELECT * FROM Products;
$$ LANGUAGE SQL;

--TODO replace with custom type (e.g. ProductMinimal)
CREATE OR REPLACE FUNCTION get_all_product_titles() RETURNS SETOF VARCHAR AS $$
    SELECT ProductTitle FROM Products;
$$ LANGUAGE SQL;

CREATE OR REPLACE FUNCTION get_all_product_prices() RETURNS SETOF FLOAT AS $$
    SELECT ProductPrice FROM Products;
$$ LANGUAGE SQL;

CREATE OR REPLACE FUNCTION get_all_product_descs() RETURNS SETOF VARCHAR AS $$
    SELECT ProductDescription FROM Products;
$$ LANGUAGE SQL;

CREATE OR REPLACE FUNCTION get_all_product_weights() RETURNS SETOF FLOAT AS $$
    SELECT ProductWeight FROM Products;
$$ LANGUAGE SQL;

CREATE OR REPLACE FUNCTION assign_weight_class_to_empty() RETURNS void AS $$
    UPDATE Products
    SET ProductWeightClass = 5
    WHERE ProductWeight >= 20.0 AND ProductWeightClass = 0;

    UPDATE Products
    SET ProductWeightClass = 4
    WHERE ProductWeight < 20.0 AND ProductWeightClass = 0;

    UPDATE Products
    SET ProductWeightClass = 3
    WHERE ProductWeight < 10.5 AND ProductWeightClass = 0;

    UPDATE Products
    SET ProductWeightClass = 2
    WHERE ProductWeight < 5.5 AND ProductWeightClass = 0;

    UPDATE Products
    SET ProductWeightClass = 1
    WHERE ProductWeight < 1.1 AND ProductWeightClass = 0;
$$ LANGUAGE SQL;

CREATE OR REPLACE FUNCTION assign_weight_class_to_all() RETURNS void AS $$
    UPDATE Products
    SET ProductWeightClass = 5
    WHERE ProductWeight >= 20.0;

    UPDATE Products
    SET ProductWeightClass = 4
    WHERE ProductWeight < 20.0;

    UPDATE Products
    SET ProductWeightClass = 3
    WHERE ProductWeight < 10.5;

    UPDATE Products
    SET ProductWeightClass = 2
    WHERE ProductWeight < 5.5;

    UPDATE Products
    SET ProductWeightClass = 1
    WHERE ProductWeight < 1.1;
$$ LANGUAGE SQL;

-- category functions

--                                                    (name     desc   )
CREATE OR REPLACE FUNCTION add_category_get_categoryid(varchar, varchar) RETURNS INTEGER AS $$
    INSERT INTO Categories (
        CategoryName,
        CategoryDescription
    ) VALUES ($1, $2) RETURNING CategoryID;
$$ LANGUAGE SQL;

--                                     (name     desc   )
CREATE OR REPLACE FUNCTION add_category(varchar, varchar) RETURNS void AS $$
    INSERT INTO Categories (
        CategoryName,
        CategoryDescription
    ) VALUES ($1, $2);
$$ LANGUAGE SQL;


CREATE OR REPLACE FUNCTION get_all_categories() RETURNS SETOF Categories AS $$
    SELECT * FROM Categories;
$$ LANGUAGE SQL;

-- manufacturer functions

--                                                            (name     email  )
CREATE OR REPLACE FUNCTION add_manufacturer_get_manufacturerid(varchar, varchar) RETURNS INTEGER AS $$
    INSERT INTO Manufacturers (
        ManufacturerName,
        ManufacturerEmail
    ) VALUES ($1, $2) RETURNING ManufacturerID;
$$ LANGUAGE SQL;

--                                         (name     email  )
CREATE OR REPLACE FUNCTION add_manufacturer(varchar, varchar) RETURNS void AS $$
    INSERT INTO Manufacturers (
        ManufacturerName,
        ManufacturerEmail
    ) VALUES ($1, $2);
$$ LANGUAGE SQL;

--                                                                         (name     email    addrid )
CREATE OR REPLACE FUNCTION add_manufacturer_with_address_get_manufacturerid(varchar, varchar, integer) RETURNS INTEGER AS $$
    INSERT INTO Manufacturers (
        ManufacturerName,
        ManufacturerEmail,
        ManufacturerAddressID
    ) VALUES ($1, $2, $3) RETURNING ManufacturerID;
$$ LANGUAGE SQL;

--                                                                         (name     email    addrid )
CREATE OR REPLACE FUNCTION add_manufacturer_with_address_get_manufacturerid(varchar, varchar, integer) RETURNS INTEGER AS $$
    INSERT INTO Manufacturers (
        ManufacturerName,
        ManufacturerEmail,
        ManufacturerAddressID
    ) VALUES ($1, $2, $3) RETURNING ManufacturerID;
$$ LANGUAGE SQL;

--                                                      (name     email    addrid )
CREATE OR REPLACE FUNCTION add_manufacturer_with_address(varchar, varchar, integer) RETURNS void AS $$
    INSERT INTO Manufacturers (
        ManufacturerName,
        ManufacturerEmail,
        ManufacturerAddressID
    ) VALUES ($1, $2, $3);
$$ LANGUAGE SQL;

CREATE OR REPLACE FUNCTION get_all_manufacturers() RETURNS SETOF Manufacturers AS $$
    SELECT * FROM Manufacturers;
$$ LANGUAGE SQL;