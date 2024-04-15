% This script implements the numerical procedure used to find the long term
% trait values for Model K. In Model K, signalling, signal-response and
% signal-dishonesty coevolve. It is an open model where migration goes
% before population regulation, which are required for honest signalling
% to evolve.

close all
clearvars
clc

% Set parameter values. These are arbitrary, and may be changed, as long as
% fitness doesn't fall below zero, and as long as d>s.

d=0.5; % Predation cost
c=0.001; % Signalling cost
N=3; % Number of individuals per deme
s=0.2; % Defence cost
g=0.9; % Conditionality of signal
p=0.1; % Probability of predator attack
mR=0:0.01:1; % Migration (range)
rR=0:0.01:1; % Relatedness (range)
z=0; % Initial signal dishonesty
y=0; % Initial signal response
x=0; % Initial signal investment
inc=0.0001; % Increment by which trait values change each time step
T=10000; % Total number of time steps. Note that the increment needs to be 
% sufficiently small relative to the number of time steps that the trait 
% optima can be approached, but not too small that the optima are not
% reached in time. The inc and T values that are currently specified get
% this balance right.

% This for loop allows us to obtain results for different migration rates
for curm = 1:length(mR)

    m=mR(curm);

% This for loop allows us to obtain results for different relatedness
% values
for curr = 1:length(rR)

    r=rR(curr);

% This for loop iterates over time steps
for t=1:T

    % y selection differential (response). Equation K7 in the SI is
    % obtained by setting this to be greater than zero.
    margopeny =  p*d - s*((1-p)*z+p);

    % z selection differential (dishonesty). Equation K8 in the SI is
    % obtained by setting this to be greater than zero.
    margopenz = ((p-1)*x*((N-1)*r*(s*y*((m-2)*m*(N-1)-1)-c*(m-1)^2*((g-1)*N-g))-c*((g-1)*N-g)*((m-1)^2-N)+(m-1)^2*(N-1)*s*y))/(N*(x*(c*((g-1)*N-g)*((p-1)*z-p)-(N-1)*y*(p*(d-s)+(p-1)*s*z))+N*(d*p-1)));
    
    % x selection differential (signalling). Equation K9 in the SI is
    % obtained by setting this to be greater than zero.
    margopenx = r - (-c*((-1+m)^2-N)*(g*(-1+N)-N)*(-p+(-1+p)*z)+(-1+m)^2*(-1+N)*y*(p*(d-s)+(-1+p)*s*z))/((-1+N)*(c*(-1+m)^2*(g*(-1+N)-N)*(-p+(-1+p)*z)-(-1+(-2+m)*m*(-1+N))*y*(p*(d-s)+(-1+p)*s*z))); 
    

% We use the selection differentials listed above to find the long-term 
% trait values. The if statements below add on an incremement to trait 
% values associated with a positive selection differential, and subtract an
% increment from trait values associated with a negative differential.

if margopenx > 0
    xN=x+inc;
elseif margopenx < 0
    xN=x-inc;
else
    xN=x;
end

if margopeny > 0
    yN=y+inc;
elseif margopeny < 0
    yN=y-inc;
else
    yN=y;
end

if margopenz > 0
    zN=z+inc;
elseif margopenz < 0
    zN=z-inc;
else
    zN=z;
end

% The below three lines ensure that trait values stay in the range zero to
% one. Technically, we stop trait values from going all the way to zero and
% one, because these extreme trait values can prevent selection from
% bringing trait values to their optima.
x = max(min(xN,0.999),0.001);
y = max(min(yN,0.999),0.001);
z = max(min(zN,0.999),0.001);

end

% We record the resulting trait values in results matrices.
xres(curm,curr) = x;
yres(curm,curr) = y;
zres(curm,curr) = z;

end
end

% This plots signal investment as a heatmap, where migration and
% relatedness are varied on each axis.
figure
imagesc(mR,rR,xres)
set(gca,'FontSize',14)
set(gca,'YDir','normal')
set(gcf,'color','white')
colorbar
caxis([0 1])
ylabel('relatedness (r)')
xlabel('migration (m)')
title('Equilibrium signalling (x^*) in Model K')

% This plots signal-response as a heatmap, where migration and
% relatedness are varied on each axis.
figure
imagesc(mR,rR,yres)
set(gca,'FontSize',14)
set(gca,'YDir','normal')
set(gcf,'color','white')
colorbar
caxis([0 1])
ylabel('relatedness (r)')
xlabel('migration (m)')
title('Equilibrium signal response (y^*) in Model K')

% This plots signal-honesty as a heatmap, where migration and
% relatedness are varied on each axis.
figure
imagesc(mR,rR,1-zres)
set(gca,'FontSize',14)
set(gca,'YDir','normal')
set(gcf,'color','white')
colorbar
caxis([0 1])
ylabel('relatedness (r)')
xlabel('migration (m)')
title('Equilibrium signal honesty (1-z^*) in Model K')

% This plots a threshold, above which, the expression provided in Equation 
% D1 is greater than zero. Above this line, signalling evolves in Model D.
% We can see by comparing this figure with the 3 previous heatmaps that, in
% the present model (Model K), honest signalling evolves 'above this line',
% and signalling does not evolve 'below this line'.
figure
threshold = (-d.*(-1+mR).^2.*(-1+N)-c.*((-1+mR).^2-N).*(-g+(-1+g).*N)+(-1+mR).^2.*(-1+N).*s)./((-1+N).*(-d.*(-1+mR).^2+d.*(-2+mR).*mR.*N+c.*(-1+mR).^2.*(-g+(-1+g).*N)+s-(-2+mR).*mR.*(-1+N).*s));
plot(mR,threshold)

box on
set(gca,'FontSize',14)
set(gcf,'color','white')
ylim([0 1])
xlim([0 1])
ylabel('relatedness (r)')
xlabel('migration (m)')
title('Above this line, the expression given in Equation D1 is greater','than 0. This threshold also predicts signalling in Model K','FontWeight','bold')
