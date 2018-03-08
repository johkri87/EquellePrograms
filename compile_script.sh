#!/bin/bash
if [$# -gt 0]
then
rm CompiledSrc/*
fi


for backend in $@
do
	for i in $(ls EquelleSrc/*.equelle)
	do
	    echo "Compiling $i with the $backend backend"
	    bn=$(basename $i .equelle)
	    nondim=""
	    if [[ $nondim =~ (^| )$bn($| ) ]]; then
	        ../new-build/compiler/ec -i $i --nondimensional --backend=$backend> "CompiledSrc/$1out_${bn}_${backend}.cpp"
	    else
	        ../new-build/compiler/ec -i $i --backend=$backend > "CompiledSrc/out_${bn}_${backend}.cpp"
	    fi
	done
done
