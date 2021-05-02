%%% -------------------------------------------------------------------
%%% Author  : uabjle
%%% Description :
%%%
%%% Created : 10 dec 2012
%%% -------------------------------------------------------------------
-module(support_unit_test_sup).

-behaviour(supervisor).
%% --------------------------------------------------------------------
%% Include files
%% --------------------------------------------------------------------
 
%% --------------------------------------------------------------------
%% Definitions 

%% --------------------------------------------------------------------

%% --------------------------------------------------------------------
%% External exports
%% --------------------------------------------------------------------

-export([start_link/0]).

%% --------------------------------------------------------------------
%% Internal exports
%% --------------------------------------------------------------------
-export([
	 init/1
        ]).

%% --------------------------------------------------------------------
%% Macros
%% --------------------------------------------------------------------
-define(SERVER, ?MODULE).
%% Helper macro for declaring children of supervisor
-define(CHILD(I, Type), {I, {I, start, []}, permanent, 5000, Type, [I]}).
%% --------------------------------------------------------------------
%% Records
%% --------------------------------------------------------------------

%% ====================================================================
%% External functions
%% ====================================================================

start_link()->
   supervisor:start_link({local,?MODULE}, ?MODULE,[]).




%% ====================================================================
%% Server functions
%% ====================================================================
%% --------------------------------------------------------------------
%% Func: init/1
%% Returns: {ok,  {SupFlags,  [ChildSpec]}} |
%%          ignore                          |
%%          {error, Reason}
%% --------------------------------------------------------------------
init([]) ->
    {ok,{{one_for_one,5,10}, 
	children()
	}
    }.
children()->
    [
     ?CHILD(support_unit_test,worker)
    ].
%% ====================================================================
%% Internal functions
%% ====================================================================
