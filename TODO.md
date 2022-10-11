# Improvements
not aiming for perfect but could be better in these ways:
- Turn SQL in `.sql` files to stored procedures instead of or alongside being auto-invoked
- Switch to better logging, something like:
	```java
	import java.util.logging.Level;
	import java.util.logging.Logger;
	Logger.getLogger(EshopDatabase.class.getName()).log(Level.SEVERE, null, ex);
	```
- Check todos in code
- Find way to store product images in database
- use [sql custom mapping](https://docs.oracle.com/javase/tutorial/jdbc/basics/sqlcustommapping.html)
