`ifndef I2STRANSMITTERWRITE32BITTRANSFERSEQ_INCLUDED_
`define I2STRANSMITTERWRITE32BITTRANSFERSEQ_INCLUDED_

class I2sTransmitterWrite32bitTransferSeq extends I2sTransmitterBaseSeq;
  `uvm_object_utils(I2sTransmitterWrite32bitTransferSeq)

  rand logic txWsSeq;
  rand bit[DATA_WIDTH-1:0] txSdSeq[];
  rand numOfBitsTransferEnum txNumOfBitsTransferSeq;

  constraint txSdSeq_c{soft txSdSeq.size() == txNumOfBitsTransferSeq/DATA_WIDTH; }
 
  extern function new(string name = "I2sTransmitterWrite32bitTransferSeq");
  extern task body();
endclass : I2sTransmitterWrite32bitTransferSeq

function I2sTransmitterWrite32bitTransferSeq::new(string name = "I2sTransmitterWrite32bitTransferSeq");
  super.new(name);
endfunction : new

task I2sTransmitterWrite32bitTransferSeq::body();
  super.body();

  start_item(i2sTransmitterTransaction);
  if(!i2sTransmitterTransaction.randomize() with {
                           txWs == txWsSeq;
                           foreach(txSdSeq[i]){
                               txSd[i]  == txSdSeq[i]};
                            txNumOfBitsTransfer  == txNumOfBitsTransferSeq;
                            }) begin 
      `uvm_error(get_type_name(), "Randomization failed")
 end
  
 foreach(i2sTransmitterTransaction.txSd[i]) begin
    $display("sd[%0d]=%b",i,i2sTransmitterTransaction.txSd[i]);
   end

  
  i2sTransmitterTransaction.print();
  finish_item(i2sTransmitterTransaction);

endtask:body
  
`endif

