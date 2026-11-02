`include "mem.sv"
`include "mem_common.sv"
`include "tx_mem.sv"
`include "gen_mem.sv"
`include "mem_intrf.sv"
`include "mem_bfm.sv"
`include "mem_mon.sv"
`include "mem_cov.sv"
`include "mem_agent.sv"
`include "mem_scb.sv"
`include "mem_asser.sv"
`include "mem_env.sv"
module top;
mem_env env;
reg clk,rst;

mem_intrf pif(clk,rst);

memory dut(.clk(pif.clk),
           .rst(pif.rst),
	   .addr(pif.addr),
	   .wdata(pif.wdata),
	   .rdata(pif.rdata),
	   .valid(pif.valid),
	   .ready(pif.ready),
	   .wr_rd(pif.wr_rd)
   );

asser uut(.clk(pif.clk),
           .rst(pif.rst),
	   .addr(pif.addr),
	   .wdata(pif.wdata),
	   .rdata(pif.rdata),
	   .valid(pif.valid),
	   .ready(pif.ready),
	   .wr_rd(pif.wr_rd)
   );

always #5 clk=~clk;
initial begin
  $value$plusargs("test_name=%0s",common::test_name);
  $value$plusargs("N=%0d",common::N);
clk=0;
rst=1;
repeat(2) @(posedge clk);
rst=0;

env=new();
env.run();
end
  initial begin
  //  $dumpfile("dump.vcd"); $dumpvars;
       #1000;

$display("********************** TEST %s **********************",
         (common::matching!=0 && common::mismatching == 0)
         ? "PASSED" : "FAILED");

$display("matches=%0d, mismatches=%0d",
         common::matching, common::mismatching);

       //if (common::matching != 0 && common::mismatching==0) begin
       //     $display("********************** TEST PASSED ****************");
       // end
       // else begin //(common::matching==0 && common::mismatching)
       //     $display("********************** TEST FAILED ****************");
       // end 
       // $display("matches=%0d, mismatches=%0d",common::matching, common::mismatching);
    $finish;
  end
endmodule

