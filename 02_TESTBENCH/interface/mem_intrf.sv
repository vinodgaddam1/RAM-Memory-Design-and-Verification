interface mem_intrf(input reg clk,rst);
	bit wr_rd;
	bit [`ADDR_WIDTH-1:0]addr;
	bit [`WIDTH-1:0]wdata,rdata;
	bit valid,ready;



       //clocking blocks
       clocking bfm_cb@(posedge clk);
 	      default input #0 output #1;

	      input ready,rdata;
	      output wr_rd,addr,wdata,valid;
       endclocking
       
       clocking mon_cb@(posedge clk);
       default input #1;
       input wr_rd,addr,wdata,rdata,valid,ready;
       endclocking 

endinterface






























