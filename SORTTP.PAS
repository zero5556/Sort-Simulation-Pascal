{code writeln by zero5556 23/2/2023}
program sorttp;
uses crt,graph;
const base=10;
var n,i:integer;
    swaps,c:longint;
    choice:byte;
    mode,cl:boolean;
    a:array[0..1023] of integer;
    t:array[0..1023] of integer;
    graphDrive,graphMode:integer;

procedure swap(var a,b:integer);
var t:Integer;
begin
inc(swaps);
t:=a;
a:=b;
b:=t;
end;

function colormode(i:integer):byte;
var t:integer;
begin
case (i mod 8) of
0:t:=10;
1:t:=2;
2:t:=6;
3:t:=3;
4:t:=1;
5:t:=5;
6:t:=4;
7:t:=14;
end;
colormode:=t;
end;

procedure printpoint;
var i:integer;
begin
i:=0;
while i<=n-1 do
begin
 if t[i]<>a[i] then
 begin
  putPixel(i,n-t[i],black);
  if cl=true then putPixel(i,n-a[i],colormode(a[i]))
  else putPixel(i,n-a[i],white);
  t[i]:=a[i];
 end;
 inc(i);
end;
end;

procedure printBar;
var i:integer;
begin
i:=0;
while i<=n-1 do
 begin
 if t[i]<>a[i] then
 begin
  setcolor(black);
  line(i,0,i,n);
  if cl=true then setcolor(colormode(a[i])) else setcolor(white);
  line(i,n-a[i],i,n);
  t[i]:=a[i];
  end;
  i:=i+1;
 end;
end;

procedure print;
begin
if mode=true then printbar else printpoint;
end;

procedure SelectionSort(left,right:integer);
var i,j:integer;
    min,vj:integer;
begin
for i:=left to right-1 do
begin
 min:=10000;
 for j:=i+1 to right do
 begin
  inc(c);
  if min>a[j] then begin min:=a[j]; vj:=j; end;
  print;
 end;
 swap(a[vj],a[i]);
end;
end;

procedure QuickSort(left,right:integer);
var i,pivot,l:integer;
begin
if left<right then
 begin
  swap(a[(left+right) div 2],a[right]);
  pivot:=a[right];
  l:=left-1;
  for i:=left to right-1 do
  begin
   if (a[i]<=pivot) then
    begin
     inc(l);
     swap(a[i],a[l]);
     print;
     inc(c);
    end else inc(c);
  end;
  swap(a[l+1],a[right]);
  quicksort(left,l);
  quicksort(l+2,right);
 end;
end;

procedure InsertionSort(left,right:integer);
var i,pos,cur:integer;
begin
for i:=(left+1) to right do
 begin
  cur:=a[i];
  pos:=i;
  if (a[pos-1]<=cur) then inc(c) else
  while (pos>0) and (a[pos-1]>cur) do
   begin
    inc(c);
    inc(swaps);
    a[pos]:=a[pos-1];
    dec(pos);
    print;
   end;
  a[pos]:=cur;
 end;
end;

procedure ssort(left,right:integer);
var i,pivot,l:integer;
begin
if left<(right-9) then
 begin
 swap(a[(left+right) div 2],a[right]);
  pivot:=a[right];
  l:=left-1;
  for i:=left to right-1 do
  begin
   if (a[i]<=pivot) then
    begin
     inc(l);
     swap(a[i],a[l]);
     print;
     inc(c);
    end else inc(c);
  end;
  swap(a[l+1],a[right]);
  ssort(l+2,right);
  ssort(left,l);
 end;
end;

procedure stdsort(left,right:integer);
begin
 ssort(left,right);
 InsertionSort(left,right);
end;

procedure BubbleSort(left,right:integer);
var i,j:integer;
begin
for j:=right downto left do
 for i:=left+1 to j do
  begin
   inc(c);
   if a[i-1]>a[i] then swap(a[i-1],a[i]);
   print;
  end;
end;

procedure coutsort(left,right,e:integer);
var i:integer;
    c:array[0..base-1] of integer;
    out:array[0..1023] of integer;
begin
for i:=0 to base-1 do c[i]:=0;
for i:=left to right do inc(c[(a[i] div e) mod base]);
for i:=1 to base-1 do c[i]:=c[i-1]+c[i];
for i:=right downto left do
begin
out[c[(a[i] div e) mod base]]:=a[i];
dec(c[(a[i] div e) mod base]);
end;
for i:=left to right do a[i]:=out[i];
end;
procedure radixsort(left,right:integer);
var ex,i,max:integer;
begin
ex:=1;
for i:=left to right do if max<a[i] then max:=a[i];
while (max div ex)>0 do
begin
coutsort(left,right,ex);
ex:=ex*base;
print;
end;
end;

procedure downheap(k,n:integer);
var j,i:integer;
    done:boolean;
begin
i:=k;
done:=true;
j:=i+i+1;
while ((done) and (j<=n)) do
begin
c:=c+2;
if (j<n) then if (a[j]<a[j+1]) then inc(j);
inc(c);
if (a[i]<a[j]) then
 begin
  inc(swaps);
  swap(a[i],a[j]);
  i:=j; j:=i+i+1;
 end else done:=false;
end;
end;

procedure heapsort(left,right:integer);
var i:integer;
begin
for i:=((right div 2)-1) downto left do begin downheap(i,n); print; end;
for i:=n downto 1 do
 begin
  inc(swaps);
  swap(a[left],a[i]);
  downheap(left,i-1);
  print;
 end;
end;

procedure shellsort(left,right:integer);
var i,j,gap,cur:integer;
begin
gap:=right div 2;
while gap>0 do
 begin
  for i:=gap to right do
   begin
    j:=i;
    cur:=a[i];
    inc(c);
    while (j>=gap) and (cur<a[j-gap]) do
     begin
      a[j]:=a[j-gap];
      inc(swaps);
      j:=j-gap;
      print;
     end;
    a[j]:=cur;
   end;
  gap:=gap div 2;
 end;
end;

procedure shuffle(c:boolean);
begin
if c=true then
begin
randomize;
for i:=0 to n-1 do a[i]:=i;
for i:=0 to n*2 do
  swap(a[random(n)],a[random(n)]);
end else begin
for i:=0 to n-1 do a[i]:=(n-1)-i;
end;
end;

procedure enter;
begin
writeln('Sort Simulation 1.0 writeln by zero5556');
writeln('graph mode:');
writeln(' 0:bar graph');
writeln(' 1:point graph (rendering speed faster)');
write('enter graph mode(0/1):'); readln(choice);
case choice of
0:mode:=true;
1:mode:=false;
end;
writeln('color mode:');
writeln(' 0:white');
writeln(' 1: 8 color');
write('enter color mode:'); readln(choice);
case choice of
0:cl:=false;
1:cl:=true;
end;
n:=0;
write('enter size of array (n<=512):'); readln(n);
n:=abs(n);
writeln('Type of shuffle:');
writeln('0:random');
writeln('1:Decrease');
write('Choose type of shuffle(0/1):'); readln(choice);
case choice of
0:shuffle(true);
1:shuffle(false);
end;
writeln('1:Bubble Sort O(n^2)');
writeln('2:Selection Sort O(n^2)');
writeln('3:Insertion Sort O(n^2)');
writeln('4:Quick Sort O(nlog2(n))');
writeln('5:Quick Sort+Insertion Sort O(nlog2(n))');
writeln('6:Heap Sort O(nlog2(n))');
writeln('7:Radix Sort LCD O(nlog10(n))');
writeln('8:Shell Sort O(nlog2(n))');
choice:=0;
write('enter choice (1->8):'); readln(choice);
choice:=abs(choice);
end;

begin
clrscr;
enter;
swaps:=0; c:=0;
graphDrive:=detect;
InitGraph(graphDrive,graphMode,'');
setbkcolor(0);
print;
readln;
case choice of
1:BubbleSort(0,n-1);
2:SelectionSort(0,n-1);
3:InsertionSort(0,n-1);
4:QuickSort(0,n-1);
5:stdsort(0,n-1);
6:heapsort(0,n-1);
7:radixsort(0,n-1);
8:shellsort(0,n-1);
end;
readln;
closegraph;
writeln('sort complete');
writeln('compresses:',c);
writeln('swaps:',swaps);
  readln;
end.
