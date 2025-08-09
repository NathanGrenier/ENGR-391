function error = richardson_error(h2, h1, w2, w1, q)
  factor = ((h1 / h2)^q) - 1;
  error = abs((w2 - w1) / factor);
end
