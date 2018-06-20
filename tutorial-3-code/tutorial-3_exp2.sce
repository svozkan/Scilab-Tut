// This Code has been written by Salih Volkan ÖZKAN for Scilab Tutorials
function xdot = f(t,x,force)
    xdot = A*x + B*force
endfunction
m = 1;
k = 1;
b = 0.2;
force = 1;
A = [0 1; -k/m -b/m];
B = [0; 1/m];
C = [1 0];
x0 = [0;0];
t0 = 0;
t = [0:0.1:15];
x = ode(x0,t0,t,f);
y = C*x;
plot(t,y)
