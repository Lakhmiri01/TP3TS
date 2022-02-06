 clear all
 close all
 clc
load('Ring.mat');
F=44100;
Ts =1/F;
t =0:Ts:(length(y)-1)*Ts ;

 plot(t,y);
 xline(7,'--r');
 xline(8,'--r');
 fragment=y(7*F:8*F);
 %sound(fragment,F);
 figure(2)
  plot(fragment)
  correlation=xcorr(y,fragment);
  figure(3)
 %Le plus grand pic se produit à la valeur de décalage lorsque les éléments de x et y correspondent exactement
  plot(correlation);
  figure(4);
%find value and index of maximum value of cross-correlation amplitude
[m,d]=max(correlation);      
%shift index d, as length(y)=2*N-1; where N is the length of the signals
delay=d-max(length(y),length(fragment));   
%Plot signal s1
plot(y)                                     
hold on
plot([delay+1:length(fragment)+delay],fragment,'r');  
%-------------------------------------

YNOISE = awgn(y,30)+y;
fnoise=awgn(fragment,30)+fragment;
figure(5);
plot(t,[y YNOISE]);
xline(7,'--r');
 xline(8,'--r');
figure(6);
plot(fnoise);
%sound(YNOISE);
correlation1=xcorr(YNOISE,fnoise);
  figure(7)
 %Le plus grand pic se produit à la valeur de décalage lorsque les éléments de x et y correspondent exactement
  plot(correlation1);
  figure(8);
%find value and index of maximum value of cross-correlation amplitude
[m,d]=max(correlation1);
%shift index d, as length(YNOISE)=2*N-1; where N is the length of the signals
delay=d-max(length(YNOISE),length(fnoise));   
plot(YNOISE);
hold on,plot([delay+1:length(fnoise)+delay],fnoise,'r');  

