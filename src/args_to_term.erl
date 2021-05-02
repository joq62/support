%%% -------------------------------------------------------------------
%%% Author  : uabjle
%%% Description : dbase using dets 
%%% 
%%% Created : 10 dec 2012
%%% -------------------------------------------------------------------
-module(args_to_term).  
   
%% --------------------------------------------------------------------
%% Include files
%% --------------------------------------------------------------------
 -include_lib("eunit/include/eunit.hrl").
%%---------------------------------------------------------------------
%% Records for test
%%

%% --------------------------------------------------------------------
-export([transform/1]).


%% ====================================================================
%% External functions
%% ====================================================================

%% --------------------------------------------------------------------
%% Function:start/0 
%% Description: Initiate the eunit tests, set upp needed processes etc
%% Returns: non
%% --------------------------------------------------------------------
%% Fromat ArgList=["{","git_user","str","joq62","}","}",
%%                 "{","cl_file","cluster_info.hrl","}",
%%                 "{","int_test","int","42","}"]


transform(Args)->
 %   io:format("Args ~p~n",[{Args,?MODULE,?LINE}]),
    transform(Args,[]).
transform([],KeyValueTupleList)->
    KeyValueTupleList;
transform(["{",Key,"str",Value,"}"|T],Acc)->
    transform(T,[{list_to_atom(Key),Value}|Acc]);
transform(["{",Key,"int",Value,"}"|T],Acc)->
    transform(T,[{list_to_atom(Key),list_to_integer(Value)}|Acc]);
transform(Err,_Acc) ->
    exit("Parsing error in module "++atom_to_list(?MODULE)++" in line "++integer_to_list(?LINE)++" Input :=> "++Err).

%% --------------------------------------------------------------------
%% Function:start/0 
%% Description: Initiate the eunit tests, set upp needed processes etc
%% Returns: non
%% --------------------------------------------------------------------
