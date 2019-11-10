function gb=gabor_fn(sigma,theta,lambda,psi,gamma, type)

% Desvíos en x e y
sigma_x = sigma;
sigma_y = sigma/gamma;

% Dimensiones del filtro en x e y
if(gamma<=1)
    sz_x = round(7*sigma_y);   % width;
    sz_y = round(7*sigma_y);   % high;
else
    sz_x = round(7*sigma_x);   % width;
    sz_y = round(7*sigma_x);   % high;
end

% Definición de puntos en x e y
[x y]=meshgrid(-fix(sz_x/2):fix(sz_x/2),fix(-sz_y/2):fix(sz_y/2));

% Rotation
x_theta = x*cos(theta)+y*sin(theta);
y_theta = -x*sin(theta)+y*cos(theta);

% Definición de filtors de gabor
if(type=='e')
    gb = exp(-.5*(x_theta.^2/sigma_x^2+y_theta.^2/sigma_y^2)).*cos(2*pi/lambda*x_theta+psi);
elseif(type=='o')
    gb = exp(-.5*(x_theta.^2/sigma_x^2+y_theta.^2/sigma_y^2)).*sin(2*pi/lambda*x_theta+psi);
else
    gb = exp(-.5*(x_theta.^2/sigma_x^2+y_theta.^2/sigma_y^2)).*exp(i*2*pi/lambda*x_theta+psi);
end

end