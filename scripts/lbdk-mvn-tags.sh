#!/bin/bash

# generate tags for current directory and its maven dependencies

# see https://stackoverflow.com/questions/14394807/how-to-get-maven-dependency-sources-and-unpack-them-to-a-specified-directory

dir=target/sources
mkdir -p $dir
mvn eclipse:eclipse: -DdownloadSources
sed -rn '/sourcepath/{s/.*sourcepath="M2_REPO.([^"]*).*/\1/;p}' .classpath | \
	  (cd $dir && xargs -i jar xf ~/.m2/repository/{})
ctags -R .
