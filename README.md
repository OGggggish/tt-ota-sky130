# tt-ota-sky130 — TinyLDO

A fully analog **1.5 V low-dropout regulator** on SKY130, built for Tiny Tapeout (TTSKY26c). Two-stage Miller OTA → super-source-follower buffer → 2 mm-wide PMOS pass device (two guard-ringed segments), with on-chip bias generation, feedback divider, RC compensation, and a built-in switched-load demo. 16 transistors, 6 passives, zero digital gates.

**Post-layout results** (C-extracted, ngspice-46):

- Phase margin **51.8° / 59.6° / 70.7°** at ss 125 °C / tt 27 °C / ff −40 °C — all corners clear the 45° floor
- Unity-gain 2.0 MHz, DC loop gain 85 dB
- Load-step droop **−328 mV** with full recovery, regulation held at 1.5008 V under both load states
- **Tiny Tapeout precheck: 15/15 green**; LVS-clean (netgen: *Circuits match uniquely*)

Designed end-to-end with the open-source flow: **xschem · ngspice · magic · netgen · klayout** (IIC-OSIC-TOOLS).

Interactive layout viewer (GitHub Pages): https://ogggggish.github.io/tt-ota-sky130/

## Repo map

- `src/schematics/` — xschem schematics + SPICE netlist (`ldo_chip`)
- `src/layout/` — magic layout (`tt_um_ogggggish_ota_ldo` + subcells)
- `gds/`, `lef/` — submission artifacts (top-cell name = file name)
- `lvs/` — LVS wrapper, netlists, netgen report
- `sim/` — post-layout benches, C-extracted DUT wraps, corner logs, Bode/transient plots
- `scripts/fix_res_masks.py` — KLayout post-export mask fix (see below)
- `docs/info.md` — architecture, measured results, bring-up guide

## Design notes

The pass FET is split into two segments (M=3 + M=2 rows of 80 fingers), each with its own full guard ring, per Tiny Tapeout guidance — this keeps all P-diffusion within 15 µm of a well tap (SKY130 latch-up rule LU.3). The schematic keeps a single 2000 µm device; netgen's parallel-device merging matches the two layout segments against it, so the entire verification history (LVS, full-corner AC, droop transient) remains valid with zero schematic changes.

Magic's generated `res_*high_po_0p35` resistor cells emit rpm/urpm implant masks below the 1.27 µm minimum width (a known issue with the narrow 0p35 cells). `scripts/fix_res_masks.py` widens those masks inside the three resistor device cells after every `gds write` — run it as a fixed post-export step:

```
magic> gds write tt_um_ogggggish_ota_ldo.gds
$ klayout -b -r scripts/fix_res_masks.py
```

## Reproducing the simulations

Post-layout decks live in `sim/`. Two ngspice options are load-bearing for the extracted netlist:

- `.option rshunt=1e12` — the unused TT template pin stubs carry parasitic capacitance with no DC path; the shunt removes the singular matrix.
- `noopiter` (ss / 125 °C) — skips the first Newton attempt and starts directly with dynamic gmin stepping, avoiding a false-convergence plateau specific to the hot/slow corner.

Loop gain is measured by breaking the loop at the top of Rf1 and injecting through a 1 GH / 1 GF pair, reproducing the pre-layout methodology exactly (schematic reference bench recovers the frozen baseline to 0.01°).

## Acknowledgments

Thanks to the Tiny Tapeout team — in particular for the "split the FET" guidance on the LU.3 question — and to the maintainers of magic, xschem, ngspice, netgen, KLayout, and IIC-OSIC-TOOLS.
