# Events


# Reactions

# DNA binding/unbinding
gsini:
	gsini0+Spo0A_p_d > gsini1
	kgsini*gsini0*Spo0A_p_d

dgsini:
 	gsini1 > gsini0+Spo0A_p_d
 	dgsini*gsini1

gsini2:
	gsini1+Spo0A_p_d > gsini2
	kgsini2*gsini0*Spo0A_p_d

dgsini2:
		gsini2 > gsini1+Spo0A_p_d
		dgsini2*gsini2

glsrr:
	gslrr0+SinR_t > gslrr1
	kgslrr*SinR_t*gslrr0
ddgslrr:
	gslrr1 > gslrr0+SinR_t
	dgslrr*gslrr1

gtap:
	gtap0+SinR_t > gtap1
	kgtap*SinR_t*gtap0
dgtap:
	gtap1 > gtap0+SinR_t
	dgtap*gtap1

# Transcription
sini:
	$pool > sini
	gsini0*vsini0+gsini1*vsini1
degsini:
	sini > $pool
	sini*rnadeg
sinr:
	gsinr > gsinr+ sinr
	vsinr*gsinr
degsinr:
	sinr > $pool
	sinr*rnadeg
slrr:
	$pool > slrr
	gslrr0*vslrr0+gslrr1*vslrr1
degslrr:
	slrr > $pool
	slrr*rnadeg

tap:
	$pool > tap
	vtap*gtap0
degtap:
	tap > $pool
	tap*rnadeg

# Translation

SinI:
	$pool > SinI
	sini*trsini

SinR:
	$pool > SinR_d
	sinr*trsinr
SlrR:
	$pool > SlrR_d
	slrr*trslrr
Tap:
	$pool > TapA
	tap*trslrr



# Post_Translation

I_dimer:
	{2.0}SinI > SinI_d
	kd2*SinI*SinI
I_undimer:
	SinI_d > {2.0}SinI
	kud2*SinI_d
R_tr:
	{2.0}SinR_d > SinR_t
	kd1*SinR_d*SinR_d
R_untr:
	SinR_t > {2.0}SinR_d
	kud1*SinR_t
I_R:
	SinI_d+SinR_d > SinI_SinR_t
	kb1*SinI_d*SinR_d
l_R:
	SinR_d+SlrR_d > SinR_SlrR_t
	kb2*SlrR_d*SinR_d
dlr:
	SinR_SlrR_t>SinR_d+SlrR_d
	(kdlr)*SinR_SlrR_t

# Degradation

dSlrR:
	SlrR_d	>$pool
	kdeg_slr*SlrR_d
dSinI:
	SinI>$pool
		kdeg*SinI
dSinR:
		SinR_d>$pool
		kdeg*SinR_d
dSinR_t:
		SinR_t>$pool
		kdeg*SinR_t
dL_R:
		SinR_SlrR_t>$pool
		kdeg*SinR_SlrR_t
dI_d:
		SinI_d>$pool
		kdeg*SinI_d
dTap:
		TapA>$pool
		(kdeg+kbgdeg)*TapA


# Parameters
rnadeg=8.3
trsini=200
trsinr=100
trslrr=100
kdeg_slr=0.8
kbgdeg=1
kdeg=0.2
kgsini=1.2
kgslrr=1.2
dgsini=0.48
kgsini2=1.2
dgsini2=5
dgslrr=5

kgtap=1.2
dgtap=5

kb1=0.32
kb2=0.32
kd1=0.3
kd2=0.3
kud1=39.7
kud2=214.8
vsini0=0
vsini1=25
vtap=30
vsinr=40
vslrr0=80
vslrr1=0
kdlr=3.32



# Initiation
gsini0=1
gsini1=0
gsini2=0
gslrr0=0
gslrr1=1
gtap0=0
gtap1=1


gsinr=1
Spo0A_p_d=1

SinI=2
SinI_d=0
SinR_d=300
SlrR_d=0

SinR_t=0
SinI_SinR_t=1
SinR_SlrR_t=1

TapA=0
tap=0
sini=1
sinr=1
slrr=1
