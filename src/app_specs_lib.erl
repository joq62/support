%%% -------------------------------------------------------------------
%%% Author  : uabjle
%%% Description : dbase using dets 
%%% 
%%% Created : 10 dec 2012
%%% -------------------------------------------------------------------
-module(app_specs_lib).   
   
%% --------------------------------------------------------------------
%% Include files
%% --------------------------------------------------------------------

%% --------------------------------------------------------------------

%% External exports
-export([ extract/2]).


%% ====================================================================
%% External functions
%% ====================================================================

%% --------------------------------------------------------------------
%% Function:start/0 
%% Description: Initiate the eunit tests, set upp needed processes etc
%% Returns: non
%% --------------------------------------------------------------------

extract(Key,AppSpecFile)->
    {ok,[I]}=file:consult(AppSpecFile),
    I1=lists:delete(db_app_spec,I),
    get(Key,I1).

get(service_id,L)->
    {services,[L2]}=lists:keyfind(services,1,L),
    L3=lists:delete(services,L2),
    {service_id,ServiceId}=lists:keyfind(service_id,1,L3),
    ServiceId;
get(service_vsn,L)->
    {services,[L2]}=lists:keyfind(services,1,L),
    {service_vsn,ServiceVsn}=lists:keyfind(service_vsn,1,L2),
    ServiceVsn;
get(git_path,L)->
    {services,[L2]}=lists:keyfind(services,1,L),
    {git_path,GitPath}=lists:keyfind(git_path,1,L2),
    GitPath;
get(start_cmd,L)->
    {services,[L2]}=lists:keyfind(services,1,L),
    {start_cmd,StartCmd}=lists:keyfind(start_cmd,1,L2),
    StartCmd;
get(env_vars,L)->
     {services,[L2]}=lists:keyfind(services,1,L),
     {env_vars,EnvVars}=lists:keyfind(env_vars,1,L2),
    EnvVars;

get(git_user,L)->
    {services,[L2]}=lists:keyfind(services,1,L),
    {env_vars,EnvVars}=lists:keyfind(env_vars,1,L2),
    {dbase,git_user,GitUser}=lists:keyfind(git_user,2,EnvVars),
    GitUser;

get(git_pw,L)->
    {services,[L2]}=lists:keyfind(services,1,L),
    {env_vars,EnvVars}=lists:keyfind(env_vars,1,L2),
    {dbase,git_pw,GitPw}=lists:keyfind(git_pw,2,EnvVars),
    GitPw;

get(cl_dir,L)->
    {services,[L2]}=lists:keyfind(services,1,L),
    {env_vars,EnvVars}=lists:keyfind(env_vars,1,L2),
    {dbase,cl_dir,ClDir}=lists:keyfind(cl_dir,2,EnvVars),
    ClDir;

get(cl_file,L)->
    {services,[L2]}=lists:keyfind(services,1,L),
    {env_vars,EnvVars}=lists:keyfind(env_vars,1,L2),
    {dbase,cl_file,ClFile}=lists:keyfind(cl_file,2,EnvVars),
    ClFile;

get(app_specs_dir,L)->
    {services,[L2]}=lists:keyfind(services,1,L),
    {env_vars,EnvVars}=lists:keyfind(env_vars,1,L2),
    {dbase,app_specs_dir,AppSpecs}=lists:keyfind(app_specs_dir,2,EnvVars),
    AppSpecs;

get(dbase_nodes,L)->
    {services,[L2]}=lists:keyfind(services,1,L),
    {env_vars,EnvVars}=lists:keyfind(env_vars,1,L2),
    {dbase,dbase_nodes,DbaseNodes}=lists:keyfind(dbase_nodes,2,EnvVars),
    DbaseNodes;


get(Key,L)->
    {Key,Value}=lists:keyfind(Key,1,L),
    Value.

%% --------------------------------------------------------------------
%% Function:start/0 
%% Description: Initiate the eunit tests, set upp needed processes etc
%% Returns: non
%% --------------------------------------------------------------------
