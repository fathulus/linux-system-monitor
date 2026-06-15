# Linux System Monitor

A bash script that monitors CPU, RAM and disk usage in real time.

I started this project to learn Linux from scratch — how the system works internally, where it stores data about itself and how you can read it. Turns out Linux keeps everything in files like `/proc/stat` or `/proc/meminfo` and you can read them with basic commands.

---

## What it does

- Shows CPU usage in percent
- Shows RAM usage in percent
- Shows disk usage
- Color codes the output — green when fine, yellow above 50%, red above 80%
- Saves data to a log file with timestamp
- Refreshes every 5 seconds

---

## How to run

```bash
git clone https://github.com/fathulus/linux-system-monitor.git
cd linux-system-monitor
chmod +x cpu_ram_monitor.sh
./cpu_ram_monitor.sh
```

Stop it with `Ctrl+C`.

---

## How it works

CPU is calculated from two reads of `/proc/stat` one second apart — the file only shows counters since boot so you have to compare two snapshots to get actual usage at a given moment. That was the trickiest part to figure out.

RAM comes from `/proc/meminfo` — I grab `MemTotal` and `MemAvailable` and calculate the difference.

Disk is read with `df /` and I pull the right column using `awk`.

---

## What I learned

- How Linux stores system data in `/proc`
- Writing functions in bash
- Extracting specific columns from text output using `awk`
- Terminal colors with ANSI escape codes
- Writing logs with timestamps
- Git basics and pushing to GitHub

---

## Files

```
linux-system-monitor/
├── cpu_ram_monitor.sh   
├── logs/                
├── .gitignore           
└── README.md
```

---

Built on Ubuntu 18.04 in VirtualBox.
