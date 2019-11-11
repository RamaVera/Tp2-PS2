function imagout = gdetect(imagin,umbral)

if (umbral >= 1 || umbral <= 0)
    disp('Error: El parametro de umbral debe ser entre [0,1]')
end

%largo = size(imagin,1);
%ancho = size(imagin,2);

%Calculo valor medio y defino a imag1
imag_mean=sum(sum(imagin,1),2);
imag1 = imagin- imag_mean;
%Obtengo valor absoluto de imag1
imag2 = abs(imag1);
%Normalizo entre 0,1
imag3 = mat2gray(imag2);
%Obtengo matriz binaria
imagout=im2bw(imag3,umbral);



