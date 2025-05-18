if { $argc < 2 } {
    puts "Usage: vivado -mode batch -source script.tcl -tclargs <project_file> <num_jobs>"
    exit 1
}

set project_file [lindex $argv 0]
set num_jobs [lindex $argv 1]

open_project $project_file

reset_run synth_1
reset_run impl_1
reset_run impl_2
reset_run impl_3
reset_run impl_4
reset_run impl_5
reset_run impl_6
reset_run impl_7
reset_run impl_8
reset_run impl_9
reset_run impl_10
reset_run impl_11
reset_run impl_12
reset_run impl_13
reset_run impl_14
reset_run impl_15
reset_run impl_16
reset_run impl_17
reset_run impl_18
reset_run impl_19
reset_run impl_20
reset_run impl_21
reset_run impl_22
reset_run impl_23
reset_run impl_24
reset_run impl_25
reset_run impl_26
reset_run impl_27
reset_run impl_28

launch_runs synth_1

wait_on_run synth_1

launch_runs impl_1 impl_2 impl_3 impl_4 impl_5 impl_6 impl_7 impl_8 impl_9 impl_10 impl_11 impl_12 impl_13 impl_14 impl_15 impl_16 impl_17 impl_18 impl_19 impl_20 impl_21 impl_22 impl_23 impl_24 impl_25 impl_26 impl_27 impl_28 -jobs $num_jobs

wait_on_run impl_1 impl_2 impl_3 impl_4 impl_5 impl_6 impl_7 impl_8 impl_9 impl_10 impl_11 impl_12 impl_13 impl_14 impl_15 impl_16 impl_17 impl_18 impl_19 impl_20 impl_21 impl_22 impl_23 impl_24 impl_25 impl_26 impl_27 impl_28
