# Approximate-Dependence-Analysis

To prepare a ll file for the pass use the following commands:
 
 path/to/llvm/build/bin/clang -g -S -emit-llvm -O0 -Xclang -disable-O0-optnone <filename>.c

 path/to/llvm/build/bin/opt -S -mem2reg -loop-rotate -loop-simplify <filename>.ll -o <optimized-filename>.ll

To run the pass after building use the command

 path/to/llvm/build/bin/opt -load ./lib/Dependence.so -Dependence /path/to/<optimized-filename>.ll
