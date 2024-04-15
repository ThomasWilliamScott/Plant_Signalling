% This script contains code for generating the results figure in the main
% text (Figure 2a, b & c). Running this code generates three figures. The
% first figure is Fig 2a in the main text (evolution of signalling). The
% second figure is Fig 2b in the main text (evolution of cue-suppression).
% The third figure is Fig 2c in the main text (evolution of eavesdropping).

% First, we generate Fig 2a. The evolution of honest signalling.

close all
clearvars
clc

% Parameter values. Two values are specified - a reference value (black 
% line in figure), and an alternative value. 
dR=[0.1 0.9]; % Predation cost
cR=[0.001 0.003]; % Cost of signal production
NR=[3 10]; % Deme size
sR=[0.08 0.09]; % Defence cost
gR=[0 1]; % Conditionality of signal
mR=0:0.01:1; % Migration rate

% The for loops are used to collect data over the different parameter
% values specified above.
for curr_N = 1:length(NR)
    N=NR(curr_N);

for curr_g = 1:length(gR)
    g=gR(curr_g);

for curr_c = 1:length(cR)
    c=cR(curr_c);

for curr_d = 1:length(dR)
    d=dR(curr_d);

for curr_s = 1:length(sR)
    s=sR(curr_s);

for curr_m = 1:length(mR)
    m=mR(curr_m);

% The expression below corresponds to Equation D1. We showed in the script
% titled 'Model_K_Numerical_Analysis.m' that honest signalling evolves in
% Model K when this expression is greater than zero. We record the value of
% this expression for different parameter values and store this in a
% results matrix titled 'threshold'.
threshold(curr_m,curr_N,curr_g,curr_c,curr_d,curr_s) = (-d.*(-1+m).^2.*(-1+N)-c.*((-1+m).^2-N).*(-g+(-1+g).*N)+(-1+m).^2.*(-1+N).*s)./((-1+N).*(-d.*(-1+m).^2+d.*(-2+m).*m.*N+c.*(-1+m).^2.*(-g+(-1+g).*N)+s-(-2+m).*m.*(-1+N).*s));

end
end
end
end
end
end

% We plot our results matrix as different lines. Honest signalling is 
% favoured above these lines, and disfavoured below them. The different
% lines correspond to different parameter regimes. 
hold on
plot(mR,threshold(:,1,1,1,1,1),'LineWidth',2,'Color','k')
plot(mR,threshold(:,2,1,1,1,1),'LineWidth',1,'LineStyle','-')
plot(mR,threshold(:,1,2,1,1,1),'LineWidth',1,'LineStyle','-')
plot(mR,threshold(:,1,1,2,1,1),'LineWidth',1,'LineStyle','-')
plot(mR,threshold(:,1,1,1,2,1),'LineWidth',1,'LineStyle','-')
plot(mR,threshold(:,1,1,1,1,2),'LineWidth',1,'LineStyle','-')
hold off
box on
set(gca,'FontSize',16)
set(gcf,'color','white')
ylim([0 1])
xlim([0 1])
yticks(0:0.2:1)
xticks(0:0.2:1)

% Next, we generate Fig 2b. The evolution of cue-suppression.

clearvars
clc

% Parameter values. Two values are specified - a reference value (black 
% line in figure), and an alternative value. 
N=[3 5]; % Deme size
g=[0.8 0.95]; % Conditionality of cue-suppressor
c=0:0.001:1; % Cost of cue-suppression

% The for loops are used to collect data over the different parameter
% values specified above.
for curr_N = 1:length(N)
for curr_g = 1:length(g)
for curr_c = 1:length(c)

% When the below expression is greater than d-s, cue-suppression is 
% favoured. We record the value of this expression for different parameter 
% values and store this in a results matrix titled 'd'.
d(curr_c, curr_g, curr_N) = N(curr_N) .* c(curr_c) .* (1-g(curr_g).*((N(curr_N)-1)./N(curr_N)));

end
end
end

% We plot our results matrix as different lines. Cue-suppression is 
% favoured above these lines, and disfavoured below them. The different
% lines correspond to different parameter regimes. 
figure
hold on
plot(c,d(:,1,1),'LineWidth',2,'Color','k', 'LineStyle','-')
plot(c,d(:,2,1),'LineWidth',2,'Color','k','LineStyle','--')
plot(c,d(:,1,2),'LineWidth',2,'Color','k', 'LineStyle',':')
hold off
box on
set(gca,'FontSize',16)
set(gcf,'color','white')
ylim([0 1])
xlim([0 1])
yticks(0:0.2:1)
xticks(0:0.2:1)

% Next, we generate Fig 2c. The evolution of eavesdropping.

clearvars
clc

% Parameter values. Two values are specified - a reference value (black 
% line in figure), and an alternative value. 
N=[3 5]; % Deme size
b=[1 1.5]; % Benefit of being connected to high-quality trade partners
c=0:0.001:1; % Cost of eavesdropping

% The for loops are used to collect data over the different parameter
% values specified above.
for curr_N = 1:length(N)
for curr_b = 1:length(b)
for curr_c = 1:length(c)

% When the below expression is greater than d-s, eavesdropping is 
% favoured. We record the value of this expression for different parameter 
% values and store this in a results matrix titled 'd'.
d(curr_c,curr_b, curr_N)  = (c(curr_c) ./  b(curr_b))  .* (N(curr_N) ./ (N(curr_N)-1)) ;

end
end
end

% We plot our results matrix as different lines. Eavesdropping is 
% favoured above these lines, and disfavoured below them. The different
% lines correspond to different parameter regimes. 
figure
hold on
plot(c,d(:,1,1),'LineWidth',2,'Color','k', 'LineStyle','-')
plot(c,d(:,2,1),'LineWidth',2,'Color','k','LineStyle','--')
plot(c,d(:,1,2),'LineWidth',2,'Color','k', 'LineStyle',':')
hold off
box on
set(gca,'FontSize',16)
set(gcf,'color','white')
ylim([0 1])
xlim([0 1])
yticks(0:0.2:1)
xticks(0:0.2:1)

