function lcs = BarCode(n,seq_list,k)
tablelist = {};
seq = seq_list{1};
for i = 1:n
    seq2 = seq_list{i};
    tablelist{i} = CreateKmerTable(k,seq2);
end
kmers_s1_list = get_s1_kmers(seq,k);
common_kmers = find_common_kmers(kmers_s1_list,tablelist,n);
indices_list = combine_indices(common_kmers);
[start,stop] = find_lcs(indices_list);
lcs = seq(start:stop+k-1);
end

function [start,stop] = find_lcs(indices)
ind = [1];
for i = 1:(length(indices)-1)
    if (indices(i+1)-indices(i) > 1)
        ind(length(ind)+1) = i+1;
    end
end
ind(length(ind)+1) = length(indices)+1;
ll = [];
for i=1:length(ind)-1
    ll(i) = ind(i+1)-ind(i)-1;
end
[M,I] = max(ll);
start = indices(I);
stop = indices(ind(I+1)-1);
end

function indices = combine_indices(common_kmers)
ci = [];
kmers = common_kmers.keys;
for i = 1:length(kmers)
    ci = [ci common_kmers(kmers{i})];
end
indices = sort(ci);
end

function kmers = get_s1_kmers(s1,k)
kmers = {};
for i = 1:(length(s1)-k+1)
    kmers{length(kmers)+1} = s1(i:(i+k-1));
end
end

function common_kmers = find_common_kmers(kmer_list,tablelist,n)
common_kmers = containers.Map;
for i = 1:length(kmer_list)
    kmer = kmer_list{i};
    if is_common_kmer(kmer,tablelist,n)
        if common_kmers.isKey(kmer)
            li = common_kmers(kmer);
            len = length(li);
            li(len+1) = i;
            common_kmers(kmer) = li;
        else
            common_kmers(kmer) = [i];
        end
    end
end
end

function indices_list = LookupKmer(kmer, table)
if table.isKey(kmer) == 1
    indices_list = table(kmer);
else
    indices_list = [];
end
end

function answer = is_common_kmer(kmer,tables,n)
answer = 1;
for i = 2:n
    if isempty(LookupKmer(kmer,tables{i}))
        answer = 0;
    end
end
end

function kmertable = CreateKmerTable(k,seq)
kmertable = containers.Map;
for i=1:(length(seq)-k+1)
    if kmertable.isKey(seq(i:i+k-1))
        li = kmertable(seq(i:i+k-1));
        len = length(li);
        li(len+1) = i;
        kmertable(seq(i:i+k-1)) = li;
    else
        kmertable(seq(i:i+k-1)) = [i];
    end
end
end