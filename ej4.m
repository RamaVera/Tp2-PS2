clear all; close all; clc

load imagenes.mat
load patrones.mat

gamma=1; lambda=8; sigma=4; theta=0; psi=0;
gb=gabor_fn(sigma,theta,lambda,psi,gamma, 'e');


figure
l_vec=[4 7 10 13];
for i=1:4
    lambda=l_vec(i);
    gb=gabor_fn(sigma,theta,lambda,psi,gamma, 'e');
    f_lenna=filter2(gb,foto_lenna);
    
    %par
    subplot(2,4,i)
    imshow(mat2gray(f_lenna))
    title(['par \lambda=', num2str(lambda)])
    %impar
    gb=gabor_fn(sigma,theta,lambda,psi,gamma, 'o');
    f_lenna=filter2(gb,foto_lenna);
    subplot(2,4,i+4)
    imshow(mat2gray(f_lenna))
    title(['impar \lambda=', num2str(lambda)])
end
hgexport(gcf,'images/4/lambda_var.png')
lambda=8; s_vec=[2 4 6 8];
figure
for i=1:4
    sigma=s_vec(i);
    gb=gabor_fn(sigma,theta,lambda,psi,gamma, 'e');
    f_lenna=filter2(gb,foto_lenna);
    
    %par
    subplot(2,4,i)
    imshow(mat2gray(f_lenna))
    title(['par \sigma=', num2str(sigma)])
    %impar
    gb=gabor_fn(sigma,theta,lambda,psi,gamma, 'o');
    f_lenna=filter2(gb,foto_lenna);
    subplot(2,4,i+4)
    imshow(mat2gray(f_lenna))
    title(['impar \sigma=', num2str(sigma)])
end
hgexport(gcf,'images/4/sigma_var.png')
sigma=3; t_vec=[0 pi/4 pi/2 pi*3/4]; 
pi_vec={'0' '\pi/4' '\pi/2' ' 3\pi/4'}
figure
for i=1:4
    theta=t_vec(i);
    gb=gabor_fn(sigma,theta,lambda,psi,gamma, 'e');
    f_lenna=filter2(gb,foto_lenna);
    
    %par
    subplot(2,4,i)
    imshow(mat2gray(f_lenna))
    title(['par \theta=', pi_vec{i}])
    %impar
    gb=gabor_fn(sigma,theta,lambda,psi,gamma, 'o');
    f_lenna=filter2(gb,foto_lenna);
    subplot(2,4,i+4)
    imshow(mat2gray(f_lenna))
    title(['impar \theta=', pi_vec{i}])
end
hgexport(gcf,'images/4/theta_var.png')