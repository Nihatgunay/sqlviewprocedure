create database LibraryDB
use LibraryDB

create table Authors(
	Id int identity primary key,
	Name varchar(100) default 'author name',
	Surname varchar(100) default 'author surname'
)
create table Books(
	Id int identity primary key,
	AuthorId int foreign key references Authors(Id),
	Name varchar(100) default 'book name',
	PageCount int check(PageCount > 0)
)

insert into Authors
values
('JK','Rowling'),
('JRR','Talkien'),
('RR','Martin')

insert into Books
values
(1, 'Harry potter & stone', 300),
(1, 'Harry potter & azkaban', 350),
(2, 'Lord of the rings 1', 400),
(2, 'Lord of the rings 2', 380),
(3, 'game of thrones', 500),
(3, 'dance with dragons', 200)

create view Get_Author_Book as 
select b.Id, b.Name as 'book name', b.PageCount as 'book pagecount', a.Name as 'author name', a.Surname as 'author surname'
from Books as b inner join Authors as a
on a.Id = b.AuthorId

create view Get_Author as
select a.Id, a.Name, a.Surname, COUNT(b.Id) as 'book count', MAX(b.PageCount) as 'max pagecount'
from Authors as a inner join Books as b
on a.Id = b.AuthorId
group by a.Id, a.Name, a.Surname

create procedure Get_book_by_bookName @bookname varchar(100) as 
select B.Id, B.Name as 'book name', B.PageCount as 'book pagecount', A.Name as 'author name', A.Surname as 'author surname'
from Books as B inner join Authors as A on A.Id = B.AuthorId
where b.Name = @bookname

create procedure Get_books_by_AuthorName @authorname varchar(100) as 
select B.Id, B.Name as 'book name', B.PageCount as 'book pagecount', A.Name as 'author name', A.Surname as 'author surname'
from Books as B inner join Authors as A on A.Id = B.AuthorId
where a.Name = @authorname

exec Get_book_by_bookName @bookname = 'Harry potter & azkaban'
exec Get_books_by_AuthorName @authorname = 'JK'

select * from Get_Author_Book
select * from Get_Author