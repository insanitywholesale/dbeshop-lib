-- create triggers for audit tables

CREATE OR REPLACE FUNCTION process_order_audit() RETURNS TRIGGER AS $$
    BEGIN
        IF (TG_OP = 'DELETE') THEN
            INSERT INTO OrderAudit SELECT 'D', now(), user, OLD.*;
            RETURN OLD;
        ELSEIF (TG_OP = 'UPDATE') THEN
            INSERT INTO OrderAudit SELECT 'U', now(), user, NEW.*;
            RETURN NEW;
        ELSEIF (TG_OP = 'INSERT') THEN
            INSERT INTO OrderAudit SELECT 'I', now(), user, NEW.*;
            RETURN NEW;
        END IF;
        RETURN NULL;
    END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER order_audit
AFTER INSERT OR UPDATE OR DELETE ON Orders
FOR EACH ROW EXECUTE PROCEDURE process_order_audit();

CREATE OR REPLACE FUNCTION process_user_audit() RETURNS TRIGGER AS $$
    BEGIN
        IF (TG_OP = 'DELETE') THEN
            INSERT INTO UserAudit SELECT 'D', now(), user, OLD.*;
            RETURN OLD;
        ELSEIF (TG_OP = 'UPDATE') THEN
            INSERT INTO UserAudit SELECT 'U', now(), user, NEW.*;
            RETURN NEW;
        ELSEIF (TG_OP = 'INSERT') THEN
            INSERT INTO UserAudit SELECT 'I', now(), user, NEW.*;
            RETURN NEW;
        END IF;
        RETURN NULL;
    END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER user_audit
AFTER INSERT OR UPDATE OR DELETE ON Users
FOR EACH ROW EXECUTE PROCEDURE process_user_audit();

CREATE OR REPLACE FUNCTION process_address_audit() RETURNS TRIGGER AS $$
    BEGIN
        IF (TG_OP = 'DELETE') THEN
            INSERT INTO AddressAudit SELECT 'D', now(), user, OLD.*;
            RETURN OLD;
        ELSEIF (TG_OP = 'UPDATE') THEN
            INSERT INTO AddressAudit SELECT 'U', now(), user, NEW.*;
            RETURN NEW;
        ELSEIF (TG_OP = 'INSERT') THEN
            INSERT INTO AddressAudit SELECT 'I', now(), user, NEW.*;
            RETURN NEW;
        END IF;
        RETURN NULL;
    END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER address_audit
AFTER INSERT OR UPDATE OR DELETE ON Addresses
FOR EACH ROW EXECUTE PROCEDURE process_address_audit();

CREATE OR REPLACE FUNCTION process_category_audit() RETURNS TRIGGER AS $$
    BEGIN
        IF (TG_OP = 'DELETE') THEN
            INSERT INTO CategoryAudit SELECT 'D', now(), user, OLD.*;
            RETURN OLD;
        ELSEIF (TG_OP = 'UPDATE') THEN
            INSERT INTO CategoryAudit SELECT 'U', now(), user, NEW.*;
            RETURN NEW;
        ELSEIF (TG_OP = 'INSERT') THEN
            INSERT INTO CategoryAudit SELECT 'I', now(), user, NEW.*;
            RETURN NEW;
        END IF;
        RETURN NULL;
    END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER category_audit
AFTER INSERT OR UPDATE OR DELETE ON Categories
FOR EACH ROW EXECUTE PROCEDURE process_category_audit();

CREATE OR REPLACE FUNCTION process_manufacturer_audit() RETURNS TRIGGER AS $$
    BEGIN
        IF (TG_OP = 'DELETE') THEN
            INSERT INTO ManufacturerAudit SELECT 'D', now(), user, OLD.*;
            RETURN OLD;
        ELSEIF (TG_OP = 'UPDATE') THEN
            INSERT INTO ManufacturerAudit SELECT 'U', now(), user, NEW.*;
            RETURN NEW;
        ELSEIF (TG_OP = 'INSERT') THEN
            INSERT INTO ManufacturerAudit SELECT 'I', now(), user, NEW.*;
            RETURN NEW;
        END IF;
        RETURN NULL;
    END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER manufacturer_audit
AFTER INSERT OR UPDATE OR DELETE ON Manufacturers
FOR EACH ROW EXECUTE PROCEDURE process_manufacturer_audit();

CREATE OR REPLACE FUNCTION process_product_audit() RETURNS TRIGGER AS $$
    BEGIN
        IF (TG_OP = 'DELETE') THEN
            INSERT INTO ProductAudit SELECT 'D', now(), user, OLD.*;
            RETURN OLD;
        ELSEIF (TG_OP = 'UPDATE') THEN
            INSERT INTO ProductAudit SELECT 'U', now(), user, NEW.*;
            RETURN NEW;
        ELSEIF (TG_OP = 'INSERT') THEN
            INSERT INTO ProductAudit SELECT 'I', now(), user, NEW.*;
            RETURN NEW;
        END IF;
        RETURN NULL;
    END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER product_audit
AFTER INSERT OR UPDATE OR DELETE ON Products
FOR EACH ROW EXECUTE PROCEDURE process_product_audit();