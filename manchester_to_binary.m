clc
clear all
close all
a=textread('bit_values.txt');
a=cast(a,'int8');
a=[0;a(1:586,1);0;0;a(587:1172,1);0;0;a(1173:end-1,1)];

b=textread('bit_values_1.txt');
b=cast(b,'int8');
b=[0;b(1:586,1);0;0;b(587:1172,1);0;0;b(1173:end-1,1)];

cell1={a,b}; 
cell2={[],[]}; 

for i=1:length(cell1)
    
    vector=cell1{i};
    
for j=1:2:length(vector)
    
    if vector(j)==0 && vector(j+1)==1
        
       cell2{i}=[cell2{i};1];
       
    elseif vector(j)==1 && vector(j+1)==0
       
        cell2{i}=[cell2{i};0];
        
    end
 end
end
c(:,1)=cell2{1};
c(:,2)=cell2{2};
c(:,3)=xor(cell2{1},cell2{2});