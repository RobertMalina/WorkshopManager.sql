DECLARE @itemsOnPage int;
DECLARE @page int;
DECLARE @fetchArchivedToo bit;

SET @itemsOnPage = 5;
SET @page = 0;
SET @fetchArchivedToo = 1;

SELECT * FROM GetOrdersForPage(@page, @itemsOnPage, @fetchArchivedToo);

SET @page = 1;
SELECT * FROM GetOrdersForPage(@page, @itemsOnPage, @fetchArchivedToo);


SET @page = 2;
SELECT * FROM GetOrdersForPage(@page, @itemsOnPage, @fetchArchivedToo);


SET @fetchArchivedToo = 0;
SET @page = 0;
SELECT * FROM GetOrdersForPage(@page, @itemsOnPage, @fetchArchivedToo);

SET @page = 1;
SELECT * FROM GetOrdersForPage(@page, @itemsOnPage, @fetchArchivedToo);