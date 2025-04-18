`ifndef I2SGLOBALSPKG_INCLUDED_
`define I2SGLOBALSPKG_INCLUDED_

package I2sGlobalPkg;


parameter int DATA_WIDTH=8;

parameter int MAXIMUM_SIZE=4;

parameter int NUM_OF_CHANNEL=2;

parameter logic WS_DEFAULT=1'bx;

typedef enum bit{
    TRUE=1'b1,
    FALSE=1'b0
} hasCoverageEnum;


typedef enum bit[1:0]{
    TX_MASTER=2'b00,
    TX_SLAVE=2'b01,
    RX_MASTER=2'b10,
    RX_SLAVE=2'b11
  }modeTypeEnum;


  typedef enum bit[31:0] {
    KHZ_8=8000,
    KHZ_48=48000,
    KHZ_96=96000,
    KHZ_192=192000
  }clockrateFrequencyEnum;

  typedef enum bit[31:0] {
    WS_PERIOD_2_BYTE = 16,
    WS_PERIOD_4_BYTE=32,
    WS_PERIOD_6_BYTE=48,
    WS_PERIOD_8_BYTE=64
  } wordSelectPeriodEnum;

  typedef enum{
    BITS_8  = 8, 
    BITS_16 =16,
    BITS_24 =24,
    BITS_32 =32
   }numOfBitsTransferEnum;

typedef struct {
   bit[1:0]mode;
    int clockratefrequency;
    int numOfBitsTransfer; 
    int delayFortxSd;
    int delayFortxWs;
    int clockPeriod;
    int sclkFrequency;
    bit Sclk;
  } i2sTransferCfgStruct;  

  typedef struct {
    bit [DATA_WIDTH-1:0]sd[MAXIMUM_SIZE];
    bit ws;
    bit sclk;
    int wordSelectPeriod;
    int numOfBitsTransfer;
    int clockratefrequency;
   }i2sTransferPacketStruct;

endpackage:I2sGlobalPkg

`endif

