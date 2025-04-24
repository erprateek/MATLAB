function answer = Zombie_sim(H0, Z0, L1, L2, dH, dZ, T, s, m, n)
    %COncentration at center  = Z0*m*n
    %position of Zombies = m/2 and n/2
    H_conc = H0*ones(m,n);
    Z_conc = zeros(m,n);
    Z_conc(floor(m/2),floor(n/2)) = Z0*m*n;
    dT = T/s;
    dX = 1/m;
    dY = 1/n;
    Z_tab_half = zeros(m,n);
    H_tab_half = ones(m,n);
        
    for i = 1:s
        for x = 2:m-1
            for y = 2:n-1
                H = H_conc(x,y);
                Z = Z_conc(x,y);
                H_tab_half(x,y) = max(0, H - (dT/2)*((L1*H*Z)/(H+Z)) + dH*(dT/2)*(((H_conc(x+1,y)+H_conc(x-1,y)-2*H)/(dX^2))+((H_conc(x,y+1)+H_conc(x,y-1)-2*H)/dY^2)));
                Z_tab_half(x,y) = max(0, Z + (dT/2)*(((L1-L2)*H*Z)/(H+Z)) + dZ*(dT/2)*(((Z_conc(x+1,y)+Z_conc(x-1,y)-2*Z)/(dX^2))+((Z_conc(x,y+1)+Z_conc(x,y-1)-2*Z)/dY^2)));
            end
        end
        H_Hn = H_tab_half;
        H_Zn = Z_tab_half;
        for x = 2:m-1
            for y = 2:n-1
                H1 = H_conc(x,y);
                Z1 = Z_conc(x,y);
                H2 = H_Hn(x,y);
                Z2 = H_Zn(x,y);
                H_conc(x,y) = max(0, H1 - dT*((L1*H2*Z2)/(H2+Z2)) + dH*dT*(((H_Hn(x+1,y)+H_Hn(x-1,y)-2*H2)/(dX^2))+((H_Hn(x,y+1)+H_Hn(x,y-1)-2*H2)/dY^2)));
                Z_conc(x,y) = max(0, Z1 + dT*(((L1-L2)*H2*Z2)/(H2+Z2)) + dZ*dT*(((H_Zn(x+1,y)+H_Zn(x-1,y)-2*Z2)/(dX^2))+((H_Zn(x,y+1)+H_Zn(x,y-1)-2*Z2)/dY^2)));

            end
        end
        t = i*dT;
        H_avg = mean(H_conc(:));
        Z_avg = mean(Z_conc(:));
        fprintf('t = %.3f, H_avg = %.3f, Z_avg = %.3f  \n', t, H_avg, Z_avg);
        T(i) = t;
        Zz(i) = Z_avg;
    end
    graph = plot(T,Zz);
    xlabel('Time');
    ylabel('Avg Zombie Concentration');
    title('Zombie infection plot');
end