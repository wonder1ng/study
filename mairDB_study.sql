-- https://www.w3schools.com/sql/trysql.asp?filename=trysql_select_all

-- self join
SELECT * FROM Products p, Suppliers s where p.supplierid==s.supplierid;

SELECT * FROM Products p, categories c where c.categoryname="Seafood" and p.CategoryID==c.CategoryID;

SELECT s.Country, p.ProductID, count(p.ProductID), avg(p.Price) FROM Suppliers s, Products p, Categories c
where s.SupplierID=p.SupplierID and c.CategoryID=p.CategoryID
group by s.Country, p.CategoryID;

SELECT o.OrderID, c.CustomerName, e.LastName, s.ShipperName, sum(d.Quantity)
FROM Orders o, Customers c, OrderDetails d, Employees e, Shippers s
where o.OrderID=d.OrderID and o.CustomerID=c.CustomerID and o.EmployeeID=e.EmployeeID and o.ShipperID=s.ShipperID
group by o.OrderID;

select s.SupplierID, sum(d.Quantity) rank
FROM Products p, OrderDetails d, Suppliers s
where p.ProductID=d.ProductID and s.SupplierID=p.SupplierID
group by s.SupplierID
order by rank desc limit 3;

select g.CategoryID, c.City, sum(d.Quantity) rank
FROM Orders o, Customers c, OrderDetails d, Products p, categories g
where o.OrderID=d.OrderID and o.CustomerID=c.CustomerID and p.CategoryID=g.CategoryID and d.ProductID=p.ProductID
group by g.CategoryID, c.City
order by rank desc;

select c.City, sum(d.Quantity) rank
FROM Orders o, Customers c, OrderDetails d, Products p
where  o.OrderID=d.OrderID and o.CustomerID=c.CustomerID and d.ProductID=p.ProductID and c.Country="USA"
group by c.City
order by rank desc;

-- inner join
SELECT * FROM Products p inner join Suppliers s on p.supplierid==s.supplierid;

SELECT * FROM Products p inner join categories c on c.categoryname="Seafood" and p.CategoryID==c.CategoryID;

SELECT s.Country, p.ProductID, count(p.ProductID), avg(p.Price) 
FROM Suppliers s
inner join Products p on s.SupplierID=p.SupplierID
inner join Categories c on c.CategoryID=p.CategoryID
group by s.Country, p.CategoryID;

SELECT o.OrderID, c.CustomerName, e.LastName, s.ShipperName, sum(d.Quantity)
FROM Orders o
inner join OrderDetails d on o.OrderID=d.OrderID
inner join Customers c on o.CustomerID=c.CustomerID 
inner join Employees e on o.EmployeeID=e.EmployeeID 
inner join Shippers s on o.ShipperID=s.ShipperID
group by o.OrderID;

select s.SupplierID, sum(d.Quantity) rank
FROM Products p
inner join OrderDetails d on p.ProductID=d.ProductID
inner join Suppliers s on s.SupplierID=p.SupplierID
group by s.SupplierID
order by rank desc limit 3;

select g.CategoryID, c.City, sum(d.Quantity) rank
FROM Orders o
inner join OrderDetails d on o.OrderID=d.OrderID
inner join Customers c on o.CustomerID=c.CustomerID
inner join Products p on d.ProductID=p.ProductID
inner join categories g on p.CategoryID=g.CategoryID
group by g.CategoryID, c.City
order by rank desc;

select c.City, sum(d.Quantity) rank
FROM Orders o
inner join Customers c on o.CustomerID=c.CustomerID
inner join OrderDetails d on o.OrderID=d.OrderID 
inner join Products p on d.ProductID=p.ProductID and c.Country="USA"
group by c.City
order by rank desc;