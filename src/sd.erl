%%% -------------------------------------------------------------------
%%% Author  : uabjle
%%% Description : dbase using dets 
%%% 
%%% Created : 10 dec 2012
%%% -------------------------------------------------------------------
-module(sd).  
   
%% --------------------------------------------------------------------
%% Include files
%% --------------------------------------------------------------------

%%---------------------------------------------------------------------
%% Records for test
%%

%% --------------------------------------------------------------------
-compile(export_all).

-define(DbaseVmId,"dbase").
%% ====================================================================
%% External functions
%% ====================================================================

%% --------------------------------------------------------------------
%% Function:start/0 
%% Description: Initiate the eunit tests, set upp needed processes etc
%% Returns: non
%% --------------------------------------------------------------------
get(ServiceId)->
    DbaseNode=misc_node:node(?DbaseVmId),
    rpc:call(DbaseNode,db_sd,get,[ServiceId],2000).

get_one(ServiceId)->
    DbaseNode=misc_node:node(?DbaseVmId),
    [ServiceNode|_]=rpc:call(DbaseNode,db_sd,get,[ServiceId],2000),
    ServiceNode.
    
    
%% --------------------------------------------------------------------
%% Function:start/0 
%% Description: Initiate the eunit tests, set upp needed processes etc
%% Returns: non
%% --------------------------------------------------------------------
dbase_node()->
    DbaseNode=misc_node:node(?DbaseVmId),
    DbaseNode.
