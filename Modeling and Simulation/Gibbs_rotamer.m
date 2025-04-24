function config_fracs = Gibbs_rotamer(n,r,E)
    % for changing the states randomly
    states = zeros(1,n);
    % resulting fractions corresponding to each amino acid 
    config_counts = zeros(1,n);
    
    for i = 1:r
        xi = randi(n);
        %xi is now the ith amino acid
        %we develop two states corresponding to its value 0 and 1.
        states0 = states;
        states0(xi) = 0;
        states1 = states;
        states1(xi) = 1;
        %assign the state according to random sampling
        states(xi) = randomly_sample(states0,states1,E,n);
        %fancy matlab function to map states vector and config_counts 
        %vector to increase the values for all the states that have been 
        %found to be in zero rotamer state in the current state of AAs.
        config_counts(states == 0) = config_counts(states == 0) + 1;
    end
    config_fracs = rdivide(config_counts,r);
end

function value = randomly_sample(s0,s1,E,n)
    ps0 = get_probability(n,s0,E);
    ps1 = get_probability(n,s1,E);
    cond_prob = ps0/(ps0+ps1);
    %we sample value from the uniform distribution
    %and look for the correspoding state in the CDF.
    U01 = rand;
    value = 1;
    if U01 < cond_prob
        value = 0;
    end
end

function prob = get_probability(n,states,E)
    G = 0;
    % loop to sum over the e(i,j,b,c) for calculating G.
    for i = 1:n
        % i signifies the amino acid at the position i
        for j = i:n
            % loop to move through all the remaining states
            indices = num2cell(get_index(states,i,j));
            [ind_x, ind_y] = indices{:};
            G = G + E(ind_x,ind_y);
        end
    end
    prob = exp(-G);
end

%index assignment as per the given directions in the question
function indices = get_index(states,i,j) 
    ind_x = 2*i;
    ind_y = 2*j;
    
    if states(i) == 0
        ind_x = ind_x-1;
    end
    if states(j) == 0
        ind_y = ind_y-1;
    end
    indices = [ind_x, ind_y];
end