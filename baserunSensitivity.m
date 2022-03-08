%Sensitivity analysis for different parameters
%
%Input: aimname is the parameter name. It should be string format.
% parameters and names  Please see below
%

function baserunSensitivity(aimname)

arguments
aimname string ='NB'; % 'NB' 'tau' 'Zm' 'Hn' 'dz' 'l' 'Iin'

end

switch aimname

    case 'NB' % bottom nutrient
NB = [15, 30, 60, 120];
aim=NB;
clf
for i = 1:length(aim)
    [t,y,p] = sensifuction(aimname,aim(i));
    plot(y(end,1:p.xgrid), -p.z,LineWidth=2)
    drawnow
    hold on
end
title('Sensitivity analysis of bottom nutrient')
legend(string(NB(1:length(NB)))+' mmol N m^-^3')

%--------------------------------------------------

    case 'l' % intrinsic mortality
l = [0.02, 0.04, 0.08, 0.16];
aim=l;
clf
for i = 1:length(aim)
    [t,y,p] = sensifuction(aimname,aim(i));
    plot(y(end,1:p.xgrid), -p.z,LineWidth=2)
    drawnow
    hold on
end
title('Sensitivity analysis of intrinsic mortality')
legend(string(l(1:length(l)))+' d^-^1')

%--------------------------------------------------

    case 'Iin' % incident light intensity
Iin = [100, 200, 400, 800];
aim=Iin;
clf
for i = 1:length(aim)
    [t,y,p] = sensifuction(aimname,aim(i));
    plot(y(end,1:p.xgrid), -p.z,LineWidth=2)
    drawnow
    hold on
end
title('Sensitivity analysis of incident light intensity')
legend(string(Iin(1:length(Iin)))+' W m^-^2')

%--------------------------------------------------


    case 'tau' % remineralization coefficient
tau = [0.05, 0.15, 0.3, 0.6];
aim=tau;
clf
for i = 1:length(aim)
    [t,y,p] = sensifuction(aimname,aim(i));
    plot(y(end,1:p.xgrid), -p.z,LineWidth=2)
    drawnow  
    hold on
end
title('Sensitivity analysis of remineralization coefficient')
legend(string(tau(1:length(tau)))+' d^-^1')

%------------------------------------------------------

    case 'Zm' % depth
Zm = [200, 400, 800,1600];
aim=Zm;
clf
for i = 1:length(aim)
    [t,y,p] = sensifuction(aimname,aim(i));
    plot(y(end,1:p.xgrid), -p.z,LineWidth=2)
    drawnow
    hold on
    ylim([-400 0])
end
title('Sensitivity analysis of water column depth')
legend(string(Zm(1:length(Zm)))+' m')

%---------------------------------------------
     case 'Hn' % half-saturation nutrient
Hn = [0.1, 0.2, 0.4, 0.8];
aim=Hn;
clf
for i = 1:length(aim)
    [t,y,p] = sensifuction(aimname,aim(i));
    plot(y(end,1:p.xgrid), -p.z,LineWidth=2)
    drawnow
    hold on
end
title('Sensitivity analysis of nutrient half-saturation')
legend(string(Hn(1:length(Hn)))+' mmol N m^-^3')

%-------------------------------------------------

    case 'dz' % grid cell size
dz = [0.5, 1, 2, 4, 8, 16, 32];
aim=dz;
clf
for i = 1:length(aim)
    [t,y,p] = sensifuction(aimname,aim(i));
    plot(y(end,1:p.xgrid), -p.z,LineWidth=2)
    drawnow
    hold on
end
title('Sensitivity analysis of grid cell length')
legend(string(dz(1:length(dz)))+' m')

end


xlabel('Phytoplankton concentration (mmol N m^-^3)')
ylabel('Depth (m)')
set(gca,FontSize=20)
end
