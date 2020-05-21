clearvars
close all

addpath(genpath(pwd))
x = (sort(rand(1,100)) - 0.5)*pi;
y = sin(x).^5 + randn(size(x))/10;

slm = slmengine(x,y,'plot','on','order', 2,'increasing','on');