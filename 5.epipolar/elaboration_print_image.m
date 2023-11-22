run("elaboration.m");

F
avgval_F

I1 = imread('IMG_20231110_150716.jpg');
I2 = imread('IMG_20231110_150721.jpg');

subplot(1,2,1)
imshow(I1, []);
hold on;
plot(m1(1,:), m1(2,:), 'o');
hold off

subplot(1,2,2)
imshow(I2, []);
hold on;
plot(m2(1,:), m2(2,:), 'o');
for i=1:size(m1, 2)
    lin = F*[m1(:,i) ; 1];
    %retta nel formato: lin(1)*x + lin(2)*y + lin(3) = 0 , quindi : -(lin(1)*x+lin(3))/lin(2);
    x(1,1) = 0;
    x(1,2) = size(I2, 2);
    y(1,1) = -(lin(1)*x(1,1)+lin(3))/lin(2);
    y(1,2) = -(lin(1)*x(1,2)+lin(3))/lin(2);
    plot(x, y, '-');
end
hold off;
