// This Code has been written by Salih Volkan ÖZKAN for Scilab Tutorials
// Take the inputs from user
function x1 = SRK4(dt,time,x1,force,mass,k,b)
   k1 = ODES(time,x1,force,mass,k,b)
   dt2 = 0.5*dt
   x1_temp = x1 + dt2*k1
   k2 = ODES(time+dt2,x1_temp,force,mass,k,b)
   x1_temp = x1 + dt2*k2
   k3 = ODES(time+dt2,x1_temp,force,mass,k,b)
   x1_temp = x1 + dt*k3
   k4 = ODES(time+dt,x1_temp,force,mass,k,b)
   for n = 1:2
       phi = (k1(n) + 2*(k2(n)+k3(n))+ k4(n))/6
       x1(n) = x1(n) + dt*phi
   end
endfunction

function k1 = ODES(time,x1,force,mass,k,b)
    k1(1) = x1(2)
    k1(2) = force/mass-b/mass*x1(2)-k/mass*x1(1)
endfunction

dt = input('Step Time : ')
tmax = input('Final Time : ')

// Set Initial Conditions
time = 0;
x1 = [0;0]
force = 1;
mass = 1;
k = 1;
b = 0.2;

// Solution Loop
i = 1;
while (time < tmax)
    x1 = SRK4(dt,time,x1,force,mass,k,b)
    y = [1 0]*x1; 
    x11(i) = y
    time1(i) = time;
    i = i + 1;
    time = time + dt
end
plot2d(time1,x11)
