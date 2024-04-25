% This script contains code for generating the results figures: Fig. 2, 
% Fig. 3a, Fig. 3b & Fig. S1. Running this code generates four figures. The
% first figure is Fig 2 in the main text (evolution of signalling in closed
% model). The second figure is Fig 3a in the main text (evolution of 
% cue-suppression). The third figure is Fig 3b in the main text (evolution 
% of eavesdropping). The fourth figure is Fig. S1 in the SI (evolution of 
% signalling in open model).

% First, we generate Fig 2. The evolution of signalling in a closed model.

close all
clearvars
clc

% Parameter values. Two values are specified - a reference value (black 
% line in figure), and an alternative value. 
dR=0:0.001:1; % Predation cost
gR=[0 1]; % Conditionality of signal
cR=[0.1 0.3]; % Cost of signal production
NR=[3 50]; % Deme size
sR=[0 0.1]; % Defence cost
mR=[0.5 1]; % Migration rate
x=0; % Inital signalling investment

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

% The expression below corresponds to the selection differential for 
% signalling (dw/dx) given in Equation A18. When this is greater than zero,
% signalling is favoured, else signalling is not favoured. We record this
% for different parameter combinations and store it in a results matrix.
seldiff(curr_d,curr_g,curr_c,curr_N,curr_s,curr_m) = ((m-2)*m*(N-1)*(c*(g-1)*N-c*g-d+s))/(((m-2)*m*(N-1)-1)*(x*(N*(c*g-s)-c*(g+N)+d*(N-1)+s)-d*N+N));

end
end
end
end
end
end

% We plot our results matrix as different lines. Signalling is favoured
% whenever a line goes above zero. We see that this never happens.
hold on
plot(dR,seldiff(:,1,1,1,1,1),'LineWidth',2,'Color','k')
plot(dR,seldiff(:,2,1,1,1,1),'LineWidth',1,'LineStyle','-')
plot(dR,seldiff(:,1,2,1,1,1),'LineWidth',1,'LineStyle','-')
plot(dR,seldiff(:,1,1,2,1,1),'LineWidth',1,'LineStyle','-')
plot(dR,seldiff(:,1,1,1,2,1),'LineWidth',1,'LineStyle','-')
plot(dR,seldiff(:,1,1,1,1,2),'LineWidth',1,'LineStyle','-')
hold off
set(gca,'FontSize',16)
set(gcf,'color','white')
ylim([-1 0.2])
xlim([0 1])
yticks(-1:0.2:1.2)
xticks(0:0.2:1.1)
yline(0,'LineWidth',1,'LineStyle','--')

% Next, we generate Fig 3a. The evolution of cue-suppression.

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

% Next, we generate Fig 3b. The evolution of eavesdropping.

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

% Finally, we generate Fig S1. The evolution of signalling in an open 
% model.

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
figure
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
