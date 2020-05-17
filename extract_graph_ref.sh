#!/bin/bash

#Input parameters
graph_tar_name=$1

#Untar graph files
cd /usr/local/bin/HLA-LA/graphs
tar -xvzf $graph_tar_name
