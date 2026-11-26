
# Adaptive Multi-Junction Traffic Grid Controller (AMTGC)

A Verilog HDL-based traffic signal controller that coordinates two road junctions using adaptive traffic-density timing, green-wave coordination, shared pedestrian-request arbitration, and emergency override.

**Academic Year:** 2026–2027  
**HDL:** Verilog  
**Simulation Tool:** ModelSim

## Project Overview

The Adaptive Multi-Junction Traffic Grid Controller (AMTGC) manages traffic signals at two connected junctions, Junction A and Junction B. Each junction controls North–South (NS) and East–West (EW) traffic movements.

The controller uses finite-state machines (FSMs) and programmable timers to manage signal phases. Green-light duration is selected according to the traffic-density input. A green-wave coordination mechanism coordinates the North–South green phases between the two junctions. A shared arbiter manages pedestrian requests, while an emergency override places the junctions into an all-red condition.

## Key Features

- **Two-junction control:** Controls NS and EW traffic signals at Junction A and Junction B.
- **Adaptive green timing:** Selects green duration according to the 2-bit traffic-density input.
- **Green-wave coordination:** Coordinates Junction B's NS green phase with Junction A's NS green phase using a configurable delay.
- **Pedestrian request handling:** Detects pedestrian requests and uses a shared arbiter to grant service to one junction at a time.
- **Emergency override:** Overrides normal traffic sequencing and commands both traffic directions to red.
- **FSM-based operation:** Uses defined states for green, yellow, all-red, pedestrian and emergency phases.
- **Simulation-based verification:** Includes module-level and integrated testbenches for ModelSim.

## System Architecture

The project is organised into four main RTL modules:

| Module | Purpose |
|---|---|
| `generic_timer.v` | Parameterized timer used to measure traffic and pedestrian phases. |
| `junction_controller.v` | Controls one junction's signal sequence, adaptive green timing, pedestrian phase and emergency state. |
| `ped_arbiter.v` | Arbitrates pedestrian requests from Junction A and Junction B. |
| `amtgc_top.v` | Connects both junction controllers, the pedestrian arbiter and green-wave coordination logic. |

The top-level module instantiates two junction controllers and one shared pedestrian arbiter. Junction A starts the green-wave timing sequence; the resulting enable signal is used by Junction B when it is ready to enter its NS green phase.

## Adaptive Green Timing

The junction controller uses the 2-bit traffic-density input to select the green-phase duration:

| Traffic density input | Selected green duration |
|---|---:|
| `00` | 5 clock cycles |
| `01` | 10 clock cycles |
| `10` | 15 clock cycles |
| `11` | 20 clock cycles |

These are the values implemented in the current controller configuration. Other phase durations and the green-wave delay are parameterized in the RTL.

## Traffic Signal States

The junction controller includes the following operating states:

1. NS Green
2. NS Yellow
3. All Red 1
4. EW Green
5. EW Yellow
6. All Red 2
7. Pedestrian Phase
8. Emergency

The normal traffic sequence moves through the NS and EW phases with yellow and all-red clearance intervals. A pending pedestrian request can be served during the pedestrian phase when the arbiter grants access. An active emergency override takes priority over normal operation.

## Repository Structure

The following is the intended project structure. Keep only entries that are actually present in your GitHub repository, and adjust filenames if needed.

```text
AMTGC_PROJECT/
├── DOCS/
│   ├── AMTGC_Architecture.txt
│   ├── AMTGC_Updated_Complete_Project_Documentation.docx
│   ├── AMTGC_Simulation_Verification_Report.docx
│   └── AMTGC_Test_Scenario_Verification_Report.docx
├── RTL/
│   ├── generic_timer.v
│   ├── junction_controller.v
│   ├── ped_arbiter.v
│   └── amtgc_top.v
├── TB/
│   ├── generic_timer_tb.v
│   ├── junction_controller_tb.v
│   ├── ped_arbiter_tb.v
│   └── amtgc_top_tb.v
├── SIM/
└── README.md
```

## Tools and Requirements

- Windows 10 or Windows 11
- ModelSim Intel FPGA Starter Edition (or a compatible ModelSim version)
- Verilog HDL source files and testbench files from this repository

## Running the Simulation in ModelSim

1. Open ModelSim.
2. Create or open the AMTGC project.
3. Add the RTL files from the `RTL` folder.
4. Add the required testbench file from the `TB` folder.
5. Compile the RTL modules and the selected testbench.
6. Start the simulation using the testbench as the top-level simulation module.
7. Add the required signals to the Wave window.
8. Run the simulation and inspect the transcript and waveforms.

For integrated simulation, use `amtgc_top_tb` as the testbench top-level module. Exact compile and run commands may depend on the ModelSim project setup.

## Verification

The repository includes separate testbenches for the timer, junction controller, pedestrian arbiter and integrated AMTGC design.

The integrated testbench is intended to exercise and check important behaviours, including:

- Reset operation
- Adaptive green timing
- Green-wave coordination
- Pedestrian request handling and arbitration
- Prevention of conflicting green signals
- Prevention of simultaneous pedestrian WALK grants
- Emergency override behaviour
- Repeated pedestrian requests

The integrated testbench checks a number of these behaviours automatically. Some individual signal phases and emergency recovery situations may also require separate waveform-based verification. Refer to the simulation and test-scenario reports in `DOCS` for the evidence and results available for each scenario.

## Documentation

Detailed project information, architecture, module descriptions, simulation procedure and verification evidence should be maintained in the `DOCS` folder.

- **Complete Project Documentation:** `DOCS/AMTGC_Updated_Complete_Project_Documentation.docx`
- **Simulation and Verification Report:** `DOCS/AMTGC_Simulation_Verification_Report.docx`
- **Test Scenario Verification Report:** `DOCS/AMTGC_Test_Scenario_Verification_Report.docx`

If a document has a different filename or format in your repository, update the filename above accordingly.

## Project Status

Academic project developed for the design and simulation of a two-junction adaptive traffic controller using Verilog HDL. Simulation results should be interpreted according to the testbench checks and waveform evidence included with the project.

## Author

**Sanjay**  
B.Tech – Electronics and Communication Engineering  
Aditya University

## Repository

[AMTGC_PROJECT on GitHub](https://github.com/gallasanjay6513-star/AMTGC_PROJECT)
