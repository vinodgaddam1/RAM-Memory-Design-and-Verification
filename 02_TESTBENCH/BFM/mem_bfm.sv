class mem_bfm;
	tx_mem tx;
        virtual mem_intrf vif;
	task run();
	vif = top.pif;
      forever begin
      common::mbox.get(tx);
      drive(tx);
      tx.print("mem_bfm");
      end
    endtask

  task drive(tx_mem tx);
	  @(vif.bfm_cb);
          vif.bfm_cb.wr_rd <= tx.wr_rd;
          vif.bfm_cb.addr<=tx.addr;
          if(tx.wr_rd==1) vif.bfm_cb.wdata<=tx.wdata;
          else vif.bfm_cb.wdata<=0;
          vif.bfm_cb.valid<=1;
          wait(vif.bfm_cb.ready==1);
          if(tx.wr_rd==0)begin
	  @(vif.bfm_cb);
	  tx.rdata=vif.bfm_cb.rdata;
          end
          @( vif.bfm_cb);
          vif.bfm_cb.wr_rd<=0;
          vif.bfm_cb.addr<=0;
          vif.bfm_cb.wdata<=0;
          vif.bfm_cb.valid<=0;
	  //Note: what ever Output are there make it to non-blocking
      endtask
endclass









