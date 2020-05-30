The Dockerfile was downloaded on 14 May 2020 from 
https://github.com/zlskidmore/docker-hla-la/blob/master/Dockerfile
and then modified as follows:

The version of ubuntu was changed to 16.04 to avoid invalid security errors
returned from ubuntu when running apt-get update

The HLA-LA-master branch was downloaded from
https://github.com/DiltheyLab/HLA-LA 15 May 2020 and zipped up, and used
instead of the v1.01 archived release, in order to get the fix for the
--samtools_T flag

At the bottom of the Dockerfile, aa command to copy the calling bash scripts to
/usr/local/bin, was added
