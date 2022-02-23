%https://www.mathworks.com/help/images/ref/videoviewer-app.html
%https://www.mathworks.com/solutions/image-video-processing/video-processing.html


v = VideoReader('Balls_falling_LQ.avi');

%implay('Balls_falling_LQ.avi'); 

i = 1;

a=readFrame(v);
imshow(a);
frame = zeros(240,320,3,191);
frame = cast(frame,'uint8');

workingDir= tempname;
mkdir(workingDir)
mkdir(workingDir,'images')

while hasFrame(v)
    
    frame(1:240, 1:320, 1:3, i) = readFrame(v);
    
    [centers,radii] = imfindcircles(frame(1:240, 1:320, 1:3, i),[15 30],'Sensitivity',0.92,'ObjectPolarity','bright');
    h(i) = viscircles(centers,radii);
    filename = [sprintf('%03d',i) '.jpg'];
    fullname = fullfile(workingDir,'images',filename);
    imwrite(frame(1:240, 1:320, 1:3, i),fullname)
    
%     if (mod(i,10)==0)
%         figure, imshow(frame(1:240, 1:320, 1:3, i));
%     end;
    i=i+1;    
end

imageNames = dir(fullfile(workingDir,'images','*.jpg'));
imageNames = {imageNames.name}';

outputVideo = VideoWriter(fullfile(workingDir,'video_out.avi'));
outputVideo.Frame = v.FrameRate;
open(outputVideo)

for i=1:length(imageNames{i});
    img=imRead(fullfile(workingDir,'images',imageNames{i}));
    writeVideo(outputVideo,img)
end
close(outputVideo)

shuttleAvi = VideoReader(fullfile(workingDir,'video_out.avi'));

ii = 1;
while hasFrame(shuttleAvi)
   mov(ii) = im2frame(readFrame(shuttleAvi));
   ii = ii+1;
end

figure 
imshow(mov(1).cdata, 'Border', 'tight')

movie(mov,1,shuttleAvi.FrameRate)
