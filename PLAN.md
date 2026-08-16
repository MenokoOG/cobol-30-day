# COBOL 30-Day Refresh — The Plan

60–90 min/day. Every day ships a compiled, running program.
`[G]` = GnuCOBOL local · `[Z]` = z/OS / mainframe concept day

---

## Week 1 — Language spine (Days 1–7)

### Day 1 [G] — Program structure
**Concept:** The four divisions. IDENTIFICATION / ENVIRONMENT / DATA / PROCEDURE. `DISPLAY`, `STOP RUN`, comment lines.
**Deliverable:** `src/day01/HELLO.cbl` — prints a 3-line banner with your name, the date via `FUNCTION CURRENT-DATE`, and a separator rule.
**Done when:** compiles with zero warnings under `cobc -x`.

### Day 2 [G] — PICTURE clauses and WORKING-STORAGE
**Concept:** `PIC X`, `9`, `S9(n)V9(m)`, `COMP-3`, `VALUE`, level numbers 01/05/77/88.
**Deliverable:** `src/day02/PICDEMO.cbl` — declares 12 fields across every PIC type, MOVEs literals in, DISPLAYs each with its raw storage length. Include one 88-level condition name.
**Done when:** you can predict every DISPLAY output before running it.

### Day 3 [G] — Fixed format + MOVE semantics
**Concept:** Columns 1-6 seq, 7 indicator, 8-11 Area A, 12-72 Area B. MOVE truncation and padding rules — alphanumeric left-justified, numeric right-justified with decimal alignment.
**Deliverable:** `src/day03/MOVETEST.cbl` — **fixed format from here on.** 15 MOVE cases that each demonstrate a truncation or padding rule; DISPLAY before/after in delimiters so you can see the spaces.
**Done when:** every surprising result is written down in `notes/day03.md`.

### Day 4 [G] — Arithmetic
**Concept:** `ADD`/`SUBTRACT`/`MULTIPLY`/`DIVIDE ... GIVING`, `COMPUTE`, `ROUNDED`, `ON SIZE ERROR`, `REMAINDER`.
**Deliverable:** `src/day04/PAYCALC.cbl` — gross-to-net pay calculator. Hourly rate, hours, overtime at 1.5x over 40, three tax brackets, deductions. Uses `ROUNDED` and traps `ON SIZE ERROR`.
**Done when:** a 60-hour week at $28.50/hr produces a penny-accurate result you verified by hand.

### Day 5 [G] — Conditionals and control flow
**Concept:** `IF/ELSE/END-IF`, `EVALUATE` (incl. `EVALUATE TRUE`), class/sign/relation conditions, 88-levels as flags, `NEXT SENTENCE` vs `CONTINUE`.
**Deliverable:** `src/day05/GRADECLS.cbl` — classifies 20 hardcoded records by a 4-way `EVALUATE TRUE` and a nested `IF` version of the same logic, then asserts both agree.
**Done when:** both paths produce identical output.

### Day 6 [G] — PERFORM
**Concept:** `PERFORM paragraph`, `THRU`, `VARYING`, `UNTIL`, `WITH TEST BEFORE/AFTER`, inline `PERFORM`. Paragraph vs section. Why `GO TO` exists in the code you'll inherit.
**Deliverable:** `src/day06/LOOPLAB.cbl` — same accumulation implemented five ways (inline PERFORM, PERFORM UNTIL, PERFORM VARYING, PERFORM n TIMES, and a GO TO loop). All five print the same total.
**Done when:** you can explain the TEST BEFORE/AFTER off-by-one out loud.

### Day 7 [G] — Sequential file I/O
**Concept:** `SELECT ... ASSIGN`, `ORGANIZATION LINE SEQUENTIAL`, FD, record layout, `OPEN/READ/WRITE/CLOSE`, `AT END`, `FILE STATUS`.
**Deliverable:** `data/customers.dat` (create 25 fixed-width records) + `src/day07/CUSTLIST.cbl` — reads the file, counts records, writes a formatted listing to `data/custlist.txt`. Checks FILE STATUS after every operation.
**Done when:** deleting the input file produces a clean error message, not a crash.

---

## Week 2 — Data structures (Days 8–14)

### Day 8 [G] — Group items and REDEFINES
**Concept:** Nested groups, group MOVEs, `REDEFINES`, `RENAMES` (66-level), why REDEFINES is everywhere in legacy code.
**Deliverable:** `src/day08/REDEF.cbl` — one 80-byte record area REDEFINEd three ways (customer / order / adjustment) with a record-type byte selecting the view.
**Done when:** you can articulate why this is COBOL's union type and where it goes wrong.

### Day 9 [G] — Tables I: OCCURS and subscripts
**Concept:** `OCCURS`, subscripts vs indexes, `INDEXED BY`, `SET`, multi-dimensional tables.
**Deliverable:** `src/day09/RATETBL.cbl` — a 12x5 rate table (month x tier), loaded at init, queried by month+tier, with bounds checking on both dimensions.
**Done when:** an out-of-range lookup is caught by your code, not by the runtime.

### Day 10 [G] — Tables II: SEARCH and SEARCH ALL
**Concept:** `SEARCH` (linear) vs `SEARCH ALL` (binary — requires `ASCENDING KEY` and a sorted table), `AT END`, `WHEN`.
**Deliverable:** `src/day10/PRODLOOK.cbl` — 200-entry product table; same lookup via SEARCH and SEARCH ALL, with a probe counter proving the binary search does fewer comparisons.
**Done when:** the counter output matches your log2(n) expectation.

### Day 11 [G] — String handling
**Concept:** `STRING`, `UNSTRING`, `INSPECT` (TALLYING / REPLACING / CONVERTING), reference modification `FIELD(3:5)`, `FUNCTION TRIM/UPPER-CASE/LOWER-CASE`.
**Deliverable:** `src/day11/NAMEPARS.cbl` — parses "LAST, FIRST MI" free-text names into discrete fields, normalizes case, strips punctuation, and rebuilds a display name. Handles 10 messy test cases including missing middle initial.
**Done when:** all 10 cases pass without a special-case hack per name.

### Day 12 [G] — COPY books
**Concept:** `COPY`, `REPLACING`, copybook discipline, why a record layout lives in exactly one place.
**Deliverable:** `copybooks/CUSTREC.cpy` + `copybooks/WSCONST.cpy` + `src/day12/COPYUSE.cbl` — Day 7's program refactored to use the copybook. Compile with `cobc -I ..\..\copybooks`.
**Done when:** changing a field length in the copybook alone changes the program's behavior.

### Day 13 [G] — Subprograms
**Concept:** `CALL ... USING`, `LINKAGE SECTION`, `PROCEDURE DIVISION USING`, `BY REFERENCE` vs `BY CONTENT`, `GOBACK` vs `STOP RUN`, static vs dynamic CALL.
**Deliverable:** `src/day13/TAXSUB.cbl` (callable module) + `src/day13/TAXMAIN.cbl` (driver). Compile the sub with `cobc -m`, the main with `cobc -x`. Prove BY CONTENT protects the caller's field.
**Done when:** the BY REFERENCE version mutates the caller and the BY CONTENT version does not.

### Day 14 [G] — Sorting and merging
**Concept:** `SORT` with `USING/GIVING`, `INPUT PROCEDURE`/`OUTPUT PROCEDURE`, `RELEASE`/`RETURN`, `MERGE`, SD file description.
**Deliverable:** `src/day14/CUSTSORT.cbl` — sorts `customers.dat` by state then last name using an INPUT PROCEDURE that filters out inactive records.
**Done when:** the filter runs inside the sort, not as a separate pass.

---

## Week 3 — Batch patterns (Days 15–21)

### Day 15 [G] — Report writing and edited PICs
**Concept:** Edit characters — `Z`, `*`, `$`, `,`, `.`, `-`, `CR`, `DB`, `BLANK WHEN ZERO`. Headings, page breaks, `LINE-COUNT`.
**Deliverable:** `src/day15/SALESRPT.cbl` — paginated sales report, 55 lines/page, page header with date and page number, column headings, money formatted with floating `$` and comma separators.
**Done when:** output is genuinely printable — aligned columns, no orphan headers.

### Day 16 [G] — Control break logic
**Concept:** Single and multi-level control breaks, hold fields, break detection, subtotal/total accumulation, the "first record" problem.
**Deliverable:** `src/day16/RGNRPT.cbl` — three-level break (region / state / salesrep) with subtotals at each level and a grand total. Input must be pre-sorted.
**Done when:** totals foot exactly and the last group's subtotal prints (the classic bug).

### Day 17 [G] — Master/transaction sequential update
**Concept:** The balanced-line / matching-record algorithm. Add, change, delete transactions against a sorted master. High-values sentinel.
**Deliverable:** `data/master.dat` + `data/trans.dat` + `src/day17/MASTUPD.cbl` — produces new master, an audit trail, and an error file for unmatched transactions.
**Done when:** a delete for a nonexistent key lands in the error file rather than corrupting the master.

### Day 18 [G] — Indexed and relative files
**Concept:** `ORGANIZATION INDEXED`, `RECORD KEY`, `ALTERNATE RECORD KEY WITH DUPLICATES`, `ACCESS MODE RANDOM/DYNAMIC`, `START`, `READ NEXT`, `REWRITE`, `DELETE`. `ORGANIZATION RELATIVE`.
**Deliverable:** `src/day18/CUSTIDX.cbl` — builds an indexed file from `customers.dat`, then supports random read by key, alternate-key browse by state, rewrite, and delete. FILE STATUS checked on all six operations.
**Done when:** duplicate alternate keys browse correctly in sequence.

### Day 19 [G] — Error handling and defensive COBOL
**Concept:** FILE STATUS code families (00/02/10/22/23/35/9x), `DECLARATIVES` / `USE AFTER ERROR`, abend codes, `RETURN-CODE`, why swallowing a status is how legacy data gets corrupted.
**Deliverable:** `src/day19/SAFEIO.cbl` — a reusable `CHECK-STATUS` paragraph plus a DECLARATIVES section; deliberately trigger status 35, 23 and 22 and show each handled distinctly with a nonzero RETURN-CODE.
**Done when:** every path exits with a return code a JCL step could branch on.

### Day 20 [G] — Debugging and reading unfamiliar code
**Concept:** `DISPLAY` tracing, `cobc -g` + `gdb`, `-fdump`, `READY TRACE`, compiler listings and cross-reference (`-Xref`). Reading a program you did not write: find the file I/O, find the main loop, find the control breaks.
**Deliverable:** `src/day20/TRACE.cbl` — take Day 17's MASTUPD, introduce a deliberate bug in a branch, hand yourself the listing, and fix it using the xref and a trace. Write the diagnosis in `notes/day20.md`.
**Done when:** the note describes the method, not just the fix.

### Day 21 [G] — Refactoring legacy COBOL
**Concept:** Structured programming in a GO TO codebase. `PERFORM THRU` + EXIT paragraph idiom. Extracting a section into a subprogram without changing behavior. Behavior-preserving change with a before/after output diff as the proof.
**Deliverable:** `src/day21/LEGACY-BEFORE.cbl` and `LEGACY-AFTER.cbl` — write a deliberately gnarly 150-line GO TO program, then restructure it. Both must produce byte-identical output on the same input.
**Done when:** `fc` (Windows) reports no differences between the two outputs.

---

## Week 4 — Mainframe surface (Days 22–28)

### Day 22 [Z] — JCL fundamentals
**Concept:** `//JOB`, `//EXEC PGM=`, `//DD`, DISP tuples, SYSOUT, SYSIN, return-code conditioning (`COND`, `IF/THEN/ELSE`), catalogued procedures, GDGs.
**Deliverable:** `jcl/CUSTRPT.jcl` — a 3-step job: sort, report, archive. Step 2 runs only if step 1 RC=0; step 3 conditioned on step 2. Annotate every line with what it does.
**Done when:** you can explain `DISP=(NEW,CATLG,DELETE)` element by element without looking.

### Day 23 [Z] — Datasets and VSAM
**Concept:** PS / PDS / PDSE, RECFM (F, FB, V, VB), LRECL, BLKSIZE. VSAM KSDS / ESDS / RRDS, control intervals, IDCAMS `DEFINE CLUSTER` / `REPRO` / `LISTCAT`, alternate indexes and paths.
**Deliverable:** `jcl/DEFCLUST.jcl` — IDCAMS job defining a KSDS with an alternate index, plus `notes/day23.md` mapping each VSAM concept to its GnuCOBOL equivalent from Day 18.
**Done when:** the mapping table is complete and you can name what has no local equivalent.

### Day 24 [Z] — Packed decimal and mainframe data types
**Concept:** `COMP-3` internal layout (nibbles, sign nibble C/D/F), `COMP`/binary, `COMP-1/2`, EBCDIC vs ASCII, sign overpunch, why a bad copybook silently garbles money.
**Deliverable:** `src/day24/PACKED.cbl` — dumps the hex bytes of COMP-3, COMP and DISPLAY numerics side by side; include a case where a mismatched PIC misreads a packed field, and show the wrong number it produces.
**Done when:** you can hand-decode a COMP-3 field from its hex.

### Day 25 [Z] — Embedded SQL / DB2
**Concept:** `EXEC SQL ... END-EXEC`, host variables, `SQLCA` and `SQLCODE`, singleton SELECT vs cursors (`DECLARE`/`OPEN`/`FETCH`/`CLOSE`), null indicators, precompile → bind → run.
**Deliverable:** `src/day25/DB2CUST.cbl` — a DB2 program: singleton SELECT, a cursor loop, an INSERT with null indicator, and SQLCODE checked after every call (100 = not found, negative = error). Won't compile locally without DB2 — deliver it as reviewed source plus `notes/day25.md` describing the precompile/bind chain.
**Done when:** every SQL statement in the file has a matching SQLCODE check.

### Day 26 [Z] — CICS concepts
**Concept:** Online vs batch. `EXEC CICS SEND MAP / RECEIVE MAP / READ / WRITE / LINK / XCTL / RETURN`, pseudo-conversational design, COMMAREA, BMS maps, `EIBCALEN`.
**Deliverable:** `src/day26/CICSINQ.cbl` — a pseudo-conversational customer inquiry transaction as reviewed source, plus `notes/day26.md` diagramming the pseudo-conversational state cycle across three user interactions.
**Done when:** the diagram shows exactly where COMMAREA carries state and why `EIBCALEN = 0` means first entry.

### Day 27 [Z] — Utilities and the batch ecosystem
**Concept:** DFSORT/SYNCSORT control cards (SORT FIELDS, INCLUDE/OMIT, OUTREC, SUM), IEBGENER, IEFBR14, IDCAMS, restart/rerun, checkpointing.
**Deliverable:** `jcl/SORTSTEP.jcl` — DFSORT control cards that reproduce Day 14's sort-and-filter, plus a one-paragraph note on when the utility beats writing COBOL.
**Done when:** the sort card and the COBOL produce the same logical result.

### Day 28 [G] — Modernization seam
**Concept:** Where a legacy COBOL system meets a modern stack — file/dataset extracts, batch-window constraints, character-set boundaries, COMP-3 on the wire, wrapping a callable module behind an API. Behavioral-equivalence testing as the safety mechanism.
**Deliverable:** `src/day28/EXTRACT.cbl` — reads the Day 18 indexed file and emits clean JSON lines (UTF-8, decimals as strings, no COMP-3 leakage) + a Python harness `src/day28/verify.py` that diffs the JSON against the COBOL report output.
**Done when:** the harness passes on 100% of records and you have written down the three places this seam could silently corrupt data.

---

## Capstone (Days 29–30)

### Day 29 [G] — Build: batch billing system, part 1
**Deliverable:** `src/capstone/` — driver script + modules. Read a customer master (indexed) and a transaction file, validate transactions against the master, apply the Day 4 rate logic, write an updated master and a posting file. Reuse the Day 12 copybooks, the Day 13 subprogram pattern, and the Day 19 error handling.
**Done when:** the pipeline runs end-to-end from one command and rejects bad transactions to an error file.

### Day 30 [G] — Build: part 2 + retrospective
**Deliverable:** Add the Day 15/16 report (paginated, three-level control break) and the Day 28 JSON extract to the capstone. Then write `notes/RETRO.md`:
- The five things you had to look up more than once → your real gap list
- Three legacy patterns you now recognize on sight
- What you'd want in a COBOL agent's tool surface, given what you just did by hand

**Done when:** `cobol-30-day/` is committed on a `claude/*` branch and the capstone runs clean from a fresh checkout.

---

## Weekly checkpoints

| End of | Prove |
|---|---|
| Week 1 | Read any single-file batch program and name every division's job |
| Week 2 | Refactor a 500-line program into copybooks + subprograms without behavior change |
| Week 3 | Write a master/transaction update with control-break reporting from a blank file |
| Week 4 | Read a JCL job stream and a DB2/CICS program and explain what runs when |
| Day 30 | Capstone runs; retro names your actual gaps |

---

*LAHA — Love All Humans Always.*
