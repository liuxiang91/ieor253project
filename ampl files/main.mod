param n=20;
set I={1..n};
param D{i in I}>=0;
param L{i in I, j in I}>=0;
param S{i in I}>=0;
param C>=0;

var x{i in I, j in I} binary;
var y{i in I, j in I} binary;
var w{i in I} binary;
var z{i in I} binary;

minimize cost:
sum {i in I} S[i]*(w[i]+z[i])
+sum {i in 1..n-1, j in i+1..n} L[i,j]*x[i,j];

subject to _2_ {i in I}: 
	D[i]+sum{j in I} D[j]*y[i,j]<=C;

subject to _3_ {i in 1..n-2, j in i+1..n-1, k in j+1..n}:
	y[i,j]+y[j,k]-y[i,k]<=1;

subject to _4_ {i in I, j in I}:
	x[i,j]<=y[i,j];

subject to _5_ {j in I}:
	w[j]+sum{i in 1..j-1}x[i,j]=1;

subject to _6_ {i in I}:
	z[i]+sum{j in i+1..n}x[i,j]=1;