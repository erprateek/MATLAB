function output = LVModel(a,b,c,d, M,N,T)
    Mv = [M];
    Nv = [N];
    Tv = [1];
    index = 1;
    t = 0;
    for i = 1:T
        tmplus = exprnd(a*M);
        tmminus = exprnd(b*M*N);
        tnplus = exprnd(c*M*N);
        tnminus = exprnd(d*N);
        tarray = [tmplus, tmminus, tnplus, tnminus];
        tmax = max(tarray);
        if (M~=0 && N~=0)
            if tmax == tmplus
                M = M+1;
            elseif tmax == tmminus
                M = M-1;
            elseif tmax == tnminus
                N = N-1;
            else
                N = N+1;
            end          
        end
        
        if (M == 0 && N~=0)
            N = N - 1;
            tmax = tnminus;
        end
        if (M~=0 && N == 0)
            M = M+1;
            tmax = tmplus;
        end 
        t = t+tmax;
        index = index+1;
        Tv(index) = t;
        Mv(index) = M;
        Nv(index) = N;
        fprintf('t = %.3f, M = %.3f, N = %.3f  \n', t, M, N);
        % output = sprintf('%d, %d, %d', t,M,N);
    end
    graph = plot(Tv, Mv, 'b', Tv, Nv,'r');
    xlabel('Time');
    ylabel('Size of populations, M and N');
    title('Lotka Volterra plot for Predator-Prey populations');
    legend(graph, 'Prey', 'Predators');
end