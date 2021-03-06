
## FIFO depth is 4Mb - 250k samples (65k samples per converter)
set adc_fifo_address_width 13

source $ad_hdl_dir/projects/common/vcu118/vcu118_system_bd.tcl
source $ad_hdl_dir/projects/common/xilinx/adcfifo_bd.tcl
source ../common/dual_ad9208_bd.tcl

foreach i {0 1} {

  ad_ip_parameter util_adc_${i}_xcvr CONFIG.RX_CLK25_DIV 30
  ad_ip_parameter util_adc_${i}_xcvr CONFIG.CPLL_CFG0 0x1fa
  ad_ip_parameter util_adc_${i}_xcvr CONFIG.CPLL_CFG1 0x2b
  ad_ip_parameter util_adc_${i}_xcvr CONFIG.CPLL_CFG2 0x2
  ad_ip_parameter util_adc_${i}_xcvr CONFIG.CPLL_FBDIV 2
  ad_ip_parameter util_adc_${i}_xcvr CONFIG.GTY4_CH_HSPMUX 0x4040
  ad_ip_parameter util_adc_${i}_xcvr CONFIG.GTY4_PREIQ_FREQ_BST 1
  ad_ip_parameter util_adc_${i}_xcvr CONFIG.GTY4_RTX_BUF_CML_CTRL 0x5
  ad_ip_parameter util_adc_${i}_xcvr CONFIG.GTY4_RXPI_CFG0 0x3002

  ad_ip_parameter util_adc_${i}_xcvr CONFIG.QPLL_REFCLK_DIV 1
  ad_ip_parameter util_adc_${i}_xcvr CONFIG.QPLL_CFG0 0x333c
  ad_ip_parameter util_adc_${i}_xcvr CONFIG.QPLL_CFG4 0x2
  ad_ip_parameter util_adc_${i}_xcvr CONFIG.QPLL_FBDIV 20
  ad_ip_parameter util_adc_${i}_xcvr CONFIG.GTY4_PPF0_CFG 0xB00

}


# Set the smart interconnect to use a lower speed switch to meet timing
set_property -dict [list CONFIG.ADVANCED_PROPERTIES {  __view__ { \
    timing { M00_Buffer { AR_SLR_PIPE 1 AW_SLR_PIPE 1 B_SLR_PIPE 1 R_SLR_PIPE 1 W_SLR_PIPE 1 } } \
    clocking { SW0 { ASSOCIATED_CLK aclk1 } } \
  } }] [get_bd_cells axi_mem_interconnect]


