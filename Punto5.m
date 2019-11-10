clear all
close all
clc

load("patrones.mat")
load("imagenes.mat")

%parte = 1;
parte = 2;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if( parte == 1 )

    sigma = [6,1];
    theta = [0,pi/4,pi/2,3*pi/4];
    lambda = 10; 
    psi = 0;
    gamma = 1;
    type = 'o';
    pattern = mat2gray( foto_lenna );
    %pattern = foto_lenna ;
    base=0;
    thresholdDetect= 'true' ;
    threshold = 0.55;

    figure(1)
    imshow(pattern)
    set(gcf, 'Position', get(0, 'Screensize'));

    for var=1:length(sigma)
        for rot=1:length(theta)
            base=base+1;
            gaborBase{base}=gabor_fn(sigma(var),theta(rot),lambda,psi,gamma,type);
            filterPattern{base} = filter2(gaborBase{base},pattern);

            figure(base+1)
            if( strcmp(thresholdDetect,'false') )
                imshow(filterPattern{base});
                suptitle(['Base de Gabor con Theta = ',num2str(theta(rot)),' y Sigma = ',num2str(sigma(var))]);
            else
                subplot(1,2,1)
                imshow(filterPattern{base});
                title("Sin funcion umbral")

                subplot(1,2,2)
                imshow(gdetect(filterPattern{base},threshold));
                title("Aplicando funcion umbral")


                suptitle(['Base de Gabor con Theta = ',num2str(theta(rot)),' y Sigma = ',num2str(sigma(var))]);
            end
            set(gcf, 'Position', get(0, 'Screensize'));

        end
    end
    sum=zeros(size(filterPattern{1}));

    for i=1:base
        sum=sum+filterPattern{i};
    end
    I=ones(size(sum));

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
        title(['Negativo de Suma total sin funcion umbral']);

        subplot(2,2,2)
        imshow(gdetect(mat2gray(sum),threshold))
        title(['Suma total con funcion umbral']);  

        subplot(2,2,4)
        imshow(I - gdetect(mat2gray(sum),threshold))
        title(['Suma total con funcion umbral']);  
        set(gcf, 'Position', get(0, 'Screensize'));

    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
    thresholdDetect= 'true' ;
    thresholdValues = 0.3:0.02:0.7;

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

        if( strcmp(thresholdDetect,'false') )
            figure(k)
            imshow(mat2gray(sum))
            title(['Suma total']);
        else
            figure(k)
            subplot(2,2,1)
            imshow(mat2gray(sum));
            title(['Suma total sin funcion umbral']);

            subplot(2,2,3)
            imshow(I-mat2gray(sum));
            title(['Negativo de Suma total sin funcion umbral']);

            subplot(2,2,2)
            imshow(gdetect(mat2gray(sum),threshold))
            title(['Suma total con funcion umbral']);  

            subplot(2,2,4)
            imshow(I - gdetect(mat2gray(sum),threshold))
            title(['Suma total con funcion umbral']);  
            set(gcf, 'Position', get(0, 'Screensize'));
            
            suptitle(['Umbral = ',num2str(threshold)])

        end
    end
end
