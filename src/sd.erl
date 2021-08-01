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


%% ====================================================================
%% External functions
%% ====================================================================

%% --------------------------------------------------------------------
%% Function:start/0 
%% Description: Initiate the eunit tests, set upp needed processes etc
%% Returns: non
%% --------------------------------------------------------------------
all()->
    Apps=[{Node,rpc:call(Node,application,which_applications,[],5*1000)}||Node<-[node()|nodes()]],
    AvailableNodes=[{Node,AppList}||{Node,AppList}<-Apps],
    AvailableNodes.
    

get(WantedApp)->
    Apps=[{Node,rpc:call(Node,application,which_applications,[],5*1000)}||Node<-[node()|nodes()]],
    AvailableNodes=[Node||{Node,AppList}<-Apps,
			  true==lists:keymember(WantedApp,1,AppList)],
    AvailableNodes.

get(WantedApp,WantedNode)->
    Apps=[{Node,rpc:call(Node,application,which_applications,[],5*1000)}||Node<-[node()|nodes()]],
    AvailableNodes=[WantedNode||{Node,AppList}<-Apps,
				true==lists:keymember(WantedApp,1,AppList),
				Node==WantedNode],
    AvailableNodes.


%% --------------------------------------------------------------------
%% Function:start/0 
%% Description: Initiate the eunit tests, set upp needed processes etc
%% Returns: non
%% --------------------------------------------------------------------
