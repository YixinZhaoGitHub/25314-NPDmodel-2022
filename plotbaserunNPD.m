%
% Plot results of NPD
%
function plotbaserunNPD(t,y,p,season)

switch season
    case false % constant environment----------------------
%% surface plot
figure(1)
surface(t,-p.z,y(1:length(t),1:p.xgrid)')
xlim([0 9125])
shading interp
bar=colorbar;
bar.Label.String = 'Phytoplankton concentration (mmol N m^-^3)';
xlabel('Time (days)')
ylabel('Depth (m)')
title('Phytoplankton population dynamics (constant environmental conditions)',FontSize=20)
set(gca,FontSize=20)

%% day 55 limitation plot
figure(2)
tl1=tiledlayout(1,1);
ax1 = axes(tl1);

plot(ax1,y(56,1:p.xgrid),-p.z,'g',LineWidth=3)
xlabel('Concentration (mmol N m^-^3)')
ylabel('Depth (m)',FontSize=20)
ax1.XAxisLocation = 'bottom';
set(gca,FontSize=20)
grid on

ax2 = axes(tl1);
plot(ax2,p.An.*y(56,p.xgrid+1:2*p.xgrid)./(p.An.*y(56,p.xgrid+1:2*p.xgrid)+p.pmax),-p.z,'--',LineWidth=2)
hold on
plot(ax2,p.Al.*calculatelight(y(56,1:p.xgrid)',y(56,2*p.xgrid+1:end)',t,p,season)./(p.Al.*calculatelight(y(56,1:p.xgrid)',y(56,2*p.xgrid+1:end)',t,p,season)+p.pmax),-p.z,'--r',LineWidth=2)
hold off
xlim([0 1])
ax2.XAxisLocation = 'top';
ax2.YAxisLocation = 'right';
ax2.Color = 'none';
xlabel('Resource limitation')

set(gca,FontSize=20)

%% day 9125 limitation plot
figure(3)
tl2=tiledlayout(1,1);
ax3 = axes(tl2);

plot(ax3,y(end,1:p.xgrid),-p.z,'g',LineWidth=3)
xlabel('Concentration (mmol N m^-^3)')
ylabel('Depth (m)',FontSize=20)
xlim([0 0.15])
ax3.XAxisLocation = 'bottom';
set(gca,FontSize=20)
grid on

ax4 = axes(tl2);
plot(ax4,p.An.*y(end,p.xgrid+1:2*p.xgrid)./(p.An.*y(end,p.xgrid+1:2*p.xgrid)+p.pmax),-p.z,'--',LineWidth=2)
hold on
plot(ax4,p.Al.*calculatelight(y(end,1:p.xgrid)',y(end,2*p.xgrid+1:end)',t,p,season)./(p.Al.*calculatelight(y(end,1:p.xgrid)',y(end,2*p.xgrid+1:end)',t,p,season)+p.pmax),-p.z,'--r',LineWidth=2)
hold off
xlim([0 1])
ax4.XAxisLocation = 'top';
ax4.YAxisLocation = 'right';
ax4.Color = 'none';
xlabel('Resource limitation')

set(gca,FontSize=20)

%% day 9125 all substances
figure(4)
tl3=tiledlayout(1,1);

ax5 = axes(tl3);
plot(ax5,y(end,1:p.xgrid),-p.z,'g',LineWidth=3)%P
hold on 
plot(ax5,y(end,2*p.xgrid+1:end),-p.z,'black',LineWidth=3)%D
hold off
ax5.XAxisLocation = 'top';
xlim([0 0.2])
xlabel('Concentration (mmol N m^-^3)')
ylabel('Depth (m)')
legend('P','D')
set(gca,FontSize=20)

ax6 = axes(tl3);
plot(ax6,y(end,p.xgrid+1:2*p.xgrid),-p.z,'blue',LineWidth=3)%N
ax6.XAxisLocation = 'bottom';
ax6.YAxisLocation = 'right';
ax6.Color = 'none';
xlim([0 50])
xlabel('Concentration (mmol N m^-^3)')
set(gca,FontSize=20)
legend('N','Location','east')

    case true %plot seasonal forcing-----------------------------
figure(1)
surface(0:365,-p.z,y((length(t)-365):length(t),1:p.xgrid)')
xlim([0 365])
shading interp
bar=colorbar;
bar.Label.String = 'Phytoplankton concentration (mmol N m^-^3)';
xticks([0 365/12 2*365/12 3*365/12 4*365/12 5*365/12 6*365/12 7*365/12 8*365/12 9*365/12 10*365/12 11*365/12 365]);
xticklabels({'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'});
xlabel('Month')
ylabel('Depth (m)')
title('Phytoplankton population dynamics (seasonal scenario)',FontSize=20)
set(gca,FontSize=20)

%% middle of a year
figure(2)
tl1=tiledlayout(1,1);

ax1 = axes(tl1);

plot(ax1,y(end-181,1:p.xgrid),-p.z,'g',LineWidth=3)%P
hold on
plot(ax1,y(end-181,2*p.xgrid+1:end),-p.z,'black',LineWidth=3)%D
hold off
xlabel('Concentration (mmol N m^-^3)')
ylabel('Depth (m)',FontSize=20)
xlim([0 0.2])
ax1.XAxisLocation = 'bottom';
set(gca,FontSize=20)
grid on

ax2 = axes(tl1);
plot(ax2,p.An.*y(end-180,p.xgrid+1:2*p.xgrid)./(p.An.*y(end-180,p.xgrid+1:2*p.xgrid)+p.pmax),-p.z,'--',LineWidth=2)
hold on
plot(ax2,p.Al.*calculatelight(y(end-180,1:p.xgrid)',y(end-180,2*p.xgrid+1:end)',9125-179,p,season)./(p.Al.*calculatelight(y(end-180,1:p.xgrid)',y(end-180,2*p.xgrid+1:end)',9125-179,p,season)+p.pmax),-p.z,'--r',LineWidth=2)
hold off
xlim([0 1])
ax2.XAxisLocation = 'top';
ax2.YAxisLocation = 'right';
ax2.Color = 'none';
xlabel('Resource limitation')

set(gca,FontSize=20)

%% day9125
figure(3)
tl2=tiledlayout(1,1);

ax3 = axes(tl2);
plot(ax3,y(end,1:p.xgrid),-p.z,'g',LineWidth=3)%P
hold on
plot(ax3,y(end,2*p.xgrid+1:end),-p.z,'black',LineWidth=3)%D
hold off
xlabel('Concentration (mmol N m^-^3)')
ylabel('Depth (m)',FontSize=20)
xlim([0 0.2])
ax3.XAxisLocation = 'bottom';
set(gca,FontSize=20)
grid on

ax4 = axes(tl2);
plot(ax4,p.An.*y(end,p.xgrid+1:2*p.xgrid)./(p.An.*y(end,p.xgrid+1:2*p.xgrid)+p.pmax),-p.z,'--',LineWidth=2)
hold on
plot(ax4,p.Al.*calculatelight(y(end,1:p.xgrid)',y(end,2*p.xgrid+1:end)',9125,p,season)./(p.Al.*calculatelight(y(end,1:p.xgrid)',y(end,2*p.xgrid+1:end)',9125,p,season)+p.pmax),-p.z,'--r',LineWidth=2)
hold off
xlim([0 1])

ax4.XAxisLocation = 'top';
ax4.YAxisLocation = 'right';
ax4.Color = 'none';
xlabel('Resource limitation')

set(gca,FontSize=20)
%% incident light intensity change
figure(4)
plot([0:365],p.Iin.*(0.2*sin(2*pi*[0:365]/365-pi/2)+0.8),'black',LineWidth=3);
xlim([0 365])
xticks([0 365/12 2*365/12 3*365/12 4*365/12 5*365/12 6*365/12 7*365/12 8*365/12 9*365/12 10*365/12 11*365/12 365]);
xticklabels({'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'});
xlabel('Month')
ylabel('Light intensity (W m^-^2)')
title('Seasonal change of incident light intensity ')
set(gca,FontSize=20)
end

end
