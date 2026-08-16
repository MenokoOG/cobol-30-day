# COBOL 30-Day Refresh

**Owner:** Lawrence Jefferson II
**Started:** 2026-08-16
**Budget:** 60–90 min/day
**Primary env:** GnuCOBOL on Windows (F: drive)
**Secondary env:** z/OS flavor — JCL, VSAM, DB2, CICS (reading + simulated exercises; IBM Z Xplore optional)

---

## Why this exists

Refresh working COBOL fast enough to read, reason about, and modify real legacy code — the skill the classHuman AI legacy-modernization specialization depends on, and the language the Ag3nt24 gate kernel is written in.

## The rule

**One program per day, compiled and run.** No day is complete without a `.cbl` that compiles clean and produces the expected output. Reading is not a deliverable.

---

## Setup (do this before Day 1)

```powershell
# Install GnuCOBOL via winget (installs to C: defaults)
winget install --id GnuCOBOL.GnuCOBOL
# or download the Windows build: https://gnucobol.sourceforge.io/

cobc --version          # verify
```

Compile + run pattern used every day:

```powershell
cd F:\learning\ibm\cobol-30-day\src\day01
cobc -x -free HELLO.cbl -o HELLO.exe   # -free for free-format
cobc -x HELLO.cbl -o HELLO.exe         # fixed-format (column 7/8-11/12-72) — the legacy default
.\HELLO.exe
```

**Write fixed-format from Day 3 onward.** Real legacy COBOL is fixed-format and you need the column discipline back in your fingers.

---

## Folder layout

```
cobol-30-day/
  README.md          <- this file
  PLAN.md            <- the 30 days, with deliverables
  LOG.md             <- your daily log; one line per day
  src/
    day01/ ... day30/
  data/              <- shared fixture files (customers.dat, trans.dat, etc.)
  jcl/               <- z/OS-side deliverables (Week 4)
  notes/             <- one .md per day, max 10 lines
```

## Daily loop

1. Read the day's objective in `PLAN.md` (5 min)
2. Write the program from scratch — do not copy (40–60 min)
3. Compile clean, run, verify output (10 min)
4. Write `notes/dayNN.md`: what broke, what you had to look up (5 min)
5. Add one line to `LOG.md`

## Done criteria for the 30 days

- [ ] 30 compiled programs, all runnable
- [ ] Capstone batch system (Days 29–30) runs end-to-end from a driver script
- [ ] You can read a 2,000-line legacy program and describe its control flow without a debugger
- [ ] `notes/` shows the concepts you had to look up twice — that's your real gap list
