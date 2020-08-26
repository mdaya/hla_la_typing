{
    "class": "Workflow",
    "cwlVersion": "v1.0",
    "label": "HLA LA workflow",
    "$namespaces": {
        "sbg": "https://sevenbridges.com"
    },
    "inputs": [
        {
            "id": "ref_fasta_file",
            "sbg:fileTypes": ".FA",
            "type": "File",
            "label": "ref_fasta_file",
            "doc": "Reference fasta file used to align the CRAM",
            "secondaryFiles": [
                ".fai"
            ],
            "sbg:x": -507.57122802734375,
            "sbg:y": -422.5242919921875
        },
        {
            "id": "cram_file",
            "sbg:fileTypes": ".CRAM",
            "type": "File",
            "label": "cram_file",
            "doc": "CRAM file",
            "secondaryFiles": [
                ".crai"
            ],
            "sbg:x": -493,
            "sbg:y": -100
        },
        {
            "id": "input_archive_file",
            "sbg:fileTypes": "TAR, TAR.GZ, TGZ, TAR.BZ2, TBZ2, GZ, BZ2, ZIP",
            "type": "File",
            "label": "Input archive file",
            "doc": "The input archive file to be unpacked.",
            "sbg:x": -503,
            "sbg:y": -260
        }
    ],
    "outputs": [
        {
            "id": "best_out_file",
            "outputSource": [
                "type_hla_la_1/best_out_file"
            ],
            "sbg:fileTypes": ".TXT",
            "type": "File",
            "label": "best_out_file",
            "doc": "Output file with best HLA allele calls",
            "sbg:x": 95,
            "sbg:y": -461
        },
        {
            "id": "all_out_file",
            "outputSource": [
                "type_hla_la_1/all_out_file"
            ],
            "sbg:fileTypes": ".TXT",
            "type": "File",
            "label": "all_out_file",
            "doc": "Output file with all possible HLA alleles",
            "sbg:x": 102,
            "sbg:y": -119
        }
    ],
    "steps": [
        {
            "id": "type_hla_la_1",
            "in": [
                {
                    "id": "cram_file",
                    "source": "cram_file"
                },
                {
                    "id": "ref_fasta_file",
                    "source": "ref_fasta_file"
                },
                {
                    "id": "graph_files",
                    "source": [
                        "sbg_decompressor_cwl1_0/output_files"
                    ]
                }
            ],
            "out": [
                {
                    "id": "best_out_file"
                },
                {
                    "id": "all_out_file"
                }
            ],
            "run": {
                "class": "CommandLineTool",
                "cwlVersion": "v1.0",
                "$namespaces": {
                    "sbg": "https://sevenbridges.com"
                },
                "id": "midaya/hisat-genotype-hla-typing/type-hla-la-1/1",
                "baseCommand": [
                    "/usr/local/bin/type_hla.sh"
                ],
                "inputs": [
                    {
                        "id": "cram_file",
                        "type": "File",
                        "inputBinding": {
                            "position": 1,
                            "shellQuote": false
                        },
                        "label": "cram_file",
                        "doc": "CRAM file",
                        "sbg:fileTypes": ".CRAM",
                        "secondaryFiles": [
                            ".crai"
                        ]
                    },
                    {
                        "id": "ref_fasta_file",
                        "type": "File",
                        "inputBinding": {
                            "position": 2,
                            "shellQuote": false
                        },
                        "label": "ref_fasta_file",
                        "doc": "Reference fasta file used to align the CRAM",
                        "sbg:fileTypes": ".FA",
                        "secondaryFiles": [
                            ".fai"
                        ]
                    },
                    {
                        "id": "graph_files",
                        "type": "File[]",
                        "inputBinding": {
                            "position": 3,
                            "shellQuote": false
                        },
                        "label": "graph_files",
                        "doc": "Extracted graph files to link to graph/PRG_MHC_GRCh38_withIMGT"
                    }
                ],
                "outputs": [
                    {
                        "id": "best_out_file",
                        "doc": "Output file with best HLA allele calls",
                        "label": "best_out_file",
                        "type": "File",
                        "outputBinding": {
                            "glob": "*_output_G.txt"
                        },
                        "sbg:fileTypes": ".TXT"
                    },
                    {
                        "id": "all_out_file",
                        "doc": "Output file with all possible HLA alleles",
                        "label": "all_out_file",
                        "type": "File",
                        "outputBinding": {
                            "glob": "*_output.txt"
                        },
                        "sbg:fileTypes": ".TXT"
                    }
                ],
                "label": "type_hla_la",
                "arguments": [
                    {
                        "position": 0,
                        "prefix": "",
                        "shellQuote": false,
                        "valueFrom": "8"
                    }
                ],
                "requirements": [
                    {
                        "class": "ShellCommandRequirement"
                    },
                    {
                        "class": "ResourceRequirement",
                        "ramMin": 64
                    },
                    {
                        "class": "DockerRequirement",
                        "dockerPull": "quay.io/mdaya/hla_la_typing:1.0"
                    }
                ],
                "hints": [
                    {
                        "class": "sbg:AWSInstanceType",
                        "value": "r5.2xlarge;ebs-gp2;1024"
                    }
                ],
                "sbg:projectName": "HISAT-genotype HLA typing"
            },
            "label": "type_hla_la",
            "sbg:x": -193,
            "sbg:y": -268
        },
        {
            "id": "sbg_decompressor_cwl1_0",
            "in": [
                {
                    "id": "input_archive_file",
                    "source": "input_archive_file"
                }
            ],
            "out": [
                {
                    "id": "output_files"
                }
            ],
            "run": {
                "class": "CommandLineTool",
                "cwlVersion": "v1.0",
                "$namespaces": {
                    "sbg": "https://sevenbridges.com"
                },
                "id": "admin/sbg-public-data/sbg-decompressor-cwl1-0/12",
                "baseCommand": [
                    "python3.7"
                ],
                "inputs": [
                    {
                        "id": "input_archive_file",
                        "type": "File",
                        "inputBinding": {
                            "position": 1,
                            "prefix": "--input_archive_file",
                            "shellQuote": false,
                            "valueFrom": "${\n    var available_ext = ['.tar', '.tar.gz', '.tgz', '.tar.bz2', '.tbz2', '.gz', '.bz2', '.zip']\n    var ext = inputs.input_archive_file.nameext\n    \n    if (available_ext.indexOf(ext) > -1) {\n        return inputs.input_archive_file.path\n    } else return ''\n}"
                        },
                        "label": "Input archive file",
                        "doc": "The input archive file to be unpacked.",
                        "sbg:fileTypes": "TAR, TAR.GZ, TGZ, TAR.BZ2, TBZ2, GZ, BZ2, ZIP"
                    },
                    {
                        "sbg:toolDefaultValue": "false",
                        "id": "flatten_output",
                        "type": "boolean?",
                        "label": "Flatten outputs",
                        "doc": "Flatten output files, essentially putting them all in a single list structure.",
                        "default": false
                    }
                ],
                "outputs": [
                    {
                        "id": "output_files",
                        "doc": "Unpacked files from the input archive.",
                        "label": "Output files",
                        "type": "File[]",
                        "outputBinding": {
                            "glob": "decompressed_files/*",
                            "outputEval": "${\n    return inheritMetadata(self, inputs.input_archive_file)\n\n}"
                        }
                    }
                ],
                "doc": "The SBG Decompressor tool performs extraction of files from an input archive file. \n\nThe supported formats are:\n1. TAR\n2. TAR.GZ (TGZ)\n3. TAR.BZ2 (TBZ2)\n4. GZ\n5. BZ2\n6. ZIP\n\n*A list of all inputs and parameters with corresponding descriptions can be found at the bottom of this page.*\n\n\n###Common use cases\n\nThis tool can be used to extract necessary files from input archives, or in workflows to uncompress and pass on containing files. \n\nThe two modes of work include outputting archive contents with preserved folder structure, and outputting extracted files as a list.\n\n* Select the mode by setting the parameter **Flatten outputs**. Setting the parameter to **True** extracts all files from the archive and outputs them to a list. \n* To preserve the folder structure of the archive, set the **Flatten outputs** parameter to **False** (default is **True**).\n\n###Common Issues and Important Notes\n\nThis tool cannot extract archives of different types than noted above.\n\n###Performance Benchmarking\n\nBelow is a table describing the runtimes and task costs for different file sizes:\n\n| Input Archive Type | Input Archive Size | Duration | Cost   | Instance (AWS) |\n|--------------------|--------------------|----------|--------|----------------|\n| TAR.GZ             | 100MB              | 2min     | $0.006 | c4.2xlarge     |\n| TAR.GZ             | 1GB                | 8min     | $0.05  | c4.2xlarge     |\n\n*Cost can be significantly reduced by using spot instances. Visit the [Knowledge Center](https://docs.sevenbridges.com/docs/about-spot-instances) for more details.*",
                "label": "SBG Decompressor CWL1.0",
                "arguments": [
                    {
                        "position": 0,
                        "prefix": "",
                        "shellQuote": false,
                        "valueFrom": "${\n    var available_ext = ['.tar', '.tar.gz', '.tgz', '.tar.bz2', '.tbz2', '.gz', '.bz2', '.zip']\n    var ext = inputs.input_archive_file.nameext\n    \n    if (available_ext.indexOf(ext) > -1) {\n        return 'sbg_decompressor.py '\n    } else return 'ARCHIVE TYPE NOT SUPPORTED: ' + ext\n}"
                    },
                    {
                        "position": 2,
                        "prefix": "",
                        "separate": false,
                        "shellQuote": false,
                        "valueFrom": "${\n    var available_ext = ['.tar', '.tar.gz', '.tgz', '.tar.bz2', '.tbz2', '.gz', '.bz2', '.zip']\n    var ext = inputs.input_archive_file.nameext\n    \n    if (available_ext.indexOf(ext) > -1) {\n        if (inputs.flatten_output == true){\n            return \"; find ./decompressed_files -mindepth 2 -type f -exec mv -i '{}' ./decompressed_files ';'; mkdir ./decompressed_files/dummy_to_delete ;rm -R -- ./decompressed_files/*/ \"\n        } else return ''\n    } else return ''\n}"
                    }
                ],
                "requirements": [
                    {
                        "class": "ShellCommandRequirement"
                    },
                    {
                        "class": "ResourceRequirement",
                        "ramMin": 1000,
                        "coresMin": 1
                    },
                    {
                        "class": "DockerRequirement",
                        "dockerImageId": "58b79c627f95",
                        "dockerPull": "images.sbgenomics.com/ana_stankovic/python:3.7_dockerfile"
                    },
                    {
                        "class": "InitialWorkDirRequirement",
                        "listing": [
                            {
                                "entryname": "sbg_decompressor.py",
                                "entry": "#!/usr/bin/python\n\"\"\"\nUsage:\n\tsbg_decompressor.py --input_archive_file FILE\n\n\nDescription:  \n\tSBG Decompressor performs the extraction of the input archive file. \n\tSupported formats are:\n\t\t1. TAR\n\t\t2. TAR.GZ (TGZ)\n\t\t3. TAR.BZ2 (TBZ2)\n\t\t4. GZ\n\t\t5. BZ2\n\t\t6. ZIP\n\nOptions:\n\t-h, --help\t\t\t\t\t\t\tShow this screen.\n\n    -v, --version           \t\t\tShow version.\n\n    --input_archive_file FILE        \tThe input archive file, containing FASTQ files, to be unpacked.\n                            \t\nExamples:\n\tsbg_decompressor.py --input_archive_file file1.tar.bz2\n\tsbg_decompressor.py --input_archive_file file1.zip\n\"\"\"\n\nimport sys\nimport os\nfrom docopt import docopt\n\ndef main(argv):\n\n    args = docopt(__doc__, version='v1.0')\n    inputfile = args[\"--input_archive_file\"]\n\n    path = os.getcwd()\n    folder = 'decompressed_files'\n\n    basename = os.path.split(inputfile)[1]\n    basename = basename[0:basename.rindex('.')]\n\n    if inputfile.endswith('.tar'):\n        command = 'tar xvf ' + inputfile + ' -C ' + folder\n    elif inputfile.endswith(('.tar.gz', '.tgz')):\n        command = 'tar xvzf ' + inputfile + ' -C ' + folder\n    elif inputfile.endswith(('.tar.bz2', '.tbz2')):\n        command = 'tar xvjf ' + inputfile + ' -C ' + folder\n    elif inputfile.endswith('.zip'):\n        command = 'unzip ' + inputfile + ' -d ' + path + '/' + folder\n    elif inputfile.endswith('.gz'):\n        command = 'gunzip -c ' + inputfile + ' > ' + path + '/' + folder + '/' + basename\n    elif inputfile.endswith('.bz2'):\n        command = 'bunzip2 -c ' + inputfile + ' > ' + path + '/' + folder + '/' + basename\n    else:\n        raise Exception(\"Format is not supported!\")\n\n    print (command)\n    os.system('mkdir ' + folder)\n    os.system(command)\n\nif __name__ == \"__main__\":\n    main(sys.argv[1:])\n",
                                "writable": false
                            }
                        ]
                    },
                    {
                        "class": "InlineJavascriptRequirement",
                        "expressionLib": [
                            "var setMetadata = function(file, metadata) {\n    if (!('metadata' in file)) {\n        file['metadata'] = {}\n    }\n    for (var key in metadata) {\n        file['metadata'][key] = metadata[key];\n    }\n    return file\n};\n\nvar inheritMetadata = function(o1, o2) {\n    var commonMetadata = {};\n    if (!o2) {\n        return o1;\n    };\n    if (!Array.isArray(o2)) {\n        o2 = [o2]\n    }\n    for (var i = 0; i < o2.length; i++) {\n        var example = o2[i]['metadata'];\n        for (var key in example) {\n            if (i == 0)\n                commonMetadata[key] = example[key];\n            else {\n                if (!(commonMetadata[key] == example[key])) {\n                    delete commonMetadata[key]\n                }\n            }\n        }\n        for (var key in commonMetadata) {\n            if (!(key in example)) {\n                delete commonMetadata[key]\n            }\n        }\n    }\n    if (!Array.isArray(o1)) {\n        o1 = setMetadata(o1, commonMetadata)\n        if (o1.secondaryFiles) {\n            o1.secondaryFiles = inheritMetadata(o1.secondaryFiles, o2)\n        }\n    } else {\n        for (var i = 0; i < o1.length; i++) {\n            o1[i] = setMetadata(o1[i], commonMetadata)\n            if (o1[i].secondaryFiles) {\n                o1[i].secondaryFiles = inheritMetadata(o1[i].secondaryFiles, o2)\n            }\n        }\n    }\n    return o1;\n};\n"
                        ]
                    }
                ],
                "sbg:license": "Apache License 2.0",
                "sbg:toolkit": "SBGTools",
                "sbg:projectName": "SBG Public Data",
                "sbg:image_url": null,
                "sbg:toolkitVersion": "v1.0",
                "sbg:homepage": "https://igor.sbgenomics.com/",
                "sbg:cmdPreview": "python /opt/sbg_decompressor.py  --input_archive_file input_file.tar ; find ./decompressed_files -mindepth 2 -type f -exec mv -i '{}' ./decompressed_files ';'; mkdir ./decompressed_files/dummy_to_delete ;rm -R -- ./decompressed_files/*/",
                "sbg:categories": [
                    "Utilities",
                    "SBGTools",
                    "CWL1.0"
                ],
                "sbg:toolAuthor": "Seven Bridges",
                "sbg:revisionsInfo": [
                    {
                        "sbg:revision": 0,
                        "sbg:modifiedBy": "admin",
                        "sbg:modifiedOn": 1584385310,
                        "sbg:revisionNotes": null
                    },
                    {
                        "sbg:revision": 1,
                        "sbg:modifiedBy": "admin",
                        "sbg:modifiedOn": 1584385445,
                        "sbg:revisionNotes": "Upgraded to v1.0 from bix-demo/sbgtools-demo/sbg-decompressor-1-0"
                    },
                    {
                        "sbg:revision": 2,
                        "sbg:modifiedBy": "admin",
                        "sbg:modifiedOn": 1584385446,
                        "sbg:revisionNotes": "Updated description"
                    },
                    {
                        "sbg:revision": 3,
                        "sbg:modifiedBy": "admin",
                        "sbg:modifiedOn": 1584385446,
                        "sbg:revisionNotes": "Updated tool name"
                    },
                    {
                        "sbg:revision": 4,
                        "sbg:modifiedBy": "admin",
                        "sbg:modifiedOn": 1584385446,
                        "sbg:revisionNotes": "Added option to preserve archive folder structure"
                    },
                    {
                        "sbg:revision": 5,
                        "sbg:modifiedBy": "admin",
                        "sbg:modifiedOn": 1584385446,
                        "sbg:revisionNotes": "Added option to preserve archive folder structure"
                    },
                    {
                        "sbg:revision": 6,
                        "sbg:modifiedBy": "admin",
                        "sbg:modifiedOn": 1584385447,
                        "sbg:revisionNotes": "Added option to preserve archive folder structure"
                    },
                    {
                        "sbg:revision": 7,
                        "sbg:modifiedBy": "admin",
                        "sbg:modifiedOn": 1584385447,
                        "sbg:revisionNotes": "Updated description"
                    },
                    {
                        "sbg:revision": 8,
                        "sbg:modifiedBy": "admin",
                        "sbg:modifiedOn": 1584385447,
                        "sbg:revisionNotes": "Revise description"
                    },
                    {
                        "sbg:revision": 9,
                        "sbg:modifiedBy": "admin",
                        "sbg:modifiedOn": 1584385448,
                        "sbg:revisionNotes": "Updated Description"
                    },
                    {
                        "sbg:revision": 10,
                        "sbg:modifiedBy": "admin",
                        "sbg:modifiedOn": 1584385448,
                        "sbg:revisionNotes": "Updated Description"
                    },
                    {
                        "sbg:revision": 11,
                        "sbg:modifiedBy": "admin",
                        "sbg:modifiedOn": 1584385448,
                        "sbg:revisionNotes": "Change \"SBG Tools\" to \"SBGTools\" tag"
                    },
                    {
                        "sbg:revision": 12,
                        "sbg:modifiedBy": "admin",
                        "sbg:modifiedOn": 1584385448,
                        "sbg:revisionNotes": "Add CWL1.0 to name"
                    }
                ],
                "sbg:appVersion": [
                    "v1.0"
                ],
                "sbg:id": "admin/sbg-public-data/sbg-decompressor-cwl1-0/12",
                "sbg:revision": 12,
                "sbg:revisionNotes": "Add CWL1.0 to name",
                "sbg:modifiedOn": 1584385448,
                "sbg:modifiedBy": "admin",
                "sbg:createdOn": 1584385310,
                "sbg:createdBy": "admin",
                "sbg:project": "admin/sbg-public-data",
                "sbg:sbgMaintained": false,
                "sbg:validationErrors": [],
                "sbg:contributors": [
                    "admin"
                ],
                "sbg:latestRevision": 12,
                "sbg:publisher": "sbg",
                "sbg:content_hash": "a8c9f8c2203da4362ff89564543e6efd434d460f0a7f1ee8462d7dc8a903436c6"
            },
            "label": "SBG Decompressor CWL1.0",
            "sbg:x": -371,
            "sbg:y": -260
        }
    ],
    "requirements": [
        {
            "class": "InlineJavascriptRequirement"
        },
        {
            "class": "StepInputExpressionRequirement"
        }
    ]
}
