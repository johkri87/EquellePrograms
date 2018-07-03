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
	        ../new-build/compiler/ec -i $i --nondimensional --backend=$backend > "CompiledSrc/out_${bn}_${backend}.cpp"
	done
done
