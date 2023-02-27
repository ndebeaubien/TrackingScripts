%import IR Data Structure as Data

final_data = {};
groups = [11 12 13 14 15 1 16 27];
number_of_groups = size(groups,2)

for i = 1:number_of_groups;
    group_data = [];
    groupID = groups(i);
    IR_ID = find(Data(:,1) == groupID);
    group_data = Data(IR_ID,:);
    number_of_bio = unique(group_data(:,3));
    output = [];
    for ii = 1:length(number_of_bio)
     Bio_ID = number_of_bio(ii);
     reps = find(group_data(:,3) == Bio_ID)
     reps = group_data(reps,:)
     reps = mean(reps)
     output(ii,:) = reps;
    end
    final_data{i} = output
end


figure
hold on
title('Preference Index')
plot([0 number_of_groups+1],[0 0],'k')
ylim([-1 1])
set(gca,'TickDir','out')
for i = 1:number_of_groups

    
    PIdat = final_data{i};
    ID = ones(size(PIdat,1),1)*i;
    scatter(ID,PIdat(:,4),30,'Filled')
    plot([0.75+i-1 1.25+i-1],[mean(PIdat(:,4)) mean(PIdat(:,4))],'k')
    errorbar(i,mean(PIdat(:,4)),std(PIdat(:,4))/(size(PIdat,1)^0.5))
end

figure
hold on
title('Preference Index BOX')
plot([0 number_of_groups+1],[0 0],'k')
ylim([-1 1])
set(gca,'TickDir','out')
PIgrid = NaN(10,number_of_groups);
for i = 1:number_of_groups
    PIS = final_data{i}(:,4);
    PIgrid(1:length(PIS),i) = PIS;
end
boxplot(PIgrid,'Whisker',3)

figure
hold on
title('Average Time Per Track')
plot([0 number_of_groups+1],[0 0],'k')
%ylim([-1 1])
set(gca,'TickDir','out')
for i = 1:number_of_groups

    
    PIdat = final_data{i};
    ID = ones(size(PIdat,1),1)*i;
    scatter(ID,PIdat(:,8)./PIdat(:,12),30,'Filled')
    scatter(ID+0.25,PIdat(:,9)./PIdat(:,13),30,'Filled')
    plot([0.75+i-1 1.25+i-1],[mean(PIdat(:,8)./PIdat(:,12)) mean(PIdat(:,8)./PIdat(:,12))],'k')
    plot([0.75+i-1 1.25+i-1]+0.25,[mean(PIdat(:,9)./PIdat(:,13)) mean(PIdat(:,9)./PIdat(:,13))],'k')
    errorbar(i, mean(PIdat(:,8)./PIdat(:,12)), std(PIdat(:,9)./PIdat(:,13))/(size(PIdat,1)^0.5))
    errorbar(i+0.25, mean(PIdat(:,9)./PIdat(:,13)), std(PIdat(:,9)./PIdat(:,13))/(size(PIdat,1)^0.5))
end

figure
hold on
title('Number of Tracks')
plot([0 number_of_groups+1],[0 0],'k')
%ylim([-1 1])
set(gca,'TickDir','out')
for i = 1:number_of_groups

    
    PIdat = final_data{i};
    ID = ones(size(PIdat,1),1)*i;
    scatter(ID,PIdat(:,12),30,'Filled')
    scatter(ID+0.25,PIdat(:,13),30,'Filled')
    plot([0.75+i-1 1.25+i-1],[mean(PIdat(:,12)) mean(PIdat(:,12))],'k')
    plot([0.75+i-1 1.25+i-1]+0.25,[mean(PIdat(:,13)) mean(PIdat(:,13))],'k')
    errorbar(i, mean(PIdat(:,12)), std(PIdat(:,12))/(size(PIdat,1)^0.5))
    errorbar(i+0.25, mean(PIdat(:,13)), std(PIdat(:,13))/(size(PIdat,1)^0.5))
end

[p,tbl,stats] = anova1(PIgrid)

tbl2 = multcompare(stats)
