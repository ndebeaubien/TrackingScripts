
opt_list = {};

for i = 1:length(exps)
    string1 = 'opt_';
    string2 = num2str(exps(i));
    string3 = strcat(string1,string2,'.mat');
    opt_list(i,1) = {string3};
end

Extracted_Track_Data = [];

for i = 1:length(opt_list)
    i
    
    if exist(opt_list{i})
        
        load(opt_list{i})
        [newPI,final_pts,point_distance,points_out] = stat_remover(track_set,trax_X,trax_Y,X,Y,fsize,framelimit);
   
   track_bins = [];
   for ii = 1:length(points_out)
       query = points_out{ii};
       track_bins(ii,1) = max(inpolygon(query(:,1),query(:,2),X(1:4),Y(1:4)));
       track_bins(ii,2) = max(inpolygon(query(:,1),query(:,2),X(5:8),Y(5:8)));
   end
   
   
     track_sums = sum(track_bins); 
     
   if size(track_sums,2) == 2;
Extracted_Track_Data(i,:) = [track_data{2,1},track_data{2,2},...
    track_data{2,3},track_data{2,4},...
    track_data{2,5},track_data{2,6}...
    track_sums(1),track_sums(2)];
   else
       Extracted_Track_Data(i,:) = [track_data{2,1},track_data{2,2},...
    track_data{2,3},track_data{2,4},...
    track_data{2,5},track_data{2,6}...
    NaN,NaN];
   end
   
   
    else
        Extracted_Track_Data(i,:) = [NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN];
    end
end
