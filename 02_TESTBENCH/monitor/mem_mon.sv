class mem_mon;
	virtual mem_intrf vif;
	tx_mem tx;
	task run();
	vif=top.pif;
	forever begin
	@(vif.mon_cb);
	if(vif.mon_cb.valid==1 && vif.mon_cb.ready==1)begin
	tx=new();
	tx.wr_rd= vif.mon_cb.wr_rd;
	tx.addr= vif.mon_cb.addr;
	tx.wdata= vif.mon_cb.wdata;
	if(tx.wr_rd==0)begin
		@(vif.mon_cb);
		tx.rdata=vif.mon_cb.rdata;
	end
	else tx.rdata=0;
		tx.print("mem_mon");
		common::mbox_mon_cov.put(tx);
		common::mbox_mon_sbd.put(tx);
	end

     end
  endtask
endclass

