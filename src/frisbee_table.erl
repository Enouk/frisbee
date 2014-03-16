-module(frisbee_table).

-include("frisbee.hrl").

-export([
    init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3
]).

%% ====================================================================
%% API functions
%% ====================================================================
-export([
    start_link/1, stop/1
]).

start_link(TableName) ->
	gen_server:start_link(?MODULE, [TableName], []).

stop(Pid) when is_pid(Pid) ->
    gen_server:call(Pid, stop).

%% ====================================================================
%% State
%% ====================================================================
-record(state,
{
    name :: atom(),
    def :: fe_table()
}).

%% ====================================================================
%% Behavioural functions
%% ====================================================================

init([TableName]) ->
    SchemaName = frisbee_util:get_schema_name(TableName),
    Def = frisbee_schema:get_tabledef(SchemaName),
    {ok, #state{name=TableName, def=Def}}.

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