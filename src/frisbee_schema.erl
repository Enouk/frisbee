-module(frisbee_schema).

-include("frisbee.hrl").

-export([
    init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3
]).

%% ====================================================================
%% API functions
%% ====================================================================
-export([
    start_link/1,stop/1,get_tabledef/1,create/1,drop/1,create_table/2,drop_table/1,add_column/2,drop_column/1,get_columndef/1]).

start_link(SchemaName) ->
	gen_server:start_link(?MODULE, [SchemaName], []).

stop(Pid) when is_pid(Pid) ->
    gen_server:call(Pid, stop).

-spec create(atom()) -> fe_result().
create(Name) when is_atom(Name)->
    {error, not_impl}.

drop(_Name) ->
    {error, not_impl}.

create_table(_SchemaName, #fe_table{} = _T) ->
    {error, not_impl}.

drop_table(_Name) ->
    {error, not_impl}.

add_column(_TableName, #fe_column{} = _C ) ->
    {error, not_impl}.

drop_column(_Name) ->
    {error, not_impl}.
    
get_tabledef(Name) ->
	SchemaName = frisbee_util:get_schema_name(Name),
	gen_server:call(SchemaName, {get_tabledef, Name}).

get_columndef(Name) ->
    SchemaName = frisbee_util:get_schema_name(Name),
    gen_server:call(SchemaName, {get_columndef, Name}).

%% ====================================================================
%% State
%% ====================================================================
-record(state,
{
    name :: atom(),
    def :: fe_schema()
}).

%% ====================================================================
%% Behavioural functions
%% ====================================================================

init([SchemaName]) ->
    {ok, #state{name=SchemaName}}.

handle_call({get_tabledef, TableName}, _From, #state{def=D} = S) ->
    [T] = [X || X <- D#fe_schema.tables, X#fe_table.name =:= TableName],
    {reply, T, S};
handle_call(_Request, _From, State) ->
    Reply = ok,
    {reply, Reply, State}.

handle_cast(_Msg, State) ->
    {noreply, State}.

handle_info(_Info, State) ->
    {noreply, State}.

terminate(_Reason, _State) ->
    ok.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.