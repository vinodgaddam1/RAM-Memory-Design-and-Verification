// List down the memory assertions 
// Wherever rstet is happend all the  signal will be 0 or not ?
// Wherever rstet is low happend all the  signal will be know or not ?
// Wherever valid  is happend ready is happend or not ?
// Wherever wr_rd is happend wdata and addrsts are know or not?
//wherever wr_rd is 0 rdata and addrsts are know or not?
//Write operation must happen only when ready is high.
module asser(clk,rst,wr_rd,addr,wdata,rdata,valid,ready);
input  clk,rst,wr_rd,valid,ready;
input  [`ADDR_WIDTH-1:0]addr;
input  [`WIDTH-1:0]wdata,rdata;


//Assertion-1 
property rstet;
@(posedge clk) (rst==1'b1) |-> (wr_rd==1'b0 && addr==1'b0 && wdata==1'b0 && valid==1'b0 && ready==1'b0 && rdata==1'b0);
endproperty

assert property (rstet)
else $error ("Assertion-1'b1 is faild!");


//Assertion-2 
property know;
@(posedge clk) (rst==1'b0) |-> ((!($isunknown(wr_rd))) && (!($isunknown(wdata)))&&(!($isunknown(rdata)))&&(!($isunknown(ready)))&&(!($isunknown(valid))));
endproperty

assert property (know)
else $error ("Assertion-2 is faild!");


//Assertion-3 
property va_rd;
@(posedge clk) (valid==1'b1) |=> (ready==1'b1);
endproperty

assert property (va_rd)
else $error ("Assertion-3 is faild!");


//Assertion-4 
property writes;
@(posedge clk) (wr_rd==1'b1) |-> ((!$isunknown (wdata)) && (!$isunknown (addr)));
endproperty

assert property (writes)
else $error ("Assertion-4 is faild!");


//Assertion-5 
property reads;
@(posedge clk) (wr_rd==1'b0) |-> ((!$isunknown (rdata)) && (!$isunknown (addr)));
endproperty

assert property (reads)
else $error ("Assertion-4 is faild!");

//Assertion-6 
property ra_ope;
@(posedge clk) disable iff (rst)
(wr_rd && valid)|->(ready);
endproperty

assert property (ra_ope)
else $error ("Assertion-5 is faild!");
endmodule









































