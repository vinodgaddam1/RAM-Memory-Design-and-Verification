class mem_scb;
	tx_mem tx;
	int asso[*];
	task run();

 forever begin
	 common::mbox_mon_sbd.get(tx);
	 tx.print("mon_sbd");
	 if(tx.wr_rd==1)begin
         asso[tx.addr]=tx.wdata;
         end
	 else begin
		 if(tx.rdata == asso[tx.addr]) common::matching++;
		 else 
		 common::mismatching++;
	 end
 end
endtask
endclass


