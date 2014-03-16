-module(frisbee_util).

-export([get_schema_name/1,get_table_name/1]).

get_schema_name(Name) ->
	S = atom_to_list(Name),
	[Schema|_R] = string:tokens(S, "."),
	list_to_existing_atom(Schema).

get_table_name(Name) ->
	S = atom_to_list(Name),
	Idx = string:rstr(S, "."),
	list_to_existing_atom(string:substr(S, 1, Idx-1)).


%% ====================================================================
%% Unit Tests 
%% ====================================================================
-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").

get_schema_name_test() ->
	schema0 = get_schema_name('schema0.table0.column0').

get_table_name_test() ->
	'schema0.table0' = get_table_name('schema0.table0.column0').

-endif.
