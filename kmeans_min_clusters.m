% Code borrowed and modified from Computerphile
% at https://youtu.be/yR7k19YBqiw

im = imread('demo_img/robo_img.jpg');
imflat = double(reshape(im, size(im,1) * size(im,2), 3));
X = []
Y = []
prev_sum = 0.0;
for K = 1:1:100
    [kIDs, kC, sumd, D] = kmeans(imflat, K, 'Display', 'iter', 'MaxIter', 150, 'Start', 'sample');
    X(K) = K;
    Y(K) = sum(sumd);
    
    % Convergence Criteria
    diff = Y(K) - prev_sum;
    error = (abs(diff/prev_sum));
    if error < 0.01
        error
        break
    end
    
    colormap = kC / 256;
    imout = reshape(uint8(kIDs), size(im,1), size(im,2));
    prev_sum = Y(K)
end
K
imwrite(imout - 1, colormap, 'demo_img/robo_img_processed.jpg');
plot(X, Y);
