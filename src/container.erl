%%% -------------------------------------------------------------------
%%% Author  : uabjle
%%% Description : dbase using dets 
%%% 
%%% Created : 10 dec 2012
%%% --------------------------------------------------------------------
-module(container).  
   
%% --------------------------------------------------------------------
%% Include files
%% --------------------------------------------------------------------
-include("kube_logger.hrl").
%% --------------------------------------------------------------------

% New final ?

-export([
	 load_start/2,
	 stop_unload/2
	]).

%% ====================================================================
%% External functions
%% ====================================================================
%% --------------------------------------------------------------------
%% Function:start
%% Description: List of test cases 
%% Returns: non
%% --------------------------------------------------------------------


load_start({AppId,AppVsn,GitPath,AppEnv},Pods)->
    NumPods=lists:flatlength(Pods),
    N=rand:uniform(NumPods),
    WorkerPod=lists:nth(N,Pods),
    Dir=db_kubelet:dir(WorkerPod),
    Result=case load(AppId,AppVsn,GitPath,AppEnv,WorkerPod,Dir) of
	       {error,Reason}->
		   {error,Reason};
	       ok ->
		   case start(AppId,WorkerPod) of
		       {error,Reason}->
			   {error,Reason};
		       ok->
			   {atomic,ok}=db_kubelet:add_container(WorkerPod,{AppId,AppVsn,GitPath,AppEnv}),
			   {ok,{AppId,AppVsn,GitPath,AppEnv},WorkerPod}
		   end
	   end,
    Result.
    
load(AppId,_AppVsn,GitPath,AppEnv,Pod,Dir)->
    Result = case rpc:call(Pod,application,which_applications,[],5*1000) of
		 {badrpc,Reason}->
		     {error,[badrpc,Reason,?FUNCTION_NAME,?MODULE,?LINE]};
		 LoadedApps->
		     case lists:keymember(list_to_atom(AppId),1,LoadedApps) of
			 true->
			     ?PrintLog(log,'Already loaded',[AppId,Pod,?FUNCTION_NAME,?MODULE,?LINE]),
			     {error,['Already loaded',AppId,Pod]};
			 false ->
			     AppDir=filename:join(Dir,AppId),
			     AppEbin=filename:join(AppDir,"ebin"),
			     App=list_to_atom(AppId),
			     rpc:call(Pod,os,cmd,["rm -rf "++AppId],25*1000),
			     _GitResult=rpc:call(Pod,os,cmd,["git clone "++GitPath],25*1000),
				%	   ?PrintLog(log,"GitResult",[PodNode,GitPath,GitResult,?FUNCTION_NAME,?MODULE,?LINE]),
			     _MVResult=rpc:call(Pod,os,cmd,["mv "++AppId++" "++AppDir],25*1000),
				%	   ?PrintLog(log,"MVResult",[AppId,AppDir,MVResult,?FUNCTION_NAME,?MODULE,?LINE]),
			     true=rpc:call(Pod,code,add_patha,[AppEbin],22*1000),
			     ok=rpc:call(Pod,application,set_env,[[{App,AppEnv}]]),		       
			     ok
		     end
	     end,
    Result.

start(AppId,Pod)->
    App=list_to_atom(AppId),
    ?PrintLog(debug,"App,Pod",[App,Pod,?FUNCTION_NAME,?MODULE,?LINE]),
    Result=case rpc:call(Pod,application,start,[App],2*60*1000) of
	       ok->
		   ok;
	       {error,{already_started}}->
		   ok;
	       {Error,Reason}->
		   {Error,[Reason,application,Pod,start,App,?FUNCTION_NAME,?MODULE,?LINE]}
	   end,
    Result.

    
%% --------------------------------------------------------------------
%% Function:start
%% Description: List of test cases 
%% Returns: non
%% --------------------------------------------------------------------
stop_unload(Pod,{AppId,AppVsn,GitPath,AppEnv})->
    Dir=db_kubelet:dir(Pod),
    AppDir=filename:join(Dir,AppId),
    App=list_to_atom(AppId),
    rpc:call(Pod,application,stop,[App],5*1000),
    rpc:call(Pod,application,unload,[App],5*1000),
    rpc:call(Pod,os,cmd,["rm -rf "++AppDir],3*1000),
    {atomic,ok}=db_kubelet:delete_container(Pod,{AppId,AppVsn,GitPath,AppEnv}),
    ok.
    
%% --------------------------------------------------------------------
%% Function:start
%% Description: List of test cases 
%% Returns: non
%% --------------------------------------------------------------------
