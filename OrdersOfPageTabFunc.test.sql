DECLARE @itemsOnPage int;
DECLARE @page int;

SET @itemsOnPage = 5;
SET @page = 0;

SELECT * FROM GetOrdersForPage(@page,@itemsOnPage);

SET @itemsOnPage = 5;
SET @page = 1;

SELECT * FROM GetOrdersForPage(@page,@itemsOnPage);


SET @itemsOnPage = 5;
SET @page = 2;

SELECT * FROM GetOrdersForPage(@page,@itemsOnPage);
