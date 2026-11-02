class mem_cov;
	tx_mem tx;


	covergroup mem;
		//option.name = "MEMORY_COVERGROUP";
                //option.per_instance = 1;
		          coverpoint tx.wr_rd{
		  bins WRITE = {1'b1};
		  bins READ = {1'b0};
		  //option.weight =1;
		  //option.comment ="memory wr_rd covergroup";
	  }
          coverpoint tx.addr{
		   bins ADDR [] = {[0:32]};//dynamic array 
		  //bins ADDR [32] = {[0:20]} with (item % 2 == 0);//dynamic array with condtion 
		  //bins ADDR0 = {5'b00000}; 
		  //bins ADDR1 = {5'b00001};
	          //bins ADDR2 = {5'b00010}; 
		  //bins ADDR3 = {5'b00011};  
		  //bins ADDR4 = {5'b00100}; 
		  //bins ADDR5 = {5'b00101};
		  //bins ADDR6 = {5'b00110}; 
		  //bins ADDR7 = {5'b00111}; 
		  //bins ADDR8 = {5'b01000}; 
		  //bins ADDR9 = {5'b01001};
		  //bins ADDR10 = {5'b01010}; 
		  //bins ADDR11 = {5'b01011};  
		  //bins ADDR12 = {5'b01100}; 
		  //bins ADDR13 = {5'b01101};
		  //bins ADDR14 = {5'b01110}; 
		  //bins ADDR15 = {5'b01111}; 
		  //bins ADDR16 = {5'b100000}; 
		  //bins ADDR17 = {5'b100001};
		  //bins ADDR18 = {5'b100010}; 
		  //bins ADDR19 = {5'b100011};  
		  //bins ADDR20 = {5'b100100}; 
		  //bins ADDR21 = {5'b100101};
		  //bins ADDR22 = {5'b100110}; 
		  //bins ADDR23 = {5'b100111}; 
		  //bins ADDR24 = {5'b101000}; 
		  //bins ADDR25 = {5'b101001};
		  //bins ADDR26 = {5'b101010}; 
		  //bins ADDR27 = {5'b101011};  
		  //bins ADDR28 = {5'b101100}; 
		  //bins ADDR29 = {5'b101101};
		  //bins ADDR30 = {5'b101110}; 
		  //bins ADDR31 = {5'b101111}; 
		  //option.auto_bin_max =32;
		  //bins ADDR[32] ={[0:32]} with (item % 2==0);static array	  
		  //bins ADDR[32] = default;	  
		  //option.comment ="memory wr_rd covergroup";

	  }
	endgroup
   
	function new();
	mem=new();	
	endfunction

	task run();
	forever begin
	common::mbox_mon_cov.get(tx);
	tx.print("mon_cov");
	mem.sample();
end
endtask
endclass
 
















