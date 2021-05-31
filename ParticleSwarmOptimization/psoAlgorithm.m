% % PSO
clear
close

% parametry
pop_size = 100; %ustalenie liczby populacji poczatkowej

l_k=round(pop_size/5);
ilosc=100;
czas_pauzy=0.1;
c1=0.1;
c2=0.2;
c3=0.9;

[x y ]= meshgrid(-5:0.1:5);
z=ea_fun(x,y);
surf(x,y,z);
pause(czas_pauzy)
close
contour(x,y,z);
pause(czas_pauzy)
hold on

% ustawienie populacji poczatkowej
w=10*rand(pop_size,2)-5;
w0=w;
vfun=ea_fun(w(:,1),w(:,2));
[varmin,j]=min(vfun);
best_point=w(j,:); %najlepszy punkt
% najlepsz pkt  indiwidualnie 
best_positions = w;
%początkowa prędkość
velocity = zeros(pop_size,2);

% jakość (fitness)
for i=1: ilosc
    vfun=ea_fun(w(:,1),w(:,2));
    [varmin,j]=min(vfun);
    actual_best_point=w(j,:); %aktualny najlepszy punkt
    % aktualizacja najleszego punktu globalnie
    if min(vfun) < ea_fun(best_point(1,1),best_point(1,2)) 
        best_point=actual_best_point;
    end
    plot(best_point(1,1),best_point(1,2),'.g','MarkerSize',30)
    
    % aktualizacja najlepszych indywidualnie
    b=ea_fun(w(:,1),w(:,2))< ea_fun(best_positions(:,1),best_positions(:,2));
    best_positions(b,:)=w(b,:);
    
    % przesunienicie 
    wp_best_p = (best_point-w)*c1; %wektor przesuniecia w kierunku najlepsze punktu w historii
    wp_best_pi = (best_positions-w)*c2; %wektor przesuniecia w kierunku najlepszej pozycji punktu w historii
    wp_speed = (w-w0)*c3; %wektor przesuniecia oznzaczający poprzedni kierunek - prędkość
    w0=w;
    w=w+wp_best_p + wp_best_pi + wp_speed;
   
    % wizualizacja
    pause(czas_pauzy)
    close
    contour(x,y,z);
    hold on
    plot(w(:,1),w(:,2),'rx')
    hold on
    for iter=1 : pop_size
        %plot([w0(iter,1),w(iter,1)], [w0(iter,2),w(iter,2)],'r')
        %hold on
    end
end
vfun=ea_fun(best_point(1,1),best_point(1,2))

best_point
