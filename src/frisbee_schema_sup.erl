-module(frisbee_schema_sup).

-behaviour(supervisor).

%% API
-export([start_link/1]).

%% Supervisor callbacks
-export([init/1]).

%% Helper macro for declaring children of supervisor
-define(child(I, Type), {I, {I, start_link, []}, permanent, 5000, Type, [I]}).

%% ===================================================================
%% API functions
%% ===================================================================

start_link(SchemaName) ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, [SchemaName]).

%% ===================================================================
%% Supervisor callbacks
%% ===================================================================

init([_SchemaName]) ->
    {ok, { {one_for_one, 5, 10}, []} }.

