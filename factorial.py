def fac(a):
    return a * fac(a-1) if a > 1 else 1
