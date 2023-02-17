helper scripts to check vmags manually for amg and amr analysis

VirSorter2 SOP used in this study(documented here to avoid version change) 
see https://www.protocols.io/view/viral-sequence-identification-sop-with-virsorter2-5qpvoyqebg4o/v3?step=5 for details and updates

Screening based on viral and host gene counts, score, hallmark gene counts, and contig length

The viral and host gene counts from checkV can be used for false positive screen ing. 
Since checkV is very conservative on calling viral genes, those sequences with viral genes called by checkV should be viral, and those with no viral gene called by checkV are more likely to be non-viral. 
Based on our benchmark with a soil bulk metagenome, those with no viral and no host gene called are viral; those with no viral gene and 2 or more host genes are mostly non-viral; 
those with no viral gene and 1 host gene are hard to tell viral from non-viral (likely mobile genetic elements, similar to category 3 in VirSorter1), and should be discarded unless manually checked. 
Here we only select those >10kb for manual curation since shorter ones are too short to tell. Also those with VirSorter2 score ≥0.95 or hallmark gene count >2 are mostly viral. 
These empirical screening criteria are summarized below:

Keep1: viral_gene >0
Keep2: viral_gene =0 AND (host_gene =0 OR score >=0.95 OR hallmark >2)
Manual check: (NOT in Keep1 OR Keep2) AND viral_gene =0 AND host_gene =1 AND length >=10kb
Discard: the rest

To look at the viral_gene, host_gene, score, and hallmark of sequences you can merge "vs2-pass1/final-viral-score.tsv" and "checkv/contamination.tsv", and filter in a spreadsheet.


DRAMv annotation screening
There are some genes that are common in both viruses and hosts 
(e.g.  Polyliposaccharides [LPS] related) and mobile element, which can cause false positives in the above "Keep2" category. 
Thus we want to be cautious with contigs with these genes. We have compiled a list of "suspicious" genes in this link. 
You can subset the DRAMv table using contigs in the "Keep2" category, and screen for the "suspicious" genes in the subset DRAMv table (ignore case, e.g. use "-i" option for "grep"),  and then put contigs with those genes in the “Manual check” category.

Manual curation

For those in “manual check” category, you can look through their annotations in "dramv-annotate/annotations.tsv", in which each gene of every contig is a line and has annotation from multiple databases. This step is hard to standardize, but below are some criteria based on our experience.

Criteria for calling a contig viral:
Structural genes, hallmark genes, depletion in annotations or enrichment for hypotheticals (~10% genes having non-hypothetical annotations)
Lacking hallmarks but >=50% of annotated genes hit to a virus and at least half of those have viral bitcore >100 and the contig is <50kb in length
Provirus: Integrase/recombinase/excisionase/repressor, enrichment of viral genes on one side
Provirus: “break” in the genome: gap between two genes corresponding to a strand switch, higher coding density, depletion in annotations, and an enrichment for phage genes on one side
Few annotations only ~1-3 genes, but with at least half hitting to viruses, and where the genes hitting cells have a bitscore no more than 150% that of the viral bitscores and/or viral bitscores are >100
LPS (lipopolysaccharide) looking regions if also has very strong hits to viral genes bitscore > 100

Criteria for callling a contig non-viral:
>3x cellular like genes than viral, nearly all genes annotated, no genes hitting to only viruses and no viral hallmark genes
Lacking any viral hallmark genes and >50kb
Strings of many obvious cellular genes, with no other viral hallmark genes. Examples encountered in our benchmarking include 1) CRISPR Cas, 2) ABC transporters, 3) Sporulation proteins, 4) Two-component systems, 5) Secretion system. Some of these may be encoded by viruses, but are not indicative of a viral contig without further evidence.
Multiple plasmid genes or transposases but no clear genes hitting only to viruses
Few annotations, only ~1-3 genes hitting to both viruses and cellular genes but with stronger bitscores for the cellular genes.
LPS looking regions if no strong viral hits. Enriched in genes commonly associated with Lipopolysaccharide or LPS, such as epimerases, glycosyl transferases, acyltransferase, short-chain dehydrogenase/reductase, dehydratase
Genes annotated as Type IV and/or Type VI secretion system surrounded by non-viral genes
Few annotations, only ~1-3 genes all hitting to cellular genes (even if bitscore <100) with no viral hits

Lastly, user beware that any provirus boundary predicted by VirSorter 2 and/or checkV is an approximate estimate only (calling “ends” is quite a challenging problem in prophage discovery), and needs to be manually inspected carefully too, especially for AMG studies.