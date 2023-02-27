t_length = [];
for i = 1:size(track_set,2)
t_length(i) = size(track_set{i},1);
end

long_index = find(t_length > 100);
long_tracks = track_set(long_index)


mosquitocount = []
for i = 1:3600;
   mosquitocount(i) = size(cords{i},1);
end
mosquitocount2 = sum(mosquitocount)

time_stamp = [];
ticker = 0;
for i = 1:3600;
    t_ind = i;
    
    no_counted = (mosquitocount(i));
    t_range = [ticker+1:ticker+no_counted];
    time_stamp(t_range) = t_ind;
    ticker = ticker+no_counted;
end
time_stamp = time_stamp';









test_trace = long_tracks{37};
figure('Position',[200 200 1000 500])
xlimits = [min(test_trace(:,1)) max(test_trace(:,1))]
ylimits = [min(test_trace(:,2)) max(test_trace(:,2))]
dx = diff(test_trace(:,1));
dy = diff(test_trace(:,2));
vel = (dx.^2 + dy.^2).^0.5;
vel = round(vel./max(vel),2)*100;
vel = [0; vel]+1;
vel = round(vel,0)
map = bone(101);


for i = 1:size(test_trace,1)
    findX = find(all_cords(:,1) == test_trace(i,1));
findY = find(all_cords(:,2) == test_trace(i,2));
match_loc = findX(ismember(findX,findY));
match_loc = time_stamp(match_loc)
    
    
if size(match_loc,1) == 1
    v.CurrentTime = (match_loc+1)*(1/30)
    subplot(1,2,1)
    im = readFrame(v);
       im = rgb2gray(im);                                                  % Converts RGB frame to grayscale
        [BW] = segmentImage5v1(im, erode, sens);                            % Image thresholding        
        BW_inv = ((BW-1)*-1) == 1;                                          % Invert threshold image
        
       
        
        blobs = regionprops(BW_inv,'Area','Centroid','BoundingBox','Orientation','MajorAxisLength');
       
    query_set = vertcat(blobs.Centroid);
    quesr_set = query_set(:,1);
    query_pt = test_trace(i,1);
    query_result = find(query_set == query_pt);
    
    imshow(im)
    hold on
    xlim([test_trace(i,1)-50, test_trace(i,1)+50])
    ylim([test_trace(i,2)-50, test_trace(i,2)+50])
    time_text = text(test_trace(i,1)-40,test_trace(i,2)-40,num2str(v.CurrentTime))
    xy = [blobs(query_result).Centroid]
    x = xy(:,1)
    y = xy(:,2)
    L = blobs(query_result).MajorAxisLength/2
    x2=x-(L*cos(deg2rad(blobs(query_result).Orientation)))*0.5;
    y2=y+(L*sin(deg2rad(blobs(query_result).Orientation)))*0.5;
    x3=x+(L*cos(deg2rad(blobs(query_result).Orientation)))*0.5;
    y3=y-(L*sin(deg2rad(blobs(query_result).Orientation)))*0.5;
    plot([x3 x2],[y3 y2])
    hold off
    %pause(0.5)
    delete(time_text)
    subplot(1,2,2)
    hold on
    traj = scatter(test_trace(i,1),test_trace(i,2),20,'Filled','MarkerFaceColor',map(vel(i),:))
    set(gca,'YDir','reverse')
    xlim([xlimits(1)-10 xlimits(2)+10])
    ylim([ylimits(1)-10 ylimits(2)+10])
    daspect([1 1 1])
else
    'skip'
end
    
end


    