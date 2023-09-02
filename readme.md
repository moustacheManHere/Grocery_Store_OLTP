# Grocery Store OLTP Database Project

This project involves the creation of an OLTP (Online Transaction Processing) database for a fictional grocery store. The database is designed to manage various aspects of the grocery store's operations, including item inventory, customer information, employee data, and transaction records.

## Database Tables

1. **Item**: Stores information about grocery items.
2. **Customer**: Manages customer details.
3. **Store**: Contains store information including addresses and managers.
4. **Inventory**: Tracks item quantities in each store.
5. **Employee**: Manages employee data and relationships.
6. **Dependent**: Stores information about employee dependents.
7. **CheckOut**: Records customer transactions.
8. **CheckOutItems**: Tracks items purchased in each transaction.

## Queries

Here are some SQL queries that can give interesting insights:

### Query 1

This query retrieves information about customer transactions, including customer names, store details, purchased items, quantities, and the employee who processed the transaction.

### Query 2

This query provides details about store managers, the stores they manage, and the items available in those stores.

### Query 3

This query identifies customers who made purchases with a total quantity of two items or less in any single transaction. It includes customers who have never made a purchase.

### Query 4

This query calculates the retail and wholesale value of items in inventory for stores that have at least two items in stock.

### Query 5

This query lists employee details, including employee names, IDs, manager names, and manager IDs.

### Query 6

This query retrieves information about managers and their respective bosses, including names, employee IDs, and store details.

Please note that these sample queries are intended to showcase the functionality of the database and may be used for reporting and analysis within the grocery store's operations.

## License

This project is licensed under the MIT License