function answer = EMallelepair(L,e,r,M)
    models = ['AA';'AC';'AG';'AT';'CG';'CC';'CT';'GG';'GT';'TT'];
    num_models = length(models);
    %For L sites given
    for i = 1:L
        counts = [M(1,i) M(2,i) M(3,i) M(4,i)];
        total_all = sum(M,1);
        num_reads = total_all(i);
        p_geno_data = zeros(10,1);
        p_data_geno = zeros(10,1);
        %Runnning r rounds of EM for each site.
        for j = 1:r
            for k = 1:num_models
                p_data_geno(k) = get_p_data_geno(counts, e, models(k,1),models(k,2));
            end
            %The following scaling of values is done to avoid underflow.
            %Reference: http://u.cs.biu.ac.il/~shey/919-2011/index.files/underflow%20and%20smoothing%20in%20EM.pdf
            %Scaling to prevent underflow
            [max_pdg,max_ind] = max(p_data_geno);
            p_data_geno = p_data_geno - max_pdg;
            for k = 1:num_models
                if p_data_geno(k) < -10
                    p_data_geno(k) = 0;
                else
                    p_data_geno(k) = exp(p_data_geno(k));
                end
            end
            %Normalizing factor
            Z = sum(p_data_geno,1);
            p_geno_data = p_data_geno/Z;
            counts = zeros(4,1)';
            for k = 1:num_models
                %Getting expected and replacing with counts for reusage in
                %the loop but with updated values.
                allele1 = models(k,1);
                allele2 = models(k,2);
                exp_counts = get_exp_counts(num_reads,allele1,allele2);
                counts = counts + p_geno_data(k)*exp_counts;
            end
        end
        [max_pgd,maxim] = max(p_geno_data);
        fprintf('Position #%d: Probability: %.4f Genotype: %c%c \n', i, max_pgd,models(maxim,1),models(maxim,2));
    end
end

function c = get_exp_counts(ct,a1,a2)
    gt = [a1 a2];
    c = zeros(4,1)';
    for i = 1:2
        if gt(i) == 'A'
            c = c + [ct*.5 0 0 0];
        elseif gt(i) == 'C'
            c = c + [0 ct*.5 0 0];
        elseif gt(i) == 'G'
            c = c + [0 0 ct*.5 0];
        elseif gt(i) == 'T'
            c = c + [0 0 0 ct*.5];
        end
    end
end

function answer = get_p_data_geno(counts, e, genotype_1, genotype_2 )
    answer= 0;
    nucs = 'ACGT';
    for i = 1:4
        if nucs(i) == genotype_1
            p1 = 1 - (3*e);
        else
            p1 = e;
        end
        if nucs(i) == genotype_2
            p2 = 1-(3*e);
        else
            p2 = e;
        end
        answer = answer + counts(i) * log((p1 + p2)/2);
    end
end