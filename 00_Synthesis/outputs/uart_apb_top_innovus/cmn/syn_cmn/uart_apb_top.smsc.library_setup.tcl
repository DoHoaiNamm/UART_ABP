################################################################################
#
# Genus(TM) Synthesis Solution setup file
# Created by Genus(TM) Synthesis Solution 22.12-s082_1
#   on 04/24/2026 13:14:25
#
#
################################################################################


# This script is intended for use with Genus(TM) Synthesis Solution version 22.12-s082_1


# To allow user-readonly attributes
################################################################################
::legacy::set_attribute -quiet force_tui_is_remote 1 /


# Libraries
################################################################################
create_library_domain {slow fast}
::legacy::set_attribute library {/home/QUYETDT3/DATN/ver3_UART_APB/00_Synthesis/../libraries/lib/max/slow.lib /home/QUYETDT3/DATN/ver3_UART_APB/00_Synthesis/../libraries/lib/max/pdkIO.lib} slow
::legacy::set_attribute library {/home/QUYETDT3/DATN/ver3_UART_APB/00_Synthesis/../libraries/lib/min/fast.lib /home/QUYETDT3/DATN/ver3_UART_APB/00_Synthesis/../libraries/lib/min/pdkIO.lib} fast
::legacy::set_attribute -quiet default true slow
::legacy::set_attribute -quiet wireload_selection none slow
::legacy::set_attribute -quiet power_library {/libraries/library_domains/fast} slow
::legacy::set_attribute -quiet wireload_selection none fast

