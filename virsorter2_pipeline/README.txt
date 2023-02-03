ran "virsorter setup -d db -j 4" to download required databases  
[2022-01-11 09:16 INFO] All setup finished
"pass2_setup.sh": after "running virsorter2_pass1.sh" and "check_V.sh", run this script to setup for virsorter2_pass2.sh

split virsorter2_pass2 results into chunks using split_for_dramv.sh, because takes too long to run in dramv
after virus identification, cluster identified virus contigs into vOTU at 95% nucleotide similarity over 80% of the area