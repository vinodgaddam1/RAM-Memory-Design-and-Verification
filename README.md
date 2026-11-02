# RAM-Memory-Design-and-Verification

## 📌 1. Project Title

✅ **RAM (Random Access Memory) Design and Verification Using SystemVerilog**

---

## 📝 2. Description

This project implements a parameterized-style **32 × 8-bit synchronous memory** using Verilog and verifies its functionality using a class-based SystemVerilog testbench.

The memory supports read and write operations using a common address and control interface.

The verification environment follows a modular testbench architecture consisting of:

* Generator for transaction generation.
* BFM (Bus Functional Model) for driving DUT signals.
* Monitor for observing memory transactions.
* Scoreboard for checking read data correctness.
* Agent for integrating generator, BFM, monitor and coverage.
* Environment for integrating agent and scoreboard.
* SystemVerilog Assertions (SVA) for protocol checking.
* Functional coverage for measuring verification progress.

The verification focuses on:

* Correct memory write and read operations.
* Address-based memory access.
* Data integrity and storage.
* Reset behavior.
* Single and multiple write operations.
* Single and multiple read operations.
* Back-to-back memory transactions.
* Randomized memory access.
* Matching and mismatching data scenarios.

---

## ⭐ 3. Key Features

* ⚙️ Memory organization of 32 × 8 bits.
* 📦 32 configurable memory locations.
* ✍️ Write operation using `wr_rd`.
* 📖 Read operation using `wr_rd`.
* 📍 5-bit address selection.
* 🔄 Synchronous active-high reset.
* 🚦 Valid-ready handshake mechanism.
* 🧪 Class-based SystemVerilog testbench.
* 🎯 Randomized transaction generation.
* 📊 Functional coverage using covergroups and coverpoints.
* 🚨 SystemVerilog Assertions (SVA).
* 🔍 Scoreboard-based data comparison.
* 📈 Multiple test scenarios.
* 📂 QuestaSim UCDB coverage database generation and merging.

---

## 🔌 4. Module Interface

### 📄 Module Declaration

```verilog
module memory (
    clk,
    rst,
    addr,
    wdata,
    rdata,
    valid,
    ready,
    wr_rd
);
```

### 🧾 Ports

| Signal  | Direction | Width | Description                   |
| ------- | --------- | ----- | ----------------------------- |
| `clk`   | Input     | 1     | Clock signal                  |
| `rst`   | Input     | 1     | Active-high synchronous reset |
| `addr`  | Input     | 5     | Memory address                |
| `wdata` | Input     | 8     | Input write data              |
| `rdata` | Output    | 8     | Output read data              |
| `valid` | Input     | 1     | Transaction valid signal      |
| `ready` | Output    | 1     | Memory ready signal           |
| `wr_rd` | Input     | 1     | Write/read selection          |

### Operation Selection

| `wr_rd` | Operation       |
| ------- | --------------- |
| `1'b1`  | Write operation |
| `1'b0`  | Read operation  |

---

## ⚙️ 5. Memory Configuration

| Parameter / Macro | Default | Meaning                    |
| ----------------- | ------: | -------------------------- |
| `WIDTH`           |       8 | Data width                 |
| `DEPTH`           |      32 | Number of memory locations |
| `ADDR_WIDTH`      |       5 | Address width              |

**Memory capacity:**

`DEPTH × WIDTH = 32 × 8 = 256 bits`

**Address range:**

`0 to 31`

---

## 🧠 6. Internal Design (How It Works)

### ✍️ Write Operation

On the rising edge of `clk`:

* If `rst == 1`, the memory is reset.
* If `valid == 1`, the memory asserts `ready`.
* If `wr_rd == 1`, input data is written into the selected memory location.
* The address determines the memory location.

Example:

```systemverilog
if (valid == 1) begin
    ready = 1;

    if (wr_rd == 1)
        mem[addr] = wdata;
end
```

### 📖 Read Operation

On the rising edge of `clk`:

* If `valid == 1`, the memory asserts `ready`.
* If `wr_rd == 0`, data is read from the selected memory location.
* The selected memory data is transferred to `rdata`.

Example:

```systemverilog
if (valid == 1) begin
    ready = 1;

    if (wr_rd == 0)
        rdata = mem[addr];
end
```

### 🔄 Reset Operation

When `rst == 1`:

* All 32 memory locations are cleared.
* `rdata` becomes zero.
* `ready` becomes zero.

---

## 🚦 7. Verification Testbench Architecture

The project uses a modular class-based SystemVerilog testbench.

### Main Components

| Component   | Responsibility                                  |
| ----------- | ----------------------------------------------- |
| `mem_gen`   | Generates randomized transactions               |
| `mem_bfm`   | Drives transactions to the DUT                  |
| `mem_mon`   | Monitors memory transactions                    |
| `mem_scb`   | Compares expected and actual read data          |
| `mem_cov`   | Collects functional coverage                    |
| `mem_agent` | Integrates generator, BFM, monitor and coverage |
| `mem_env`   | Integrates agent and scoreboard                 |
| `common`    | Maintains shared mailboxes and test information |
| `mem_intrf` | Connects DUT and testbench                      |

### Communication Mechanism

The testbench uses SystemVerilog mailboxes for transaction communication.

The following mailboxes are used:

```systemverilog
static mailbox mbox = new();

static mailbox mbox_mon_cov = new();

static mailbox mbox_mon_sbd = new();
```

* `mbox`: Generator to BFM.
* `mbox_mon_cov`: Monitor to coverage.
* `mbox_mon_sbd`: Monitor to scoreboard.

---

## 🚨 8. SystemVerilog Assertions (SVA)

The project implements six concurrent assertions to check memory protocol behavior.

### Assertion Scenarios

1. Reset assertion:

   * Checks that memory interface signals are zero during reset.

2. Unknown-value assertion:

   * Checks that important signals do not contain unknown values during normal operation.

3. Valid-ready assertion:

   * Checks the relationship between `valid` and `ready`.

4. Write assertion:

   * Checks that write data and address are known during write operations.

5. Read assertion:

   * Checks that read data and address are known during read operations.

6. Write operation assertion:

   * Checks that a write operation with valid asserted is accompanied by ready.

---

## 📊 9. Functional Coverage

Functional coverage is implemented using SystemVerilog covergroups and coverpoints.

### Coverage Points

**1. Write/Read Coverage**

```systemverilog
coverpoint tx.wr_rd {
    bins WRITE = {1'b1};
    bins READ  = {1'b0};
}
```

Checks whether both write and read operations have occurred.

**2. Address Coverage**

```systemverilog
coverpoint tx.addr {
    bins ADDR[] = {[0:32]};
}
```

Checks address distribution.

The current coverage implementation includes:

* Write operation coverage.
* Read operation coverage.
* Address coverage.

---

## 🧪 10. Test Scenarios

The generator supports the following test scenarios:

| No. | Test Name | Description                        |
| --- | --------- | ---------------------------------- |
| 1   | `1W`      | Single write operation             |
| 2   | `5W`      | Five write operations              |
| 3   | `1W_1R`   | One write followed by one read     |
| 4   | `5W_5R`   | Five writes followed by five reads |
| 5   | `NW_NR`   | N writes followed by N reads       |
| 6   | `MIS`     | Mismatching address read scenario  |
| 7   | `Unknown` | Default generator scenario         |

### Scoreboard Verification

The scoreboard uses an associative array to maintain expected memory data.

```systemverilog
int asso[*];
```

It performs:

* Expected data storage during write operations.
* Actual and expected data comparison during read operations.
* Matching transaction counting.
* Mismatching transaction counting.

---

## 📁 11. Project Folder Structure

```text
RAM-Memory-Design-and-Verification/
│
├── 01_RTL/
│   └── mem.sv
│
├── 02_TESTBENCH/
│   │
│   ├── common/
│   │   └── mem_common.sv
│   │
│   ├── interface/
│   │   └── mem_intrf.sv
│   │
│   ├── generator/
│   │   └── gen_mem.sv
│   │
│   ├── BFM/
│   │   └── mem_bfm.sv
│   │
│   ├── monitor/
│   │   └── mem_mon.sv
│   │
│   ├── scoreboard/
│   │   └── mem_scb.sv
│   │
│   ├── coverage/
│   │   └── mem_cov.sv
│   │
│   ├── agent/
│   │   └── mem_agent.sv
│   │
│   ├── environment/
│   │   └── mem_env.sv
│   │
│   └── top/
│       └── top.sv
│
├── 03_ASSERTIONS/
│   └── mem_asser.sv
│
├── 04_SIMULATION/
│   ├── cov_cg.do
│   └── MEMMORY.do
│
├── 05_COVERAGE_REPORTS/
│   ├── 1W.ucdb
│   ├── 5W.ucdb
│   ├── 1W_1R.ucdb
│   ├── 5W_5R.ucdb
│   ├── NW_NR.ucdb

│   ├── Unknown.ucdb
│   └── final.ucdb
│
└── README.md
```

---

## 🛠️ 12. Tools Used

* HDL: Verilog
* Verification Language: SystemVerilog
* Simulator: QuestaSim
* Testbench Architecture: Class-Based SystemVerilog
* Communication: SystemVerilog Mailboxes
* Assertions: SystemVerilog Assertions (SVA)
* Coverage: Functional Coverage
* Coverage Database: UCDB
* Simulation Automation: QuestaSim DO Scripts

---

## 🎯 13. Expected Outcome

Successfully design and verify a 32 × 8-bit synchronous memory using a modular SystemVerilog testbench.

Demonstrate practical verification skills through:

* Randomized transaction generation.
* BFM-based DUT communication.
* Monitor-based transaction collection.
* Scoreboard-based data checking.
* SystemVerilog Assertions.
* Functional coverage analysis.
* Multiple test scenario execution.
* QuestaSim coverage database generation and merging.

The project demonstrates an end-to-end memory verification workflow using SystemVerilog.
