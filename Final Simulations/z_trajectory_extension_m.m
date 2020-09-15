% z movement code 
clear all;
clc
format compact

smc = 0;
w_lim = 6000;
t_stop = 250;
t_step = 0.0001;

b = 9.13e-5;
m = 0.93;
cos_phi_max = 1;
cos_theta_max = 1;
f_phi = 2;
f_theta = 2;
g = 9.81;
rpm1 = 1946; 
rpm2 = 1946;
rpm3 = 1946;
rpm4 = 1946;
w1 = 2*pi*rpm1/60;
w2 = 2*pi*rpm2/60;
w3 = 2*pi*rpm3/60;
w4 = 2*pi*rpm4/60;
k = (b/m)*(w1*w1+w2*w2+w3*w3+w4*w4)
w = (g*m/(4*b))^(0.5)
rpm = w*60/(2*pi)


z_ref = 15; %15; %15;
% Ux = 5;
% Uy = 5;
theta_ref = 30*3.142/180;
phi_ref = 30*3.142/180; %2*3.142/180;
psi_ref= 20*3.142/180; % 2*3.142/180;
xref = 5;
yref = 15;

Kp_z = 22.1;
Ki_z = 0.4;
Kd_z = 40.7;

Kp_phi = 90.0;
Ki_phi = 0.001;
Kd_phi = 20.5;

Kp_theta = 90.0;
Ki_theta = 0.001;
Kd_theta = 20.5;

Kp_psi = 50;
Ki_psi = 0.001; 
Kd_psi = 20;     

Kp_x = 0.5005;
Ki_x = 0.00;
Kd_x = 0.5005;

Kp_y = 0.5005;
Ki_y = 0.00;
Kd_y = 0.5005;

k3_pid = 5;
k4_pid = 5;
k5_pid = 5;
k6_pid = 5;

% Kp_v = 20;
% Ki_v = 0;
% Kd_v = 0;

bias = 0;
Ixx = 0.047;
Iyy = 0.047;
Izz = 0.094;
%ct = 0.0984;
%cm = 0.00679;
ct = 1.471e-7;
cm = 2.582e-9;
L = 0.225;
b = 10e-6;
d = 0.3e-6;
O = 0.283;

z_inti = 0;
theta_init = 0;
psi_init = 0;
phi_init = 0;

%%% For sliding mode control
a3 = 0.9;
a1 = 0.8;
a2 = 0.8;
a4 = 7;
a5 = 7;
a6 = 5;

k3 = 2.78;
k1 = 1.98;
k2 = 1.98;
k4 = 5.25;
k5 = 5.25;
k6 = 2.75;

l3 = 1.25;
l2 = 0.9; 
l1 = 0.9;
l4 = 3.5;
l5 = 3.5;
l6 = 1.8;

Ix = Ixx;
Iy = Iyy;
Iz = Izz;

tau_att  = 2;
tau_att_1 = 2;  
tau_p = 2;
disturbance = 0.1;
fd = 50/(2*pi);
% sim('z_trajectory_extension_v1.slx')