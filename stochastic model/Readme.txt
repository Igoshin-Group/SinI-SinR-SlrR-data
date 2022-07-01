This folder contains the scripts and data of stochastic simulation.

/data-visualization     -- scripts and data files used to produce the figures
        /distribution  -- scripts and data to plot the distribution of tapA expression
        /sporulation-simulation  -- scripts and data to plot the correlation between sporulation and tapA expression
        /static_stochastic_data  -- scripts and data to plot the distribution of tapA when Apo0A~P and growth rate are fixed
        /stochastic_da_ds  -- scripts and data to plot the mean tapA expression level in different strains
        /stochastic_gr_change  --  scripts and data to plot the mean tapA expression level under different growth curve
        /tapA-frac-vs-level  --  scripts and data to plot the tapA-on cell fraction and tapA level
/model -- stores stochpy models used in the model and raw simulated data 
        /sinIR_full  -- the major model 
        /sinIR_test  -- the model used for fixed spo0A~P and growth rate
CellStoch.py  -- python module for stochastic simulation
fix_time.py   -- script for simulation with fixed growth rate after T6
plot_cellline.py -- script for plotting the avg tapA expression level
plot_distribution.py  -- script for generating .mat files of tapA distribution data for each set of simulation
plot_frac_vs_level.py -- script for generating .mat files of the data used to analyse the tapA expression cell fraction
test_ap_gr.py -- script for simulation with fixed SpoA~P and growth rate
test_cellline.py  -- script for simulation for starving conmunity
test_no_gr_noise.py  -- script for simulation without growth rate noise
test_sporulation2.py  -- script to generate .mat files of (predicted)sporulation data
utils.py  -- some util functions