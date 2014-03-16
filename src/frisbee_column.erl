-module(frisbee_column).

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

start_link(ColumnName) ->
	gen_server:start_link(?MODULE, [ColumnName], []).

stop(Pid) when is_pid(Pid) ->
    gen_server:call(Pid, stop).

%% ====================================================================
%% State
%% ====================================================================
-record(state,
{
    name :: atom(),
    def :: fe_column()
}).

%% ====================================================================
%% Behavioural functions
%% ====================================================================

init([ColumnName]) ->
    Def = frisbee_schema:get_columndef(ColumnName),
    {ok, #state{name=ColumnName, def=Def}}.

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