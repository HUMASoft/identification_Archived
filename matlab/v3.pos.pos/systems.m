systemas = csvread("ids.csv");
numorder=0;
denorder=2;
numidx=2:(numorder+2);
denidx=(numorder+3):(numorder+3+denorder);

gains=[];
tcs=[]; % socorro, estoy atrapado en la mente de Jorge

for i=100:size(systemas,1)
    num=systemas(i,numidx);
    den=systemas(i,denidx);
    
    Gz=tf(num,den,0.02);
    G=d2c(Gz);
    
    [wn,xi,p]=damp(G);
    %tc=1/G.Denominator{1}(2);
    tc=1/wn;
    tcs=[tcs tc'];
    gain=G.Numerator{1}(2)*tc;
    gains=[gains gain];
    
end

figure;
saveas(plot(tcs),"tcs","epsc")
figure;
saveas(plot(gains),"gains","epsc")

tc=mean(tcs);
gain=mean(gains);

sys=tf([gain],[tc 1]);
figure;
bode(sys)
saveas(gcf(),"bode","epsc")
%m000=[mean(tcs(350:400)) mean(gains(350:400))];
%data4=[tcs; gains];



