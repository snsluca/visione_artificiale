%I1 = rgb2gray(imread('1700683504527.jpg'));
%I2 = rgb2gray(imread('1700683504539.jpg'));
I1 = rgb2gray(imread('1702719956145.jpg'));
I2 = rgb2gray(imread('1702719956160.jpg'));
points1 = detectSIFTFeatures(I1)
points2 = detectSIFTFeatures(I2)

[features1,valid_points1] = extractFeatures(I1,points1);
[features2,valid_points2] = extractFeatures(I2,points2); 
disp('qua1')
indexPairs = matchFeatures(features1,features2);
disp('qua2')
matchedPoints1 = valid_points1(indexPairs(:,1),:);
matchedPoints2 = valid_points2(indexPairs(:,2),:);

save("matchedpoints.mat","matchedPoints1","matchedPoints2");

if 0==1
    disp('qua3')
    figure; 
    showMatchedFeatures(I1,I2,matchedPoints1,matchedPoints2);
end



%I = imread('IMG_20231110_150716.jpg');
%I = imread('IMG_20231110_150721.jpg');
%I = imread('IMG_20231110_150726.jpg');

%imshow(I, []);
%ginput %press enter to quit
