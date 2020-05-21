clearvars

load fisheriris
X = meas(:,3:4);

figure;
plot(X(:,1),X(:,2),'k*','MarkerSize',5);
title 'Fisher''s Iris Data';
xlabel 'Petal Lengths (cm)'; 
ylabel 'Petal Widths (cm)';
hold on

k = 3;
[idx,C] = kmeans(X, k);

plot(X(idx==1,1),X(idx==1,2),'ro','MarkerSize',12)
plot(X(idx==2,1),X(idx==2,2),'go','MarkerSize',12)
plot(X(idx==3,1),X(idx==3,2),'bo','MarkerSize',12)

CLR = 'rgb';
for n = 1:k
    x = X(idx==n,1);
    y = X(idx==n,2);
    kb = boundary(x, y);
    plot(x(kb), y(kb), CLR(n));
end