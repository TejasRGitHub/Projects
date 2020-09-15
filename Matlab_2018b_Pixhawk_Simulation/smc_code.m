int xd ;
int yd;
int zd;
int phid;
int thetad;
int psid;
 
t = 0.004;   %Updated time step to the base rate of model
% Above are the desired values to be taken as input from the user
% Take all the current values from the gps and gyro etc
% variables xd_dot are desired rate of changes in the setpoint. Current we
% set it as zero
% calculate cos of theta and phi
% Assign all the values from a1 to a6, k1 to k6 and l1 to l6
% Define constants like ct, cm and L

% Values of phid and thetad will be iteratively modified based on ux and uy
% values 
% Thus phid and thetad will be non zero and will have to be calculated

% set phid and thetad as zero initially (please calculate its derivative
% somewhere, i cant figure out where to calcualte it

s1 = (x-xprev)/t - xd_dot + a1*(x-xd); % t is timestep
s2 = (y-yprev)/t - yd_dot + a2*(y-yd);
s3 = (z-zprev)/t - zd_dot + a3*(z-zd);
s4 = (phi-phiprev)/t - phid_dot + a4*(phi-phid);
s5 = (theta-thetaprev)/t - thetad_dot + a5*(theta-thetad);
s6 = (psi-psiprev)/t - psid_dot + a6*(psi-psid);

if s1 > 0 
    sign_s1 = 1;
else
    sign_s1 = -1;
end

if s2 > 0 
    sign_s2 = 1;
else
    sign_s2 = -1;
end

if s3 > 0 
    sign_s3 = 1;
else
    sign_s3 = -1;
end

if s4 > 0 
    sign_s4 = 1;
else
    sign_s4 = -1;
end

if s5 > 0 
    sign_s5 = 1;
else
    sign_s5 = -1;
end

if s6 > 0 
    sign_s6 = 1;
else
    sign_s6 = -1;
end

u4 = (m*g/(cos_phi * cos_theta))*(zd_dot_dot - a3*((z-zprev)/t - zd_dot) - k3*sign_s3 - l3*s3);
ux = (m/u4)*(xd_dot_dot - a1*((x-xprev)/t - xd_dot) - k1*sign_s1 - l1*s1);
uy = (m/u4)*(yd_dot_dot - a2*((y-yprev)/t - yd_dot) - k2*sign_s2 - l2*s2);
u1 = Ix * (phid_dot_dot - a4*((phi-phiprev)/t - phid_dot) - k4*sign_s4 - l4*s4 - ((Iy-Iz)/Ix)*((theta-thetaprev)/t)*(psi-psiprev)/t);
u2 = Iy * (thetad_dot_dot - a5*((theta-thetaprev)/t - thetad_dot) - k5*sign_s5 - l5*s5 - ((Iz-Ix)/Iy)*((phi-phiprev)/t)*(psi-psiprev)/t);
u3 = Iz * (psid_dot_dot - a6*((psi-psiprev)/t - psid_dot) - k6*sign_s6 - l6*s6 - ((Ix-Iy)/Iz)*((phi-phiprev)/t)*(theta-thetaprev)/t);

phidprev = phidrecent; % assign initial values of both   equal to zero
thetadprev = thetadrecent; % assign initial values of both   equal to zero

phid_dotprev = phid_dot; % assign initial values of both   equal to zero
thetad_dotprev = thetad_dot; % assign initial values of both   equal to zero

% calculate sine and cosines here
% and take sine inverse
phid = arc_sine(sin_psi * ux + cos_psi * uy);
thetad = arc_sine((cos_psi * ux + sin_psi * uy)/cos_phid);
phidrecent = phid;
thetadrecent = thetad;

phid_dot = (phidrecent - phidprev)/t;
thetad_dot = (thetadrecent - thetadprev)/t;

phid_dot_dot = (phid_dot - phid_dotprev)/t;
thetad_dot_dot = (thetad_dot - thetad_dotprev)/t;


% Finding square of speed of motors from the thrusts
w1_sq = u4/(4*ct) - u3/(4*cm) - u2/(2*L*ct);
w2_sq = u4/(4*ct) + u3/(4*cm) - u1/(2*L*ct);
w3_sq = u4/(4*ct) - u3/(4*cm) + u2/(2*L*ct);
w4_sq = u4/(4*ct) + u3/(4*cm) + u1/(2*L*ct);

% Take square root and convert to pwm


