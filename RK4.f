c------------------------------------------------------------------------
c  RK4 SOLVER for a system of ODEs                                      |
c  Course:  AE305                                                       |
c  Instructor: Ismail H. TUNCER                                         |
c------------------------------------------------------------------------
      program sysRK4
      parameter (neq=4)
      real y1(neq)
      character*40 fname

c..read the input data
      print*,' '
      print*,' Enter the Timestep,Finaltime :>'
      read(*,*) dt,tmax

c..open the output file
      print*,'  Enter the output file name [solution.dat]:'
      read(*,'(a)') fname
      if( fname .eq. ' ') fname = 'solution.dat'
      open(1,file=fname,form='formatted')

c..set the initial conditions
      time =  0.
      y1(1) = 0.1
      y1(2) = 0.
      y1(3) = 0.
      y1(4) = 0.
      write(1,'(6E15.7)') time,(y1(n),n=1,neq)

c..solution loop
      DO WHILE (time.lt.tmax)
        call SRK4(dt,time,y1)
        time = time + dt
        write(1,'(6E15.7)') time,(y1(n),n=1,neq)
      ENDDO

      close(1)
      stop
      end

c------------------------------------------------------------------------
       subroutine SRK4(dt,t1,y1)
       parameter (neq=4)
       real y1(neq),ytemp(neq),k1(neq),k2(neq),k3(neq),k4(neq)

       call ODES(t1,y1,k1)
       dt2 = 0.5*dt
       do n = 1,neq
         ytemp(n)  = y1(n) + dt2*k1(n)
       enddo
       call ODES(t1+dt2,ytemp,k2)
       do n = 1,neq
          ytemp(n) = y1(n) + dt2*k2(n)
       enddo
       call ODES (t1+dt2,ytemp,k3)
       do n = 1,neq
          ytemp(n) = y1(n) +  dt*k3(n)
       enddo
       call ODES (t1+dt,ytemp,k4)

c..obtain the solution at t1+dt and update y1 for the next step
       do n = 1,neq
          phi   = (k1(n) + 2*(k2(n)+k3(n)) + k4(n))/6.
          y1(n) = y1(n) + dt*phi
       enddo

       return
       end

c------------------------------------------------------------------------
       subroutine ODES(t,y,f)
       parameter (neq=4)
       real y(neq),f(neq)

c..define the ODE's/return the slopes in "f" array
       f(1) = y(2)
       f(2) =-(2*0*y(3)+2*2*y(1)-0.25*10*0.5*y(3))/(10*(2-10*0.0625))
       f(3) = y(4)
       f(4) = (0*y(3)*0.25+0.25*2*y(1)-0.5*y(3))/(2-10*(0.0625))

       return
       end
