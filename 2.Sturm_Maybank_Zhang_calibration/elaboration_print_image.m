run("elaboration.m");

P
K

Ivec = {'IMG_20231104_104409.jpg', 'IMG_20231104_104431.jpg', 'IMG_20231104_104503.jpg', 'IMG_20231104_104513.jpg'};

for i = 1:size(Ivec, 2)
    I = imread(Ivec{i});
    subplot(2,2,i)
    imshow(I, []);
    hold on;
    plot(m{i}(1,:), m{i}(2,:), 'o');

    tmp = proj(P{i}, M);
    plot(tmp(1,:), tmp(2,:), 'x');
    hold off
end
