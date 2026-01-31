`include"memory_design.v"

module top;


parameter WIDTH=16;
parameter DEPTH=64;
parameter ADDR =$clog2(DEPTH);

reg clk_i,
      rst_i,
      wr_rd,
      valid_i;

reg [WIDTH-1:0]write_i;
reg [ADDR-1:0] addr_i;

wire [WIDTH-1:0] read_o;
wire ready_o;

integer i;

reg [30*8:0] command;



memory #(.WIDTH(WIDTH),.DEPTH(DEPTH),.ADDR(ADDR)) dut(
       .clk_i(clk_i),
       .rst_i(rst_i),
       .wr_rd(wr_rd),
       .addr_i(addr_i),
       .write_i(write_i),
       .read_o(read_o),
       .valid_i(valid_i),
       .ready_o(ready_o));



//-------------->Clock Generation
initial begin
       clk_i=0;
       forever #5 clk_i=~clk_i;
   end


//--->Reset
task reset();
    begin
        rst_i=1;
        wr_rd=0;
        write_i=0;

        @(posedge clk_i);

        rst_i=0;
      
    end
endtask

//----->Writing and Reading
task write_mem(input integer start_loc,end_loc);
    
    begin
       // $display("write_memory");
       for(i=start_loc;i<end_loc;i=i+1) begin
            @(posedge clk_i);
            addr_i=i;
            write_i=$urandom;
            valid_i=1;
            @(posedge clk_i);
            wait(ready_o==1);
            wr_rd=1;
            @(posedge clk_i);
            valid_i=0;
        end
    end
endtask


task read_mem(input integer start_loc, end_loc);


    begin
       // $display("read memory");
       for(i=start_loc;i<=end_loc;i=i+1) begin
            @(posedge clk_i);
            addr_i=i;
            valid_i=1;
            @(posedge clk_i);
            wait(ready_o==1);
            wr_rd=0;
        end
         @(posedge clk_i);
         valid_i=0;

    end
endtask
        


initial begin


    $value$plusargs("command=%s",command);
    reset();
    
    case(command)
        "WRITE":begin
           bd_rd();
       // write_mem(10,20);
        //$readmemh("video.hex",dut.mem);
        //$writememh("video.bin",dut.mem);
       // read_mem(10,20);
    end
    
    endcase

end

task bd_rd();
   begin
      write_mem(10,20);
     $writememh("video.bin",dut.mem);
  end
endtask


initial begin
    #500;
    $stop;
end


endmodule

    

