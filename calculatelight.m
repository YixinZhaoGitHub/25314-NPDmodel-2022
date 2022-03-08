%% light function
%
function I = calculatelight(P,D,t,p,season)

         int=(cumsum((P+D).*p.dz)) * p.k;

 switch season
     case false %constant environmental conditions
         I=p.Iin.*exp(-int-p.Kbg.*p.z');
     case true %seasonal forcing
         I=p.Iin.*(0.2*sin(2*pi*t/365-pi/2)+0.8).*exp(-int-p.Kbg.*p.z');
 end
  
end