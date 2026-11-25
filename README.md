# Adaptive Multi-Junction Traffic Grid Controller (AMTGC)

## Project Overview

The **Adaptive Multi-Junction Traffic Grid Controller (AMTGC)** is a Verilog-based digital system designed to control traffic signals at two interconnected road junctions.

The project aims to improve traffic coordination through adaptive green-light timing, green-wave coordination, shared pedestrian request handling, and emergency override functionality.

The design is developed using modular RTL coding and simulated using ModelSim.

## Project Objectives

- Control traffic signals at two junctions.
- Implement traffic-density-based green-light timing.
- Coordinate the two junctions using green-wave control.
- Manage pedestrian requests through a shared arbiter.
- Provide emergency override functionality.
- Verify the RTL design through simulation.

## Main Features

### 1. Two-Junction Traffic Control
Controls North-South and East-West traffic signals at Junction A and Junction B.

### 2. Adaptive Green-Light Timing
Uses a 2-bit traffic-density input to select green-light duration.

| Traffic Density | Green Duration |
|---|---:|
| 00 | 5 clock cycles |
| 01 | 10 clock cycles |
| 10 | 15 clock cycles |
| 11 | 20 clock cycles |

### 3. Green-Wave Coordination
Uses a configurable delay timer to coordinate the North-South green signal of Junction B after Junction A starts its North-South green phase.

### 4. Shared Pedestrian Arbiter
Uses a shared pedestrian arbiter to manage requests from both junctions. The arbiter uses a round-robin-style selection mechanism when both requests are pending.

### 5. Emergency Override
Provides an emergency override input that moves both junction controllers into an all-red state while the override is active.

## RTL Modules

| Module | Description |
|---|---|
| `generic_timer.v` | Parameterized timer used for timing operations |
| `junction_controller.v` | Controls traffic-light states, pedestrian phases and adaptive green timing |
| `ped_arbiter.v` | Manages pedestrian requests from both junctions |
| `amtgc_top.v` | Top-level module connecting both junctions, arbiter and green-wave timer |

## Project Directory Structure

```text
AMTGC_PROJECT/
│
├── DOCS/
│   └── AMTGC_Architecture.txt
│
├── RTL/
│   ├── generic_timer.v
│   ├── junction_controller.v
│   ├── ped_arbiter.v
│   └── amtgc_top.v
│
├── SIM/
│
├── TB/
│   ├── generic_timer_tb.v
│   ├── junction_controller_tb.v
│   ├── ped_arbiter_tb.v
│   └── amtgc_top_tb.v
│
├── README.md
└── .gitignore
```

## Tools and Technologies

- **HDL:** Verilog
- **Simulation Tool:** ModelSim Intel FPGA Starter Edition
- **Operating System:** Windows 10
- **Version Control:** Git and GitHub

## Simulation
