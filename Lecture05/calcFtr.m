function [Ftr, K, fi, om] = calcFtr(fun, om1, om2, Nom, T0, Tend)
%CALCFTR Calculate Fourier-transform amplitude and phase
om = logspace(log10(om1), log10(om2), Nom);
  for id=1:length(om)
    omv = om(id);
    Ftr(id) = integral(@(t) fun(t).*exp(-j*omv*t), T0, Tend );
  end
K = abs(Ftr);
fi = angle(Ftr);
end
