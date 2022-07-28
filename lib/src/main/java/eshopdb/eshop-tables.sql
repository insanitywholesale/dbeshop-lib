--create base tables

CREATE OR REPLACE FUNCTION create_tables() RETURNS void AS $$

    CREATE TABLE if not exists Addresses (
        AddressID SERIAL PRIMARY KEY NOT NULL,
        AddressCountry VARCHAR NOT NULL,
        AddressCity VARCHAR NOT NULL,
        AddressZipcode VARCHAR NOT NULL,
        Address1 VARCHAR NOT NULL,
        Address2 VARCHAR,
        AddressPhone VARCHAR NOT NULL,
        AddressPhone2 VARCHAR
    );

    CREATE TABLE if not exists Users (
        UserID SERIAL PRIMARY KEY NOT NULL,
        UserNickName VARCHAR UNIQUE NOT NULL,
        UserEmail VARCHAR NOT NULL,
        UserPassword VARCHAR NOT NULL,
        UserFirstName VARCHAR NOT NULL,
        UserLastName VARCHAR NOT NULL,
        UserAddressID INTEGER REFERENCES Addresses(AddressID),
        UserIsAdmin BOOLEAN NOT NULL DEFAULT FALSE
    );

    CREATE TABLE if not exists Categories (
        CategoryID SERIAL PRIMARY KEY NOT NULL,
        CategoryName VARCHAR NOT NULL,
        CategoryDescription VARCHAR NOT NULL DEFAULT ''
    );

    CREATE TABLE if not exists Manufacturers (
        ManufacturerID SERIAL PRIMARY KEY NOT NULL,
        ManufacturerName VARCHAR NOT NULL,
        ManufacturerEmail VARCHAR NOT NULL,
        ManufacturerAddressID INTEGER REFERENCES Addresses(AddressID)
    );

    CREATE TABLE if not exists Products (
        --ProductID INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY NOT NULL,
        ProductID SERIAL PRIMARY KEY NOT NULL,
        ProductTitle VARCHAR NOT NULL,
        ProductPrice FLOAT NOT NULL,
        ProductCategoryID INTEGER REFERENCES Categories(CategoryID),
        ProductManufacturerID INTEGER REFERENCES Manufacturers(ManufacturerID),
        ProductDescription VARCHAR NOT NULL DEFAULT '',
        ProductVersion FLOAT NOT NULL DEFAULT 1.0,
        ProductWeight FLOAT NOT NULL DEFAULT 0.0,
        ProductWeightClass SMALLINT,
        ProductOnSale BOOLEAN NOT NULL DEFAULT FALSE
    );

    CREATE TABLE if not exists Orders (
        OrderID SERIAL PRIMARY KEY NOT NULL,
        OrderUserID INTEGER REFERENCES Users(UserID) NOT NULL,
        OrderCost FLOAT NOT NULL DEFAULT 0.0,
        OrderShippingCost FLOAT NOT NULL DEFAULT 5.0,
        OrderTax FLOAT NOT NULL DEFAULT 24.0,
        OrderTotalCost FLOAT NOT NULL DEFAULT 0.0,
        OrderBillingAddressID INTEGER REFERENCES Addresses(AddressID),
        OrderShippingAddressID INTEGER REFERENCES Addresses(AddressID),
        OrderIsFinal BOOLEAN NOT NULL DEFAULT FALSE,
        OrderHasShipped BOOLEAN NOT NULL DEFAULT FALSE,
        OrderHasArrived BOOLEAN NOT NULL DEFAULT FALSE,
        OrderTrackingNumber VARCHAR
    );

    CREATE TABLE if not exists OrderedProducts (
        OrderedProductID SERIAL PRIMARY KEY NOT NULL,
        OrderID INTEGER NOT NULL,
        ProductID INTEGER NOT NULL,
        ProductQuantity INTEGER NOT NULL DEFAULT 1,
        ProductTotalCost FLOAT NOT NULL DEFAULT 0.0,
        Constraint Ordered_OrderID FOREIGN KEY(OrderID) REFERENCES Orders on delete cascade on update cascade,
        Constraint Ordered_ProductID FOREIGN KEY(ProductID) REFERENCES Products on delete cascade on update cascade
    );

$$ LANGUAGE SQL;