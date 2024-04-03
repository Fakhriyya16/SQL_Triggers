create table Students(
	[Id] int primary key identity(1,1),
	[Name] nvarchar(50),
	[Surname] nvarchar(50),
	[Age] int,
	[Email] nvarchar(50),
	[Address] nvarchar(50)
)

create table StudentArchives(
	[Id] int,
	[Name] nvarchar(50),
	[Surname] nvarchar(50),
	[Age] int,
	[Email] nvarchar(50),
	[Address] nvarchar(50)
)

create procedure usp_createStudent
@Name nvarchar(50),
@Surname nvarchar(50),
@Age int,
@Email nvarchar(50),
@Address nvarchar(50)
as
begin
	insert into Students([Name],[Surname],[Age],[Email],[Address])
	values (@Name,@Surname,@Age,@Email,@Address)
end

exec usp_createStudent 'Name1','Surname1',19,'email1@mail.ru','address1'
exec usp_createStudent 'Name2','Surname3',29,'email2@mail.ru','address2'
exec usp_createStudent 'Name2','Surname3',16,'email3@mail.ru','address3'


create procedure usp_deleteStudentById
@id int
as 
begin
	delete from Students where [Id]=@id
end


create trigger trg_addDeletedStudentToArchive on Students
after delete
as
begin
	insert into StudentArchives([Id],[Name],[Surname],[Age],[Email],[Address])
	select [Id],[Name],[Surname],[Age],[Email],[Address] from deleted
end

exec usp_deleteStudentById 2

select * from Students
select * from StudentArchives