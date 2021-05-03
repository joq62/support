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
	 severity_read/1,
	 print/1,
	 print/2,
	 print_new/0
	]).

-define(WAIT_FOR_TABLES,5000).

%% ====================================================================
%% External functions
%% ====================================================================



sort([{Pivot,Log}|T]) ->
    sort([ {P,I} || {P,I} <- T, P < Pivot]) ++
    [Log] ++
    sort([ {P,I} || {P,I} <- T, P >= Pivot]);
sort([]) -> [];
sort(X)->{error,X}.
%% --------------------------------------------------------------------
%% Function:tes cases
%% Description: List of test cases 
%% Returns: non
%% --------------------------------------------------------------------
print(MaxNum)->
    All=read_all(),
 %   DateTimeInSec=[{calendar:datetime_to_gregorian_seconds(DateTime),
%		    {Severity,Id,Status,DateTime,Modul,Function,Line,Info}}||
%		      {Severity,Id,Status,DateTime,Modul,Function,Line,Info}<-All],
    DateTimeInSec=[{Id,{Severity,Id,Status,DateTime,Modul,Function,Line,Info}}||
		      {Severity,Id,Status,DateTime,Modul,Function,Line,Info}<-All],
    lists:sublist(lists:reverse(sort(DateTimeInSec)),MaxNum).
print(WantedSeverity,MaxNum)->
    All=read_all(),
    DateTimeInSec=[{Id,{Severity,Id,Status,DateTime,Modul,Function,Line,Info}}||
		      {Severity,Id,Status,DateTime,Modul,Function,Line,Info}<-All,
		      WantedSeverity==Severity],
    lists:sublist(lists:reverse(sort(DateTimeInSec)),MaxNum).
print_new()->    
    All=read_all(),
    DateTimeInSec=[{Id,{Severity,Id,new,DateTime,Modul,Function,Line,Info}}||
		      {Severity,Id,new,DateTime,Modul,Function,Line,Info}<-All],
    lists:reverse(sort(DateTimeInSec)).
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
alert(DateTime,Module,Function,Line,Info)->
    Record=#log{
	      severity=alert,
	      id=os:system_time(micro_seconds),
	      status=new,	      
	      time=DateTime,
	      module=Module,
	      function=Function,
	      line=Line,
	      info=Info},
    F = fun() -> mnesia:write(Record) end,
    mnesia:transaction(F).
ticket(DateTime,Module,Function,Line,Info)->
    Record=#log{
	      severity=ticket,
	      id=os:system_time(micro_seconds),
	      status=new,	      
	      time=DateTime,
	      module=Module,
	      function=Function,
	      line=Line,
	      info=Info},
    F = fun() -> mnesia:write(Record) end,
    mnesia:transaction(F).

info(DateTime,Module,Function,Line,Info)->
    Record=#log{
	      severity=info,
	      id=os:system_time(micro_seconds),
	      status=new,	      
	      time=DateTime,
	      module=Module,
	      function=Function,
	      line=Line,
	      info=Info},
    F = fun() -> mnesia:write(Record) end,
    mnesia:transaction(F).
read_all()->
    Z=do(qlc:q([X || X <- mnesia:table(log)])),
    [{Severity,Id,Status,Time,Modul,Function,Line,Info}||{log,Severity,Id,Status,Time,Modul,Function,Line,Info}<-Z].


%calendar:datetime_to_gregorian_seconds({date(), time()}).


%% Function:start/0 
%% Description: Initiate the eunit tests, set upp needed processes etc
%% Returns: non
%% --------------------------------------------------------------------
severity_read(Severity) ->
    Z=do(qlc:q([X || X <- mnesia:table(log),
		     X#log.severity==Severity,
		     X#log.status==new])),
    New=[{XSeverity,Id,DateTime,Modul,Function,Line,Info}||{log,XSeverity,Id,new,DateTime,Modul,Function,Line,Info}<-Z],
    F = fun() -> 
		Log=do(qlc:q([X || X <- mnesia:table(log),
				   X#log.severity==Severity,
				   X#log.status==new])),
		case Log of
		    []->
			mnesia:abort(log);
		    NewInfo->
			[mnesia:delete_object(S)||S<-NewInfo],
			[mnesia:write(S#log{status=read})||S<-NewInfo]
		end
	end,
    mnesia:transaction(F),
    New.
