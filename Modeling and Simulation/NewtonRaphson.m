function solution = NewtonRaphson(filename)
    M = csvread(filename);
    k1 = M(1);
    k2 = M(2);
    da = M(3);
    db = M(4);
    r = M(5);
    n = M(6);
    t = M(7:n+6)';
    A = M(n+13:(2*n+12))';
    a = k1/(k1+k2);
    b = -(k1+k2);
    for i = 1:r
        Gradient = get_Gradient(a,b,A,t);
        Hessian = get_Hessian(Gradient,A,t,a,b,da,db);
        U = linsolve(Hessian,Gradient);
        a = a-U(1,1);
        b = b-U(2,1);
    end
    k1 = -a*b;
    k2 = a*b - b;
    solution = sprintf('K1 = %d, K2 = %d',k1,k2);
    %disp(solution);
end

function gradient = get_Gradient(a,b,A,t)
    grad_a = 2*(A-(1-a)-a*exp(b*t))'*(1-exp(b*t));
    grad_b = -2*(A-(1-a)-a*exp(b*t))'*(a*t.*exp(b*t));
    gradient = [grad_a; grad_b];
end

function hessian = get_Hessian(Gradient,A,t,a,b,da,db)
    hessian = [];
    a2 = 2*(A-(1-(a+da))-(a+da)*exp(b*t))'*(1-exp(b*t));
    b2 = -2*(A-(1-a)-a*exp((b+db)*t))'*(a*t.*exp((b+db)*t));
    ab = 2*(A-(1-a)-a*exp((b+db)*t))'*(1-exp((b+db)*t));
    ba = -2*(A-(1-(a+da))-(a+da)*exp(b*t))'*((a+da)*t.*exp(b*t));
    hessian(1,1) = (a2 - Gradient(1))/da;
    hessian(1,2) = (ab - Gradient(1))/db;
    hessian(2,1) = (ba - Gradient(2))/da;
    hessian(2,2) = (b2 - Gradient(2))/db;
end