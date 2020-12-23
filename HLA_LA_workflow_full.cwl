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
  run:
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
  run:
    class: CommandLineTool
    cwlVersion: v1.0
    label: SBG Decompressor CWL1.0
    doc: |-
      The SBG Decompressor tool performs extraction of files from an input archive file. 

      The supported formats are:
      1. TAR
      2. TAR.GZ (TGZ)
      3. TAR.BZ2 (TBZ2)
      4. GZ
      5. BZ2
      6. ZIP

      *A list of all inputs and parameters with corresponding descriptions can be found at the bottom of this page.*


      ###Common use cases

      This tool can be used to extract necessary files from input archives, or in workflows to uncompress and pass on containing files. 

      The two modes of work include outputting archive contents with preserved folder structure, and outputting extracted files as a list.

      * Select the mode by setting the parameter **Flatten outputs**. Setting the parameter to **True** extracts all files from the archive and outputs them to a list. 
      * To preserve the folder structure of the archive, set the **Flatten outputs** parameter to **False** (default is **True**).

      ###Common Issues and Important Notes

      This tool cannot extract archives of different types than noted above.

      ###Performance Benchmarking

      Below is a table describing the runtimes and task costs for different file sizes:

      | Input Archive Type | Input Archive Size | Duration | Cost   | Instance (AWS) |
      |--------------------|--------------------|----------|--------|----------------|
      | TAR.GZ             | 100MB              | 2min     | $0.006 | c4.2xlarge     |
      | TAR.GZ             | 1GB                | 8min     | $0.05  | c4.2xlarge     |

      *Cost can be significantly reduced by using spot instances. Visit the [Knowledge Center](https://docs.sevenbridges.com/docs/about-spot-instances) for more details.*
    $namespaces:
      sbg: https://sevenbridges.com

    requirements:
    - class: ShellCommandRequirement
    - class: ResourceRequirement
      coresMin: 1
      ramMin: 1000
    - class: DockerRequirement
      dockerPull: images.sbgenomics.com/ana_stankovic/python:3.7_dockerfile
      dockerImageId: 58b79c627f95
    - class: InitialWorkDirRequirement
      listing:
      - entryname: sbg_decompressor.py
        writable: false
        entry: |
          #!/usr/bin/python
          """
          Usage:
          	sbg_decompressor.py --input_archive_file FILE


          Description:  
          	SBG Decompressor performs the extraction of the input archive file. 
          	Supported formats are:
          		1. TAR
          		2. TAR.GZ (TGZ)
          		3. TAR.BZ2 (TBZ2)
          		4. GZ
          		5. BZ2
          		6. ZIP

          Options:
          	-h, --help							Show this screen.

              -v, --version           			Show version.

              --input_archive_file FILE        	The input archive file, containing FASTQ files, to be unpacked.
                                      	
          Examples:
          	sbg_decompressor.py --input_archive_file file1.tar.bz2
          	sbg_decompressor.py --input_archive_file file1.zip
          """

          import sys
          import os
          from docopt import docopt

          def main(argv):

              args = docopt(__doc__, version='v1.0')
              inputfile = args["--input_archive_file"]

              path = os.getcwd()
              folder = 'decompressed_files'

              basename = os.path.split(inputfile)[1]
              basename = basename[0:basename.rindex('.')]

              if inputfile.endswith('.tar'):
                  command = 'tar xvf ' + inputfile + ' -C ' + folder
              elif inputfile.endswith(('.tar.gz', '.tgz')):
                  command = 'tar xvzf ' + inputfile + ' -C ' + folder
              elif inputfile.endswith(('.tar.bz2', '.tbz2')):
                  command = 'tar xvjf ' + inputfile + ' -C ' + folder
              elif inputfile.endswith('.zip'):
                  command = 'unzip ' + inputfile + ' -d ' + path + '/' + folder
              elif inputfile.endswith('.gz'):
                  command = 'gunzip -c ' + inputfile + ' > ' + path + '/' + folder + '/' + basename
              elif inputfile.endswith('.bz2'):
                  command = 'bunzip2 -c ' + inputfile + ' > ' + path + '/' + folder + '/' + basename
              else:
                  raise Exception("Format is not supported!")

              print (command)
              os.system('mkdir ' + folder)
              os.system(command)

          if __name__ == "__main__":
              main(sys.argv[1:])
    - class: InlineJavascriptRequirement
      expressionLib:
      - |
        var setMetadata = function(file, metadata) {
            if (!('metadata' in file)) {
                file['metadata'] = {}
            }
            for (var key in metadata) {
                file['metadata'][key] = metadata[key];
            }
            return file
        };

        var inheritMetadata = function(o1, o2) {
            var commonMetadata = {};
            if (!o2) {
                return o1;
            };
            if (!Array.isArray(o2)) {
                o2 = [o2]
            }
            for (var i = 0; i < o2.length; i++) {
                var example = o2[i]['metadata'];
                for (var key in example) {
                    if (i == 0)
                        commonMetadata[key] = example[key];
                    else {
                        if (!(commonMetadata[key] == example[key])) {
                            delete commonMetadata[key]
                        }
                    }
                }
                for (var key in commonMetadata) {
                    if (!(key in example)) {
                        delete commonMetadata[key]
                    }
                }
            }
            if (!Array.isArray(o1)) {
                o1 = setMetadata(o1, commonMetadata)
                if (o1.secondaryFiles) {
                    o1.secondaryFiles = inheritMetadata(o1.secondaryFiles, o2)
                }
            } else {
                for (var i = 0; i < o1.length; i++) {
                    o1[i] = setMetadata(o1[i], commonMetadata)
                    if (o1[i].secondaryFiles) {
                        o1[i].secondaryFiles = inheritMetadata(o1[i].secondaryFiles, o2)
                    }
                }
            }
            return o1;
        };

    inputs:
    - id: input_archive_file
      label: Input archive file
      doc: The input archive file to be unpacked.
      type: File
      inputBinding:
        prefix: --input_archive_file
        position: 1
        valueFrom: |-
          ${
              var available_ext = ['.tar', '.tar.gz', '.tgz', '.tar.bz2', '.tbz2', '.gz', '.bz2', '.zip']
              var ext = inputs.input_archive_file.nameext
              
              if (available_ext.indexOf(ext) > -1) {
                  return inputs.input_archive_file.path
              } else return ''
          }
        shellQuote: false
      sbg:fileTypes: TAR, TAR.GZ, TGZ, TAR.BZ2, TBZ2, GZ, BZ2, ZIP
    - id: flatten_output
      label: Flatten outputs
      doc: Flatten output files, essentially putting them all in a single list structure.
      type: boolean?
      default: false
      sbg:toolDefaultValue: 'false'

    outputs:
    - id: output_files
      label: Output files
      doc: Unpacked files from the input archive.
      type: File[]
      outputBinding:
        glob: decompressed_files/*
        outputEval: "${\n    return inheritMetadata(self, inputs.input_archive_file)\n\
          \n}"

    baseCommand:
    - python3.7
    arguments:
    - prefix: ''
      position: 0
      valueFrom: |-
        ${
            var available_ext = ['.tar', '.tar.gz', '.tgz', '.tar.bz2', '.tbz2', '.gz', '.bz2', '.zip']
            var ext = inputs.input_archive_file.nameext
            
            if (available_ext.indexOf(ext) > -1) {
                return 'sbg_decompressor.py '
            } else return 'ARCHIVE TYPE NOT SUPPORTED: ' + ext
        }
      shellQuote: false
    - prefix: ''
      position: 2
      valueFrom: |-
        ${
            var available_ext = ['.tar', '.tar.gz', '.tgz', '.tar.bz2', '.tbz2', '.gz', '.bz2', '.zip']
            var ext = inputs.input_archive_file.nameext
            
            if (available_ext.indexOf(ext) > -1) {
                if (inputs.flatten_output == true){
                    return "; find ./decompressed_files -mindepth 2 -type f -exec mv -i '{}' ./decompressed_files ';'; mkdir ./decompressed_files/dummy_to_delete ;rm -R -- ./decompressed_files/*/ "
                } else return ''
            } else return ''
        }
      separate: false
      shellQuote: false
    id: admin/sbg-public-data/sbg-decompressor-cwl1-0/12
    sbg:appVersion:
    - v1.0
    sbg:categories:
    - Utilities
    - SBGTools
    - CWL1.0
    sbg:cmdPreview: |-
      python /opt/sbg_decompressor.py  --input_archive_file input_file.tar ; find ./decompressed_files -mindepth 2 -type f -exec mv -i '{}' ./decompressed_files ';'; mkdir ./decompressed_files/dummy_to_delete ;rm -R -- ./decompressed_files/*/
    sbg:content_hash: a8c9f8c2203da4362ff89564543e6efd434d460f0a7f1ee8462d7dc8a903436c6
    sbg:contributors:
    - admin
    sbg:createdBy: admin
    sbg:createdOn: 1584385310
    sbg:homepage: https://igor.sbgenomics.com/
    sbg:id: admin/sbg-public-data/sbg-decompressor-cwl1-0/12
    sbg:image_url:
    sbg:latestRevision: 12
    sbg:license: Apache License 2.0
    sbg:modifiedBy: admin
    sbg:modifiedOn: 1584385448
    sbg:project: admin/sbg-public-data
    sbg:projectName: SBG Public Data
    sbg:publisher: sbg
    sbg:revision: 12
    sbg:revisionNotes: Add CWL1.0 to name
    sbg:revisionsInfo:
    - sbg:modifiedBy: admin
      sbg:modifiedOn: 1584385310
      sbg:revision: 0
      sbg:revisionNotes:
    - sbg:modifiedBy: admin
      sbg:modifiedOn: 1584385445
      sbg:revision: 1
      sbg:revisionNotes: Upgraded to v1.0 from bix-demo/sbgtools-demo/sbg-decompressor-1-0
    - sbg:modifiedBy: admin
      sbg:modifiedOn: 1584385446
      sbg:revision: 2
      sbg:revisionNotes: Updated description
    - sbg:modifiedBy: admin
      sbg:modifiedOn: 1584385446
      sbg:revision: 3
      sbg:revisionNotes: Updated tool name
    - sbg:modifiedBy: admin
      sbg:modifiedOn: 1584385446
      sbg:revision: 4
      sbg:revisionNotes: Added option to preserve archive folder structure
    - sbg:modifiedBy: admin
      sbg:modifiedOn: 1584385446
      sbg:revision: 5
      sbg:revisionNotes: Added option to preserve archive folder structure
    - sbg:modifiedBy: admin
      sbg:modifiedOn: 1584385447
      sbg:revision: 6
      sbg:revisionNotes: Added option to preserve archive folder structure
    - sbg:modifiedBy: admin
      sbg:modifiedOn: 1584385447
      sbg:revision: 7
      sbg:revisionNotes: Updated description
    - sbg:modifiedBy: admin
      sbg:modifiedOn: 1584385447
      sbg:revision: 8
      sbg:revisionNotes: Revise description
    - sbg:modifiedBy: admin
      sbg:modifiedOn: 1584385448
      sbg:revision: 9
      sbg:revisionNotes: Updated Description
    - sbg:modifiedBy: admin
      sbg:modifiedOn: 1584385448
      sbg:revision: 10
      sbg:revisionNotes: Updated Description
    - sbg:modifiedBy: admin
      sbg:modifiedOn: 1584385448
      sbg:revision: 11
      sbg:revisionNotes: Change "SBG Tools" to "SBGTools" tag
    - sbg:modifiedBy: admin
      sbg:modifiedOn: 1584385448
      sbg:revision: 12
      sbg:revisionNotes: Add CWL1.0 to name
    sbg:sbgMaintained: false
    sbg:toolAuthor: Seven Bridges
    sbg:toolkit: SBGTools
    sbg:toolkitVersion: v1.0
    sbg:validationErrors: []
  out:
  - id: output_files
  sbg:x: -371
  sbg:y: -260
id: |-
  https://api.sb.biodatacatalyst.nhlbi.nih.gov/v2/apps/midaya/hla-la-bags-asthmatics/hla-la-workflow-1/1/raw/
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
