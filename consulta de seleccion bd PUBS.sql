--BD DE PUBS

--t�tulos de los libros junto con los nombres de los autores y ordenarlos alfab�ticamente por t�tulo
SELECT titles.title, authors.au_fname, authors.au_lname
FROM titles
INNER JOIN titleauthor ON titles.title_id = titleauthor.title_id
INNER JOIN authors ON titleauthor.au_id = authors.au_id
ORDER BY titles.title;
-- t�tulos de los libros junto con las categor�as de los libros y ordenarlos alfab�ticamente por categor�a
SELECT titles.title, publishers.pub_name
FROM titles
INNER JOIN publishers ON titles.pub_id = publishers.pub_id
ORDER BY publishers.pub_name;
--nombres de los autores junto con el n�mero de libros que han escrito y ordenarlos por el n�mero de libros en orden descendente
SELECT authors.au_fname, authors.au_lname, COUNT(titleauthor.title_id) AS NumBooksWritten
FROM authors
INNER JOIN titleauthor ON authors.au_id = titleauthor.au_id
GROUP BY authors.au_fname, authors.au_lname
ORDER BY NumBooksWritten DESC;
--nombres de los autores junto con los t�tulos de los libros que han escrito y ordenarlos alfab�ticamente por el nombre del autor y el t�tulo del libro
SELECT authors.au_fname, authors.au_lname, titles.title
FROM authors
INNER JOIN titleauthor ON authors.au_id = titleauthor.au_id
INNER JOIN titles ON titleauthor.title_id = titles.title_id
ORDER BY authors.au_lname, authors.au_fname, titles.title;
--	nombres de las editoriales junto con el n�mero de t�tulos publicados por cada editorial y ordenarlos por n�mero de t�tulos en orden descendente
SELECT publishers.pub_name, COUNT(titles.title_id) AS NumTitlesPublished
FROM publishers
INNER JOIN titles ON publishers.pub_id = titles.pub_id
GROUP BY publishers.pub_name
ORDER BY NumTitlesPublished DESC;
--nombres de los autores que han escrito libros en m�ltiples categor�as y ordenarlos alfab�ticamente por nombre de autor
SELECT authors.au_fname, authors.au_lname
FROM authors
INNER JOIN titleauthor ON authors.au_id = titleauthor.au_id
INNER JOIN titles ON titleauthor.title_id = titles.title_id
GROUP BY authors.au_fname, authors.au_lname
HAVING COUNT(DISTINCT titles.type) > 1
ORDER BY authors.au_lname, authors.au_fname;
--libros junto con el n�mero total de copias vendidas para cada t�tulo y ordenarlos por el n�mero de copias vendidas en orden descendente
SELECT titles.title, SUM(sales.qty) AS TotalCopiesSold
FROM titles
INNER JOIN sales ON titles.title_id = sales.title_id
GROUP BY titles.title
ORDER BY TotalCopiesSold DESC;
--autores junto con el n�mero total de libros que han escrito y ordenarlos por el n�mero de libros en orden descendente
SELECT authors.au_id, authors.au_lname, authors.au_fname, COUNT(titles.title_id) AS TotalBooksWritten
FROM authors
INNER JOIN titleauthor ON authors.au_id = titleauthor.au_id
INNER JOIN titles ON titleauthor.title_id = titles.title_id
GROUP BY authors.au_id, authors.au_lname, authors.au_fname
ORDER BY TotalBooksWritten DESC;
--categor�as de libros junto con el n�mero total de t�tulos en cada categor�a y ordenarlas por el n�mero de t�tulos en orden descendente
SELECT titles.type AS BookCategory, COUNT(titles.title_id) AS TotalTitles
FROM titles
GROUP BY titles.type
ORDER BY TotalTitles DESC;
--editoriales junto con el n�mero total de t�tulos publicados por cada editorial y ordenarlas por el n�mero de t�tulos en orden descenden
SELECT publishers.pub_id, publishers.pub_name, COUNT(titles.title_id) AS TotalTitlesPublished
FROM publishers
INNER JOIN titles ON publishers.pub_id = titles.pub_id
GROUP BY publishers.pub_id, publishers.pub_name
ORDER BY TotalTitlesPublished DESC;
--vnombres de los autores junto con el n�mero total de copias vendidas de todos sus libros y ordenarlos por el n�mero de copias vendidas en orden descendente
SELECT authors.au_id, authors.au_lname, authors.au_fname, SUM(sales.qty) AS TotalCopiesSold
FROM authors
INNER JOIN titleauthor ON authors.au_id = titleauthor.au_id
INNER JOIN sales ON titleauthor.title_id = sales.title_id
GROUP BY authors.au_id, authors.au_lname, authors.au_fname
ORDER BY TotalCopiesSold DESC;
--Listar los autores junto con el n�mero total de libros que han escrito y mostrar solo aquellos autores que han escrito al menos m�s 5 libros
SELECT authors.au_id, authors.au_lname, authors.au_fname, COUNT(titles.title_id) AS TotalBooksWritten
FROM authors
INNER JOIN titleauthor ON authors.au_id = titleauthor.au_id
INNER JOIN titles ON titleauthor.title_id = titles.title_id
GROUP BY authors.au_id, authors.au_lname, authors.au_fname
HAVING COUNT(titles.title_id) <= 5;
--Listar las categor�as de libros junto con el n�mero total de t�tulos en cada categor�a y mostrar solo aquellas categor�as que tienen al meno masde  10 t�tulo
SELECT titles.type AS BookCategory, COUNT(titles.title_id) AS TotalTitles
FROM titles
GROUP BY titles.type
HAVING COUNT(titles.title_id) <= 10;
--Listar los nombres de las editoriales junto con el n�mero total de t�tulos publicados por cada editorial y mostrar solo aquellas editoriales que han publicado al menos mas de 20 t�tulos
SELECT publishers.pub_id, publishers.pub_name, COUNT(titles.title_id) AS TotalTitlesPublished
FROM publishers
INNER JOIN titles ON publishers.pub_id = titles.pub_id
GROUP BY publishers.pub_id, publishers.pub_name
HAVING COUNT(titles.title_id) <= 20;
--
SELECT publishers.pub_id, publishers.pub_name, AVG(titles.pubdate) AS AvgPages
FROM publishers
INNER JOIN titles ON publishers.pub_id = titles.pub_id
GROUP BY publishers.pub_id, publishers.pub_name
HAVING AVG(titles.pubdate) > 200;
--autores junto con el n�mero total de copias vendidas de todos sus libros y mostrar solo aquellos autores cuyo n�mero total de copias vendidas es superior a 5000 copias
SELECT authors.au_id, authors.au_lname, authors.au_fname, SUM(sales.qty) AS TotalCopiesSold
FROM authors
INNER JOIN titleauthor ON authors.au_id = titleauthor.au_id
INNER JOIN sales ON titleauthor.title_id = sales.title_id
GROUP BY authors.au_id, authors.au_lname, authors.au_fname
HAVING SUM(sales.qty) < 5000;
-- categor�as de libros junto con el precio promedio de los libros en cada categor�a y mostrar solo aquellas categor�as con un precio promedio superior a $20
SELECT titles.type AS BookCategory, AVG(titles.price) AS AvgPrice
FROM titles
GROUP BY titles.type
HAVING AVG(titles.price) < 20;
--autores junto con el n�mero total de libros que han escrito y mostrar solo aquellos autores que han escrito exactamente 2 libro
SELECT authors.au_id, authors.au_lname, authors.au_fname, COUNT(titleauthor.title_id) AS TotalBooksWritten
FROM authors
INNER JOIN titleauthor ON authors.au_id = titleauthor.au_id
GROUP BY authors.au_id, authors.au_lname, authors.au_fname
HAVING COUNT(titleauthor.title_id) = 2;
--editoriales junto con el n�mero total de t�tulos publicados por cada editorial y mostrar solo aquellas editoriales que han publicado menos de 10 t�tulos--
SELECT publishers.pub_id, publishers.pub_name, COUNT(titles.title_id) AS TotalTitlesPublished
FROM publishers
INNER JOIN titles ON publishers.pub_id = titles.pub_id
GROUP BY publishers.pub_id, publishers.pub_name
HAVING COUNT(titles.title_id) < 10;
--los autores y t�tulos de libros que han escrito
SELECT authors.au_id, authors.au_lname, authors.au_fname, titles.title
FROM authors
LEFT JOIN titleauthor ON authors.au_id = titleauthor.au_id
LEFT JOIN titles ON titleauthor.title_id = titles.title_id
UNION
SELECT authors.au_id, authors.au_lname, authors.au_fname, titles.title
FROM authors
RIGHT JOIN titleauthor ON authors.au_id = titleauthor.au_id
RIGHT JOIN titles ON titleauthor.title_id = titles.title_id
ORDER BY au_id;
--ategor�as de libros y los nombres de las editoriales que publicaron libros en esas categor�as 
SELECT titles.type AS BookCategory, publishers.pub_name
FROM titles
LEFT JOIN publishers ON titles.pub_id = publishers.pub_id
UNION
SELECT titles.type AS BookCategory, publishers.pub_name
FROM titles
RIGHT JOIN publishers ON titles.pub_id = publishers.pub_id
ORDER BY BookCategory, pub_name;
--autores y los t�tulos de los libros que han escrito, incluyendo los autores que no han escrito ning�n libro, y ordenarlos alfab�ticamente por el nombre del autor y el t�tulo del libro
SELECT authors.au_id, authors.au_lname, authors.au_fname, titles.title
FROM authors
LEFT JOIN titleauthor ON authors.au_id = titleauthor.au_id
LEFT JOIN titles ON titleauthor.title_id = titles.title_id
ORDER BY authors.au_lname, authors.au_fname, titles.title;
--categor�as de libros y los precios promedio de los libros en cada categor�a, incluyendo las categor�as que no tienen libros, y ordenarlas por el precio promedio en orden ascendente
SELECT titles.type AS BookCategory, AVG(titles.price) AS AvgPrice
FROM titles
LEFT JOIN publishers ON titles.pub_id = publishers.pub_id
GROUP BY titles.type
ORDER BY AvgPrice ASC;
--nombres de las editoriales y el n�mero total de t�tulos publicados por cada editorial, incluyendo las editoriales que no han publicado ning�n t�tulo, y ordenarlas por el n�mero total de t�tulos en orden descendent
SELECT publishers.pub_id, publishers.pub_name, COUNT(titles.title_id) AS TotalTitlesPublished
FROM publishers
LEFT JOIN titles ON publishers.pub_id = titles.pub_id
GROUP BY publishers.pub_id, publishers.pub_name
ORDER BY TotalTitlesPublished DESC;
-- editoriales y el n�mero total de t�tulos publicados por cada editorial, incluyendo las editoriales que no han publicado ning�n t�tulo
SELECT publishers.pub_id, publishers.pub_name, COUNT(titles.title_id) AS TotalTitlesPublished
FROM publishers
LEFT JOIN titles ON publishers.pub_id = titles.pub_id
GROUP BY publishers.pub_id, publishers.pub_name
--categor�as de libros y el n�mero total de t�tulos en cada categor�a, incluyendo las categor�as que no tienen libros
SELECT titles.type AS BookCategory, COUNT(titles.title_id) AS TotalTitles
FROM titles
LEFT JOIN publishers ON titles.pub_id = publishers.pub_id
GROUP BY titles.type
--autores y el n�mero total de libros que han escrito, incluyendo los autores que no han escrito ning�n libro
SELECT authors.au_id, authors.au_lname, authors.au_fname, COUNT(titles.title_id) AS TotalBooksWritten
FROM authors
LEFT JOIN titleauthor ON authors.au_id = titleauthor.au_id
LEFT JOIN titles ON titleauthor.title_id = titles.title_id
GROUP BY authors.au_id, authors.au_lname, authors.au_fname
-- t�tulos de libros junto con el nombre de la editorial que los public�, incluyendo los t�tulos que no tienen una editorial asignada, y ordenarlos alfab�ticamente por t�tulo
SELECT titles.title, publishers.pub_name
FROM titles
RIGHT JOIN publishers ON titles.pub_id = publishers.pub_id
ORDER BY titles.title;
--Listar todos los autores y el t�tulo de los libros que han escrito, incluyendo los autores que no han escrito ning�n libro, y ordenarlos alfab�ticamente por nombre del autor y t�tulo del libro
SELECT authors.au_id, authors.au_lname, authors.au_fname, titles.title
FROM authors
RIGHT JOIN titleauthor ON authors.au_id = titleauthor.au_id
RIGHT JOIN titles ON titleauthor.title_id = titles.title_id
ORDER BY authors.au_lname, authors.au_fname, titles.title;
-- todas las categor�as de libros junto con el precio promedio de los libros en cada categor�a, incluyendo las categor�as que no tienen libros, y ordenarlas por el precio promedio en orden descendente
SELECT titles.type AS BookCategory, AVG(titles.price) AS AvgPrice
FROM titles
RIGHT JOIN publishers ON titles.pub_id = publishers.pub_id
GROUP BY titles.type
ORDER BY AvgPrice DESC;
--categor�as de libros junto con el precio promedio m�s bajo de los libros en cada categor�a, incluyendo las categor�as que no tienen libros, y ordenarlas por el precio promedio en orden ascendente
SELECT titles.type AS BookCategory, MIN(titles.price) AS MinPrice
FROM titles
RIGHT JOIN publishers ON titles.pub_id = publishers.pub_id
GROUP BY titles.type
ORDER BY MinPrice ASC;
--autores y n�mero total de libros que han escrito, incluyendo los autores que no han escrito ning�n libro, y ordenarlos por el n�mero total de libros en orden descendente
SELECT authors.au_id, authors.au_lname, authors.au_fname, COUNT(titles.title_id) AS TotalBooksWritten
FROM authors
RIGHT JOIN titleauthor ON authors.au_id = titleauthor.au_id
RIGHT JOIN titles ON titleauthor.title_id = titles.title_id
GROUP BY authors.au_id, authors.au_lname, authors.au_fname
ORDER BY TotalBooksWritten DESC;
--Enlistar todas las editoriales junto con el n�mero total de t�tulos publicados por cada editorial, incluyendo las editoriales que no han publicado ning�n t�tulo, y ordenarlas alfab�ticamente por nombre de editorial
SELECT publishers.pub_id, publishers.pub_name, COUNT(titles.title_id) AS TotalTitlesPublished
FROM publishers
RIGHT JOIN titles ON publishers.pub_id = titles.pub_id
GROUP BY publishers.pub_id, publishers.pub_name
ORDER BY publishers.pub_name;
-- t�tulos de libros junto con el nombre de la editorial que los public�, incluyendo los t�tulos que no tienen una editorial asignada, y ordenarlos alfab�ticamente por nombre de editorial y t�tulo de libro
SELECT titles.title, publishers.pub_name
FROM titles
RIGHT JOIN publishers ON titles.pub_id = publishers.pub_id
ORDER BY publishers.pub_name, titles.title;
-- todos los autores junto con el t�tulo de los libros que han escrito, incluyendo los autores que no han escrito ning�n libro, y ordenarlos alfab�ticamente por t�tulo de libro y nombre del autor
SELECT authors.au_id, authors.au_lname, authors.au_fname, titles.title
FROM authors
RIGHT JOIN titleauthor ON authors.au_id = titleauthor.au_id
RIGHT JOIN titles ON titleauthor.title_id = titles.title_id
ORDER BY titles.title, authors.au_lname, authors.au_fname;
--editoriales junto con el n�mero total de t�tulos publicados por cada editorial, incluyendo las editoriales que no han publicado ning�n t�tulo
SELECT publishers.pub_id, publishers.pub_name, COUNT(titles.title_id) AS TotalTitlesPublished
FROM publishers
RIGHT JOIN titles ON publishers.pub_id = titles.pub_id
GROUP BY publishers.pub_id, publishers.pub_name
-- categor�as de libros junto con el precio promedio de los libros en cada categor�a, incluyendo las categor�as que no tienen libros
SELECT titles.type AS BookCategory, AVG(titles.price) AS AvgPrice
FROM titles
RIGHT JOIN publishers ON titles.pub_id = publishers.pub_id
GROUP BY titles.type
--autores junto con el n�mero total de libros que han escrito, incluyendo los autores que no han escrito ning�n libro
SELECT authors.au_id, authors.au_lname, authors.au_fname, COUNT(titles.title_id) AS TotalBooksWritten
FROM authors
RIGHT JOIN titleauthor ON authors.au_id = titleauthor.au_id
RIGHT JOIN titles ON titleauthor.title_id = titles.title_id
GROUP BY authors.au_id, authors.au_lname, authors.au_fname
--ciudades de los autores junto con el n�mero total de autores que viven en cada ciudad, incluyendo las ciudades sin autores, y ordenarlas alfab�ticamente por nombre de ciudad
SELECT authors.city, COUNT(authors.au_id) AS TotalAuthors
FROM authors
RIGHT JOIN publishers ON authors.city = publishers.city
GROUP BY authors.city
ORDER BY authors.city;
--categor�as de libros junto con el n�mero total de t�tulos en cada categor�a, incluyendo solo las categor�as con m�s de 10 t�tulos
SELECT titles.type AS BookCategory, COUNT(titles.title_id) AS TotalTitles
FROM titles
RIGHT JOIN publishers ON titles.pub_id = publishers.pub_id
GROUP BY titles.type
HAVING COUNT(titles.title_id) > 10;
--todos los autores junto con el n�mero total de libros que han escrito, incluyendo solo los autores que han escrito menos de 5 libros
SELECT authors.au_id, authors.au_lname, authors.au_fname, COUNT(titles.title_id) AS TotalBooksWritten
FROM authors
RIGHT JOIN titleauthor ON authors.au_id = titleauthor.au_id
RIGHT JOIN titles ON titleauthor.title_id = titles.title_id
GROUP BY authors.au_id, authors.au_lname, authors.au_fname
HAVING COUNT(titles.title_id) < 5;
--t�tulos de libros junto con el nombre de la editorial que los public�, incluyendo solo los t�tulos que tienen un precio menor a $20
SELECT titles.title, publishers.pub_name
FROM titles
RIGHT JOIN publishers ON titles.pub_id = publishers.pub_id
WHERE titles.price > 20;
-- t�tulos de libros junto con el nombre de la editorial que los public�, incluyendo solo los t�tulos que tienen un precio menor a $25:
SELECT titles.title, publishers.pub_name
FROM titles
RIGHT JOIN publishers ON titles.pub_id = publishers.pub_id
WHERE titles.price < 25;
--utores y la cantidad total de libros que han escrito, ordenados por la cantidad de libros en orden descendente
SELECT authors.au_id, authors.au_lname, authors.au_fname, COUNT(titleauthor.title_id) AS TotalBooksWritten
FROM authors
LEFT JOIN titleauthor ON authors.au_id = titleauthor.au_id
GROUP BY authors.au_id, authors.au_lname, authors.au_fname
ORDER BY TotalBooksWritten DESC;
--t�tulos de libros junto con la cantidad total de ventas en d�lares, ordenados por la cantidad total de ventas en orden descendente
SELECT titles.title, SUM(sales.qty * titles.price) AS TotalSalesDollars
FROM titles
LEFT JOIN sales ON titles.title_id = sales.title_id
GROUP BY titles.title
ORDER BY TotalSalesDollars DESC;
-- t�tulos de libros y sus precios, ordenados por precio en orden ascendente
SELECT title, price
FROM titles
ORDER BY price ASC;
--editoriales junto con la cantidad total de t�tulos publicados, ordenados alfab�ticamente por nombre de editorial
SELECT publishers.pub_name, COUNT(titles.title_id) AS TotalTitlesPublished
FROM publishers
LEFT JOIN titles ON publishers.pub_id = titles.pub_id
GROUP BY publishers.pub_name
ORDER BY publishers.pub_name;
--autores y la suma total de las ventas de sus libros, ordenados por la suma de ventas en orden descendente
SELECT authors.au_id, authors.au_lname, authors.au_fname, SUM(sales.qty * titles.price) AS TotalSales
FROM authors
LEFT JOIN titleauthor ON authors.au_id = titleauthor.au_id
LEFT JOIN titles ON titleauthor.title_id = titles.title_id
LEFT JOIN sales ON titles.title_id = sales.title_id
GROUP BY authors.au_id, authors.au_lname, authors.au_fname
ORDER BY TotalSales DESC;
-- categor�as de libros y el precio promedio de los libros en cada categor�a, ordenados por precio promedio en orden descendente
SELECT titles.type AS BookCategory, AVG(titles.price) AS AvgPrice
FROM titles
LEFT JOIN publishers ON titles.pub_id = publishers.pub_id
GROUP BY titles.type
ORDER BY AvgPrice DESC;
-- t�tulos de libros junto con la fecha de publicaci�n m�s reciente, ordenados por fecha de publicaci�n en orden descendente
SELECT title, MAX(pubdate) AS LatestPublicationDate
FROM titles
GROUP BY title
ORDER BY LatestPublicationDate DESC;
--ciudades de las editoriales junto con la cantidad total de t�tulos publicados en cada ciudad, ordenadas por cantidad en orden descendente
SELECT publishers.city, COUNT(titles.title_id) AS TotalTitlesPublished
FROM publishers
LEFT JOIN titles ON publishers.pub_id = titles.pub_id
GROUP BY publishers.city
ORDER BY TotalTitlesPublished DESC;
-- editoriales que han publicado al menos un libro con un precio superior a $30
SELECT publishers.pub_name
FROM publishers
JOIN titles ON publishers.pub_id = titles.pub_id
WHERE titles.price > 30
GROUP BY publishers.pub_name
HAVING COUNT(titles.title_id) <= 1;
--autores que han escrito al menos un libro con m�s de 300 p�ginas
SELECT authors.au_id, authors.au_lname, authors.au_fname
FROM authors
JOIN titleauthor ON authors.au_id = titleauthor.au_id
JOIN titles ON titleauthor.title_id = titles.title_id
WHERE titles.pages > 300
GROUP BY authors.au_id, authors.au_lname, authors.au_fname
HAVING COUNT(DISTINCT titles.title_id) >= 1;
-- ciudades de las editoriales que tienen al menos una editorial con menoz de 10 t�tulos publicados
SELECT publishers.city
FROM publishers
JOIN titles ON publishers.pub_id = titles.pub_id
GROUP BY publishers.city
HAVING COUNT(DISTINCT publishers.pub_id) >= 1
AND COUNT(DISTINCT titles.title_id) < 10;
--ategor�as de libros junto con el precio promedio de los libros en cada categor�a, incluyendo solo las categor�as donde el precio promedio es inferior a $15
SELECT titles.type AS BookCategory, AVG(titles.price) AS AvgPrice
FROM titles
JOIN publishers ON titles.pub_id = publishers.pub_id
GROUP BY titles.type
HAVING AVG(titles.price) < 15;
--editoriales junto con la cantidad total de t�tulos publicados por cada editorial, incluyendo solo las editoriales que han publicado al menos 5 t�tulos y la cantidad de t�tulos es mayor a 5 veces la cantidad de editoriales
SELECT publishers.pub_name, COUNT(titles.title_id) AS TotalTitlesPublished
FROM publishers
JOIN titles ON publishers.pub_id = titles.pub_id
GROUP BY publishers.pub_name
HAVING COUNT(titles.title_id) >= 5
AND COUNT(titles.title_id) > 5 * COUNT(DISTINCT publishers.pub_id);
--ciudades de las editoriales junto con la cantidad total de editoriales en cada ciudad, incluyendo solo las ciudades con al menos 3 editoriales, y ordenarlas alfab�ticamente por nombre de ciudad
SELECT publishers.city, COUNT(DISTINCT publishers.pub_name) AS TotalPublishers
FROM publishers
GROUP BY publishers.city
HAVING COUNT(DISTINCT publishers.pub_name) <= 3
ORDER BY publishers.city;
--Listar todos los autores que han escrito al menos un libro que se ha vendido en menos de 10,000 copias
SELECT authors.au_id, authors.au_lname, authors.au_fname
FROM authors
JOIN titleauthor ON authors.au_id = titleauthor.au_id
JOIN titles ON titleauthor.title_id = titles.title_id
JOIN sales ON titles.title_id = sales.title_id
GROUP BY authors.au_id, authors.au_lname, authors.au_fname
HAVING SUM(sales.qty) < 10000;
--Listar las categor�as de libros junto con la cantidad total de t�tulos en cada categor�a, incluyendo solo las categor�as con al menos 5 t�tulos y ordenarlas por cantidad de t�tulos en orden descendente
SELECT titles.type AS BookCategory, COUNT(titles.title_id) AS TotalTitles
FROM titles
GROUP BY titles.type
HAVING COUNT(titles.title_id) <= 5
ORDER BY TotalTitles DESC;
--editoriales junto con el precio promedio de los libros que han publicado, incluyendo solo las editoriales con un precio promedio menor a $20 y ordenarlas alfab�ticamente por nombre de editorial
SELECT publishers.pub_name, AVG(titles.price) AS AvgPrice
FROM publishers
JOIN titles ON publishers.pub_id = titles.pub_id
GROUP BY publishers.pub_name
HAVING AVG(titles.price) < 20
ORDER BY publishers.pub_name;
--t�tulos de libros junto con la fecha de publicaci�n m�s antigua, incluyendo solo los t�tulos con una fecha de publicaci�n anterior a 1995 y ordenarlos por fecha de publicaci�n en orden ascendente
SELECT titles.title, MIN(pubdate) AS OldestPublicationDate
FROM titles
GROUP BY titles.title
HAVING MIN(YEAR(pubdate)) < 1995
ORDER BY OldestPublicationDate ASC;
--Ordenar editoriales por la concatenaci�n de pub_name, city y state
SELECT pub_name, city, state
FROM publishers
ORDER BY CONCAT(pub_name, ', ', city, ', ', state) ASC;
--Ordenar autores por la concatenaci�n de au_lname y au_fname en orden descendente
SELECT au_lname, au_fname
FROM authors
ORDER BY CONCAT(au_lname, ', ', au_fname) DESC;
--t�tulos de libros por la concatenaci�n de title y type en orden ascendente
SELECT title, type
FROM titles
ORDER BY CONCAT(title, ' (', type, ')') ASC;
--ventas por la concatenaci�n de stor_id, ord_num y title_id en orden ascendente
SELECT stor_id, ord_num, title_id
FROM sales
ORDER BY CONCAT(stor_id, '-', ord_num, '-', title_id) ASC;
--contar el n�mero de t�tulos de libros en cada categor�a (considerando el texto en min�sculas)
SELECT LOWER(type) AS LowercaseCategory, COUNT(title_id) AS TotalTitles
FROM titles
GROUP BY LOWER(type)
ORDER BY TotalTitles DESC;
--Calcular el precio promedio de los libros publicados por cada editorial (considerando el texto en min�sculas)
SELECT LOWER(pub_name) AS LowercasePublisher, AVG(price) AS AvgPrice
FROM publishers
JOIN titles ON publishers.pub_id = titles.pub_id
GROUP BY LOWER(pub_name)
ORDER BY AvgPrice DESC;
--Listar los autores junto con la cantidad total de libros que han escrito (considerando el texto en min�sculas)
SELECT LOWER(au_lname) AS LowercaseLastName, LOWER(au_fname) AS LowercaseFirstName, COUNT(titleauthor.title_id) AS TotalBooksWritten
FROM authors
LEFT JOIN titleauthor ON authors.au_id = titleauthor.au_id
GROUP BY LOWER(au_lname), LOWER(au_fname)
ORDER BY TotalBooksWritten DESC;
--







































