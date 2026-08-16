      ******************************************************************
      * DAY 01 - PROGRAM STRUCTURE                                     *
      * COBOL 30-DAY REFRESH - LAWRENCE JEFFERSON II                   *
      *                                                                *
      * OBJECTIVE: THE FOUR DIVISIONS. DISPLAY. STOP RUN.              *
      * COMPILE:   cobc -x HELLO.cbl -o HELLO.exe                      *
      *                                                                *
      * FIXED FORMAT REMINDER:                                         *
      *   COLS 1-6   SEQUENCE (LEAVE BLANK)                            *
      *   COL  7     INDICATOR (* COMMENT, - CONTINUATION)             *
      *   COLS 8-11  AREA A  (DIVISION, SECTION, 01/77, PARAGRAPH)     *
      *   COLS 12-72 AREA B  (EVERYTHING ELSE)                         *
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. HELLO.
       AUTHOR. LAWRENCE JEFFERSON II.
      *
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
      *
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  WS-CURRENT-DATE-DATA.
           05  WS-CURRENT-DATE.
               10  WS-CURRENT-YEAR     PIC 9(04).
               10  WS-CURRENT-MONTH    PIC 9(02).
               10  WS-CURRENT-DAY      PIC 9(02).
           05  WS-CURRENT-TIME.
               10  WS-CURRENT-HOUR     PIC 9(02).
               10  WS-CURRENT-MINUTE   PIC 9(02).
               10  FILLER              PIC X(09).
      *
       01  WS-RULE                     PIC X(60) VALUE ALL '='.
       01  WS-NAME                     PIC X(30)
                                       VALUE 'LAWRENCE JEFFERSON II'.
      *
       01  WS-DATE-OUT.
           05  FILLER                  PIC X(06) VALUE 'DATE: '.
           05  WS-OUT-YEAR             PIC 9(04).
           05  FILLER                  PIC X     VALUE '-'.
           05  WS-OUT-MONTH            PIC 9(02).
           05  FILLER                  PIC X     VALUE '-'.
           05  WS-OUT-DAY              PIC 9(02).
           05  FILLER                  PIC X(04) VALUE '  T '.
           05  WS-OUT-HOUR             PIC 9(02).
           05  FILLER                  PIC X     VALUE ':'.
           05  WS-OUT-MINUTE           PIC 9(02).
      *
       PROCEDURE DIVISION.
       0000-MAIN.
           PERFORM 1000-GET-DATE
           PERFORM 2000-PRINT-BANNER
           STOP RUN.
      *
       1000-GET-DATE.
           MOVE FUNCTION CURRENT-DATE TO WS-CURRENT-DATE-DATA
           MOVE WS-CURRENT-YEAR   TO WS-OUT-YEAR
           MOVE WS-CURRENT-MONTH  TO WS-OUT-MONTH
           MOVE WS-CURRENT-DAY    TO WS-OUT-DAY
           MOVE WS-CURRENT-HOUR   TO WS-OUT-HOUR
           MOVE WS-CURRENT-MINUTE TO WS-OUT-MINUTE.
      *
       2000-PRINT-BANNER.
           DISPLAY WS-RULE
           DISPLAY 'COBOL 30-DAY REFRESH -- DAY 01'
           DISPLAY WS-NAME
           DISPLAY WS-DATE-OUT
           DISPLAY WS-RULE.
      *
       END PROGRAM HELLO.
