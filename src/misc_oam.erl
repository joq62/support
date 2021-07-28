%%% -------------------------------------------------------------------
%%% Author  : uabjle
%%% Description : dbase using dets 
%%% 
%%% Created : 10 dec 2012
%%% -------------------------------------------------------------------
-module(misc_oam).  
   
%% --------------------------------------------------------------------
%% Include files
%% --------------------------------------------------------------------
-define(TerminalVmId,"terminal").
-define(Terminal,'terminal@c2').
-define(LogTerminals,['log_terminal@c2',
		      'log_terminal@c1',
		      'log_terminal@c0']).
-define(AlertTicketTerminals,['alert_ticket_terminal@c2',
			      'alert_ticket_terminal@c1',
			      'alert_ticket_terminal@c0']).
-define(Masters,['master@c2','master@c1','master@c0',
		 'boot_master@c2','boot_master@c1','boot_master@c0',
		'test_dbase@c2']).
%%---------------------------------------------------------------------
%% Records for test
%%

%% --------------------------------------------------------------------
-compile(export_all).


%% ====================================================================
%% External functions
%% ====================================================================
start_slave(NodeName)->
    Cookie=atom_to_list(rpc:call(node(),erlang,get_cookie,[],5*1000)),
    Args="-setcookie "++Cookie,
    {ok,Host}=inet:gethostname(),
    slave:start(Host,NodeName,Args).


print(Text,T)->
    rpc:call(?Terminal,terminal,print,[Text],T).

print(Text,List,T)->
    rpc:call(?Terminal,terminal,print,[Text,List],T).
%% --------------------------------------------------------------------
%% Function:start/0 
%% Description: Initiate the eunit tests, set upp needed processes etc
%% Returns: non
%% --------------------------------------------------------------------
node(Name)->
    {ok,HostId}=net:gethostname(),
    list_to_atom(Name++"@"++HostId).
%% --------------------------------------------------------------------
%% Function:start/0 
%% Description: Initiate the eunit tests, set upp needed processes etc
%% Returns: non
%% --------------------------------------------------------------------
get_log_terminals()->
    VmStrList=[{string:lexemes([atom_to_list(Node)],"@"),Node}||Node<-[node()|nodes()]],
    [Node||{[?TerminalVmId,_],Node}<-VmStrList].
   % VmStrList.    
					       

log_terminals()->
    ?LogTerminals.
alert_ticket_terminals()->
    ?AlertTicketTerminals.

masters()->
    ?Masters.
