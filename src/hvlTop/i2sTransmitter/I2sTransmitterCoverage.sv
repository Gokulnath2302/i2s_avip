`ifndef I2STRANSMITTERCOVERAGE_INCLUDED_
`define I2STRANSMITTERCOVERAGE_INCLUDED_
 
class I2sTransmitterCoverage extends uvm_subscriber#(I2sTransmitterTransaction);
`uvm_component_utils(I2sTransmitterCoverage)
 
  I2sTransmitterTransaction i2sTransmitterTransaction;


   covergroup i2sTransmitterTransactionCovergroup with function sample (I2sTransmitterTransaction packet);
  option.per_instance = 1;

   WORDSELECT_CP : coverpoint packet.txWs {
   option.comment = "Word Select";
   bins WORDSELECT_LEFT                              = {1}; 
   bins WORDSELECT_RIGHT                             = {0};
   }

   SERIALCLOCK_CP : coverpoint packet.txSclk {
   option.comment = "serial clock";
   bins POSEDGE                             = {1}; 
   bins NEGEDGE                             = {0};
   }

  
   SERIALDATA_CP : coverpoint packet.txSd.size()*DATA_WIDTH {
   option.comment = "Serial Data size of the packet transfer";
   bins DATA_WIDTH_1 = {8};
   bins DATA_WIDTH_2 = {16};
   bins DATA_WIDTH_3 = {24};
   bins DATA_WIDTH_4 = {32};
 }

 WORDSELECTPERIOD_CP : coverpoint packet.txWordSelectPeriod {
  option.comment = "word select period ";
  bins WS_PERIOD_16 = {16};
  bins WS_PERIOD_32 = {32};
  bins WS_PERIOD_48 = {48};
  bins WS_PERIOD_64 = {64};
}

SERIALDATARANGE_CP : coverpoint packet.txSd {
  option.comment = "serial data value range ";
  bins SD_LOW_VALID_RANGE = {[0:50]};
  bins SD_MID_VALID_RANGE = {[51:200]};
  bins SD_HIGH_VALID_RANGE = {[201:255]};
  illegal_bins INVALID_DATA_RANGE = {[256:$]};
}

NUMOFBITSTRANSFER_CP : coverpoint packet.txNumOfBitsTransfer {
  option.comment = "num of bits transfer";
  bins BITS_8  = {8};
  bins BITS_16 = {16};
  bins BITS_24 = {24};
  bins BITS_32 = {32};
}


SERIAL_DATA_X_WORD_SELECT_PERIOD_CP:cross SERIALDATA_CP,WORDSELECTPERIOD_CP;
  
endgroup


  extern function new(string name = "I2sTransmitterCoverage", uvm_component parent = null);
  extern virtual function void display();
  extern virtual function void write(I2sTransmitterTransaction t);
  extern virtual function void report_phase(uvm_phase phase);
 
endclass : I2sTransmitterCoverage
 
 
function I2sTransmitterCoverage::new(string name = "I2sTransmitterCoverage", uvm_component parent = null);
  super.new(name, parent);
  i2sTransmitterTransactionCovergroup=new();
endfunction : new
 
 
function void  I2sTransmitterCoverage::display();  
  $display("");
  $display("--------------------------------------");
  $display(" COVERAGE");
  $display("--------------------------------------");
  $display("");
endfunction : display
 
 
function void I2sTransmitterCoverage::write(I2sTransmitterTransaction t);
  `uvm_info(get_type_name(), $sformatf("Before Calling the Sample Method"),UVM_HIGH); 
   i2sTransmitterTransactionCovergroup.sample(t);
  `uvm_info(get_type_name(), $sformatf("After Calling the Sample Method"),UVM_HIGH);
endfunction: write
 
function void I2sTransmitterCoverage::report_phase(uvm_phase phase);
display(); 

`uvm_info(get_type_name(),$sformatf("I2s Transmitter Coverage  = %0.2f %%", i2sTransmitterTransactionCovergroup.get_coverage()), UVM_NONE);

endfunction: report_phase
`endif



