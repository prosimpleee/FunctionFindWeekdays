--Create table holiday 
CREATE TABLE holiday ([Date] Date NOT NULL UNIQUE);

--Alter table for adding a check
ALTER TABLE holiday ADD CONSTRAINT check_date CHECK (DATENAME(WEEKDAY, DATE) NOT IN ('Saturday', 'Sunday'));

--Add values for table holiday 
DECLARE @Year char(4) = 2021,
		@Date datetime

-- New Years Day
SET @Date=CONVERT(date, @Year +'-01-01' ) 
IF DATENAME( dw, @Date ) = 'Saturday'
    SET @Date=@Date-1
ELSE IF DATENAME( dw, @Date ) = 'Sunday'
    SET @Date=@Date+1

INSERT INTO holiday 
SELECT @Date

-- Christmas
SET @Date=CONVERT(date, @Year +'-12-25' ) 
IF DATENAME( dw, @Date ) = 'Saturday'
    SET @Date=@Date-1
ELSE IF DATENAME( dw, @Date ) = 'Sunday'
    SET @Date=@Date+1

INSERT INTO holiday 
SELECT @Date

-- Independence Day
SET @Date=CONVERT(date, @Year +'-07-04' ) 
IF DATENAME( dw, @Date ) = 'Saturday'
    SET @Date=@Date-1
ELSE IF DATENAME( dw, @Date ) = 'Sunday'
    SET @Date=@Date+1

INSERT INTO holiday 
SELECT @Date

SELECT * 
FROM holiday --The code was run with a variable, where @Year = 2021 and 2020
 
 
 
--Create function (returns count of days with the weekend)
CREATE FUNCTION count_work_day (@start_day DATE, @end_day DATE) RETURNS INT AS BEGIN DECLARE @holidays INT =
  (SELECT COUNT (*)
   FROM holiday
   WHERE Date BETWEEN @start_day AND @end_day) DECLARE @datediff INT =
  (SELECT datediff(DAY, @start_day, @end_day)-(2)*datediff(WEEK, @start_day, @end_day) - @holidays) RETURN @datediff END;

--Select dates
SELECT dbo.count_work_day ('2020-12-28', '2021-01-11');
