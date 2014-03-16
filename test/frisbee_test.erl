-module(frisbee_test).

-include("frisbee.hrl").
-include_lib("eunit/include/eunit.hrl").


setup() -> 
    frisbee:start().

teardown(_) -> 
    frisbee:stop().

schema_test() ->
	ok.

table_test_() ->
    {setup, fun setup/0, fun teardown/1,
        [
            {"create table", fun create_table_tc/0}
        ]
    }.

create_table_tc() ->
	ok = frisbee:create_schema(myschema),
	T = #fe_table{
		name = 'mytable',
		columns = [#fe_column{name='mycolumn', type=integer}]
	},
	ok = frisbee:create_table(myschema, T),
	{ok, T} = frisbee:get_tabledef('myschema.mytable').

