if { $argc < 2 } {
    puts "Usage: vivado -mode batch -source script.tcl -tclargs <project_file> <num_jobs>"
    exit 1
}

set project_file [lindex $argv 0]
set num_jobs [lindex $argv 1]

open_project $project_file

reset_run synth_2
reset_run impl_30
reset_run impl_31
reset_run impl_32
reset_run impl_33
reset_run impl_34
reset_run impl_35
reset_run impl_36
reset_run impl_37
reset_run impl_38
reset_run impl_39
reset_run impl_40
reset_run impl_41
reset_run impl_42
reset_run impl_43
reset_run impl_44
reset_run impl_45
reset_run impl_46
reset_run impl_47
reset_run impl_48
reset_run impl_49
reset_run impl_50
reset_run impl_51
reset_run impl_52
reset_run impl_53
reset_run impl_54
reset_run impl_55
reset_run impl_56
reset_run impl_57
reset_run impl_58

launch_runs synth_2 -jobs $num_jobs

wait_on_run synth_2

launch_runs impl_31 impl_32 impl_33 impl_34 impl_35 impl_36 impl_37 impl_38 impl_39 impl_40 impl_41 impl_42 impl_43 impl_44 impl_45 impl_46 impl_47 impl_48 impl_49 impl_50 impl_51 impl_52 impl_53 impl_54 impl_55 impl_56 impl_57 impl_58 -jobs $num_jobs

wait_on_run impl_31 impl_32 impl_33 impl_34 impl_35 impl_36 impl_37 impl_38 impl_39 impl_40 impl_41 impl_42 impl_43 impl_44 impl_45 impl_46 impl_47 impl_48 impl_49 impl_50 impl_51 impl_52 impl_53 impl_54 impl_55 impl_56 impl_57 impl_58
