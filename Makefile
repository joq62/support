all:
#	service
	rm -rf ebin/*;
#	interfaces
	erlc -I ../../interfaces -o ebin ../../interfaces/*.erl;
#	support
	erlc -I ../../interfaces -o ebin ../../kube_support/src/*.erl;
#	application
	cp src/*.app ebin;
	erlc -o ebin src/*.erl;
	rm -rf src/*.beam *.beam;
	rm -rf  *~ */*~  erl_cra*;
	echo Done
