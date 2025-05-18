if { $argc < 2 } {
    puts "Usage: vivado -mode batch -source script.tcl -tclargs <project_file> <num_jobs>"
    exit 1
}

set project_file [lindex $argv 0]
set num_jobs [lindex $argv 1]

open_project $project_file

reset_run [get_runs impl_*]
reset_run [get_runs synth_*]