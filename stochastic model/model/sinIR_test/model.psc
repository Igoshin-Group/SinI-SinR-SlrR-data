# Events


# Reactions

# DNA binding/unbinding
gsini:
	gsini0+Spo0A_p_d > gsini1
	kgsini*gsini0*Spo0A_p_d

dgsini:
 	gsini1 > gsini0+Spo0A_p_d
 	dgsini*gsini1

glsrr:
	gslrr0+SinR_t > gslrr1
	kgslrr*SinR_t*gslrr0
dgslrr:
	gslrr1 > gslrr0+SinR_t
	dgslrr*gslrr1

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
dI_d:
		SinI_d>$pool
		kdeg*SinI_d


# Parameters
rnadeg=8.3
trsini=400
trsinr=200
trslrr=200
kdeg_slr=0.8
kdeg=0.2
kgsini=1.2
kgslrr=1.2
dgsini=0.48
dgslrr=5

kb1=0.32
kb2=0.32
kd1=0.3
kd2=0.3
kud1=39.7
kud2=214.8
vsini0=0
vsini1=25
vsinr=40
vslrr0=80
vslrr1=0
kdlr=1.1661



# Initiation
gsini0=1
gsini1=0
gslrr0=0
gslrr1=1

gsinr=1
Spo0A_p_d=1

SinI=2
SinI_d=0
SinR_d=2
SlrR_d=500

SinR_t=0
SinI_SinR_t=1
SinR_SlrR_t=1



sini=1
sinr=1
slrr=1
