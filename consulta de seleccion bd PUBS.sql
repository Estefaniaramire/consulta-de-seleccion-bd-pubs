--BD DE PUBS

--títulos de los libros junto con los nombres de los autores y ordenarlos alfabéticamente por título
SELECT titles.title, authors.au_fname, authors.au_lname
FROM titles
INNER JOIN titleauthor ON titles.title_id = titleauthor.title_id
INNER JOIN authors ON titleauthor.au_id = authors.au_id
ORDER BY titles.title;
-- títulos de los libros junto con las categorías de los libros y ordenarlos alfabéticamente por categoría
SELECT titles.title, publishers.pub_name
FROM titles
INNER JOIN publishers ON titles.pub_id = publishers.pub_id
ORDER BY publishers.pub_name;
--nombres de los autores junto con el número de libros que han escrito y ordenarlos por el número de libros en orden descendente
SELECT authors.au_fname, authors.au_lname, COUNT(titleauthor.title_id) AS NumBooksWritten
FROM authors
INNER JOIN titleauthor ON authors.au_id = titleauthor.au_id
GROUP BY authors.au_fname, authors.au_lname
ORDER BY NumBooksWritten DESC;
--nombres de los autores junto con los títulos de los libros que han escrito y ordenarlos alfabéticamente por el nombre del autor y el título del libro
SELECT authors.au_fname, authors.au_lname, titles.title
FROM authors
INNER JOIN titleauthor ON authors.au_id = titleauthor.au_id
INNER JOIN titles ON titleauthor.title_id = titles.title_id
ORDER BY authors.au_lname, authors.au_fname, titles.title;
--	nombres de las editoriales junto con el número de títulos publicados por cada editorial y ordenarlos por número de títulos en orden descendente
SELECT publishers.pub_name, COUNT(titles.title_id) AS NumTitlesPublished
FROM publishers
INNER JOIN titles ON publishers.pub_id = titles.pub_id
GROUP BY publishers.pub_name
ORDER BY NumTitlesPublished DESC;
--nombres de los autores que han escrito libros en múltiples categorías y ordenarlos alfabéticamente por nombre de autor
SELECT authors.au_fname, authors.au_lname
FROM authors
INNER JOIN titleauthor ON authors.au_id = titleauthor.au_id
INNER JOIN titles ON titleauthor.title_id = titles.title_id
GROUP BY authors.au_fname, authors.au_lname
HAVING COUNT(DISTINCT titles.type) > 1
ORDER BY authors.au_lname, authors.au_fname;
--libros junto con el número total de copias vendidas para cada título y ordenarlos por el número de copias vendidas en orden descendente
SELECT titles.title, SUM(sales.qty) AS TotalCopiesSold
FROM titles
INNER JOIN sales ON titles.title_id = sales.title_id
GROUP BY titles.title
ORDER BY TotalCopiesSold DESC;
--autores junto con el número total de libros que han escrito y ordenarlos por el número de libros en orden descendente
SELECT authors.au_id, authors.au_lname, authors.au_fname, COUNT(titles.title_id) AS TotalBooksWritten
FROM authors
INNER JOIN titleauthor ON authors.au_id = titleauthor.au_id
INNER JOIN titles ON titleauthor.title_id = titles.title_id
GROUP BY authors.au_id, authors.au_lname, authors.au_fname
ORDER BY TotalBooksWritten DESC;
--categorías de libros junto con el número total de títulos en cada categoría y ordenarlas por el número de títulos en orden descendente
SELECT titles.type AS BookCategory, COUNT(titles.title_id) AS TotalTitles
FROM titles
GROUP BY titles.type
ORDER BY TotalTitles DESC;
--editoriales junto con el número total de títulos publicados por cada editorial y ordenarlas por el número de títulos en orden descenden
SELECT publishers.pub_id, publishers.pub_name, COUNT(titles.title_id) AS TotalTitlesPublished
FROM publishers
INNER JOIN titles ON publishers.pub_id = titles.pub_id
GROUP BY publishers.pub_id, publishers.pub_name
ORDER BY TotalTitlesPublished DESC;
--vnombres de los autores junto con el número total de copias vendidas de todos sus libros y ordenarlos por el número de copias vendidas en orden descendente
SELECT authors.au_id, authors.au_lname, authors.au_fname, SUM(sales.qty) AS TotalCopiesSold
FROM authors
INNER JOIN titleauthor ON authors.au_id = titleauthor.au_id
INNER JOIN sales ON titleauthor.title_id = sales.title_id
GROUP BY authors.au_id, authors.au_lname, authors.au_fname
ORDER BY TotalCopiesSold DESC;
--Listar los autores junto con el número total de libros que han escrito y mostrar solo aquellos autores que han escrito al menos más 5 libros
SELECT authors.au_id, authors.au_lname, authors.au_fname, COUNT(titles.title_id) AS TotalBooksWritten
FROM authors
INNER JOIN titleauthor ON authors.au_id = titleauthor.au_id
INNER JOIN titles ON titleauthor.title_id = titles.title_id
GROUP BY authors.au_id, authors.au_lname, authors.au_fname
HAVING COUNT(titles.title_id) <= 5;
--Listar las categorías de libros junto con el número total de títulos en cada categoría y mostrar solo aquellas categorías que tienen al meno masde  10 título
SELECT titles.type AS BookCategory, COUNT(titles.title_id) AS TotalTitles
FROM titles
GROUP BY titles.type
HAVING COUNT(titles.title_id) <= 10;
--Listar los nombres de las editoriales junto con el número total de títulos publicados por cada editorial y mostrar solo aquellas editoriales que han publicado al menos mas de 20 títulos
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
--autores junto con el número total de copias vendidas de todos sus libros y mostrar solo aquellos autores cuyo número total de copias vendidas es superior a 5000 copias
SELECT authors.au_id, authors.au_lname, authors.au_fname, SUM(sales.qty) AS TotalCopiesSold
FROM authors
INNER JOIN titleauthor ON authors.au_id = titleauthor.au_id
INNER JOIN sales ON titleauthor.title_id = sales.title_id
GROUP BY authors.au_id, authors.au_lname, authors.au_fname
HAVING SUM(sales.qty) < 5000;
-- categorías de libros junto con el precio promedio de los libros en cada categoría y mostrar solo aquellas categorías con un precio promedio superior a $20
SELECT titles.type AS BookCategory, AVG(titles.price) AS AvgPrice
FROM titles
GROUP BY titles.type
HAVING AVG(titles.price) < 20;
--autores junto con el número total de libros que han escrito y mostrar solo aquellos autores que han escrito exactamente 2 libro
SELECT authors.au_id, authors.au_lname, authors.au_fname, COUNT(titleauthor.title_id) AS TotalBooksWritten
FROM authors
INNER JOIN titleauthor ON authors.au_id = titleauthor.au_id
GROUP BY authors.au_id, authors.au_lname, authors.au_fname
HAVING COUNT(titleauthor.title_id) = 2;
--editoriales junto con el número total de títulos publicados por cada editorial y mostrar solo aquellas editoriales que han publicado menos de 10 títulos--
SELECT publishers.pub_id, publishers.pub_name, COUNT(titles.title_id) AS TotalTitlesPublished
FROM publishers
INNER JOIN titles ON publishers.pub_id = titles.pub_id
GROUP BY publishers.pub_id, publishers.pub_name
HAVING COUNT(titles.title_id) < 10;
--los autores y títulos de libros que han escrito
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
--ategorías de libros y los nombres de las editoriales que publicaron libros en esas categorías 
SELECT titles.type AS BookCategory, publishers.pub_name
FROM titles
LEFT JOIN publishers ON titles.pub_id = publishers.pub_id
UNION
SELECT titles.type AS BookCategory, publishers.pub_name
FROM titles
RIGHT JOIN publishers ON titles.pub_id = publishers.pub_id
ORDER BY BookCategory, pub_name;
--autores y los títulos de los libros que han escrito, incluyendo los autores que no han escrito ningún libro, y ordenarlos alfabéticamente por el nombre del autor y el título del libro
SELECT authors.au_id, authors.au_lname, authors.au_fname, titles.title
FROM authors
LEFT JOIN titleauthor ON authors.au_id = titleauthor.au_id
LEFT JOIN titles ON titleauthor.title_id = titles.title_id
ORDER BY authors.au_lname, authors.au_fname, titles.title;
--categorías de libros y los precios promedio de los libros en cada categoría, incluyendo las categorías que no tienen libros, y ordenarlas por el precio promedio en orden ascendente
SELECT titles.type AS BookCategory, AVG(titles.price) AS AvgPrice
FROM titles
LEFT JOIN publishers ON titles.pub_id = publishers.pub_id
GROUP BY titles.type
ORDER BY AvgPrice ASC;
--nombres de las editoriales y el número total de títulos publicados por cada editorial, incluyendo las editoriales que no han publicado ningún título, y ordenarlas por el número total de títulos en orden descendent
SELECT publishers.pub_id, publishers.pub_name, COUNT(titles.title_id) AS TotalTitlesPublished
FROM publishers
LEFT JOIN titles ON publishers.pub_id = titles.pub_id
GROUP BY publishers.pub_id, publishers.pub_name
ORDER BY TotalTitlesPublished DESC;
-- editoriales y el número total de títulos publicados por cada editorial, incluyendo las editoriales que no han publicado ningún título
SELECT publishers.pub_id, publishers.pub_name, COUNT(titles.title_id) AS TotalTitlesPublished
FROM publishers
LEFT JOIN titles ON publishers.pub_id = titles.pub_id
GROUP BY publishers.pub_id, publishers.pub_name
--categorías de libros y el número total de títulos en cada categoría, incluyendo las categorías que no tienen libros
SELECT titles.type AS BookCategory, COUNT(titles.title_id) AS TotalTitles
FROM titles
LEFT JOIN publishers ON titles.pub_id = publishers.pub_id
GROUP BY titles.type
--autores y el número total de libros que han escrito, incluyendo los autores que no han escrito ningún libro
SELECT authors.au_id, authors.au_lname, authors.au_fname, COUNT(titles.title_id) AS TotalBooksWritten
FROM authors
LEFT JOIN titleauthor ON authors.au_id = titleauthor.au_id
LEFT JOIN titles ON titleauthor.title_id = titles.title_id
GROUP BY authors.au_id, authors.au_lname, authors.au_fname
-- títulos de libros junto con el nombre de la editorial que los publicó, incluyendo los títulos que no tienen una editorial asignada, y ordenarlos alfabéticamente por título
SELECT titles.title, publishers.pub_name
FROM titles
RIGHT JOIN publishers ON titles.pub_id = publishers.pub_id
ORDER BY titles.title;
--Listar todos los autores y el título de los libros que han escrito, incluyendo los autores que no han escrito ningún libro, y ordenarlos alfabéticamente por nombre del autor y título del libro
SELECT authors.au_id, authors.au_lname, authors.au_fname, titles.title
FROM authors
RIGHT JOIN titleauthor ON authors.au_id = titleauthor.au_id
RIGHT JOIN titles ON titleauthor.title_id = titles.title_id
ORDER BY authors.au_lname, authors.au_fname, titles.title;
-- todas las categorías de libros junto con el precio promedio de los libros en cada categoría, incluyendo las categorías que no tienen libros, y ordenarlas por el precio promedio en orden descendente
SELECT titles.type AS BookCategory, AVG(titles.price) AS AvgPrice
FROM titles
RIGHT JOIN publishers ON titles.pub_id = publishers.pub_id
GROUP BY titles.type
ORDER BY AvgPrice DESC;
--categorías de libros junto con el precio promedio más bajo de los libros en cada categoría, incluyendo las categorías que no tienen libros, y ordenarlas por el precio promedio en orden ascendente
SELECT titles.type AS BookCategory, MIN(titles.price) AS MinPrice
FROM titles
RIGHT JOIN publishers ON titles.pub_id = publishers.pub_id
GROUP BY titles.type
ORDER BY MinPrice ASC;
--autores y número total de libros que han escrito, incluyendo los autores que no han escrito ningún libro, y ordenarlos por el número total de libros en orden descendente
SELECT authors.au_id, authors.au_lname, authors.au_fname, COUNT(titles.title_id) AS TotalBooksWritten
FROM authors
RIGHT JOIN titleauthor ON authors.au_id = titleauthor.au_id
RIGHT JOIN titles ON titleauthor.title_id = titles.title_id
GROUP BY authors.au_id, authors.au_lname, authors.au_fname
ORDER BY TotalBooksWritten DESC;
--Enlistar todas las editoriales junto con el número total de títulos publicados por cada editorial, incluyendo las editoriales que no han publicado ningún título, y ordenarlas alfabéticamente por nombre de editorial
SELECT publishers.pub_id, publishers.pub_name, COUNT(titles.title_id) AS TotalTitlesPublished
FROM publishers
RIGHT JOIN titles ON publishers.pub_id = titles.pub_id
GROUP BY publishers.pub_id, publishers.pub_name
ORDER BY publishers.pub_name;
-- títulos de libros junto con el nombre de la editorial que los publicó, incluyendo los títulos que no tienen una editorial asignada, y ordenarlos alfabéticamente por nombre de editorial y título de libro
SELECT titles.title, publishers.pub_name
FROM titles
RIGHT JOIN publishers ON titles.pub_id = publishers.pub_id
ORDER BY publishers.pub_name, titles.title;
-- todos los autores junto con el título de los libros que han escrito, incluyendo los autores que no han escrito ningún libro, y ordenarlos alfabéticamente por título de libro y nombre del autor
SELECT authors.au_id, authors.au_lname, authors.au_fname, titles.title
FROM authors
RIGHT JOIN titleauthor ON authors.au_id = titleauthor.au_id
RIGHT JOIN titles ON titleauthor.title_id = titles.title_id
ORDER BY titles.title, authors.au_lname, authors.au_fname;
--editoriales junto con el número total de títulos publicados por cada editorial, incluyendo las editoriales que no han publicado ningún título
SELECT publishers.pub_id, publishers.pub_name, COUNT(titles.title_id) AS TotalTitlesPublished
FROM publishers
RIGHT JOIN titles ON publishers.pub_id = titles.pub_id
GROUP BY publishers.pub_id, publishers.pub_name
-- categorías de libros junto con el precio promedio de los libros en cada categoría, incluyendo las categorías que no tienen libros
SELECT titles.type AS BookCategory, AVG(titles.price) AS AvgPrice
FROM titles
RIGHT JOIN publishers ON titles.pub_id = publishers.pub_id
GROUP BY titles.type
--autores junto con el número total de libros que han escrito, incluyendo los autores que no han escrito ningún libro
SELECT authors.au_id, authors.au_lname, authors.au_fname, COUNT(titles.title_id) AS TotalBooksWritten
FROM authors
RIGHT JOIN titleauthor ON authors.au_id = titleauthor.au_id
RIGHT JOIN titles ON titleauthor.title_id = titles.title_id
GROUP BY authors.au_id, authors.au_lname, authors.au_fname
--ciudades de los autores junto con el número total de autores que viven en cada ciudad, incluyendo las ciudades sin autores, y ordenarlas alfabéticamente por nombre de ciudad
SELECT authors.city, COUNT(authors.au_id) AS TotalAuthors
FROM authors
RIGHT JOIN publishers ON authors.city = publishers.city
GROUP BY authors.city
ORDER BY authors.city;
--categorías de libros junto con el número total de títulos en cada categoría, incluyendo solo las categorías con más de 10 títulos
SELECT titles.type AS BookCategory, COUNT(titles.title_id) AS TotalTitles
FROM titles
RIGHT JOIN publishers ON titles.pub_id = publishers.pub_id
GROUP BY titles.type
HAVING COUNT(titles.title_id) > 10;
--todos los autores junto con el número total de libros que han escrito, incluyendo solo los autores que han escrito menos de 5 libros
SELECT authors.au_id, authors.au_lname, authors.au_fname, COUNT(titles.title_id) AS TotalBooksWritten
FROM authors
RIGHT JOIN titleauthor ON authors.au_id = titleauthor.au_id
RIGHT JOIN titles ON titleauthor.title_id = titles.title_id
GROUP BY authors.au_id, authors.au_lname, authors.au_fname
HAVING COUNT(titles.title_id) < 5;
--títulos de libros junto con el nombre de la editorial que los publicó, incluyendo solo los títulos que tienen un precio menor a $20
SELECT titles.title, publishers.pub_name
FROM titles
RIGHT JOIN publishers ON titles.pub_id = publishers.pub_id
WHERE titles.price > 20;
-- títulos de libros junto con el nombre de la editorial que los publicó, incluyendo solo los títulos que tienen un precio menor a $25:
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
--títulos de libros junto con la cantidad total de ventas en dólares, ordenados por la cantidad total de ventas en orden descendente
SELECT titles.title, SUM(sales.qty * titles.price) AS TotalSalesDollars
FROM titles
LEFT JOIN sales ON titles.title_id = sales.title_id
GROUP BY titles.title
ORDER BY TotalSalesDollars DESC;
-- títulos de libros y sus precios, ordenados por precio en orden ascendente
SELECT title, price
FROM titles
ORDER BY price ASC;
--editoriales junto con la cantidad total de títulos publicados, ordenados alfabéticamente por nombre de editorial
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
-- categorías de libros y el precio promedio de los libros en cada categoría, ordenados por precio promedio en orden descendente
SELECT titles.type AS BookCategory, AVG(titles.price) AS AvgPrice
FROM titles
LEFT JOIN publishers ON titles.pub_id = publishers.pub_id
GROUP BY titles.type
ORDER BY AvgPrice DESC;
-- títulos de libros junto con la fecha de publicación más reciente, ordenados por fecha de publicación en orden descendente
SELECT title, MAX(pubdate) AS LatestPublicationDate
FROM titles
GROUP BY title
ORDER BY LatestPublicationDate DESC;
--ciudades de las editoriales junto con la cantidad total de títulos publicados en cada ciudad, ordenadas por cantidad en orden descendente
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
--autores que han escrito al menos un libro con más de 300 páginas
SELECT authors.au_id, authors.au_lname, authors.au_fname
FROM authors
JOIN titleauthor ON authors.au_id = titleauthor.au_id
JOIN titles ON titleauthor.title_id = titles.title_id
WHERE titles.pages > 300
GROUP BY authors.au_id, authors.au_lname, authors.au_fname
HAVING COUNT(DISTINCT titles.title_id) >= 1;
-- ciudades de las editoriales que tienen al menos una editorial con menoz de 10 títulos publicados
SELECT publishers.city
FROM publishers
JOIN titles ON publishers.pub_id = titles.pub_id
GROUP BY publishers.city
HAVING COUNT(DISTINCT publishers.pub_id) >= 1
AND COUNT(DISTINCT titles.title_id) < 10;
--ategorías de libros junto con el precio promedio de los libros en cada categoría, incluyendo solo las categorías donde el precio promedio es inferior a $15
SELECT titles.type AS BookCategory, AVG(titles.price) AS AvgPrice
FROM titles
JOIN publishers ON titles.pub_id = publishers.pub_id
GROUP BY titles.type
HAVING AVG(titles.price) < 15;
--editoriales junto con la cantidad total de títulos publicados por cada editorial, incluyendo solo las editoriales que han publicado al menos 5 títulos y la cantidad de títulos es mayor a 5 veces la cantidad de editoriales
SELECT publishers.pub_name, COUNT(titles.title_id) AS TotalTitlesPublished
FROM publishers
JOIN titles ON publishers.pub_id = titles.pub_id
GROUP BY publishers.pub_name
HAVING COUNT(titles.title_id) >= 5
AND COUNT(titles.title_id) > 5 * COUNT(DISTINCT publishers.pub_id);
--ciudades de las editoriales junto con la cantidad total de editoriales en cada ciudad, incluyendo solo las ciudades con al menos 3 editoriales, y ordenarlas alfabéticamente por nombre de ciudad
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
--Listar las categorías de libros junto con la cantidad total de títulos en cada categoría, incluyendo solo las categorías con al menos 5 títulos y ordenarlas por cantidad de títulos en orden descendente
SELECT titles.type AS BookCategory, COUNT(titles.title_id) AS TotalTitles
FROM titles
GROUP BY titles.type
HAVING COUNT(titles.title_id) <= 5
ORDER BY TotalTitles DESC;
--editoriales junto con el precio promedio de los libros que han publicado, incluyendo solo las editoriales con un precio promedio menor a $20 y ordenarlas alfabéticamente por nombre de editorial
SELECT publishers.pub_name, AVG(titles.price) AS AvgPrice
FROM publishers
JOIN titles ON publishers.pub_id = titles.pub_id
GROUP BY publishers.pub_name
HAVING AVG(titles.price) < 20
ORDER BY publishers.pub_name;
--títulos de libros junto con la fecha de publicación más antigua, incluyendo solo los títulos con una fecha de publicación anterior a 1995 y ordenarlos por fecha de publicación en orden ascendente
SELECT titles.title, MIN(pubdate) AS OldestPublicationDate
FROM titles
GROUP BY titles.title
HAVING MIN(YEAR(pubdate)) < 1995
ORDER BY OldestPublicationDate ASC;
--Ordenar editoriales por la concatenación de pub_name, city y state
SELECT pub_name, city, state
FROM publishers
ORDER BY CONCAT(pub_name, ', ', city, ', ', state) ASC;
--Ordenar autores por la concatenación de au_lname y au_fname en orden descendente
SELECT au_lname, au_fname
FROM authors
ORDER BY CONCAT(au_lname, ', ', au_fname) DESC;
--títulos de libros por la concatenación de title y type en orden ascendente
SELECT title, type
FROM titles
ORDER BY CONCAT(title, ' (', type, ')') ASC;
--ventas por la concatenación de stor_id, ord_num y title_id en orden ascendente
SELECT stor_id, ord_num, title_id
FROM sales
ORDER BY CONCAT(stor_id, '-', ord_num, '-', title_id) ASC;
--contar el número de títulos de libros en cada categoría (considerando el texto en minúsculas)
SELECT LOWER(type) AS LowercaseCategory, COUNT(title_id) AS TotalTitles
FROM titles
GROUP BY LOWER(type)
ORDER BY TotalTitles DESC;
--Calcular el precio promedio de los libros publicados por cada editorial (considerando el texto en minúsculas)
SELECT LOWER(pub_name) AS LowercasePublisher, AVG(price) AS AvgPrice
FROM publishers
JOIN titles ON publishers.pub_id = titles.pub_id
GROUP BY LOWER(pub_name)
ORDER BY AvgPrice DESC;
--Listar los autores junto con la cantidad total de libros que han escrito (considerando el texto en minúsculas)
SELECT LOWER(au_lname) AS LowercaseLastName, LOWER(au_fname) AS LowercaseFirstName, COUNT(titleauthor.title_id) AS TotalBooksWritten
FROM authors
LEFT JOIN titleauthor ON authors.au_id = titleauthor.au_id
GROUP BY LOWER(au_lname), LOWER(au_fname)
ORDER BY TotalBooksWritten DESC;
--







































