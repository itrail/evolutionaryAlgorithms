% GENETIC ALGORITHM
clear
close

% parameters
pop_size = 100; % determination of the starting population size
p = 0.1;
crossings_amount=round(pop_size/5);
amount=20;
pause_time=1;

%plots of function
[x, y] = meshgrid(-5:0.1:5);
z = ea_fun(x,y);
surf(x, y, z)
pause %press any key
contour(x,y,z)
pause %press any key
close

w = rand(pop_size, 2);
w=w*10-5;
for i=1: amount
    % fitness
    vfun=ea_fun(w(:,1), w(:,2))  ;
    emin = min(vfun);
    emax = max(vfun);
    a = (1-p)/(emin - emax);
    b = 1 - a*min(vfun);
    Quality = a*vfun + b;

    % selection
    pr = Quality/sum(Quality);
    prsum = cumsum(pr);

    for i=1:pop_size 
        bool = rand>prsum
        num=sum(bool)+1
        ww(i,:) = w(num,:);
    end
    w=ww;
    % crossing species
    for i=1:crossings_amount
        ri = randi([1,100],1,2);
        point1 = w(ri(1),:);
        point2 = w(ri(2),:);
        S = (point1 + point2)/2

        vector1 = randn(1,2)/10;
        vector2 = randn(1,2)/10;
        w(ri(1),:)=S+vector1;
        w(ri(2),:)=S+vector2;
    end
    % mutation
    rand_point=randi([1,100],1,1);
    w(rand_point,:)=w(rand_point,:)+randn(1,2)/8
    % visualisation
    pause(pause_time)
    hold off 
    close all
    contour(x,y,z);
    hold on
    plot(w(:,1),w(:,2),'rx')
end
[min,x_min]=min(vfun);
disp("There is the minimum: " + min + " in the (" + w(x_min,1) + ", " + w(x_min,2) + ") point")
