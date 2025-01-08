% tests dc line with costs
% tests generator and dc line voltage setpoint warnings

function mpc = case32
mpc.version = '2';
mpc.baseMVA = 100.0;

%% bus data
%	bus_i       type     Pd       Qd       Gs         Bs         area        Vm        Va       baseKV      zone     Vmax      Vmin
mpc.bus = [
	1011	     1	      0        0        0         0	          1	       1.0618     -6.65	    130.0	     1       1.1        0.9;
    1012	     1	      0        0        0         0	          1	       1.0634     -3.1	    130.0	     1       1.1        0.9;
    1013	     1	      0        0        0         0	          1	       1.0548     1.26	    130.0	     1       1.1        0.9;
    1014	     1	      0        0        0         0	          1	       1.0611     4.26	    130.0	     1       1.1        0.9;
    1021	     1	      0        0        0         0	          1	       1.0311     2.64	    130.0	     1       1.1        0.9;
    1022	     1	      0        0        0        50  	      1	       1.0512     -19.05    130.0	     1       1.1        0.9;
    1041	     1	      0        0        0        250         1        1.0124     -81.87	    130.0	     1       1.1        0.9;
    1042	     1	      0        0        0        0            1        1.0145     -67.38	130.0	     1       1.1        0.9;
    1043	     1	      0        0        0        200         1        1.0274     -76.77    130.0	     1       1.1        0.9;
    1044	     1	      0        0        0        200         1        1.0066     -67.71    130.0	     1       1.1        0.9;
    1045	     1	      0        0        0        200         1        1.0111     -71.66    130.0	     1       1.1        0.9;
    2031	     1	      0        0        0        0            1        1.0279     -36.66    220.0	     1       1.1        0.9;
    2032	     1	      0        0        0        0            1        1.0695     -23.92    220.0	     1       1.1        0.9;
    4011	     1	      0        0        0        0            1        1.0224     -7.55	    400.0	     1       1.1        0.9;
    4012	     1	      0        0        0        -100          1        1.0235     -5.54	    400.0	     1       1.1        0.9;
    4021	     1	      0        0        0        0            1        1.0488     -36.08    400.0	     1       1.1        0.9;
    4022	     1	      0        0        0        0            1        0.9947     -20.86	400.0	     1       1.1        0.9;
    4031	     1	      0        0        0        0            1        1.0367     -39.46	400.0	     1       1.1        0.9;
    4032	     1	      0        0        0        0            1        1.0487     -44.54    400.0	     1       1.1        0.9;
    4041	     1	      0        0        0        200         1        1.0506     -54.3     400.0	     1       1.1        0.9;
    4042	     1	      0        0        0        0            1        1.0428     -57.37	400.0	     1       1.1        0.9;
    4043	     1	      0        0        0        200         1       1.0370      -63.51	400.0	     1       1.1        0.9;
    4044	     1	      0        0        0        0            1        1.0395     -64.23	400.0	     1       1.1        0.9;
    4045	     1	      0        0        0        0            1        1.0533     -68.88    400.0	     1       1.1        0.9;
    4046	     1	      0        0        0        100         1        1.0357     -64.11	400.0	     1       1.1        0.9;
    4047	     1	      0        0        0        0            1        1.059      -59.55	400.0	     1       1.1        0.9;
    4051	     1	      0        0        0        100         1        1.0659     -71.01	400.0	     1       1.1        0.9;
    4061	     1	      0        0        0        0            1        1.0387     -57.93    400.0	     1       1.1        0.9;
    4062	     1	      0        0        0        0            1        1.056      -54.36	400.0	     1       1.1        0.9;
    4063	     1	      0        0        0        0            1        1.0536     -50.68	400.0	     1       1.1        0.9;
    4071	     1	      0        0        0        -400          1        1.0484     -4.99	    400.0	     1       1.1        0.9;
    4072	     1	      0        0        0         0	          1	       1.059      -3.98	    400.0	     1       1.1        0.9;        
    501          2	      0        0        0         0	          1        1.0684     2.59	    15.0	     1       1.1        0.9;
    502          2	      0        0        0         0	          1        1.0565     5.12	    15.0	     1       1.1        0.9;
    503          2	      0        0        0         0	          1        1.0595     10.27	    15.0	     1       1.1        0.9;  
    504          2	      0        0        0         0	          1        1.0339     8.03	    15.0	     1       1.1        0.9; 
    505          2	      0        0        0         0	          1        1.0294     -12.36    15.0	     1       1.1        0.9; 
    506          2	      0        0        0         0	          1        1.0084     -59.42	15.0	     1       1.1        0.9; 
    507          2	      0        0        0         0	          1        1.0141     -68.95	15.0	     1       1.1        0.9; 
    508          2	      0        0        0         0	          1        1.0498     -16.81	15.0	     1       1.1        0.9; 
    509          2	      0        0        0         0	          1        0.9988     -1.63	    15.0	     1       1.1        0.9; 
    510          2	      0        0        0         0	          1        1.0157     0.99	    15.0	     1       1.1        0.9; 
    511          2	      0        0        0         0	          1        1.0211     -29.04	15.0	     1       1.1        0.9; 
    512          2	      0        0        0         0	          1        1.02       -31.88    15.0	     1       1.1        0.9; 
    513          2	      0        0        0         0	          1        1.017      -54.3	    15.0	     1       1.1        0.9; 
    514          2	      0        0        0         0	          1        1.0454     -49.9	    15.0	     1       1.1        0.9; 
    515          2	      0        0        0         0	          1        1.0455     -52.19	15.0	     1       1.1        0.9; 
    516          2	      0        0        0         0	          1        1.0531     -64.1	    15.0	     1       1.1        0.9; 
    517          2	      0        0        0         0	          1        1.0092     -46.85    15.0	     1       1.1        0.9; 
    518          2	      0        0        0         0	          1        1.0307     -43.32    15.0	     1       1.1        0.9; 
    519          2	      0        0        0         0	          1        1.03       0.03	    15.0	     1       1.1        0.9; 
    520          3	      0        0        0         0	          1        1.0185     0  	    15.0	     1       1.1        0.9;
    551          2	      0        0        0         0	          1        1.0531     -64.1	    15.0	     1       1.1        0.9;
    547          2	      0        0        0         0	          1        1.0455     -52.19	15.0	     1       1.1        0.9; 
    563          2	      0        0        0         0	          1        1.0307     -43.32    15.0	     1       1.1        0.9;
    1            1	     600     148.2      0         0    	      1	       0.9988     -84.71	20.0	     1       1.1        0.9;
    2            1	     330     71.0       0         0	          1	       1.0012     -70.49    20.0	     1       1.1        0.9;
    3            1	     260     83.8       0         0	          1	       0.9974     -79.97    20.0	     1       1.1        0.9;
    4            1	     840     252        0         0	          1	       0.9996     -70.67	20.0	     1       1.1        0.9;
    5            1	     720     190.4      0         0	          1	       0.9961     -74.59    20.0	     1       1.1        0.9;
    11           1	     200     68.8       0         0	          1	       1.0026     -9.45     20.0	     1       1.1        0.9;
    12           1	     300     83.8       0         0	          1	       0.9975	  -5.93     20.0	     1       1.1        0.9;
    13           1	     100     34.4       0         0	          1	       0.9957     -1.58	    20.0	     1       1.1        0.9;
    22           1	     280     79.9       0         0	          1	       0.9952     -21.89	20.0	     1       1.1        0.9;
    31           1	     100     24.7       0         0	          1	       1.0042     -39.47    20.0	     1       1.1        0.9;
    32           1	     200     39.6       0         0	          1	       0.9978     -26.77	20.0	     1       1.1        0.9;
    41           1	     540     131.4      0         0	          1	       0.9967     -57.14	20.0	     1       1.1        0.9;
    42           1	     400     127.4      0         0	          1	       0.9952     -60.22	20.0	     1       1.1        0.9;
    43           1	     900     254.6      0         0	          1	       1.0013     -66.33    20.0	     1       1.1        0.9;
    46           1	     700     211.8      0         0	          1	       0.999      -66.93    20.0	     1       1.1        0.9;
    47           1	     100     44.0       0         0	          1	       0.995      -62.38    20.0	     1       1.1        0.9;
    51           1	     800     258.2      0         0	          1	       0.9978     -73.84    20.0	     1       1.1        0.9;
    61           1	     500     122.5      0         0	          1	       0.9949     -60.78    20.0	     1       1.1        0.9;
    62           1	     300     83.8       0         0	          1	       1.0002     -57.18	20.0	     1       1.1        0.9;
    63           1	     590     264.6      0         0	          1	       0.9992     -53.49    20.0	     1       1.1        0.9;
    71           1	     300     83.8       0         0	          1	       1.0028     -7.8	    20.0	     1       1.1        0.9;
    72           1	     2000    396.1      0         0	          1	       0.9974     -6.83	    20.0	     1       1.1        0.9;
];

%% generator data
%	bus	    Pg	         Qg	        Qmax	      Qmin         Vg	       mBase	  status	 Pmax	  Pmin
mpc.gen = [
	501    600.0        58.3       800.0        -800.0	      1.0684       100.0	     1	     760.0	   0.0;
	502	   300.0        17.2       600.0        -600.0        1.0565       100.0         1       570.0     0.0;
	503	   550.0        20.9       700.0        -700.0        1.0595       100.0         1       665.0     0.0;
    504    400.0        30.4       600.0        -600.0        1.0339       100.0         1       570.0     0.0;
    505    200.0        60.1       250.0        -250.0        1.0294       100.0         1       237.5     0.0;
    506    360.0        138.6      400.0        -400.0        1.0084       100.0         1       360.0     0.0;
    507    180.0        60.4       200.0        -200.0        1.0141       100.0         1       180.0     0.0;
    508    750.0        232.6      850.0        -850.0        1.0498       100.0         1       807.5     0.0;
    509    668.5        201.3      1000.0       -1000.0       0.9988       100.0        1       950.0     0.0;
    510    600.0        255.7      800.0        -800.0        1.0157       100.0         1       760.0     0.0;
    511    250.0        60.7       300.0        -300.0        1.0211       100.0         1       285.0     0.0;
    512    310.0        98.3       350.0        -350.0        1.02         100.0         1       332.5     0.0;
    513    0.0          50.1       300.0        -300.0        1.017        100.0         1       0.0       0.0;
    514    630.0        295.9      700.0        -700.0        1.0454       100.0         1       630.0     0.0;
    515    540.0        74.1       600.0        -600.0        1.0455       100.0         1       540.0     0.0;
    516    600.0        59.9       700.0        -700.0        1.0531       100.0         1       630.0     0.0;
    517    530.0        48.7       600.0        -600.0        1.0092       100.0         1       540.0     0.0;
    518    530.0        110.5      600.0        -600.0        1.0307       100.0        1       530.0     0.0;
    519    300.0        121.2      500.0        -500.0        1.03         100.0         1       475.0     0.0;
    520    2137.4       377.4      4500.0       -4500.0       1.0185       100.0        1       4275.0    0.0;
    551    600.0        59.9       700.0        -700.0        1.0531       100.0         1       630.0     0.0;
    547    540.0        74.1       600.0        -600.0        1.0455       100.0         1       540.0     0.0;
    563    530.0        110.5      600.0        -600.0        1.0307       100.0        1       530.0     0.0;
];

%% generator cost data
%	2	startup	shutdown	n	c(n-1)	...	c0
mpc.gencost = [
	2	 0.0	 0.0	 3	   1.0  0.5   2.0;
	2	 0.0	 0.0	 3	   1.0  0.5   2.0;
	2	 0.0	 0.0	 3	   1.0  0.5   2.0;
	2	 0.0	 0.0	 3	   1.0  0.5   2.0;
	2	 0.0	 0.0	 3	   1.0  0.5   2.0;
    2	 0.0	 0.0	 3	   2.0  1.0   5.0;
	2	 0.0	 0.0	 3	   2.0  1.0   5.0;
	2	 0.0	 0.0	 3	   1.0  0.5   2.0;
	2	 0.0	 0.0	 3	   1.0  0.5   2.0;
	2	 0.0	 0.0	 3	   1.0  0.5   2.0;
    2	 0.0	 0.0	 3	   1.0  0.5   2.0;
	2	 0.0	 0.0	 3	   1.0  0.5   2.0;
	2	 0.0	 0.0	 3	   2.0  1.0   5.0;
	2	 0.0	 0.0	 3	   2.0  1.0   5.0;
	2	 0.0	 0.0	 3	   2.0  1.0   5.0;
    2	 0.0	 0.0	 3	   2.0  1.0   5.0;
	2	 0.0	 0.0	 3	   2.0  1.0   5.0;
	2	 0.0	 0.0	 3	   2.0  1.0   5.0;
	2	 0.0	 0.0	 3	   1.0  0.5   2.0;
	2	 0.0	 0.0	 3	   1.0  0.5   2.0;
    2	 0.0	 0.0	 3	   2.0  1.0   5.0;
    2	 0.0	 0.0	 3	   2.0  1.0   5.0;
	2	 0.0	 0.0	 3	   2.0  1.0   5.0;
];

%% branch data
%  fbus    tbus	       r  	     x	           b	         rateA	           rateB	   rateC	  ratio	   angle	status	angmin	angmax
mpc.branch = [
    1011   1013      0.010      0.070        0.014           350.0	          350.0	       350.0	   0.0	    0.0	       1        -360.0	        360.0;
    1013   1011      0.010      0.070        0.014         	 350.0	          350.0	       350.0	   0.0	    0.0	       1        -360.0	        360.0;
	1012   1014	     0.014      0.090        0.018           350.0	          350.0	       350.0	   0.0	    0.0	       1        -360.0	        360.0;
    1014   1012	     0.014      0.090        0.018           350.0	          350.0	       350.0	   0.0	    0.0	       1        -360.0	        360.0;
    1013   1014      0.007      0.050        0.010           350.0	          350.0	       350.0	   0.0	    0.0	       1        -360.0	        360.0;
    1014   1013      0.007      0.050        0.010           350.0	          350.0	       350.0	   0.0	    0.0	       1        -360.0	        360.0;
    1021   1022      0.030      0.200        0.030           350.0	          350.0	       350.0	   0.0	    0.0	       1        -360.0	        360.0;
    1022   1021      0.030      0.200        0.030           350.0	          350.0	       350.0	   0.0	    0.0	       1        -360.0	        360.0;
    1041   1043      0.010      0.060        0.012           350.0	          350.0	       350.0	   0.0	    0.0	       1	    -360.0          360.0;
    1043   1041      0.010      0.060        0.012           350.0	          350.0	       350.0	   0.0	    0.0	       1        -360.0	        360.0;
    1041   1045      0.015      0.120        0.025            350.0	          350.0	       350.0	   0.0	    0.0	       1        -360.0	        360.0;
    1045   1041      0.015      0.120        0.025            350.0	          350.0	       350.0	   0.0	    0.0	       1        -360.0	        360.0;
    1042   1044      0.038      0.280        0.060            350.0	          350.0	       350.0	   0.0	    0.0	       1	    -360.0          360.0;
    1044   1042      0.038      0.280        0.060            350.0	          350.0	       350.0	   0.0	    0.0	       1	    -360.0          360.0;
    1042   1045      0.050      0.300        0.060            350.0	          350.0	       350.0	   0.0	    0.0	       1	    -360.0          360.0;
    1043   1044      0.010      0.080        0.016            350.0	          350.0	       350.0	   0.0	    0.0	       1        -360.0	        360.0;
    1044   1043      0.010      0.080        0.016            350.0	          350.0	       350.0	   0.0	    0.0	       1        -360.0	        360.0;
    2031   2032      0.012      0.090        0.015            500.0           500.0	       500.0	   0.0	    0.0	       1	    -360.0          360.0;
    2032   2031      0.012      0.090        0.015            500.0           500.0	       500.0	   0.0	    0.0	       1	    -360.0          360.0;
    4011   4012      0.001      0.008        0.201            1400.0           1400.0       1400.0      0.0	    0.0	       1        -360.0	        360.0;
    4011   4021      0.006      0.060        1.799            1400.0           1400.0       1400.0      0.0	    0.0	       1        -360.0	        360.0; 
    4011   4022      0.004      0.040        1.201            1400.0           1400.0       1400.0      0.0	    0.0	       1        -360.0	        360.0;
    4011   4071      0.005      0.045        1.402            1400.0           1400.0       1400.0      0.0	    0.0	       1        -360.0	        360.0;
    4012   4022      0.004      0.035        1.051            1400.0           1400.0       1400.0      0.0	    0.0	       1        -360.0	        360.0;
    4012   4071      0.005      0.050        1.498            1400.0           1400.0       1400.0      0.0	    0.0	       1        -360.0	        360.0;
    4021   4032      0.004      0.040        1.201            1400.0           1400.0       1400.0      0.0	    0.0	       1        -360.0	        360.0;
    4021   4042      0.010      0.060        3.001            1400.0           1400.0       1400.0      0.0	    0.0	       1        -360.0	        360.0;
    4022   4031      0.004      0.040        1.201            1400.0           1400.0       1400.0      0.0	    0.0	       1        -360.0	        360.0;
    4031   4022      0.004      0.040        1.201            1400.0           1400.0       1400.0      0.0	    0.0	       1        -360.0	        360.0;
    4031   4032      0.001      0.010        0.302            1400.0           1400.0       1400.0      0.0	    0.0	       1        -360.0	        360.0;
    4031   4041      0.006      0.040        2.398            1400.0           1400.0       1400.0      0.0	    0.0	       1        -360.0	        360.0;
    4041   4031      0.006      0.040        2.398            1400.0           1400.0       1400.0      0.0	    0.0	       1        -360.0	        360.0;
    4032   4042      0.010      0.040        2.001            1400.0           1400.0       1400.0      0.0	    0.0	       1        -360.0	        360.0;
    4032   4044      0.006      0.050        2.398            1400.0           1400.0       1400.0      0.0	    0.0	       1        -360.0	        360.0;
    4041   4044      0.003      0.030        0.900            1400.0           1400.0       1400.0      0.0	    0.0	       1        -360.0	        360.0;
    4041   4061      0.006      0.045        1.302            1400.0           1400.0       1400.0      0.0	    0.0	       1        -360.0	        360.0;
    4042   4043      0.002      0.015        0.498            1400.0           1400.0       1400.0      0.0	    0.0	       1	    -360.0          360.0;
    4042   4044      0.002      0.020        0.598            1400.0           1400.0       1400.0      0.0	    0.0	       1        -360.0	        360.0;
    4043   4044      0.001      0.010        0.302            1400.0           1400.0       1400.0      0.0	    0.0	       1        -360.0	        360.0;
    4043   4046      0.001      0.010        0.302            1400.0           1400.0       1400.0      0.0	    0.0	       1        -360.0	        360.0; 
    4043   4047      0.002      0.020        0.598            1400.0           1400.0       1400.0      0.0	    0.0	       1        -360.0	        360.0;
    4044   4045      0.002      0.020        0.598            1400.0           1400.0       1400.0      0.0	    0.0	       1        -360.0	        360.0;
    4045   4044      0.002      0.020        0.598            1400.0           1400.0       1400.0      0.0	    0.0	       1        -360.0	        360.0;
    4045   4051      0.004      0.040        1.201            1400.0           1400.0       1400.0      0.0	    0.0	       1        -360.0	        360.0;
    4051   4045      0.004      0.040        1.201            1400.0           1400.0       1400.0      0.0	    0.0	       1        -360.0	        360.0;
    4045   4062      0.011      0.080        2.398            1400.0           1400.0       1400.0      0.0	    0.0	       1        -360.0	        360.0;
    4046   4047      0.001      0.015        0.498            1400.0           1400.0       1400.0      0.0	    0.0	       1	    -360.0          360.0;
    4061   4062      0.002      0.020        0.598            1400.0           1400.0       1400.0      0.0	    0.0	       1        -360.0	        360.0;
    4062   4063      0.003      0.030        0.900            1400.0           1400.0       1400.0      0.0	    0.0	       1        -360.0	        360.0;
    4063   4062      0.003      0.030        0.900            1400.0           1400.0       1400.0      0.0	    0.0	       1        -360.0	        360.0;
    4071   4072      0.003      0.030        3.001            1400.0           1400.0       1400.0      0.0	    0.0	       1        -360.0	        360.0;
    4072   4071      0.003      0.030        3.001            1400.0           1400.0       1400.0      0.0	    0.0	       1        -360.0	        360.0;
    1012   501       0          0.019         0              800.0            800.0        800.0       1.0      0.0        1        -360.00         360.00;
    1013   502       0          0.025         0              600.0            600.0        600.0       1.0      0.0        1        -360.00         360.00;
    1014   503       0          0.021         0              700.0            700.0        700.0       1.0      0.0        1        -360.00         360.00;
    1021   504       0          0.025         0              600.0            600.0        600.0       1.0      0.0        1        -360.00         360.00;
    1022   505       0          0.060         0              250.0            250.0        250.0       1.05     0.0        1        -360.00         360.00;
    1042   506       0          0.038         0              400.0            400.0        400.0       1.05     0.0        1        -360.00         360.00;
    1043   507       0          0.075         0              200.0            200.0        200.0       1.05     0.0        1        -360.00         360.00;
    2032   508       0          0.018         0              850.0            850.0        850.0       1.05     0.0        1        -360.00         360.00;
    4011   509       0          0.015         0              1000.0           1000.0       1000.0      1.05     0.0        1        -360.00         360.00;
    4012   510       0          0.019         0              800.0            800.0        800.0       1.05     0.0        1        -360.00         360.00;
    4021   511       0          0.050         0              300.0            300.0        300.0       1.05     0.0        1        -360.00         360.00;
    4031   512       0          0.043         0              350.0            350.0        350.0       1.05     0.0        1        -360.00         360.00;
    4041   513       0          0.050         0              300.0            300.0        300.0       1.05     0.0        1        -360.00         360.00;
    4042   514       0          0.021         0              700.0            700.0        700.0       1.05     0.0        1        -360.00         360.00;
    4042   514       0          0.021         0              700.0            700.0        700.0       1.05     0.0        1        -360.00         360.00;
    4047   515       0          0.013         0              600              600          600         1.05     0.0        1        -360.00         360.00;
    4047   547       0          0.013         0              600              600          600         1.05     0.0        1        -360.00         360.00; 
    4051   516       0          0.021         0              700.0            700.0        700.0       1.05     0.0        1        -360.00         360.00;
    4051   551       0          0.021         0              700.0            700.0        700.0       1.05     0.0        1        -360.00         360.00;  
    4062   517       0          0.025         0              600.0            600.0        600.0       1.05     0.0        1        -360.00         360.00;
    4063   518       0          0.013         0              600              600          600         1.05     0.0        1        -360.00         360.00;
    4063   563       0          0.013         0              600              600          600         1.05     0.0        1        -360.00         360.00;
    4071   519       0          0.030         0              500.0            500.0        500.0       1.05     0.0        1        -360.00         360.00;
    4072   520       0          0.003         0              4500             4500         4500        1.05     0.0        1        -360.00         360.00;
    4011   1011      0          0.008         0              1250             1250         1250        0.95     0.0        1        -360.00         360.00;
    4012   1012      0          0.008         0              1250             1250         1250        0.95     0.0        1        -360.00         360.00;
    4022   1022      0          0.012         0              833.3            833.3        833.3       0.93     0.0        1        -360.00         360.00;
    4031   2031      0          0.012         0              833.3            833.3        833.3       1.00     0.0        1        -360.00         360.00;
    4044   1044      0          0.010         0              1000             1000         1000        1.03     0.0        1        -360.00         360.00;
    1044   4044      0          0.010         0              1000             1000         1000        0.97     0.0        1        -360.00         360.00;
    4045   1045      0          0.010         0              1000             1000         1000        1.04     0.0        1        -360.00         360.00;
    1045   4045      0          0.010         0              1000             1000         1000        0.96     0.0        1        -360.00         360.00;
    1011   11        0          0.025         0              400              400          400         1.04     0.0        1        -360.00         360.00;
    1012   12        0          0.017         0              600              600          600         1.05     0.0        1        -360.00         360.00;
    1013   13        0          0.050         0              200              200          200         1.04     0.0        1        -360.00         360.00;
    1022   22        0          0.018         0              560              560          560         1.04     0.0        1        -360.00         360.00;
    1041   1         0          0.008         0              1200             1200         1200        1.00     0.0        1        -360.00         360.00;
    1042   2         0          0.017         0              600              600          600         1.00     0.0        1        -360.00         360.00;
    1043   3         0          0.022         0              460              460          460         1.01     0.0        1        -360.00         360.00;
    1044   4         0          0.006         0              1600             1600         1600        0.99     0.0        1        -360.00         360.00;
    1045   5         0          0.007         0              1400             1400         1400        1.00     0.0        1        -360.00         360.00;
    2031   31        0          0.050         0              200              200          200         1.01     0.0        1        -360.00         360.00;
    2032   32        0          0.025         0              400              400          400         1.06     0.0        1        -360.00         360.00;
    4041   41        0          0.009         0              1080             1080         1080        1.04     0.0        1        -360.00         360.00;
    4042   42        0          0.013         0              800              800          800         1.03     0.0        1        -360.00         360.00;
    4043   43        0          0.006         0              1800             1800         1800        1.02     0.0        1        -360.00         360.00;
    4046   46        0          0.007         0              1400             1400         1400        1.02     0.0        1        -360.00         360.00;
    4047   47        0          0.050         0              200              200          200         1.04     0.0        1        -360.00         360.00;
    4051   51        0          0.006         0              1600             1600         1600        1.05     0.0        1        -360.00         360.00;
    4061   61        0          0.010         0              1000             1000         1000        1.03     0.0        1        -360.00         360.00;
    4062   62        0          0.017         0              600              600          600         1.04     0.0        1        -360.00         360.00;
    4063   63        0          0.008         0              1180             1180         1180        1.03     0.0        1        -360.00         360.00;
    4071   71        0          0.017         0              600              600          600         1.03     0.0        1        -360.00         360.00;
    4072   72        0          0.003         0              4000             4000         4000        1.05     0.0        1        -360.00         360.00;               
];

%% dcline data


%% dc grid topology
%colunm_names% dcpoles
mpc.dcpol=2;
% numbers of poles (1=monopolar grid, 2=bipolar grid)
%% bus data
%column_names%   busdc_i grid    Pdc     Vdc     basekVdc    Vdcmax  Vdcmin  Cdc
mpc.busdc = [
                   601     1      0       1       200         1.1     0.9     0;
                   602     1      0       1       200         1.1     0.9     0;
	               603     1      0       1       200         1.1     0.9     0;
                   604     1      0       1       200         1.1     0.9     0;
];

%% converters
%column_names%   busdc_i busac_i type_dc type_ac P_g   Q_g islcc  Vtar    rtf xtf  transformer tm   bf filter    rc      xc  reactor   basekVac    Vmmax   Vmmin   Imax    status   LossA LossB  LossCrec LossCinv        droop   Pdcset    Vdcset  dVdcset Pacmax Pacmin Qacmax Qacmin
mpc.convdc = [
                   601    4021       3     1     300    300     0 1              0.0004  0.008 1 1 0  1         0.0004  0.008   1  400                   1.1     0.9     1.1     1       0.011 0.003  0.004    0.007      0.5      100     1     0    480 -480 480 -480;
                   602    4032       3     1     300    300    0 1               0.0004  0.008 1 1 0  1         0.0004  0.008   1  400                    1.1     0.9     1.1     1      0.011 0.003  0.004    0.007      0.001    100     1     0   480 -480 480 -480;
                   603    4042       3     1     300    300    0 1               0.0004  0.008 1 1 0  1         0.0004  0.008  1  400                    1.1     0.9     1.1     1       0.011 0.003  0.004    0.007      0.5      100     1     0   480 -480 480 -480;
                   604    4044       3     1     300    300    0 1               0.0004  0.008 1 1 0  1         0.0004  0.008  1  400                     1.1     0.9     1.1     1      0.011 0.003  0.004    0.007      0.5      100     1     0   480 -480 480 -480;
];

%% branches
%column_names%   fbusdc  tbusdc  r      l        c   rateA   rateB   rateC   status
mpc.branchdc = [
    601     602     0.0074   0   0    480     480     480     1;
    601     603     0.01112   0   0   480     480     480     1;
    602     603     0.0074   0   0    480     480     480     1;
	602     604     0.00925   0   0   480     480     480      1;
    604     603     0.00372   0   0   480     480     480       1;
 ];


 