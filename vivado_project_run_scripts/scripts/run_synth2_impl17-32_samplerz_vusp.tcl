if { $argc < 2 } {
    puts "Usage: vivado -mode batch -source script.tcl -tclargs <project_file> <num_jobs>"
    exit 1
}

set project_file [lindex $argv 0]
set num_jobs [lindex $argv 1]

open_project $project_file

reset_run synth_2
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
reset_run impl_29
reset_run impl_30


launch_runs synth_2 -jobs $num_jobs

wait_on_run synth_2

launch_runs impl_17 impl_18 impl_19 impl_20 impl_21 impl_22 impl_23 impl_24 impl_25 impl_26 impl_27 impl_28 impl_29 impl_30 impl_31 impl_32 -jobs $num_jobs

wait_on_run impl_17 impl_18 impl_19 impl_20 impl_21 impl_22 impl_23 impl_24 impl_25 impl_26 impl_27 impl_28 impl_29 impl_30 impl_31 impl_32
