-- sub queries
-- Ticket 1

select (select avg(listingprice) from properties) as avglistingprice;

-- Ticket 2
select address from properties where listingprice=(select min(listingprice) from properties);

-- Ticket 3

select address from properties where listingprice> (select avg(listingprice) from properties);

-- Ticket 4
select concat(firstname,' ',lastname) as agentname from agents where agentid  in(select agentid from properties where listingprice>5000);

-- Ticket 5

SELECT 
    Address, Bedrooms
FROM
    properties p,
    propertydetails pd
WHERE
    p.PropertyID in (SELECT 
            pd.PropertyID
        FROM
            propertydetails
        WHERE
            Bedrooms = (SELECT 
                    MAX(bedrooms)
                FROM
                    propertydetails));
-- Ticket 6


select avg(Bedrooms) from propertydetails;          
  
-- Ticket 7

select p.* from properties p,propertydetails pd where p.propertyID=pd.propertyID and YearBuilt=(select min(YearBuilt) from propertydetails);

SELECT    p.*
FROM    properties p
INNER JOIN propertydetails pd ON p.PropertyID = pd.PropertyID
WHERE   pd.YearBuilt = (SELECT MIN(YearBuilt)
        FROM propertydetails);
        
        -- Ticket 8
SELECT 
p.PropertyID,Address,Bathrooms
FROM
properties p,
propertydetails pd
WHERE
p.PropertyID = pd.PropertyID
AND pd.Bathrooms > (SELECT 
AVG(Bathrooms)
FROM
propertydetails);

-- Ticket 9

select * from propertyamenityassignments;
select count(PropertyID) from propertyamenities;
 
select count(PropertyID) from propertyamenityassignments paa where paa.AmenityID=(select pa.AmenityID from propertyamenities pa where AmenityName='pool');

-- Ticket 10

select a.AmenityName from propertyamenities a where (select count(*) from propertyamenityassignments p where p.AmenityID=a.AmenityID)>3;

-- Ticket 11

SELECT 
    Address, ListingPrice, Bedrooms
FROM
    properties p,
    propertydetails
WHERE
    Bedrooms > (SELECT 
            AVG(Bedrooms)
        FROM
            propertydetails)
        AND ListingPrice > (SELECT 
            AVG(listingprice)
        FROM
            properties);
            
-- Ticket 12


select distinct FirstName,LastName from clients,propertydetails where ClientID in (select ClientID from transactions where SalePrice>500000) and Bedrooms>3;          

select FirstName,LastName from clients c 
inner join transactions t on c.ClientID=t.ClientID 
inner join propertydetails p on t.PropertyID=p.PropertyID
where Bedrooms>3 and SalePrice>500000;
