%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                               Punto 6                                   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all
close all
clc
load("patrones.mat")
load("imagenes.mat")
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%parte = 1; % Parametro Aguila
%parte = 2; % Parametro Mariposa
parte = 3; % Parametro Moneda


%thresholdDetect= 'false' ; %No activa funcion umbral
thresholdDetect= 'true' ; %Activa funcion umbral

onlySum='true'; %Plotea solo la suma
%onlySum='false'; %Plotea acorde a onlyUmbral

onlyUmbral='false'; %Plotea la entrada al umbral y la salida
%onlyUmbral='true'; %Plotea solo la salida de umbral

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                         Parte    1                                  %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% En esta primera parte se hara el punto 5 pedido del enunciado
if( parte == 1 )
%----------------------------%
% Parametros
    sigma = [7,3,1];
    theta = [0,pi/4,pi/2,3*pi/4];
    lambda = [10,7]; 
    psi = 0;
    gamma = 1;
    type = 'o';
    pattern = mat2gray( foto_aguila );
    %pattern = foto_lenna ;
    base=0; 
    threshold = 0.52;
    if strcmp(thresholdDetect,'false')
        index='_f';
    else %strcmp(thresholdDetect,'true')
        index='_t';
    end
%----------------------------%
% Patron Inicial
    f=figure(base+1);
    imshow(pattern)
    saveas(f,['images/6/6_',num2str(base+1),'.png'],'png')
    set(gcf, 'Position', get(0, 'Screensize'));
%----------------------------%
% Generacion de componentes de la base, filtrado con las mismas e imagenes
for lam=1:length(lambda)
    for var=1:length(sigma)
        for rot=1:length(theta)
            base=base+1;
            % Generacion de componentes de la base
            gaborBase{base}=gabor_fn(sigma(var),theta(rot),lambda(lam),psi,gamma,type);
            % Filtrado con las mismas
            filterPattern{base} = filter2(gaborBase{base},pattern);
            
            if( strcmp(onlySum,'false') )
                % Generacion imagenes de patrones filtrados
                f=figure(base+1);
                if( strcmp(thresholdDetect,'false') )
                    imshow(filterPattern{base});
                    suptitle(['Base de Gabor con Theta = ',num2str(theta(rot)),' y Sigma = ',num2str(sigma(var)), ...
                    ' y Lambda =',num2str(lambda(lam))]);
                else
                    if(strcmp(onlyUmbral,'false'))
                    subplot(1,2,1)
                        imshow(filterPattern{base});
                        title("Sin funcion umbral")
                    subplot(1,2,2)
                    end
                        imshow(gdetect(filterPattern{base},threshold));
                        title("Aplicando funcion umbral")
                        suptitle(['Base de Gabor con Theta = ',num2str(theta(rot)),' y Sigma = ',num2str(sigma(var)), ...
                        ' y Lambda =',num2str(lambda(lam))]);

                end
                saveas(f,['images/6/6_',num2str(base+1),index,'.png'],'png')
                set(gcf, 'Position', get(0, 'Screensize'));
            end
        end
    end
end
%----------------------------%
% Variables auxiliares 
    sum=zeros(size(filterPattern{1}));
    I=ones(size(sum));
%----------------------------%
% Suma total de los patrones filtrados  
    for i=1:base
        sum=sum+filterPattern{i};
    end
%----------------------------%
% Imagenes de la suma total
    f=figure(base+2);
    if( strcmp(thresholdDetect,'false') )
        figure(base+2)
        imshow(mat2gray(sum))
        title(['Suma total']);
    else
        figure(base+2)
        subplot(2,2,1)
        imshow(mat2gray(sum));
        title(['Suma total sin funcion umbral']);

        subplot(2,2,3)
        imshow(I-mat2gray(sum));
        title(['Negativo total sin funcion umbral']);

        subplot(2,2,2)
        imshow(gdetect(mat2gray(sum),threshold))
        title(['Suma total con funcion umbral']);  

        subplot(2,2,4)
        imshow(I - gdetect(mat2gray(sum),threshold))
        title(['Suma total con funcion umbral']);  
    end
    saveas(f,['images/6/6_',num2str(base+2),index,'.png'],'png')
    set(gcf, 'Position', get(0, 'Screensize'));
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                         Parte    2                                  %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% En esta segunda parte se vera como queda la imagen final para distintos
% valores de threshold
if( parte == 2 )
%----------------------------%
% Parametros
    sigma = [1.5,1];
    theta = [0,pi/3,pi/4,pi/2,2*pi/3,3*pi/4,];
    lambda = [5,1,0.5]; 
    psi = 0;
    gamma = 1;
    type = 'o';
    pattern = mat2gray( foto_mariposa );
    %pattern = foto_lenna ;
    base=0; 
    threshold = 0.52;
    if strcmp(thresholdDetect,'false')
        index='_f';
    else %strcmp(thresholdDetect,'true')
        index='_t';
    end
%----------------------------%
% Patron Inicial
    f=figure(base+1);
    imshow(pattern)
    saveas(f,['images/6/6_',num2str(base+1),'.png'],'png')
    set(gcf, 'Position', get(0, 'Screensize'));
%----------------------------%
% Generacion de componentes de la base, filtrado con las mismas e imagenes
for lam=1:length(lambda)
    for var=1:length(sigma)
        for rot=1:length(theta)
            base=base+1;
            % Generacion de componentes de la base
            gaborBase{base}=gabor_fn(sigma(var),theta(rot),lambda(lam),psi,gamma,type);
            % Filtrado con las mismas
            filterPattern{base} = filter2(gaborBase{base},pattern);
            
            if( strcmp(onlySum,'false') )
                % Generacion imagenes de patrones filtrados
                f=figure(base+1);
                if( strcmp(thresholdDetect,'false') )
                    imshow(filterPattern{base});
                    suptitle(['Base de Gabor con Theta = ',num2str(theta(rot)),' y Sigma = ',num2str(sigma(var)), ...
                    ' y Lambda =',num2str(lambda(lam))]);
                else
                    if(strcmp(onlyUmbral,'false'))
                    subplot(1,2,1)
                        imshow(filterPattern{base});
                        title("Sin funcion umbral")
                    subplot(1,2,2)
                    end
                        imshow(gdetect(filterPattern{base},threshold));
                        title("Aplicando funcion umbral")
                        suptitle(['Base de Gabor con Theta = ',num2str(theta(rot)),' Sigma = ',num2str(sigma(var)), ...
                        ' y Lambda =',num2str(lambda(lam))]);
                end
                saveas(f,['images/6/6_',num2str(base+1),index,'.png'],'png')
                set(gcf, 'Position', get(0, 'Screensize'));
            end
        end
    end
end
%----------------------------%
% Variables auxiliares 
    sum=zeros(size(filterPattern{1}));
    I=ones(size(sum));
%----------------------------%
% Suma total de los patrones filtrados  
    for i=1:base
        sum=sum+filterPattern{i};
    end
%----------------------------%
% Imagenes de la suma total
    f=figure(base+2);
    if( strcmp(thresholdDetect,'false') )
        figure(base+2)
        imshow(mat2gray(sum))
        title(['Suma total']);
    else
        figure(base+2)
        subplot(2,2,1)
        imshow(mat2gray(sum));
        title(['Suma total sin funcion umbral']);

        subplot(2,2,3)
        imshow(I-mat2gray(sum));
        title(['Negativo total sin funcion umbral']);

        subplot(2,2,2)
        imshow(gdetect(mat2gray(sum),threshold))
        title(['Suma total con funcion umbral']);  

        subplot(2,2,4)
        imshow(I - gdetect(mat2gray(sum),threshold))
        title(['Suma total con funcion umbral']);  
    end
    saveas(f,['images/6/6_',num2str(base+2),index,'.png'],'png')
    set(gcf, 'Position', get(0, 'Screensize'));
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                         Parte    3                                  %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% En esta segunda parte se vera como queda la imagen final para distintos
% valores de threshold
if( parte == 3 )
%----------------------------%
% Parametros
    sigma = [1.5,1];
    theta = [0,pi/3,pi/4,pi/2,2*pi/3,3*pi/4,];
    lambda = [5,1,0.5]; 
    psi = 0;
    gamma = 1;
    type = 'o';
    pattern = mat2gray( foto_moneda );
    %pattern = foto_lenna ;
    base=0; 
    threshold = 0.52;
    if strcmp(thresholdDetect,'false')
        index='_f';
    else %strcmp(thresholdDetect,'true')
        index='_t';
    end
%----------------------------%
% Patron Inicial
    f=figure(base+1);
    imshow(pattern)
    saveas(f,['images/6/6_',num2str(base+1),'.png'],'png')
    set(gcf, 'Position', get(0, 'Screensize'));
%----------------------------%
% Generacion de componentes de la base, filtrado con las mismas e imagenes
for lam=1:length(lambda)
    for var=1:length(sigma)
        for rot=1:length(theta)
            base=base+1;
            % Generacion de componentes de la base
            gaborBase{base}=gabor_fn(sigma(var),theta(rot),lambda(lam),psi,gamma,type);
            % Filtrado con las mismas
            filterPattern{base} = filter2(gaborBase{base},pattern);
            
            if( strcmp(onlySum,'false') )
                % Generacion imagenes de patrones filtrados
                f=figure(base+1);
                if( strcmp(thresholdDetect,'false') )
                    imshow(filterPattern{base});
                    suptitle(['Base de Gabor con Theta = ',num2str(theta(rot)),' y Sigma = ',num2str(sigma(var)), ...
                    ' y Lambda =',num2str(lambda(lam))]);
                else
                    if(strcmp(onlyUmbral,'false'))
                    subplot(1,2,1)
                        imshow(filterPattern{base});
                        title("Sin funcion umbral")
                    subplot(1,2,2)
                    end
                        imshow(gdetect(filterPattern{base},threshold));
                        title("Aplicando funcion umbral")
                        suptitle(['Base de Gabor con Theta = ',num2str(theta(rot)),' Sigma = ',num2str(sigma(var)), ...
                        ' y Lambda =',num2str(lambda(lam))]);
                end
                saveas(f,['images/6/6_',num2str(base+1),index,'.png'],'png')
                set(gcf, 'Position', get(0, 'Screensize'));
            end
        end
    end
end
%----------------------------%
% Variables auxiliares 
    sum=zeros(size(filterPattern{1}));
    I=ones(size(sum));
%----------------------------%
% Suma total de los patrones filtrados  
    for i=1:base
        sum=sum+filterPattern{i};
    end
%----------------------------%
% Imagenes de la suma total
    f=figure(base+2);
    if( strcmp(thresholdDetect,'false') )
        figure(base+2)
        imshow(mat2gray(sum))
        title(['Suma total']);
    else
        figure(base+2)
        subplot(2,2,1)
        imshow(mat2gray(sum));
        title(['Suma total sin funcion umbral']);

        subplot(2,2,3)
        imshow(I-mat2gray(sum));
        title(['Negativo total sin funcion umbral']);

        subplot(2,2,2)
        imshow(gdetect(mat2gray(sum),threshold))
        title(['Suma total con funcion umbral']);  

        subplot(2,2,4)
        imshow(I - gdetect(mat2gray(sum),threshold))
        title(['Suma total con funcion umbral']);  
    end
    saveas(f,['images/6/6_',num2str(base+2),index,'.png'],'png')
    set(gcf, 'Position', get(0, 'Screensize'));
end

