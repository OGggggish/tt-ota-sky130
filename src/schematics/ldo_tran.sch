v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -60 -130 -60 -100 {lab=0}
N -60 -100 -60 -90 {lab=0}
N -300 -250 -300 -210 {lab=#net1}
N -60 -130 -40 -130 {lab=0}
N -300 -150 -300 -90 {lab=0}
N -300 -250 -40 -250 {lab=#net1}
N -100 -210 -40 -210 {lab=#net2}
N -100 -270 -60 -270 {lab=#net1}
N -60 -270 -60 -250 {lab=#net1}
N -100 -190 -40 -190 {lab=#net3}
N -100 -130 -100 -90 {lab=0}
N -150 -170 -40 -170 {lab=nx}
N -210 -150 -40 -150 {lab=#net4}
N -180 -230 -40 -230 {lab=vgate}
N -300 -90 -210 -90 {lab=0}
N -210 -90 -150 -90 {lab=0}
N -150 -90 -100 -90 {lab=0}
N -100 -90 -60 -90 {lab=0}
N 260 -250 260 -230 {lab=vldo}
N 300 -230 300 -180 {lab=vldo}
N 300 -120 300 -60 {lab=0}
N 300 -60 390 -60 {lab=0}
N 300 -230 390 -230 {lab=vldo}
N 390 -230 390 -180 {lab=vldo}
N 390 -120 390 -60 {lab=0}
N 260 -230 300 -230 {lab=vldo}
C {isource.sym} -100 -240 0 0 {name=I0 value=10u
}
C {vsource.sym} -300 -180 0 0 {name=V1 value=1.8 savecurrent=false}
C {gnd.sym} -60 -90 0 0 {name=l2 lab=0}
C {vsource.sym} -100 -160 0 0 {name=V2 value=0.9 savecurrent=false}
C {code_shown.sym} -310 -560 0 0 {name=s1 only_toplevel=false value="
.lib /foss/pdks/sky130A/libs.tech/ngspice/sky130.lib.spice tt
.tran 50n 60u
.control
run
set hcopydevtype=svg
set color0=white
set color1=black
plot v(vldo)
hardcopy tran_step_real3ma_tt_rebin.svg v(vldo)
meas tran vpre avg v(vldo) from=15u to=19u
meas tran vmin min v(vldo) from=19u to=30u
meas tran vfinal avg v(vldo) from=50u to=60u
.endc
"}
C {vsource.sym} -210 -120 0 0 {name=Ven value="pulse(0 1.8 20u 200n 200n 1 2)" savecurrent=false}
C {capa.sym} 390 -150 0 0 {name=CL
m=1
value=100p
footprint=1206
device="ceramic capacitor"}
C {isource.sym} 300 -150 0 0 {name=IL value=100u}
C {gnd.sym} 300 -60 0 0 {name=l1 lab=0}
C {lab_wire.sym} 390 -230 0 1 {name=p1 sig_type=std_logic lab=vldo}
C {lab_wire.sym} -150 -170 0 0 {name=p2 sig_type=std_logic lab=nx}
C {lab_wire.sym} -180 -230 0 0 {name=p3 sig_type=std_logic lab=vgate}
C {/foss/designs/ldo_project/ldo_chip.sym} 110 -190 0 0 {name=x1}
