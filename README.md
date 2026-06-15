# Linux System Monitor

Skrypt w bashu który monitoruje zużycie CPU, RAM i dysku w czasie rzeczywistym.

Zacząłem ten projekt żeby nauczyć się Linuksa od podstaw — jak działa system, gdzie trzyma dane o sobie i jak to można wyciągnąć. Okazało się że Linux przechowuje wszystko w plikach jak `/proc/stat` czy `/proc/meminfo` i można to czytać zwykłymi komendami.

---

## Co robi

- Pokazuje zużycie CPU w procentach
- Pokazuje zużycie RAM w procentach
- Pokazuje zużycie dysku
- Koloruje output — zielony gdy OK, żółty gdy powyżej 50%, czerwony gdy powyżej 80%
- Zapisuje dane do pliku logu z godziną i datą
- Odświeża się co 5 sekund

---

## Jak uruchomić

```bash
git clone https://github.com/fathulus/linux-system-monitor.git
cd linux-system-monitor
chmod +x cpu_ram_monitor.sh
./cpu_ram_monitor.sh
```

Zatrzymujesz przez `Ctrl+C`.

---

## Jak to działa

CPU liczy się z dwóch odczytów `/proc/stat` w odstępie 1 sekundy — sam plik pokazuje tylko liczniki od startu systemu więc trzeba porównać dwa snapshoty żeby dostać rzeczywiste zużycie w danej chwili. To było najtrudniejsze do zrozumienia na początku.

RAM pochodzi z `/proc/meminfo` — wyciągam `MemTotal` i `MemAvailable` i liczę różnicę.

Dysk czytam przez `df /` i wyciągam odpowiednią kolumnę przez `awk`.

---

## Czego się nauczyłem

- Jak Linux przechowuje dane systemowe w `/proc`
- Pisanie funkcji w bashu
- Wyciąganie konkretnych kolumn z tekstu przez `awk`
- Kolory w terminalu przez kody ANSI
- Zapis do logów i praca z plikami
- Podstawy gita i GitHub

---

## Pliki

```
linux-system-monitor/
├── cpu_ram_monitor.sh   
├── logs/                
├── .gitignore           
└── README.md
```

---

Pisane na Ubuntu 18.04 w VirtualBoxie.
