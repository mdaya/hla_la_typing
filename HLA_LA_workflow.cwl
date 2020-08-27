class: Workflow
cwlVersion: v1.0
label: HLA LA workflow
$namespaces:
  sbg: https://sevenbridges.com

requirements:
- class: InlineJavascriptRequirement
- class: StepInputExpressionRequirement

inputs:
- id: ref_fasta_file
  label: ref_fasta_file
  doc: Reference fasta file used to align the CRAM
  type: File
  secondaryFiles:
  - .fai
  sbg:fileTypes: .FA
  sbg:x: -507.57122802734375
  sbg:y: -422.5242919921875
- id: cram_file
  label: cram_file
  doc: CRAM file
  type: File
  secondaryFiles:
  - .crai
  sbg:fileTypes: .CRAM
  sbg:x: -493
  sbg:y: -100
- id: input_archive_file
  label: Input archive file
  doc: The input archive file to be unpacked.
  type: File
  sbg:fileTypes: TAR, TAR.GZ, TGZ, TAR.BZ2, TBZ2, GZ, BZ2, ZIP
  sbg:x: -503
  sbg:y: -260

outputs:
- id: best_out_file
  label: best_out_file
  doc: Output file with best HLA allele calls
  type: File
  outputSource:
  - type_hla_la_1/best_out_file
  sbg:fileTypes: .TXT
  sbg:x: 95
  sbg:y: -461
- id: all_out_file
  label: all_out_file
  doc: Output file with all possible HLA alleles
  type: File
  outputSource:
  - type_hla_la_1/all_out_file
  sbg:fileTypes: .TXT
  sbg:x: 102
  sbg:y: -119

steps:
- id: type_hla_la_1
  label: type_hla_la
  in:
  - id: cram_file
    source: cram_file
  - id: ref_fasta_file
    source: ref_fasta_file
  - id: graph_files
    source:
    - sbg_decompressor_cwl1_0/output_files
  run: HLA_LA_workflow.cwl.steps/type_hla_la_1.cwl
  out:
  - id: best_out_file
  - id: all_out_file
  sbg:x: -193
  sbg:y: -268
- id: sbg_decompressor_cwl1_0
  label: SBG Decompressor CWL1.0
  in:
  - id: input_archive_file
    source: input_archive_file
  run: HLA_LA_workflow.cwl.steps/sbg_decompressor_cwl1_0.cwl
  out:
  - id: output_files
  sbg:x: -371
  sbg:y: -260
sbg:appVersion:
- v1.0
sbg:content_hash: aa5dd2e1886fa1fd4cd39e4c89144fa9e3855be1051a7791686723dc2c5d371f6
sbg:contributors:
- midaya
sbg:createdBy: midaya
sbg:createdOn: 1590859585
sbg:id: midaya/hla-la-bags-asthmatics/hla-la-workflow-1/1
sbg:image_url: |-
  https://platform.sb.biodatacatalyst.nhlbi.nih.gov/ns/brood/images/midaya/hla-la-bags-asthmatics/hla-la-workflow-1/1.png
sbg:latestRevision: 1
sbg:modifiedBy: midaya
sbg:modifiedOn: 1590859727
sbg:original_source: |-
  https://api.sb.biodatacatalyst.nhlbi.nih.gov/v2/apps/midaya/hla-la-bags-asthmatics/hla-la-workflow-1/1/raw/
sbg:project: midaya/hla-la-bags-asthmatics
sbg:projectName: HLA-LA BAGS asthmatics
sbg:publisher: sbg
sbg:revision: 1
sbg:revisionNotes: Changed to docker image 1.0
sbg:revisionsInfo:
- sbg:modifiedBy: midaya
  sbg:modifiedOn: 1590859585
  sbg:revision: 0
  sbg:revisionNotes: Copy of midaya/hla-typing-fhs-trios/hla-la-workflow-1/0
- sbg:modifiedBy: midaya
  sbg:modifiedOn: 1590859727
  sbg:revision: 1
  sbg:revisionNotes: Changed to docker image 1.0
sbg:sbgMaintained: false
sbg:validationErrors: []
