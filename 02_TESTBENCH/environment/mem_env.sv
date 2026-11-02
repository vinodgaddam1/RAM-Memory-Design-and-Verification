class mem_env;
mem_agent ag;
mem_scb scb;
task run();
ag=new();
scb=new();
fork
ag.run();
scb.run();
join
endtask
endclass


