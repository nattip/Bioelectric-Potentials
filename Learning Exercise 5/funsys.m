function Fv = funsys(t, Y);

    g_nabar = 120;       % given constants
    g_kbar = 36;
    g_lbar = 0.3;
    c_m = 1;
    v_na = 115;
    v_k = -12;
    v_l = 10.6;
     
    V = 0;      % voltage to calculate rates with
    I = 0;      % current

    a_n = (0.01 * (10 - V)) / (exp((10 - V) / 10) - 1);      % calculated rate constants
    b_n = 0.125 * exp(-V / 80);
    a_m = (0.1 * (25 - V)) / (exp((25 - V) / 10) - 1);
    b_m = 4 * exp(-V / 18);
    a_h = 0.07 * exp(-V / 20);
    b_h = 1 / (exp((30 - V) / 10) + 1);

    Fv(1,1) = (I - g_nabar * Y(3)^3 * Y(4) * (Y(1) - v_na) - g_kbar * Y(2)^4 * (Y(1) - v_k) - g_lbar * (Y(1) - v_l)) / c_m;  % system of DEs
    Fv(2,1) = a_n * (1 - Y(2)) - b_n * Y(2);
    Fv(3,1) = a_m  * (1 - Y(3)) - b_m * Y(3);
    Fv(4,1) = a_h * (1 - Y(4)) - b_h * Y(4);

