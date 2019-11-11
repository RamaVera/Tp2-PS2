%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                               Punto 5                                   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all
close all
clc
load("patrones.mat")
load("imagenes.mat")
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

parte = 1; % Carga el punto 5 del tp
%parte = 2; % Carga un analisis del parametro de umbral
%thresholdDetect= 'false' ; %No activa funcion umbral
thresholdDetect= 'true' ; %Activa funcion umbral
%onlyUmbral='false'; %Plotea la entrada al umbral y la salida
onlyUmbral='true'; %Plotea solo la salida de umbral

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                         Parte    1                                  %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% En esta primera parte se hara el punto 5 pedido del enunciado
if( parte == 1 )
%----------------------------%
% Parametros
    sigma = [6,1];
    theta = [0,pi/4,pi/2,3*pi/4];
    lambda = 10; 
    psi = 0;
    gamma = 1;
    type = 'o';
    pattern = mat2gray( foto_lenna );
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
    saveas(f,['images/5/5_',num2str(base+1),'.png'],'png')
    set(gcf, 'Position', get(0, 'Screensize'));
%----------------------------%
% Generacion de componentes de la base, filtrado con las mismas e imagenes
    for var=1:length(sigma)
        for rot=1:length(theta)
            base=base+1;
            % Generacion de componentes de la base
            gaborBase{base}=gabor_fn(sigma(var),theta(rot),lambda,psi,gamma,type);
            % Filtrado con las mismas
            filterPattern{base} = filter2(gaborBase{base},pattern);
            % Generacion imagenes de patrones filtrados
            f=figure(base+1);
            if( strcmp(thresholdDetect,'false') )
                imshow(filterPattern{base});
                suptitle(['Base de Gabor con Theta = ',num2str(theta(rot)),' y Sigma = ',num2str(sigma(var))]);
            else
                if(strcmp(onlyUmbral,'false'))
                subplot(1,2,1)
                    imshow(filterPattern{base});
                    title("Sin funcion umbral")
                subplot(1,2,2)
                end
                    imshow(gdetect(filterPattern{base},threshold));
                    title("Aplicando funcion umbral")
                suptitle(['Base de Gabor con Theta = ',num2str(theta(rot)),' y Sigma = ',num2str(sigma(var))]);
            end
            saveas(f,['images/5/5_',num2str(base+1),index,'.png'],'png')
            set(gcf, 'Position', get(0, 'Screensize'));
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
    saveas(f,['images/5/5_',num2str(base+2),index,'.png'],'png')
    set(gcf, 'Position', get(0, 'Screensize'));
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                         Parte    2                                  %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% En esta segunda parte se vera como queda la imagen final para distintos
% valores de threshold
if(parte == 2)
    sigma = [6,1];
    theta = [0,pi/4,pi/2,3*pi/4];
    lambda = 10; 
    psi = 0;
    gamma = 1;
    type = 'o';
    pattern = mat2gray( foto_lenna );
    %pattern = foto_lenna ;
    base=0;
    plotNum=11;
    thresholdDetect= 'true' ;
    thresholdValues = 1- [0.3,0.4:0.01:0.5];

    for k=1:length(thresholdValues) 
        threshold=thresholdValues(k);
        for var=1:length(sigma)
            for rot=1:length(theta)
                base=base+1;
                gaborBase{base}=gabor_fn(sigma(var),theta(rot),lambda,psi,gamma,type);
                filterPattern{base} = filter2(gaborBase{base},pattern);
            end
        end

        sum=zeros(size(filterPattern{1}));

        for i=1:base
            sum=sum+filterPattern{i};
        end
        I=ones(size(sum));

        f=figure(k);
        if( strcmp(thresholdDetect,'false') )
            imshow(mat2gray(sum))
            title(['Suma total']);
        else
%             subplot(2,2,1)
%             imshow(mat2gray(sum));
%             title(['Suma total sin funcion umbral']);

%             subplot(2,2,3)
%             imshow(I-mat2gray(sum));
%             title(['Negativo de Suma total sin funcion umbral']);
% 
%             subplot(2,2,2)
              if strcmp(onlyUmbral,'false')
                  subplot(1,2,1)
                  imshow(gdetect(mat2gray(sum),threshold))
                  title(['Suma total con funcion umbral']);  
%             subplot(2,2,4)
                  subplot(1,2,2)
              end
                  imshow(I - gdetect(mat2gray(sum),threshold))
                  title(['Suma total con funcion umbral']);     
                  suptitle(['Umbral = ',num2str(threshold)])

                  saveas(f,['images/5/5_',num2str(plotNum),'.png'],'png')
                  set(gcf, 'Position', get(0, 'Screensize'));
              plotNum=plotNum+1;
        end
    end
end
