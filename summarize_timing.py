
# Author: Sharath Pendyala - spendya@ncsu.edu - sharathpawan@gmail.com


import re
import argparse
import subprocess
import os
import sys

def run_extraction_script(script_path, vivado_runs_folder, debug=False):
    if debug:
        print(f"\nDEBUG: Running extraction script: {script_path} with folder: {vivado_runs_folder}")
    try:
        subprocess.run([script_path, vivado_runs_folder], check=True)
        if debug:
            print("DEBUG: Extraction script completed successfully")
    except subprocess.CalledProcessError as e:
        print(f"Error running extraction script: {e}")
        sys.exit(1)

def parse_timing_file(filename, debug=False):
    if debug:
        print(f"\nDEBUG: Parsing file: {filename}")

    impl_header_re = re.compile(r"===.*?/(impl_\d+)/.*===")
    results = []

    try:
        with open(filename) as f:
            lines = f.readlines()
            if debug:
                print(f"DEBUG: Successfully read {len(lines)} lines from file")
    except Exception as e:
        print(f"ERROR: Could not read file {filename}: {e}")
        return results

    i = 0
    while i < len(lines):
        line = lines[i]
        header_match = impl_header_re.match(line)
        if header_match:
            impl = header_match.group(1)
            if debug:
                print(f"\nDEBUG: Found implementation: {impl} at line {i+1}")

            found_data = False
            for j in range(i+1, min(i+15, len(lines))):
                data_line = lines[j].strip()
                if re.match(r"^-?[\d\.]", data_line):  # line starts with a number or minus
                    cols = data_line.split()
                    if debug:
                        print(f"DEBUG: Data line: {data_line}")
                    if len(cols) < 10:
                        if debug:
                            print("DEBUG: Not enough columns in data line, skipping.")
                        break
                    try:
                        wns = float(cols[0])
                        tns = float(cols[1])
                        tns_failing = int(cols[2])
                        whs = float(cols[4])
                        ths = float(cols[5])
                        ths_failing = int(cols[6])
                        result = {
                            'impl': impl,
                            'wns': wns,
                            'tns': tns,
                            'fe': tns_failing,
                            'whs': whs,
                            'ths': ths,
                            'hold_fe': ths_failing,
                        }
                        if debug:
                            print(f"DEBUG: Parsed result: {result}")
                        results.append(result)
                        found_data = True
                    except Exception as e:
                        if debug:
                            print(f"DEBUG: Error parsing data line: {e}")
                    break
            if not found_data and debug:
                print("DEBUG: No data line found for this implementation.")
        i += 1

    if debug:
        print(f"\nDEBUG: Total implementations found: {len(results)}")
    return results

def summarize(results, top_n, debug=False):
    if debug:
        print(f"\nDEBUG: Summarizing results, looking for top {top_n}")
        print(f"DEBUG: Total results before filtering: {len(results)}")

    filtered = [r for r in results if r['wns'] is not None]
    if debug:
        print(f"DEBUG: Results after filtering out None WNS: {len(filtered)}")

    sorted_results = sorted(filtered, key=lambda x: x['wns'], reverse=True)
    if debug:
        print("\nDEBUG: Top 3 WNS values after sorting:")
        for idx, r in enumerate(sorted_results[:3]):
            print(f"DEBUG: #{idx+1}: WNS = {r['wns']} (Implementation {r['impl']})")

    top = sorted_results[:top_n]

    timing_pass = any(r['wns'] is not None and r['wns'] >= 0 and r['whs'] is not None and r['whs'] >= 0 for r in filtered)
    if debug:
        print(f"DEBUG: Overall timing pass: {timing_pass}")

    return timing_pass, top

def write_summary(input_filename, output_filename, timing_pass, top, top_n, debug=False):
    if debug:
        print(f"\nDEBUG: Writing summary to {output_filename}")
        print(f"DEBUG: Timing {'PASS' if timing_pass else 'FAIL'}")
        print(f"DEBUG: Writing {len(top)} results")

    # Determine header line based on input filename
    if "routed" in input_filename:
        header_line = "Routed Result\n-------------\n\n"
    elif "postroute_phyopt" in input_filename:
        header_line = "Post Route Phy Opt Result\n-------------------------\n\n"
    else:
        header_line = "Parsed Result\n-------------\n\n"

    with open(output_filename, "w") as f:
        f.write("\n")
        f.write(header_line)
        f.write(f"Timing {'PASS' if timing_pass else 'FAIL'}\n\n")  # Blank line after PASS/FAIL
        f.write(f"Showing {top_n} closest results to timing closure (by WNS):\n")
        f.write("Impl\tWNS\tTNS\tFailing_EP\tWHS\tTHS\tHold_Failing_EP\n")
        for r in top:
            line = f"{r['impl']}\t{r['wns']}\t{r['tns']}\t{r['fe']}\t{r['whs']}\t{r['ths']}\t{r['hold_fe']}\n"
            f.write(line)
            if debug:
                print(f"DEBUG: Wrote line: {line.strip()}")
        f.write("\n\n")

    if debug:
        print(f"DEBUG: Successfully wrote summary to {output_filename}")

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("vivado_runs_folder", help="Path to Vivado runs folder")
    parser.add_argument("--top", type=int, default=10, help="Number of top results to show (default: 10)")
    parser.add_argument("--extract_script", default=os.path.expanduser("~/my_tools/extract_timing_summary.sh"),
                        help="Path to extract_timing_summary.sh script")
    parser.add_argument("--debug", action="store_true", help="Enable debug print statements")
    parser.add_argument("--output_files", nargs="+", default=[
        "extracted_timing_summary_routed.txt",
        "extracted_timing_summary_postroute_phyopt.txt"
    ], help="Names of extracted timing summary files to process")
    args = parser.parse_args()

    # Map input files to new output file names
    output_file_map = {
        "extracted_timing_summary_routed.txt": "parsed_timing_summary_routed.txt",
        "extracted_timing_summary_postroute_phyopt.txt": "parsed_timing_summary_postroute_phyopt.txt"
    }

    if args.debug:
        print("\nDEBUG: Script started with arguments:")
        print(f"Vivado runs folder: {args.vivado_runs_folder}")
        print(f"Top N: {args.top}")
        print(f"Extract script: {args.extract_script}")
        print(f"Output files to process: {args.output_files}")

    # Step 1: Run the extraction script
    run_extraction_script(args.extract_script, args.vivado_runs_folder, debug=args.debug)

    # Step 2: Process the extracted files
    for fname in args.output_files:
        if not os.path.exists(fname):
            print(f"WARNING: {fname} not found, skipping.")
            continue
        if args.debug:
            print(f"\nDEBUG: Processing file: {fname}")
        results = parse_timing_file(fname, debug=args.debug)
        timing_pass, top = summarize(results, args.top, debug=args.debug)
        output_fname = output_file_map.get(fname, f"parsed_{fname}")
        write_summary(fname, output_fname, timing_pass, top, args.top, debug=args.debug)

    if args.debug:
        print("\nDEBUG: Script completed")

