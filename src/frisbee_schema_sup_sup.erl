-module(frisbee_schema_sup_sup).

-behaviour(supervisor).

%% API
-export([start_link/0, start_schema_sup/1]).

%% Supervisor callbacks
-export([init/1]).

%% Helper macro for declaring children of supervisor
-define(child(I, Type), {I, {I, start_link, []}, permanent, 5000, Type, [I]}).
-define(schema_sup_spec(Id), {Id, {frisbee_schema_sup, start_link, [Id]}, temporary, 5000, worker, [frisbee_schema_sup]}).

%% ===================================================================
%% API functions
%% ===================================================================

start_link() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

start_schema_sup(SchemaName) ->
    supervisor:start_child(?MODULE, ?schema_sup_spec(SchemaName)).

%% ===================================================================
%% Supervisor callbacks
%% ===================================================================

init([]) ->
    {ok, { {one_for_one, 5, 10}, []} }.

