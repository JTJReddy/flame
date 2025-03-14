drop procedure if EXISTS dbo.CalculateFLAMES1
go
CREATE  procedure dbo.CalculateFLAMES1 (@name1 VARCHAR(50), @name2 VARCHAR(50))
AS
BEGIN
---uppercase----and remove space----

--set @name1=UPPER(REPLACE(@name1,'',''))
--set @name2=UPPER(REPLACE(@name2,'',''))

set @name1=UPPER(@name1)
set @name2=UPPER(@name2)
-----remove common character------

declare @i int=1
while @i<=len(@name1)
begin
declare @char char(1)=substring(@name1,@i,1)
if(CHARINDEX(@char,@name2))>0
begin
set @name1=stuff(@name1,@i,1,'')
set @name2=STUFF(@name2,CHARINDEX(@char,@name2),1,'')
set @i=@i-1
end
set @i=@i+1
end

--calculate the reamining string-----

Declare @count int=len(@name1)+len(@name2)

---flames outcome------

declare @flames nvarchar(6)='FLAMES'
declare @index int

while len(@flames)>1
begin
---calculate ---position to remove----

set @index=(@count %len(@flames))
IF @index=0
set @index=len(@flames)

--remove calculated --position-----
set @flames=STUFF(@flames,@index,1,'')

--start from next character----

set @flames=SUBSTRING(@flames,@index,len(@flames)-@index+1)+SUBSTRING(@flames,1,@index-1)
end
---display the result----

declare @result nvarchar(50)

set @result=case @flames
when 'F' then 'FRIENDS'
when 'L' then 'LOVER'
when 'A' then 'AFFECTION'
when 'M' then 'MARRIAGE'
when 'E' then 'ENEMY'
when 'S' then 'SISTER'         
END
SELECT @result
end
go

exec dbo.CalculateFLAMES1 'vignesh','geetha'
