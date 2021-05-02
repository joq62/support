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
-define(SyslogNodes,['syslog@c2','syslog@c1','syslog@c0']).
%%---------------------------------------------------------------------
%% Records for test
%%

%% --------------------------------------------------------------------
-compile(export_all).


%% ====================================================================
%% External functions
%% ====================================================================
syslog_nodes()->
    ?SyslogNodes.


msg(Type,MsgList,Node,Module,Line)->
    rpc:cast(node(),rpc,multicall,[?SyslogNodes,syslog,Type,
				   [MsgList,Node,Module,Line],2000]).
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
