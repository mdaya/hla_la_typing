class: CommandLineTool
cwlVersion: v1.0
label: type_hla_la
$namespaces:
  sbg: https://sevenbridges.com

requirements:
- class: ShellCommandRequirement
- class: ResourceRequirement
  ramMin: 64
- class: DockerRequirement
  dockerPull: quay.io/mdaya/hla_la_typing:1.0

inputs:
- id: cram_file
  label: cram_file
  doc: CRAM file
  type: File
  secondaryFiles:
  - .crai
  inputBinding:
    position: 1
    shellQuote: false
  sbg:fileTypes: .CRAM
- id: ref_fasta_file
  label: ref_fasta_file
  doc: Reference fasta file used to align the CRAM
  type: File
  secondaryFiles:
  - .fai
  inputBinding:
    position: 2
    shellQuote: false
  sbg:fileTypes: .FA
- id: graph_files
  label: graph_files
  doc: Extracted graph files to link to graph/PRG_MHC_GRCh38_withIMGT
  type: File[]
  inputBinding:
    position: 3
    shellQuote: false

outputs:
- id: best_out_file
  label: best_out_file
  doc: Output file with best HLA allele calls
  type: File
  outputBinding:
    glob: '*_output_G.txt'
  sbg:fileTypes: .TXT
- id: all_out_file
  label: all_out_file
  doc: Output file with all possible HLA alleles
  type: File
  outputBinding:
    glob: '*_output.txt'
  sbg:fileTypes: .TXT

baseCommand:
- /usr/local/bin/type_hla.sh
arguments:
- prefix: ''
  position: 0
  valueFrom: '8'
  shellQuote: false

hints:
- class: sbg:AWSInstanceType
  value: r5.2xlarge;ebs-gp2;1024
id: midaya/hisat-genotype-hla-typing/type-hla-la-1/1
sbg:appVersion:
- v1.0
sbg:content_hash: a3390eb9136f9f75169491487256a523f469dc233082d14e96b2287aa11cde33e
sbg:contributors:
- midaya
sbg:createdBy: midaya
sbg:createdOn: 1590015304
sbg:id: midaya/hisat-genotype-hla-typing/type-hla-la-1/1
sbg:image_url:
sbg:latestRevision: 1
sbg:modifiedBy: midaya
sbg:modifiedOn: 1590016039
sbg:project: midaya/hisat-genotype-hla-typing
sbg:projectName: HISAT-genotype HLA typing
sbg:publisher: sbg
sbg:revision: 1
sbg:revisionNotes: Initial version
sbg:revisionsInfo:
- sbg:modifiedBy: midaya
  sbg:modifiedOn: 1590015304
  sbg:revision: 0
  sbg:revisionNotes:
- sbg:modifiedBy: midaya
  sbg:modifiedOn: 1590016039
  sbg:revision: 1
  sbg:revisionNotes: Initial version
sbg:sbgMaintained: false
sbg:validationErrors: []
