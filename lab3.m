clc; clear;

% Pradiniai duomenys
x = 0.1:1/22:1;
d = ((1 + 0.6*sin(2*pi*x/0.7)) + (0.3*sin(2*pi*x))/2); 
plot(x, d, 'r'); % Tikrasis atsakas
hold on;

% Inicializuojame SBF tinklo parametrus
c1 = 0.65; % Centro reikšmės pasirinktos rankiniu būdu
c2 = 0.5; % Centro reikšmės pasirinktos rankiniu būdu
r1 = 0.12; % Spindulio reikšmės pasirinktos rankiniu būdu
r2 = 0.13; % Spindulio reikšmės pasirinktos rankiniu būdu

% Svoriniai koeficientai ir poslinkiai, inicializuojami atsitiktinai
w1 = rand(1);
w2 = rand(1);
w0 = rand(1);

eta = 0.0001; % Mokymosi žingsnis

% Mokymo ciklas
for epoch = 1:500000
    for i = 1:length(x)
        % Spindulio tipo funkcijos
        f1 = exp(-(x(i)-c1)^2/(2*r1^2));
        f2 = exp(-(x(i)-c2)^2/(2*r2^2));
        
        % Išėjimo sluoksnio vertės skaičiavimas
        y = w1*f1 + w2*f2 + w0;
        
        % Klaidos skaičiavimas
        e = d(i) - y;
        
        % Svorinių koeficientų ir poslinkių atnaujinimas
        w1 = w1 + eta * e * f1;
        w2 = w2 + eta * e * f2;
        w0 = w0 + eta * e;
    end
end

% Testavimas
X_test = 0.1:1/220:1;
Y_test = zeros(1, length(X_test));
for i = 1:length(X_test)
    f1_test = exp(-(X_test(i)-c1)^2/(2*r1^2));
    f2_test = exp(-(X_test(i)-c2)^2/(2*r2^2));
    Y_test(i) = w1*f1_test + w2*f2_test + w0;
end

% Rezultatų atvaizdavimas
plot(x, d, 'r', X_test, Y_test, 'b--');
legend('Norimas atsakas', 'SBF aproksimacija');
title('Spindulio tipo bazinių funkcijų tinklo aproksimacija');
xlabel('x');
ylabel('y');
hold off;
