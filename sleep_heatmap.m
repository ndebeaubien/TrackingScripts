tempHSR = SimulationOutputHSR;
tempPI = SimulationOutputPI;

new_dat_HSR = [tempHSR,SimulationOutputHSR];
new_dat_PI = [tempPI, SimulationOutputPI];

HSR = new_dat_HSR(:,1);
PI = new_dat_PI(:,1);
for i = 1:29
    HSR = [HSR;new_dat_HSR(:,i+1)];
    PI = [PI;new_dat_PI(:,i+1)];
end

HSR2 = HSR*10;
PI2 = (PI+1)*100;
SleepNorm = [HSR2,PI2];
kernel = 25;
colorRange = 255;
Colormap = colormap(uint8(new_colormap/255));

tubeRange = zeros(200,100);

for i = 1:size(SleepNorm,2)/2
    for ii = 1:size(SleepNorm,1)
        X_pos = round(SleepNorm(ii,i));
        Y_pos = round(SleepNorm(ii,i+1));
        if Y_pos<=size(tubeRange,1)&X_pos<=size(tubeRange,2)&X_pos>0
        tubeRange(Y_pos,X_pos) = tubeRange(Y_pos,X_pos) + 1;
        end
    end
end
tubeRange = imgaussfilt(tubeRange,kernel,'Padding','replicate');
tubeRange = (rescale(tubeRange)/2+0.5);
rgbtube1 = ind2rgb(uint8(tubeRange), Colormap);


figure

hold on

imshow(rgbtube1)
set(gca,'YDir','reverse')

xlim([1 100])
ylim([1 200])
hold off








