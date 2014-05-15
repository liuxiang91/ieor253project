function [ x, y ] = code2key( code )
%CODE2KEY Summary of this function goes here
%   Detailed explanation goes here
    x=floor(code/100);
    y=mod(code,100);

end

