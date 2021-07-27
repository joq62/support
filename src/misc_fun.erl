%%% -------------------------------------------------------------------
%%% Author  : uabjle
%%% Description : dbase using dets 
%%% 
%%% Created : 10 dec 2012
%%% -------------------------------------------------------------------
-module(misc_fun).  
   
%% --------------------------------------------------------------------
%% Include files
%% --------------------------------------------------------------------

%%---------------------------------------------------------------------
%% Records for test
%%

%% --------------------------------------------------------------------
-compile(export_all).


%% ====================================================================
%% External functions
%% ====================================================================
date_time()->
    Date=print_date(),
    Time=print_time(),
    Date++"-"++Time.

print_time()->
    print_time(time()).
print_time({H,M,S})->
    if
	H<10->
	    H1="0"++integer_to_list(H);
	true->
	    H1=integer_to_list(H)
    end,
    if
	M<10->
	    M1="0"++integer_to_list(M);
	true->
	    M1=integer_to_list(M)
    end,
    if
	S<10->
	    S1="0"++integer_to_list(S);
	true->
	    S1=integer_to_list(S)
    end,
    Time=H1++":"++M1++":"++S1,
    Time.   

print_date()->
    print_date(date()).
print_date({Y,M,D})->
    Y1=integer_to_list(Y-2000),
    if
	M<10->
	    M1="0"++integer_to_list(M);
	true->
	    M1=integer_to_list(M)
    end,
    if
	D<10->
	    D1="0"++integer_to_list(D);
	true->
	    D1=integer_to_list(D)
    end,
    Date=Y1++M1++D1,
    Date.   
    
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
vmid_hostid(Node)->
    NodeStr=atom_to_list(Node),
    [VmId,HostId]=string:lexemes(NodeStr,"@"),
    {VmId,HostId}.
