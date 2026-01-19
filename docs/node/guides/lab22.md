---
sidebar_position: 22
---

# Lab 22: Create Chronics From CSV Files

## Introduction 

This guide demonstrates how to use `create_chronics` hook to process CSV files containing load and generator data and convert them into 
chronics files suitable for power grid simulation tools.

The `create_chronics` hook reads normalized active and reactive power values from Load and SGen (synchronous generator) CSV files, then maps them 
to buses using a grid configuration json file, and finally outputs formatted CSV files (or compressed with bzip2) that can be used in power system 
simulation tools like OpenDSS.

## Requirements 

- **VILLASnode:** v1.0.1
- **Python:** v3.9 or later (for grid file generation, if required).
- **Bzip2:** v1.0.8 or later, required for compressed output. 

## Step-by-Step Guide 

### 1. Prepare Input CSV Files 

The hook expects CSV files with normallized power values. Each file should contain: 
- **Load files**: Named with pattern `Load*.csv` (e.g., `Load1.csv`, `Load2.csv`)
- **SGen files**: Named with pattern `SGen*.csv` (e.g., `SGen1.csv`, `SGen2.csv`)

The numeric index is important since it is used to map the file to a bus ID in the grid configuration. 

**Example Load CSV file (`Load1.csv`):** 

```text
secs,nsecs,offset,sequence,signal0,signal1
0,83333333,0.0,0,0.016932429412331206,0.009857843460539759
0,166666666,0.0,1,0.016932429412331206,0.009282331392780813
0,250000000,0.0,2,0.016932429412331206,0.008983608863673546
0,333333333,0.0,3,0.016932429412331206,0.008961675873217962
0,416666666,0.0,4,0.016932429412331206,0.0092165235308626
0,500000000,0.0,5,0.016932429412331206,0.009670519541245412
0,583333333,0.0,6,0.016932429412331206,0.009857843460539759
0,666666666,0.0,7,0.01693242416294213,0.009700854102832137
0,750000000,0.0,8,0.01693241891355305,0.009267075206472835
0,833333333,0.0,9,0.016932429412331206,0.008961675873217962
0,916666666,0.0,10,0.01693245040988752,0.008852188731969274
1,0,0.0,11,0.016932476656832916,0.008909808395991422
```

**Example SGen CSV file (`SGen1.csv`):**

```text
secs,nsecs,offset,sequence,signal0,signal1
0,83333333,0.0,0,0.0,0.0
0,166666666,0.0,1,0.0,0.0
0,250000000,0.0,2,0.0,0.0
0,333333333,0.0,3,0.0,0.0
0,416666666,0.0,4,0.0,0.0
0,500000000,0.0,5,0.0,0.0
0,583333333,0.0,6,0.0,0.0
0,666666666,0.0,7,0.0,0.0
0,750000000,0.0,8,0.0,0.0
0,833333333,0.0,9,0.0,0.0
0,916666666,0.0,10,0.0,0.0
1,0,0.0,11,0.0,0.0
```

Care has to be taken to ensure that the CSV files are in the VILLASnode supported CSV format. 

### 2. Prepare Grid Mapping file: 

The grid mapping file is a JSON file that maps load and generator indices to bus IDs in the power grid model. 
The file must contain a pandas DataFrame-like structure with `load` and `sgen` tables. 

### 3. Organize Directory structure

Organize your files in the following structure: 

```text
project/
├── loads/
│   ├── Load1.csv
│   ├── Load2.csv
│   └── Load3.csv
├── sgens/
│   ├── SGen1.csv
│   └── SGen2.csv
├── grid_file.json
└── create_chronics.conf
```

### 4. Create a VILLASnode Configuration File: `create_chronics.conf`

```text url="external/node/etc/examples/hooks/create_chronics.conf" title="node/etc/examples/hooks/create_chronics.conf"

```

#### Configuration Options: 
- `loads_dir` (required): Directory containing Load CSV files.
- `sgens_dir` (required): Directory containing SGen CSV files.
- `grid` (required): Path to grid mapping JSON file. 
- `output` (required): Output directory for generated chronics files.
- `round_decimals` (optional, default: `3`): Number of decimal places for rounding. 
- `compress` (optional, default: `true`): Enable bzip2 compression.
- `voltage` (optional, default: `true`): Volage value (kV) for generator voltage columns. 

### 5. Run VILLASnode 

Execute VILLASnode with the configuration file. 

```bash 
$ villas node create_chronics.conf
```

### 6. Verify Output Files

```bash 
$ ls -lg output/
total 1.2M
-rw-r--r-- 1 user user  45K output/load_p.csv.bz2
-rw-r--r-- 1 user user  42K output/load_q.csv.bz2
-rw-r--r-- 1 user user  38K output/prod_p.csv.bz2
-rw-r--r-- 1 user user  35K output/prod_q.csv.bz2
-rw-r--r-- 1 user user  40K output/prod_v.csv.bz2
```