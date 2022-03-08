%
% NPDmodel for constant environmental conditions / seasonal forcing.
%
% Input:season  true/flase   run with/without seasonal forcing
% Please see below
%
function baserunNPD(season)

arguments
season=false; % true=seasonal forcing   see "calculatelight" function
end

%-------------------------- parameters ----------------------------
%
p.D = 4; % diffusivity m2/day
p.v = 16; % advection velocity m/d 1.008
% water column
p.Zm=500; % depth
p.dz = 1; % grid cell size
p.z = (0+p.dz/2):p.dz:(p.Zm-p.dz/2); %grid vector
p.xgrid=length(p.z); % grid cell number
%
p.Iin = 200;  %incident light intensity   W/m2
p.k = 0.05; %light attenuation m2 (mmol N)-1
p.Kbg = 0.0375;  % background turbidity m-1
p.pmax=0.7; % maximal specific production rate   day-1
p.l = 0.03; % intrinsic loss rate d-1
p.Hl=7; % half-saturation light   W/m2
p.Al= p.pmax/p.Hl  ;     % affinity of light [day-1]/[W/m2]
p.Hn=0.3; %  half-saturation nutrient       mmol N m-3
p.An= p.pmax/p.Hn  ;     % affinity of nutrient
p.tau= 0.1; % remineralization coefficient   d-1
p.gamma= 1.5;  %loss by zooplankton  m3 (mmol N)-1 d-1
p.NB=30; % Nutrient concentration at bottom     mmol N/m3

% initial value
P= 0*p.z+0.001; %  mmol N/m3
N= 0*p.z+10; %nutrient/  mmol N/m3
D= 0*p.z; %detritus/  mmol N/m3

t=[0:365*25];
%-----------------------------run----------------------------------

[t,y]=ode45(@derivative ,t,[P,N,D],[],p);

%------------------------- Plot result ------------------------------

         plotbaserunNPD(t,y,p,season);

     
%--------------------------derivative function----------------------
function dydt = derivative(t, y, p)

              i=2:p.xgrid;
              P=y(1:p.xgrid);
              N=y(p.xgrid+1:2*p.xgrid);
              D=y(2*p.xgrid+1:end);

     %diff P   
              
              Jdp(i) = -p.D*(P(i)-P(i-1))/p.dz;
              Jdp(1) = 0;             % boundary top
              Jdp(p.xgrid+1) = 0;     % boundary bottom
     
     %diff N
                 Jdn(i) = -p.D*(N(i)-N(i-1))/p.dz;
                 Jdn(1) = 0;             % boundary top
                 Jdn(p.xgrid+1) = -p.D*(p.NB-N(p.xgrid))/p.dz;     % boundary bottom
     %adv D
                 Jad(i)=p.v*D(i-1);
                 Jad(1) = 0;  % boundary top
                 Jad(p.xgrid+1) = p.v*D(p.xgrid); % bottom

     %diff D
                 Jdd(i)= -p.D*(D(i)-D(i-1))/p.dz;
                 Jdd(1)= 0; %top
                 Jdd(p.xgrid+1)= 0;   %bottom

      %assemble  
              JP = Jdp;
              JN = Jdn;
              JD = Jad+Jdd;


            dPdt = -(JP(2:p.xgrid+1)-JP(1:p.xgrid))/p.dz;
            dNdt = -(JN(2:p.xgrid+1)-JN(1:p.xgrid))/p.dz;
            dDdt = -(JD(2:p.xgrid+1)-JD(1:p.xgrid))/p.dz;
   %reaction
          
           % light
             I = calculatelight(P,D,t,p,season);
           % P growth rate
             
           g= p.pmax* (I.*p.Al./(p.pmax+I.*p.Al)) .* (N.*p.An./(p.pmax+N.*p.An) );
     
           dPdt= g.*P- p.l*P - p.gamma*P.^2  +dPdt'; % growth-loss intrinsic-loss zoo-J
           dNdt= -g.*P + p.tau.*D+ dNdt'; % -uptake+remineralization -J
           dDdt= p.l*P + p.gamma*P.^2 -p.tau.*D + dDdt'; % loss intrinsic+loss zoo -remineralization -J
           dydt=[dPdt;dNdt;dDdt];
end
end