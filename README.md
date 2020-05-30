A docker environment and calling script to run HLA-LA on Seven Bridges on Biodata catalyst.

The docker build can be pulled from https://quay.io/repository/mdaya/hla_la_typing

To run HLA-typing, use the following command from the docker instance:

```
/usr/local/bin/type_hla.sh <nr_threads> <cram_file_name> <ref_fasta_file_name> <graph_dir>
```

## type_hla parameters

All parameters are mandatory and should be specified in order

### nr_threads

Set to the number of CPU cores available on the compute instance

### cram_file_name

Full path name of the CRAM file on which HLA typing should be run. A corresponding CRAM index file should also be available.

### ref_fasta_file_name

The reference fasta file used originally to create the CRAM file. A corresoponding index file should also be available.

### graph_dir

The graph directory needed by HLA-LA to perform HLA typing. See notes below. 

## Important notes

* Use the SBG Decompressor CWL1.0 to extract the required graph file archive PRG\_MHC\_GRCh38\_withIMGT.tar.gz, with the flatten_output argument set to false
* Recommended AWS compute instance: r5.2xlarge with 150GB attached storage (at least 64 GB memory is required for the pipeline); 8 CPU cores are available on this instance

## Creation of the graph file archive

The reference files required by HLA-LA was created using the following commands, ran within a docker instance with HLA-LA installed:

```
cd /usr/local/bin/HLA-LA/graphs
wget http://www.well.ox.ac.uk/downloads/PRG_MHC_GRCh38_withIMGT.tar.gz
tar -xvzf PRG_MHC_GRCh38_withIMGT.tar.gz
rm PRG_MHC_GRCh38_withIMGT.tar.gz
#Index the graph
../bin/HLA-LA --action prepareGraph --PRG_graph_dir ../graphs/PRG_MHC_GRCh38_withIMGT
#Run the pipeline on one sample in order to create indexes for the files in
#graphs/PRG_MHC_GRCh38_withIMGT/extendedReferenceGenome, then create tarball
#using the command below
tar -czvf PRG_MHC_GRCh38_withIMGT.tar.gz ./PRG_MHC_GRCh38_withIMGT 
```
