%% Ejercicio 2
clear all;
close all;
load('imagenes.mat');
load('patrones.mat');

lambda = [5 14 30];
sigma = [15 15 15];
theta = [0 0 0];
psi = [0 0 0];
gamma = [1 1 1];
type = ['e' 'e' 'e'];
pattern = patron_frecuencias;
[responses, filters] = filter_pattern(pattern, sigma, theta, lambda, psi, ...
    gamma, type);
titles = {'Patron', 'Filtro con \lambda=5', 'Resultado', ...
    'Patron', 'Filtro con \lambda=14', 'Resultado', ...
    'Patron', 'Filtro con \lambda=30', 'Resultado'};
plot_filter_result(pattern, responses, filters, titles);

%% Ejercicio 3
clear all;
close all;
load('imagenes.mat');
load('patrones.mat');

theta = [0 pi/4 pi/2];
sigma = [3 3 3];
lambda = [8 8 8];
psi = [0 0 0];
gamma = [0.5 0.5 0.5];
pattern = patron_cuadro;
type = ['e', 'e', 'e'];
[responses, filters] = filter_pattern(pattern, sigma, theta, lambda, psi, ...
    gamma, type);
titles = {'Patron cuadrado', 'Filtro con \theta=0', 'Resultado', ...
    'Patron cuadrado', 'Filtro con \theta=\pi/4', 'Resultado', ...
    'Patron cuadrado', 'Filtro con \theta=\pi/2', 'Resultado'};
plot_filter_result(pattern, responses, filters, titles);


theta = [0 pi/4 pi/2];
sigma = [3 3 3];
lambda = [8 8 8];
psi = [0 0 0];
gamma = [0.5 0.5 0.5];
pattern = patron_circ;
type = ['e', 'e', 'e'];
[responses, filters] = filter_pattern(pattern, sigma, theta, lambda, psi, ...
    gamma, type);
titles = {'Patron circulo', 'Filtro con \theta=0', 'Resultado', ...
    'Patron circulo', 'Filtro con \theta=\pi/4', 'Resultado', ...
    'Patron circulo', 'Filtro con \theta=\pi/2', 'Resultado'};
plot_filter_result(pattern, responses, filters, titles);


theta = [0 pi/4 pi/2];
sigma = [3 3 3];
lambda = [12 12 12];
psi = [0 0 0];
gamma = [0.5 0.5 0.5];
pattern = patron_angulo;
type = ['e', 'e', 'e'];
[responses, filters] = filter_pattern(pattern, sigma, theta, lambda, psi, ...
    gamma, type);
titles = {'Patron angulos', 'Filtro con \theta=0', 'Resultado', ...
    'Patron angulos', 'Filtro con \theta=\pi/4', 'Resultado', ...
    'Patron angulos', 'Filtro con \theta=\pi/2', 'Resultado'};
plot_filter_result(pattern, responses, filters, titles);

%% Imagenes de soporte - Ejercicio 2
close all;
clear all;
lambda = [5 14 30];
sigma = [50 50 50];
theta = [0 0 0];
psi = [0 0 0];
gamma = [1 1 1];
figure;
for i=1 : 3
    g = gabor_fn(sigma(i), theta(i), lambda(i), psi(i), gamma(i), 'e');
    subplot(1,3,i)
    imshow(mat2gray(g))
    title(sprintf('\\lambda = %d', lambda(i)))
end