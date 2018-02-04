#!/bin/bash

for i in $(ls EquelleSrc/*.equelle)
do
    echo "Compiling $i"
    bn=$(basename $i .equelle)
    nondim=""
    if [[ $nondim =~ (^| )$bn($| ) ]]; then
        ../build-cuda8/compiler/ec -i $i --nondimensional --backend=cuda > "CompiledSrc/out_$bn.cpp"
    else
        ../build-cuda8/compiler/ec -i $i --backend=cuda > "CompiledSrc/out_$bn.cpp"
    fi
done
