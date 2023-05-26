create view PartiotinedView
as
	select number, value from dbo.PositiveNumbers
	union all
	select number, value from dbo.NegativeNumbers;