clear all
close all
clc

load('patrones.mat')
load('imagenes.mat')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 1.a)
sigma = [6,4,2];
theta = 0 ;
lambda = 6; 
psi = 0;
gamma = 1;
type = ['e','o'];
type_name={'Par','Impar'};
pattern={patron_barra,patron_linea};
pattern_name={'Barra','Linea'};
jaux=1;
kaux=1;

for j=1:length(pattern)
    for k=1:length(type)
        for i=1:length(sigma)
            G{i}=gabor_fn(sigma(i),theta,lambda,psi,gamma,type(k));
            fPattern = filter2(G{i},pattern{j});
            
            figure (jaux+kaux-1)
            hold on

            subplot(3,3,(i-1)*3+1)
            imshow(mat2gray(abs(fPattern)));
            ylabel(['\sigma=', num2str(sigma(i))])
            
            subplot(3,3,(i-1)*3+2)
            plot(fPattern(128,:),'k')
            %%set(get(gca,'YLabel'),'Rotation',0)
            %title({'Patron',pattern_name(j)})
            
            subplot(3,3,(i-1)*3+3)
            imshow(mat2gray(G{i}));
            %title({'Filtro',type_name(k)})

           % suptitle(['Patron ',pattern_name{j},' Tipo ',type_name{k}])
            %text( 0, 0, 'My Nice Title', 'FontSize', 14', 'FontWeight', 'Bold', ...
            %'HorizontalAlignment', 'Center', 'VerticalAlignment', 'Top' ) ;
            
        end
        kaux=kaux+1;
        print(['Images/1/im',num2str(kaux-1)],'-dpng')
    end
    jaux=jaux+1;
end



