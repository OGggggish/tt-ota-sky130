v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 650 -40 650 -20 {lab=#net1}
N 650 -110 650 -100 {lab=vfbtop}
N 110 -10 110 20 {lab=0}
N 110 20 110 30 {lab=0}
N -130 -130 -130 -90 {lab=#net2}
N 110 -10 130 -10 {lab=0}
N -130 -30 -130 30 {lab=0}
N -130 -130 130 -130 {lab=#net2}
N 70 -90 130 -90 {lab=#net3}
N 70 -150 110 -150 {lab=#net2}
N 110 -150 110 -130 {lab=#net2}
N 70 -70 130 -70 {lab=#net4}
N 70 -10 70 30 {lab=0}
N 20 -50 130 -50 {lab=nx}
N -40 -30 130 -30 {lab=#net5}
N -10 -110 130 -110 {lab=vgate}
N -130 30 -40 30 {lab=0}
N -40 30 20 30 {lab=0}
N 20 30 70 30 {lab=0}
N 70 30 110 30 {lab=0}
N 470 -130 470 -80 {lab=vldo}
N 470 -20 470 40 {lab=0}
N 470 40 560 40 {lab=0}
N 470 -130 560 -130 {lab=vldo}
N 560 -130 560 -80 {lab=vldo}
N 560 -20 560 40 {lab=0}
N 430 -130 470 -130 {lab=vldo}
N 430 -110 650 -110 {lab=vfbtop}
N 560 40 650 40 {lab=0}
N 560 -130 580 -130 {lab=vldo}
N 640 -130 650 -130 {lab=vfbtop}
N 650 -130 650 -110 {lab=vfbtop}
C {ind.sym} 610 -130 3 0 {name=L3
m=1
value=1G
footprint=1206
device=inductor}
C {capa.sym} 650 -70 0 0 {name=Cinj
m=1
value=1G
footprint=1206
device="ceramic capacitor"}
C {vsource.sym} 650 10 0 0 {name=V3 value="0 ac 1" savecurrent=false}
C {isource.sym} 70 -120 0 0 {name=I0 value=10u
}
C {vsource.sym} -130 -60 0 0 {name=V1 value=1.8 savecurrent=false}
C {gnd.sym} 110 30 0 0 {name=l2 lab=0}
C {vsource.sym} 70 -40 0 0 {name=V2 value=0.9 savecurrent=false}
C {code_shown.sym} -160 -590 0 0 {name=s1 only_toplevel=false value="
.lib /foss/pdks/sky130A/libs.tech/ngspice/sky130.lib.spice ff
.temp -40
.nodeset v(vldo)=1.5 v(x1.vfb)=0.9 v(x1.vout1)=0.70 v(x1.vout2)=0.66 v(vgate)=1.06 v(nx)=0.68
.op
.ac dec 20 1 1G
.control
run
setplot ac1
let t = v(vldo)/v(vfbtop)
let t_db = db(t)
let t_ph = 180/pi*cph(t)
set hcopydevtype=svg
set color0=white
set color1=black
plot t_db t_ph
hardcopy bode_chip_ff-40_100u.svg t_db t_ph
meas ac t0 find t_db at=1
meas ac fu when t_db=0 cross=1
meas ac ph_fu find t_ph when t_db=0 cross=1
meas ac floor find t_db at=800meg
.endc
"}
C {vsource.sym} -40 0 0 0 {name=Ven value=0 savecurrent=false}
C {capa.sym} 560 -50 0 0 {name=CL
m=1
value=100p
footprint=1206
device="ceramic capacitor"}
C {isource.sym} 470 -50 0 0 {name=IL value=100u}
C {gnd.sym} 470 40 0 0 {name=l1 lab=0}
C {lab_wire.sym} 20 -50 0 0 {name=p2 sig_type=std_logic lab=nx}
C {/foss/designs/ldo_project/ldo_chip.sym} 280 -70 0 0 {name=x1}
C {lab_wire.sym} -10 -110 0 0 {name=p3 sig_type=std_logic lab=vgate}
C {lab_wire.sym} 470 -130 0 1 {name=p1 sig_type=std_logic lab=vldo}
C {lab_wire.sym} 490 -110 0 1 {name=p4 sig_type=std_logic lab=vfbtop}
