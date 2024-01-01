%sedia
%I1 = rgb2gray(imread('1700683504527.jpg'));
%I2 = rgb2gray(imread('1700683504539.jpg'));
%stringa = "matchedpoints_sedia_auto.mat"
%calcolatrice
%I1 = rgb2gray(imread('1702719956145.jpg'));
%I2 = rgb2gray(imread('1702719956160.jpg'));
%stringa = "matchedpoints_calcolatrice_auto.mat"
%scatola
 I1 = rgb2gray(imread('1702817288720.jpg'));
 I2 = rgb2gray(imread('1702817288728.jpg'));
 stringa = "matchedpoints_scatola_auto.mat"

points1 = detectSIFTFeatures(I1)
points2 = detectSIFTFeatures(I2)

[features1,valid_points1] = extractFeatures(I1,points1);
[features2,valid_points2] = extractFeatures(I2,points2); 
disp('qua1')
indexPairs = matchFeatures(features1,features2);
disp('qua2')
matchedPoints1 = valid_points1(indexPairs(:,1),:);
matchedPoints2 = valid_points2(indexPairs(:,2),:);

m1 = matchedPoints1.Location';
m2 = matchedPoints2.Location';
save(stringa, "m1","m2");

grafici = 0
if grafici == 1
    disp('qua3')
    figure; 
    showMatchedFeatures(I1,I2,matchedPoints1,matchedPoints2);
end
