The scripts used for deterministic model in this work.

config.m                  --   parser for biochemical reactions
F.m                       --   for growth dynamics model
fError_pso.m              --   error function for pso optimization
fglobal.m                 --   function for global effect of growth rate on produntion rates of proteins
fPS.m                     --  pso optimization
fss_fit.m                 --   function to get the steady-state value of species in the model
gr_t.m                    --   function to get the growth rate at specific time
gr_t_alter.m              --   function to get the growth rate at specific time for the alternate growth model

get_ap_th.m               --   get the threshold of ap to activate the system(bistable)
Plot_gr.m                 --   script plotting experimental data of growth
Plot_raw.m                --   script plotting experimental data of tapA expression
plot_RvsApandGr.m         --   script plotting the steady-state sinR level
plot_t1.m                 --   script plotting phy-spank level for comparison 
det_ana_fit.m             --   deterministic model for fitting 
det_ana.m                 --   fitted deterministic model
det_traj.m                --   script plotting the tapA dynamics predicted using deterministic model
RvsL.m                    --   script producing SinR vs SlrR level over time

predict_tradition.m       --   script for prediction of tapA expression using trational model 
rt_heatmap.m              --   script producing the heatmap
rt_heatmap_alter.m        --   script producing the heatmap for alter model
SinIR_fit.txt             --   model file
SinIR.txt                 --   model file
Spo0A.txt                 --   model file
SinIR_traj.txt            --   model file