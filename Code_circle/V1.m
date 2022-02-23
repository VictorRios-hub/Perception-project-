%rgb = imread('coloredChips.png');
rgb = imread('balle1.jpg');
imshow(rgb)

% video = VideoReader('ballekiroul.avi')
% current_image = readFrame(video);
% calculs

% rgb = rgb2gray(rgb);
% rgb = (rgb > 100)*255;

% [centers,radii] = imfindcircles(rgb,[15 30], ...
%     'Sensitivity',0.95)

% [centers1,radii1] = imfindcircles(rgb,[20 30],'Sensitivity',0.92)
% 
% centers2 = [centers;centers1];
% radii2 = [ radii; radii1];
% imshow(rgb)
% h = viscircles(centers2,radii2);

% [centers,radii] = imfindcircles(rgb,[70 80], ...
%     'Sensitivity',0.95,'ObjectPolarity','bright','Method','twostage')

[centers,radii] = imfindcircles(rgb,[65 75], ...
    'Sensitivity',0.95,'ObjectPolarity','bright')

imshow(rgb)
h = viscircles(centers,radii);