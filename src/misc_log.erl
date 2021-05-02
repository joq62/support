%%% -------------------------------------------------------------------
%%% Author  : uabjle
%%% Description : dbase using dets 
%%% 
%%% Created : 10 dec 2012
%%% -------------------------------------------------------------------
-module(misc_log).  
   
%% --------------------------------------------------------------------
%% Include files
%% --------------------------------------------------------------------

-import(lists, [foreach/2]).
-include_lib("stdlib/include/qlc.hrl").
%%---------------------------------------------------------------------
%% Records for test
%%

%% --------------------------------------------------------------------


%% ====================================================================
%% External functions
%% ====================================================================

%% --------------------------------------------------------------------
%% Function:start/0 
%% Description: Initiate the eunit tests, set upp needed processes etc
%% Returns: non
%% --------------------------------------------------------------------

%% --------------------------------------------------------------------
-record(log,{
	     severity,
	     id,
	     status,
	     time,
	     module,
	     function,
	     line,
	      info
	    }).


%% External exports
-export([start/0,
	 alert/5,
	 ticket/5,
	 info/5,
	 read_all/0,
	 severity_read/1
	]).

-define(WAIT_FOR_TABLES,5000).

%% ====================================================================
%% External functions
%% ====================================================================

%% --------------------------------------------------------------------
%% Function:tes cases
%% Description: List of test cases 
%% Returns: non
%% --------------------------------------------------------------------

start()->
    mnesia:create_table(log,[{attributes, record_info(fields,log)},
			    {type,bag}]),
    mnesia:wait_for_tables([log], 20000),
    ok.



%% --------------------------------------------------------------------
%% Function:start/0 
%% Description: Initiate the eunit tests, set upp needed processes etc
%% Returns: non
%% --------------------------------------------------------------------

do(Q) ->
  F = fun() -> qlc:e(Q) end,
  {atomic, Val} = mnesia:transaction(F),
  Val.

%% --------------------------------------------------------------------
%% Function:start/0 
%% Description: Initiate the eunit tests, set upp needed processes etc
%% Returns: non
%% --------------------------------------------------------------------
alert(Time,Module,Function,Line,Info)->
    Record=#log{
	      severity=alert,
	      id=os:system_time(micro_seconds),
	      status=new,	      
	      time=Time,
	      module=Module,
	      function=Function,
	      line=Line,
	      info=Info},
    F = fun() -> mnesia:write(Record) end,
    mnesia:transaction(F).
ticket(Time,Module,Function,Line,Info)->
    Record=#log{
	      severity=ticket,
	      id=os:system_time(micro_seconds),
	      status=new,	      
	      time=Time,
	      module=Module,
	      function=Function,
	      line=Line,
	      info=Info},
    F = fun() -> mnesia:write(Record) end,
    mnesia:transaction(F).

info(Time,Module,Function,Line,Info)->
    Record=#log{
	      severity=info,
	      id=os:system_time(micro_seconds),
	      status=new,	      
	      time=Time,
	      module=Module,
	      function=Function,
	      line=Line,
	      info=Info},
    F = fun() -> mnesia:write(Record) end,
    mnesia:transaction(F).
read_all()->
    Z=do(qlc:q([X || X <- mnesia:table(log)])),
    [{Severity,Id,Status,Time,Modul,Function,Line,Info}||{log,Severity,Id,Status,Time,Modul,Function,Line,Info}<-Z].

severity_read(Severity) ->
    Z=do(qlc:q([X || X <- mnesia:table(log),
		   X#log.severity==Severity])),
    [{Severity,Id,Status,Time,Modul,Function,Line,Info}||{log,Severity,Id,Status,Time,Modul,Function,Line,Info}<-Z].


%% Function:start/0 
%% Description: Initiate the eunit tests, set upp needed processes etc
%% Returns: non
%% --------------------------------------------------------------------
