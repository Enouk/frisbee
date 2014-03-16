

-type fe_result() :: ok | {error, term()}.
-type fe_col_type() :: binary | integer | float | string.

-record(fe_schema, {
	name :: string(),
	tables :: list(fe_table())
}).
-type fe_schema() :: #fe_schema{}.


-record(fe_table, {
	name :: string(),
	columns :: list(fe_column())
}).
-type fe_table() :: #fe_table{}.

-record(fe_column, {
	name :: string(),
	type :: fe_col_type()
}).
-type fe_column() :: #fe_column{}.