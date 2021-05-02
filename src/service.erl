%%% -------------------------------------------------------------------
%%% @author : joqerlang
%%% @doc : ets dbase for master service to manage app info , catalog  
%%%
%%% -------------------------------------------------------------------
-module(service).
 

%% --------------------------------------------------------------------
%% Include files
%% --------------------------------------------------------------------

%-compile(export_all).
-export([create/5,
	 create/7
	]).



%% ====================================================================
%% External functions
%% ====================================================================
create(ServiceId,ServiceVsn,StartCmd,EnvVars,GitPath)->
    ServiceDir=string:concat(ServiceId,misc_cmn:vsn_to_string(ServiceVsn)),
    GitDest=ServiceDir,
    CodePath=filename:join([ServiceDir,"ebin"]),
    {M,F,A}=StartCmd,
    file:del_dir_r(GitDest),
    os:cmd("git clone "++GitPath++" "++GitDest),
    true=code:add_patha(CodePath),
    [application:set_env(App,Par,Val)||{App,Par,Val}<-EnvVars],
    
    Result=case rpc:call(node(),M,F,A) of
	       ok->
		   [ServiceModule]=A,
		   case rpc:call(node(),ServiceModule,ping,[],3000) of
		       {pong,_,ServiceModule}->
			   {ok,ServiceId,ServiceVsn};
		       Reason->
			   {error,[Reason,?MODULE,?LINE]}
		   end;
	       Reason->
		   {error,[Reason,?MODULE,?LINE]}
	   end,
    Result.

%% --------------------------------------------------------------------
%% 
%%
%% --------------------------------------------------------------------
create(ServiceId,ServiceVsn,Vm,VmDir,StartCmd,EnvVars,GitPath)->
    ServiceDir=string:concat(ServiceId,misc_cmn:vsn_to_string(ServiceVsn)),
    GitDest=filename:join(VmDir,ServiceDir),
    CodePath=filename:join([VmDir,ServiceDir,"ebin"]),
    {M,F,A}=StartCmd,
    true=vm:vm_started(Vm),
    rpc:call(Vm,file,del_dir_r,[GitDest],3000),
    rpc:call(Vm,os,cmd,["git clone "++GitPath++" "++GitDest],10*1000),
    true=rpc:call(Vm,code,add_patha,[CodePath],3000),
    
    [rpc:call(Vm,application,set_env,[App,Par,Val],2000)||{App,Par,Val}<-EnvVars],
    
    Result=case rpc:call(Vm,M,F,A,5000) of
	       ok->
		   [ServiceModule]=A,
		   case rpc:call(Vm,ServiceModule,ping,[],3000) of
		       {pong,_,ServiceModule}->
			   {ok,ServiceId,ServiceVsn};
		       Reason->
			   {error,[Reason,?MODULE,?LINE]}
		   end;
	       Reason->
		   {error,[Reason,?MODULE,?LINE]}
	   end,
    Result.
