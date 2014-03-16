-module(frisbee).

-include("frisbee.hrl").

-export([start/0,stop/0,create_schema/1,drop_schema/1,create_table/2,drop_table/1,add_column/2,drop_column/1]).

-spec start() -> fe_result().
start() ->
	application:start(?MODULE).

-spec stop() -> fe_result().
stop() ->
	application:stop(?MODULE).

-spec create_schema(atom()) -> fe_result().
create_schema(Name) when is_atom(Name) ->
	frisbee_schema:create(Name).

-spec drop_schema(atom()) -> fe_result().
drop_schema(Name) when is_atom(Name) ->
	frisbee_schema:drop(Name).	

-spec create_table(atom(), fe_table()) -> fe_result().
create_table(Schema, #fe_table{} = T) ->
	frisbee_schema:create_table(Schema, T).

-spec drop_table(atom()) -> fe_result().
drop_table(Name) when is_atom(Name) ->
	frisbee_schema:drop_table(Name).

-spec add_column(atom(), fe_column()) -> fe_result().
add_column(TableName, #fe_column{} = C) when is_atom(TableName) ->
	frisbee_schema:add_column(TableName, C).

-spec drop_column(atom()) -> fe_result().
drop_column(Name) when is_atom(Name) ->
	frisbee_schema:drop_column(Name).


