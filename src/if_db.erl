%%% -------------------------------------------------------------------
%%% Author  : uabjle
%%% Description : dbase using dets 
%%% 
%%% Created : 10 dec 2012
%%% -------------------------------------------------------------------
-module(if_db).  
   
%% --------------------------------------------------------------------
%% Include files
%% --------------------------------------------------------------------
 
%%---------------------------------------------------------------------
%% Records for test
%%

%% --------------------------------------------------------------------
-compile(export_all).

-define(DbaseVmId,"control").


%% ====================================================================
%% External functions
%% ====================================================================
% --------------------------------------------------------------------
%% Function:start/0 
%% Description: Initiate the eunit tests, set upp needed processes etc
%% Returns: non
%% --------------------------------------------------------------------
call(M,F,A)->
    {ok,LocalHostId}=net:gethostname(),
    DbaseVm=list_to_atom(?DbaseVmId++"@"++LocalHostId),
    rpc:call(DbaseVm,M,F,A,5000).

% --------------------------------------------------------------------
%% Function:start/0 
%% Description: Initiate the eunit tests, set upp needed processes etc
%% Returns: non
%% --------------------------------------------------------------------
app_spec_create({db_app_spec,AppId,Vsn,Directives,Services})->
    app_spec_create(AppId,Vsn,Directives,Services).
app_spec_create(AppId,Vsn,Directives,Services)->
    {ok,LocalHostId}=net:gethostname(),
    DbaseVm=list_to_atom(?DbaseVmId++"@"++LocalHostId),
    rpc:call(DbaseVm,db_app_spec,create,[AppId,Vsn,Directives,Services],5000).

app_spec_read_all()->
 {ok,LocalHostId}=net:gethostname(),
    DbaseVm=list_to_atom(?DbaseVmId++"@"++LocalHostId),
    rpc:call(DbaseVm,db_app_spec,read_all,[],5000).

app_spec_read(AppId)->
    {ok,LocalHostId}=net:gethostname(),
    DbaseVm=list_to_atom(?DbaseVmId++"@"++LocalHostId),
    rpc:call(DbaseVm,db_app_spec,read,[AppId],5000).

app_spec_read(AppId,Vsn)->
    {ok,LocalHostId}=net:gethostname(),
    DbaseVm=list_to_atom(?DbaseVmId++"@"++LocalHostId),
    rpc:call(DbaseVm,db_app_spec,read,[AppId,Vsn],5000).

app_spec_delete(AppId,Vsn)->
    {ok,LocalHostId}=net:gethostname(),
    DbaseVm=list_to_atom(?DbaseVmId++"@"++LocalHostId),
    rpc:call(DbaseVm,db_app_spec,delete,[AppId,Vsn],5000).


% --------------------------------------------------------------------
%% Function:start/0 
%% Description: Initiate the eunit tests, set upp needed processes etc
%% Returns: non
%% --------------------------------------------------------------------
passwd_create({db_passwd,UserId,PassWd})->
    passwd_create(UserId,PassWd).
passwd_create(UserId,PassWd)->
    {ok,LocalHostId}=net:gethostname(),
    DbaseVm=list_to_atom(?DbaseVmId++"@"++LocalHostId),
    rpc:call(DbaseVm,db_passwd,create,[UserId,PassWd],5000).

passwd_read_all()->
 {ok,LocalHostId}=net:gethostname(),
    DbaseVm=list_to_atom(?DbaseVmId++"@"++LocalHostId),
    rpc:call(DbaseVm,db_passwd,read_all,[],5000).

passwd_read(UserId)->
    {ok,LocalHostId}=net:gethostname(),
    DbaseVm=list_to_atom(?DbaseVmId++"@"++LocalHostId),
    rpc:call(DbaseVm,db_passwd,read,[UserId],5000).

passwd_update(UserId,NewPwd)->
    {ok,LocalHostId}=net:gethostname(),
    DbaseVm=list_to_atom(?DbaseVmId++"@"++LocalHostId),
    rpc:call(DbaseVm,db_passwd,update,[UserId,NewPwd],5000).

passwd_delete(UserId)->
    {ok,LocalHostId}=net:gethostname(),
    DbaseVm=list_to_atom(?DbaseVmId++"@"++LocalHostId),
    rpc:call(DbaseVm,db_passwd,delete,[UserId],5000).


% --------------------------------------------------------------------
%% Function:start/0 
%% Description: Initiate the eunit tests, set upp needed processes etc
%% Returns: non
%% --------------------------------------------------------------------
service_def_create({db_service_def,ServiceId,Vsn,GitUserId})->
    service_def_create(ServiceId,Vsn,GitUserId).
service_def_create(ServiceId,Vsn,GitUserId)->
    {ok,LocalHostId}=net:gethostname(),
    DbaseVm=list_to_atom(?DbaseVmId++"@"++LocalHostId),
    rpc:call(DbaseVm,db_service_def,create,[ServiceId,Vsn,GitUserId],5000).

service_def_read_all()->
 {ok,LocalHostId}=net:gethostname(),
    DbaseVm=list_to_atom(?DbaseVmId++"@"++LocalHostId),
    rpc:call(DbaseVm,db_service_def,read_all,[],5000).

service_def_read(ServiceId,Vsn)->
    {ok,LocalHostId}=net:gethostname(),
    DbaseVm=list_to_atom(?DbaseVmId++"@"++LocalHostId),
    rpc:call(DbaseVm,db_service_def,read,[ServiceId,Vsn],5000).

service_def_update(Id,Vsn,NewVsn,NewSource)->
    {ok,LocalHostId}=net:gethostname(),
    DbaseVm=list_to_atom(?DbaseVmId++"@"++LocalHostId),
    rpc:call(DbaseVm,db_service_def,update,[Id,Vsn,NewVsn,NewSource],5000).

service_def_delete(Id,Vsn)->
    {ok,LocalHostId}=net:gethostname(),
    DbaseVm=list_to_atom(?DbaseVmId++"@"++LocalHostId),
    rpc:call(DbaseVm,db_service_def,delete,[Id,Vsn],5000).

% --------------------------------------------------------------------
%% Function:start/0 
%% Description: Initiate the eunit tests, set upp needed processes etc
%% Returns: non
%% --------------------------------------------------------------------
sd_create({db_sd,ServiceId,Vsn,HostId,VmId,Vm})->
    sd_create(ServiceId,Vsn,HostId,VmId,Vm).
sd_create(ServiceId,Vsn,HostId,VmId,Vm)->
    {ok,LocalHostId}=net:gethostname(),
    DbaseVm=list_to_atom(?DbaseVmId++"@"++LocalHostId),
    rpc:call(DbaseVm,db_sd,create,[ServiceId,Vsn,HostId,VmId,Vm],5000).

sd_read(ServiceId)->
    {ok,LocalHostId}=net:gethostname(),
    DbaseVm=list_to_atom(?DbaseVmId++"@"++LocalHostId),
    rpc:call(DbaseVm,db_sd,read,[ServiceId],5000).
sd_read(ServiceId,Vsn)->
    {ok,LocalHostId}=net:gethostname(),
    DbaseVm=list_to_atom(?DbaseVmId++"@"++LocalHostId),
    rpc:call(DbaseVm,db_sd,read,[ServiceId,Vsn],5000).

sd_get(ServiceId)->
    {ok,LocalHostId}=net:gethostname(),
    DbaseVm=list_to_atom(?DbaseVmId++"@"++LocalHostId),
    rpc:call(DbaseVm,db_sd,get,[ServiceId],5000).
sd_get(ServiceId,Vsn)->
    {ok,LocalHostId}=net:gethostname(),
    DbaseVm=list_to_atom(?DbaseVmId++"@"++LocalHostId),
    rpc:call(DbaseVm,db_sd,get,[ServiceId,Vsn],5000).

sd_read_all()->
 {ok,LocalHostId}=net:gethostname(),
    DbaseVm=list_to_atom(?DbaseVmId++"@"++LocalHostId),
    rpc:call(DbaseVm,db_sd,read_all,[],5000).

sd_delete(ServiceId,Vsn,Vm)->
    {ok,LocalHostId}=net:gethostname(),
    DbaseVm=list_to_atom(?DbaseVmId++"@"++LocalHostId),
    rpc:call(DbaseVm,db_sd,delete,[ServiceId,Vsn,Vm],5000).

% --------------------------------------------------------------------
%% Function:start/0 
%% Description: Initiate the eunit tests, set upp needed processes etc
%% Returns: non
%% --------------------------------------------------------------------
deployment_spec_create({db_deployment_spec,DeplId,SpecId,Vsn,Date,Time,SdList})->
    deployment_spec_create(DeplId,SpecId,Vsn,Date,Time,SdList).
deployment_spec_create(DeplId,SpecId,Vsn,Date,Time,SdList)->
    {ok,LocalHostId}=net:gethostname(),
    DbaseVm=list_to_atom(?DbaseVmId++"@"++LocalHostId),
    rpc:call(DbaseVm,db_deployment_spec,create,[DeplId,SpecId,Vsn,Date,Time,SdList],5000).

deployment_spec_read_all()->
 {ok,LocalHostId}=net:gethostname(),
    DbaseVm=list_to_atom(?DbaseVmId++"@"++LocalHostId),
    rpc:call(DbaseVm,db_deployment_spec,read_all,[],5000).

deployment_spec_read(SpecId,Vsn)->
    {ok,LocalHostId}=net:gethostname(),
    DbaseVm=list_to_atom(?DbaseVmId++"@"++LocalHostId),
    rpc:call(DbaseVm,db_deployment_spec,read,[SpecId,Vsn],5000).

deployment_spec_delete(SpecId,Vsn)->
    {ok,LocalHostId}=net:gethostname(),
    DbaseVm=list_to_atom(?DbaseVmId++"@"++LocalHostId),
    rpc:call(DbaseVm,db_deployment_spec,delete,[SpecId,Vsn],5000).

% --------------------------------------------------------------------
%% Function:start/0 
%% Description: Initiate the eunit tests, set upp needed processes etc
%% Returns: non
%% --------------------------------------------------------------------
deployment_create({db_deployment,DepSpecId,DepSpecVsn,Date,Time,StartResult})->
    deployment_create(DepSpecId,DepSpecVsn,Date,Time,StartResult).
deployment_create(DepSpecId,DepSpecVsn,Date,Time,StartResult)->
    {ok,LocalHostId}=net:gethostname(),
    DbaseVm=list_to_atom(?DbaseVmId++"@"++LocalHostId),
    rpc:call(DbaseVm,db_deployment,create,[DepSpecId,DepSpecVsn,Date,Time,StartResult],5000).

deployment_read_all()->
 {ok,LocalHostId}=net:gethostname(),
    DbaseVm=list_to_atom(?DbaseVmId++"@"++LocalHostId),
    rpc:call(DbaseVm,db_deployment,read_all,[],5000).

deployment_read(DepSpecId,DepSpecVsn)->
    {ok,LocalHostId}=net:gethostname(),
    DbaseVm=list_to_atom(?DbaseVmId++"@"++LocalHostId),
    rpc:call(DbaseVm,db_deployment,read,[DepSpecId,DepSpecVsn],5000).


deployment_update_status(DepSpecId,DepSpecVsn,NewStartResult)->
    {ok,LocalHostId}=net:gethostname(),
    DbaseVm=list_to_atom(?DbaseVmId++"@"++LocalHostId),
    rpc:call(DbaseVm,db_deployment,update_status,[DepSpecId,DepSpecVsn,NewStartResult],5000).

deployment_delete(DepSpecId,DepSpecVsn)->
    {ok,LocalHostId}=net:gethostname(),
    DbaseVm=list_to_atom(?DbaseVmId++"@"++LocalHostId),
    rpc:call(DbaseVm,db_deployment,delete,[DepSpecId,DepSpecVsn],5000).
% --------------------------------------------------------------------
%% Function:start/0 
%% Description: Initiate the eunit tests, set upp needed processes etc
%% Returns: non
%% --------------------------------------------------------------------
log_create({db_log,Vm,Module,Line,Severity,Date,Time,Text})->
    log_create(Vm,Module,Line,Severity,Date,Time,Text).
log_create(Vm,Module,Line,Severity,Date,Time,Text)->
    {ok,LocalHostId}=net:gethostname(),
    DbaseVm=list_to_atom(?DbaseVmId++"@"++LocalHostId),
    rpc:call(DbaseVm,db_log,create,[Vm,Module,Line,Severity,Date,Time,Text],5000).

log_severity(Severity)->
    {ok,LocalHostId}=net:gethostname(),
    DbaseVm=list_to_atom(?DbaseVmId++"@"++LocalHostId),
    rpc:call(DbaseVm,db_log,severity,[Severity],5000).

log_latest(Len,all)->
    {ok,LocalHostId}=net:gethostname(),
    DbaseVm=list_to_atom(?DbaseVmId++"@"++LocalHostId),
    rpc:call(DbaseVm,db_log,log_latest,[Len,all],5000).

log_read_all()->
 {ok,LocalHostId}=net:gethostname(),
    DbaseVm=list_to_atom(?DbaseVmId++"@"++LocalHostId),
    rpc:call(DbaseVm,db_log,read_all,[],5000).

log_delete(Vm,Module,Line,Severity,Date,Time,Text)->
    {ok,LocalHostId}=net:gethostname(),
    DbaseVm=list_to_atom(?DbaseVmId++"@"++LocalHostId),
    rpc:call(DbaseVm,db_log,delete,[Vm,Module,Line,Severity,Date,Time,Text],5000).

% --------------------------------------------------------------------
%% Function:start/0 
%% Description: Initiate the eunit tests, set upp needed processes etc
%% Returns: non
%% --------------------------------------------------------------------
server_status(Status)->
    {ok,LocalHostId}=net:gethostname(),
    DbaseVm=list_to_atom(?DbaseVmId++"@"++LocalHostId),
    rpc:call(DbaseVm,db_server,status,[Status],5000).
server_create({db_server,HostId,SshId,SshPwd,IpAddr,Port,Status})->
    server_create(HostId,SshId,SshPwd,IpAddr,Port,Status).
server_create(HostId,SshId,SshPwd,IpAddr,Port,Status)->
    {ok,LocalHostId}=net:gethostname(),
    DbaseVm=list_to_atom(?DbaseVmId++"@"++LocalHostId),
    rpc:call(DbaseVm,db_server,create,[HostId,SshId,SshPwd,IpAddr,Port,Status],5000).
server_read_all()->
    {ok,LocalHostId}=net:gethostname(),
    DbaseVm=list_to_atom(?DbaseVmId++"@"++LocalHostId),
    rpc:call(DbaseVm,db_server,read_all,[],5000).
server_read(HostId)->
    {ok,LocalHostId}=net:gethostname(),
    DbaseVm=list_to_atom(?DbaseVmId++"@"++LocalHostId),
    rpc:call(DbaseVm,db_server,read,[HostId],5000).

server_update(HostId,NewStatus)->
    {ok,LocalHostId}=net:gethostname(),
    DbaseVm=list_to_atom(?DbaseVmId++"@"++LocalHostId),
    rpc:call(DbaseVm,db_server,update,[HostId,NewStatus],5000).

server_delete(HostId)->
    {ok,LocalHostId}=net:gethostname(),
    DbaseVm=list_to_atom(?DbaseVmId++"@"++LocalHostId),
    rpc:call(DbaseVm,db_server,delete,[HostId],5000).
% --------------------------------------------------------------------
%% Function:start/0 
%% Description: Initiate the eunit tests, set upp needed processes etc
%% Returns: non
%% --------------------------------------------------------------------
vm_info(Vm)->
    {ok,LocalHostId}=net:gethostname(),
    DbaseVm=list_to_atom(?DbaseVmId++"@"++LocalHostId),
    rpc:call(DbaseVm,db_vm,info,[Vm],5000).

vm_host_id(HostId)->
    {ok,LocalHostId}=net:gethostname(),
    DbaseVm=list_to_atom(?DbaseVmId++"@"++LocalHostId),
    rpc:call(DbaseVm,db_vm,host_id,[HostId],5000).

vm_type(Type)->
    {ok,LocalHostId}=net:gethostname(),
    DbaseVm=list_to_atom(?DbaseVmId++"@"++LocalHostId),
    rpc:call(DbaseVm,db_vm,type,[Type],5000).

vm_status(Status)->
    {ok,LocalHostId}=net:gethostname(),
    DbaseVm=list_to_atom(?DbaseVmId++"@"++LocalHostId),
    rpc:call(DbaseVm,db_vm,status,[Status],5000).

vm_create({db_vm,HostId,SshId,SshPwd,IpAddr,Port,Status})->
    vm_create(HostId,SshId,SshPwd,IpAddr,Port,Status).
vm_create(HostId,SshId,SshPwd,IpAddr,Port,Status)->
    {ok,LocalHostId}=net:gethostname(),
    DbaseVm=list_to_atom(?DbaseVmId++"@"++LocalHostId),
    rpc:call(DbaseVm,db_vm,create,[HostId,SshId,SshPwd,IpAddr,Port,Status],5000).
vm_read_all()->
    {ok,LocalHostId}=net:gethostname(),
    DbaseVm=list_to_atom(?DbaseVmId++"@"++LocalHostId),
    rpc:call(DbaseVm,db_vm,read_all,[],5000).
vm_read(HostId)->
    {ok,LocalHostId}=net:gethostname(),
    DbaseVm=list_to_atom(?DbaseVmId++"@"++LocalHostId),
    rpc:call(DbaseVm,db_vm,read,[HostId],5000).

vm_update(Vm,NewStatus)->
    {ok,LocalHostId}=net:gethostname(),
    DbaseVm=list_to_atom(?DbaseVmId++"@"++LocalHostId),
    rpc:call(DbaseVm,db_vm,update,[Vm,NewStatus],5000).

vm_delete(HostId)->
    {ok,LocalHostId}=net:gethostname(),
    DbaseVm=list_to_atom(?DbaseVmId++"@"++LocalHostId),
    rpc:call(DbaseVm,db_vm,delete,[HostId],5000).
