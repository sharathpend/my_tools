# ------------------------------
# Directory Structure and Max number of Vivado jobs (specific to Memnon PC capabilities)
SCRIPTS_FOLDER := scripts
PROJECT_FILE_VUSP := $(shell realpath samplerz/samplerz.xpr)
VUSP_RUNS_FOLDER := $(shell realpath samplerz/samplerz.runs)
PROJECT_FILE_ZUSP := $(shell realpath samplerz_zusp/samplerz_zusp.xpr)
ZUSP_RUNS_FOLDER := $(shell realpath samplerz_zusp/samplerz_zusp.runs)
NUM_JOBS := 8
# ------------------------------

help:
	@echo "";
	@echo "  Available targets:";
	@echo "";
	@echo "  make run           - Display Help.";
	@echo "  make reset_zusp    - Reset all runs in samplerz_zusp.";
	@echo "  make reset_vusp    - Reset all runs in samplerz_vusp (samplerz).";
	@echo "  make zusp_all      - Run all synth and impl for samplerz_zusp.";
	@echo "  make vusp_all      - Run all synth and impl for samplerz_vusp (samplerz).";
	@echo "  make ts_zusp       - Extract timing summary for all runs in samplerz_zusp.";
	@echo "  make ts_vusp       - Extract timing summary for all runs in samplerz_vusp (samplerz).";
	@echo "  make zusp_synth1   - Run synth_1 and all impl under synth_1 for samplerz_zusp.";
	@echo "  make vusp_synth1   - Run synth_1 and all impl under synth_1 for samplerz_vusp (samplerz).";
	@echo "  make zusp_synth2   - Run synth_2 and all impl under synth_2 for samplerz_zusp.";
	@echo "  make vusp_synth2   - Run synth_2 and all impl under synth_2 for samplerz_vusp (samplerz).";
	@echo "  make clean         - Clear Vivado logs";
	@echo ""

run: help

reset_zusp:
	source ./setup.sh; \
	cd $(SCRIPTS_FOLDER); \
	./reset_all_samplerz.sh '$(PROJECT_FILE_ZUSP)' '$(NUM_JOBS)';

reset_vusp:
	source ./setup.sh; \
	cd $(SCRIPTS_FOLDER); \
	./reset_all_samplerz.sh '$(PROJECT_FILE_VUSP)' '$(NUM_JOBS)';

zusp_all:
	source ./setup.sh; \
	cd $(SCRIPTS_FOLDER); \
	./run_all_samplerz.sh '$(PROJECT_FILE_ZUSP)' '$(NUM_JOBS)';

vusp_all:
	source ./setup.sh; \
	cd $(SCRIPTS_FOLDER); \
	./run_all_samplerz.sh '$(PROJECT_FILE_VUSP)' '$(NUM_JOBS)';

ts_zusp:
	python ~/my_tools/summarize_timing.py '$(ZUSP_RUNS_FOLDER)';

ts_vusp:
	python ~/my_tools/summarize_timing.py '$(VUSP_RUNS_FOLDER)';

zusp_synth1:
	source ./setup.sh; \
	cd $(SCRIPTS_FOLDER); \
	./run_synth1_impl1-28_samplerz_zusp.sh '$(PROJECT_FILE_ZUSP)' '$(NUM_JOBS)';

vusp_synth1:
	source ./setup.sh; \
	cd $(SCRIPTS_FOLDER); \
	./run_synth1_impl1-16_samplerz_vusp.sh '$(PROJECT_FILE_VUSP)' '$(NUM_JOBS)';

zusp_synth2:
	source ./setup.sh; \
	cd $(SCRIPTS_FOLDER); \
	./run_synth2_impl31-58_samplerz_zusp.sh '$(PROJECT_FILE_ZUSP)' '$(NUM_JOBS)';

vusp_synth2:
	source ./setup.sh; \
	cd $(SCRIPTS_FOLDER); \
	./run_synth2_impl31-58_samplerz_zusp.sh '$(PROJECT_FILE_VUSP)' '$(NUM_JOBS)';

clean:
	~/my_tools/clear_vivado_logs.sh;
	cd $(SCRIPTS_FOLDER); \
	~/my_tools/clear_vivado_logs.sh;
