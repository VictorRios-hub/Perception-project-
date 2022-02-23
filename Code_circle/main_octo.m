%-------------------------Initialisation de la vidéo----------------------%
clc
clear

vision = VideoReader('Octo_Bouncer_POV.mp4');
% implay('Octo_Bouncer.mp4');

% Determine how many frames there are.
numberOfFrames = vision.NumberOfFrames;

% Prepare a figure to show the images.
figure;

% Enlarge figure to full screen.
set(gcf, 'units','normalized','outerposition',[1 1 1920 1080]);

% Création du fichier d'écriture
new_vision = VideoWriter('new_vision.avi');

%Initialisation des variables
r_max = 57.232051538036770;
d_min = 10;

% open(new_vision); 
%-------------------------------Processing--------------------------------%

for frame = 1 : numberOfFrames
%while hasFrame(vision)  
   
    % Extract the frame from the movie structure.
	thisFrame = read(vision, frame); % Get the next frame in the video.

    % Détection de la balle sur chaque frame
    [centers,radii,metric] = imfindcircles(thisFrame,[20 60], ...
    'Sensitivity',0.9,'ObjectPolarity','bright');
    
    % Dessin des contours 
    figure(1)
    imshow(thisFrame);
    viscircles(centers,radii);
    
    % Application du dessin à la frame (librairy manquante)
    % thisFrame = insertShape(thisFrame, 'Cercle', centers,radii);  
    
    % Write frame to final video file 
    % writeVideo(new_vision, thisFrame);
    
    % Calcul de la distance
    if (radii ~= 0)
        distance = 10*(r_max)/radii - d_min;
    end
    
    % Actual Time
    str2 = ['time = ',num2str(vision.CurrentTime)];
    text(10, 10 ,str2,'Color','white','FontSize',14)
    
    % Actual Distance
    str2 = ['distance = ',num2str(distance)];
    text(10, 40 ,str2,'Color','white','FontSize',14)
    
    % Actual Location
    str2 = ['location = ',num2str(centers)];
    text(10, 270 ,str2,'Color','white','FontSize',14)

    pause(0.5/vision.FrameRate);
    
end
% close(new_vision)
    
% implay('new_vision.avi');

close all;