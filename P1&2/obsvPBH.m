% obsvPBH(A,C);
% Uses the PBH test to test for observability of (A,C)

function ctrbPBH(A,C);
[nA,mA]=size(A);
[nC,mC]=size(C);
if (nA ~= mA) | (mC ~= nA)
    error('Bad matrix dimensions')
end
n = nA;
E = eig(A);
for k = 1:n
  lambda = E(k);
  if rank([A-lambda*eye(n); C]) == n
    disp(sprintf('eigenvalue (%+f) + (%+f)i:  observable',real(lambda),imag(lambda)))
  else
    disp(sprintf('eigenvalue (%+f) + (%+f)i:  unobservable',real(lambda),imag(lambda)))
  end
end