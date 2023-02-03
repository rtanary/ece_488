% ctrbPBH(A,B);
% Uses the PBH test to test for controllability of (A,B)

function ctrbPBH(A,B);
[nA,mA]=size(A);
[nB,mB]=size(B);
if (nA ~= mA) | (nB ~= nA)
    error('Bad matrix dimensions')
end
n = nA;
E = eig(A);
for k = 1:n
  lambda = E(k);
  if rank([A-lambda*eye(n) B]) == n
    disp(sprintf('eigenvalue (%+f) + (%+f)i:  controllable',real(lambda),imag(lambda)))
  else
    disp(sprintf('eigenvalue (%+f) + (%+f)i:  uncontrollable',real(lambda),imag(lambda)))
  end
end