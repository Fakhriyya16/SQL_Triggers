
create table Teachers(
	[Id] int primary key identity(1,1),
	[Name] nvarchar(50),
	[Surname] nvarchar(50),
	[Email] nvarchar(100),
	[Age] int
)

insert into Teachers([Name],[Surname],[Email],[Age])
values  ('Reshad','Agayev','reshad@mail.ru',21),
		('Ilqar','Shiriyev','ilqar@mail.ru',26),
		('Behruz','Aliyev','behruz@mail.ru',35),
		('Hacixan','Hacixanov','hacixan@mail.ru',19)

select * from Teachers

create view getTeacherWithId
as
select * from Teachers where [Id]>3

select * from getTeacherWithId

create view getTeacherWithAge
as
select * from Teachers where [Age] > 18

select * from getTeacherWithAge

create view getTeacherWithAgeAsc
as
select Top 3 * from Teachers where [Age] > 20

select * from getTeacherWithAgeAsc



create function sayHelloWorld()
returns nvarchar(50)
as
begin
	return 'Hello World'
end

declare @data nvarchar(50) = (select dbo.sayHelloWorld())
print @data


create function dbo.showText(@text nvarchar(50))
returns nvarchar(50)
as
begin
	return @text
end

select dbo.showText('Hello')


create function dbo.sumOfNums(@num1 int,@num2 int)
returns int
as
begin
	return @num1+@num2
end

declare @id int = (select dbo.sumOfNums(1,2))

select * from Teachers where [Id] = @id


create function dbo.getTeachersByAge(@age int)
returns int
as
begin
	declare @count int;
	select @count = Count(*) from Teachers where [Age] = @age
	return @count
end

select dbo.getTeachersByAge(19) as 'Teachers count'

create function dbo.getAllTeachers()
returns table
as
return (select * from Teachers)

select * from dbo.getAllTeachers()

create function dbo.searchTeachersbyName(@searchText nvarchar(50))
returns table
as
return (
	select * from Teachers where [Name] like '%' + @searchText + '%'
)

select * from dbo.searchTeachersbyName('a')


create procedure usp_ShowText
as
begin
	print 'Hello'
end

create procedure usp_ShowText2
@text nvarchar(50)
as
begin
	print @text
end

exec usp_ShowText2 'HelloWorld'


create procedure usp_createTeacher
@Name nvarchar(50),
@Surname nvarchar(50),
@Email nvarchar(100),
@Age int
as
begin
	insert into Teachers([Name],[Surname],[Email],[Age])
	values (@Name,@Surname,@Email,@Age)
end

exec usp_createTeacher 'Fexriyye','Tagizade','fexriyye@mail.ru',21

select * from Teachers

create procedure usp_deleteTeacherById
@id int
as
begin
	delete from Teachers where [Id] = @id
end

exec usp_deleteTeacherById 4


create function dbo.getTeachersAvgAge(@id int)
returns int
as
begin
	declare @avAge int;
	select @avAge = AVG(Age) from Teachers where [Id] > @id
	return @avAge
end

select dbo.getTeachersAvgAge(3) as 'average age'

create procedure usp_changeTeachersNameByCondition
@id int,
@Name nvarchar(50)
as
begin
	declare @avAge int = (select dbo.getTeachersAvgAge(@id))
	update Teachers
	set [Name] = @Name
	where [Age] > @avAge
end

exec usp_changeTeachersNameByCondition 3,'XXX'

create table TeacherLogs(
	[Id] int primary key identity(1,1),
	[TeacherId] int,
	[Operation] nvarchar(30),
	[Date] datetime
)

create trigger trg_createTeacher on Teachers
after insert
as
begin
	insert into TeacherLogs([TeacherId],[Operation],[Date])
	select [Id],'Insert',GETDATE() from inserted
end

select * from TeacherLogs

exec usp_createTeacher 'Afide','Veliyeva','afide@mail.ru',38


create trigger trg_deleteTeacherLog on Teachers
after delete
as
begin
	insert into TeacherLogs([TeacherId],[Operation],[Date])
	select [Id],'Delete',GETDATE() from deleted
end

exec usp_deleteTeacherById 6



