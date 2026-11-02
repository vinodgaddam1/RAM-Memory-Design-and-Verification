class mem_gen;
	tx_mem tx,temp,tq[$];
	task run(input string test_name);
        case(common::test_name)
		"1W":begin
		tx=new();
                tx.randomize() with {tx.wr_rd==1;};
		tx.print("mem_gen");
                common::mbox.put(tx);
                end
		"5W":begin
            tx=new();
            repeat(5)begin
            tx.randomize() with {tx.wr_rd==1;};
	    tx.print("mem_gen");
	    //temp=tx;
            common::mbox.put(tx);
            end
       	end
	         "1W_1R":begin
           //write
            tx=new();
            tx.randomize() with {tx.wr_rd==1;};
	    tx.print("mem_gen");
            temp=new tx;
            common::mbox.put(temp);
          //read
          tx=new();
          tx.randomize() with {tx.wr_rd==0;tx.wdata==0;tx.addr==temp.addr;};
          tx.print("mem_gen");
          common::mbox.put(tx);
          end
		"5W_5R":begin
          //write
          tx=new();
          repeat(5)begin
            tx.randomize() with {tx.wr_rd==1;};
	    tx.print("mem_gen");
            temp= new tx;
            tq.push_back(temp);
            common::mbox.put(temp);
          end
          //read
          repeat (5)begin
          tx=new();
          temp=tq.pop_front();
         
          tx.randomize() with {tx.wr_rd==0;tx.wdata==0;tx.addr==temp.addr;};
          tx.print("mem_gen");
          common::mbox.put(tx);
          end
    end
          "NW_NR":begin
            
          //write
            tx=new();
            repeat(common::N)begin
            tx.randomize() with {tx.wr_rd==1;};
	       tx.print("mem_gen");
               temp=new tx;
               tq.push_back(temp);
               common::mbox.put(temp);
          end
          //read
            repeat (common::N)begin
            tx=new();
            temp=tq.pop_front();
            tx.randomize() with{tx.wr_rd==0;tx.wdata==0;tx.addr==temp.addr;};
            tx.print("mem_gen");
            common::mbox.put(tx);
            end
    end
   "MIS":begin
            
          //write
           tx=new();
            repeat(common::N)begin
            tx.randomize() with {tx.wr_rd==1;};
               tx.print("mem_gen");
               temp=new tx;
               tq.push_back(temp);
               common::mbox.put(temp);
         end
          //read
            repeat (common::N)begin
            tx=new();
           temp=tq.pop_front();
            tx.randomize() with{tx.wr_rd==0;tx.wdata==0;tx.addr!=temp.addr;};
            tx.print("mem_gen");
            common::mbox.put(tx);
            end
    end
          default:begin
		tx=new();
                tx.randomize() with {tx.wr_rd==1;};
		tx.print("mem_gen");
                common::mbox.put(tx);
                end
	endcase
        endtask
endclass


