class mem_agent;
	mem_gen gen;
	mem_bfm bfm;
	mem_mon mon;
	mem_cov cov;
	task run();

gen=new();
bfm=new();
mon=new();
cov=new();
fork
gen.run(common::test_name);
bfm.run();
mon.run();
cov.run();
join
endtask
endclass

