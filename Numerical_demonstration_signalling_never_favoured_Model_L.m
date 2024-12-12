% The purpose of this script is to check whether the condition for
% signalling to be favoured in Model L (i.e. the main model presented in 
% the main text) is ever satisfied. We do so by sweeping through all
% combinations of parameter values, and seeing if the condition is ever
% satisfied. We find that it isn't.

clearvars
clc
close all

% Parameter values. We sweep through all possible parameter combinations %%
cR=0.00000001:0.04:0.99999999;
pR=0.00000001:0.04:0.99999999;
NR=0.00000001:0.04:0.99999999;
gR=0.00000001:0.04:0.99999999;
sR=0.00000001:0.04:0.99999999;
dR=0.00000001:0.04:0.99999999;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% We specify this empty (NaN) results matrix to fill in below.
res = NaN(length(dR),length(sR),length(gR),length(NR),length(pR),length(cR));

% We loop over all parameter combinations. We need several for loops to
% loop over each parameter.
for c_cur = 1:length(cR)

    c = cR(c_cur);

for p_cur = 1:length(pR)

    p = pR(p_cur);

for N_cur = 1:length(NR)

    N = NR(N_cur);

for g_cur = 1:length(gR)

    g = gR(g_cur);

for s_cur = 1:length(sR)

    s = sR(s_cur);

for d_cur = 1:length(dR)

    d = dR(d_cur);

        % This is the ESS value for y (signal response). This is Equation
        % L13 in the SI.
        y = (c*(g+N-g*N))/s;

        % This is the ESS value for z (signal dishonesty). This is Equation
        % L20 in the SI.
        z = (p*(-d + s))/((-1 + p)*s);


        % This if statement ensures that y is bounded between zero and one.
        if y>1
            y=1;

        elseif y<0
            y=0;

        end

        % This if statement ensures that z is bounded between zero and one.
        if z>1
            z=1;

        elseif z<0
            z=0;

        end

        % This if statement puts a '1' in the results matrix if the
        % condition for signalling to be favoured in satisfied, and a '0'
        % in the results matrix if the condition for signalling to be
        % favoured is not satisfied.
        if c*(p+(1-p)*z)*(1-(N-1)/N*g) < y/N*(s*(p+(1-p)*z)-d*p)
        res(d_cur,s_cur,g_cur,N_cur,p_cur,c_cur) = 1;
        else
        res(d_cur,s_cur,g_cur,N_cur,p_cur,c_cur) = 0;
        end

end
end
end
end
end
end

% This sums up all the 1s in the results matrix. Each '1' corresponds to a
% parameter combination where signalling was favoured. We find that S=0,
% meaning there are no instances where signalling is favoured.
S = sum(res,"all")
