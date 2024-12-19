      *  -------------------------------------------------------------
      *  The MIT License (MIT)
      *
      *  Copyright (c) 2019 Remain BV (https://remainsoftware.com)
      *
      *  Permission is hereby granted, free of charge, to any person
      *  obtaining a copy of this software and associated
      *  documentation files (the "Software"), to deal in the
      *  Software without restriction, including without limitation
      *  the rights to use, copy, modify, merge, publish, distribute,
      *  sublicense, and/or sell copies of the Software, and to
      *  permit persons to whom the Software is furnished to do so,
      *  subject to the following conditions:
      *
      *  The above copyright notice and this permission notice shall
      *  be included in all copies or substantial portions of the
      *  Software.
      *
      *  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY
      *  KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
      *  WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
      *  PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS
      *  OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR
      *  OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
      *  OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
      *  SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
      *
      *  Contributors:
      *      Remain Software - initial API and implementation
      *
      *  -------------------------------------------------------------

      *
      *
      *$$\CRTOM CRTRPGPGM
      *$$ CVTOPT(*DATETIME)
      *$$ REPLACE(*YES)
      *$$ TGTRLS(V5R2M0)
      *$$\ENDOM
      * ----------------------------------------------------------- *
      * Description                                                 *
      * ----------------------------------------------------------- *
      *                                                             *
      * Program ....: OMTXTHD                                       *
      * Function ...: Handle text copy                              *
      * Author .....: Remain BV                                     *
      * Startdate ..: 16-05-1997.                                   *
      * Parameters .: P#FROM - From code  (INC)                     *
      *               P#TP   - To code    (REQ, FIX)                *
      *               P#HEDC - HelpDesk                             *
      *               P#INC# - Incident                             *
      *               P#APPC - Application                          *
      *               P#OKEY - Other key (Request or fix number)    *
      *                                                             *
      *                                                             *
      * ----------------------------------------------------------- *
      /EJECT
      * ----------------------------------------------------------- *
      * Used files                                                  *
      * ----------------------------------------------------------- *
      *                                                             *
      * OMTIHL1 - Incident Headers                                  *
      * OMTIDL1 - Incident details                                  *
      * OMERDL1 - Request texts                                     *
      * OMESDL1 - Fix texts                                         *
      *                                                             *
      * ----------------------------------------------------------- *
      /EJECT
      * ----------------------------------------------------------- *
      * Sub programs                                                *
      * ----------------------------------------------------------- *
      *                                                             *
      * ----------------------------------------------------------- *
      /EJECT
      * ----------------------------------------------------------- *
      * Used indicators                                             *
      * ----------------------------------------------------------- *
      *                                                             *
      * 99     - General purpose indicator.                         *
      *                                                             *
      * ----------------------------------------------------------- *
      /EJECT
      * ----------------------------------------------------------- *
      * Files                                                       *
      * ----------------------------------------------------------- *
     FOMTIHL1   IF   E           K DISK
     FOMTIDL1   IF   E           K DISK
     FOMERDL1   IF A E           K DISK
     FOMESDL1   IF A E           K DISK
      * ----------------------------------------------------------- *
     D/COPY QCPYSRC,OMSREFREN
      /EJECT
      * ----------------------------------------------------------- *
      * Input specifications                                        *
      * ----------------------------------------------------------- *
      *
      *          ------------------------------------------
      *          Reference file is used for field definition
      *          ------------------------------------------
     D               E DS                  EXTNAME(OMSREFAM)
     D               E DS                  EXTNAME(OMSREFNZ)
      *
      *          ------------------------------------------
      *          Program status data structure
      *          ------------------------------------------
     D PGM            SDS
     D  PGMQ             *PROC
     D  D#PARM           *PARMS
     D  D#USID               254    263
      *
      *          ------------------------------------------
      *          Header block
      *          ------------------------------------------
     D HEADER          DS
     D  D2USID                 1     10
     D  D2ITXT                13     13
      *
     D INCID           DS
     D  D3HEDC                 1      5
     D  D3INC#                 7     16
      * ----------------------------------------------------------- *
      /EJECT
      * ----------------------------------------------------------- *
      * Main line                                                   *
      * ----------------------------------------------------------- *
      *
      *          ------------------------------------------
      *          Get parameters
      *          ------------------------------------------
     C     *ENTRY        PLIST
     C                   PARM                    P#FROM            3
     C                   PARM                    P#TO              3
     C                   PARM                    P#HEDC
     C                   PARM                    P#INC#
     C                   PARM                    P#APPC
     C                   PARM                    P#OKEY
      *
      *          ------------------------------------------
      *          Close the program if not correct number of parameters.
      *          ------------------------------------------
     C     D#PARM        CASNE     6             SRTTLR
     C                   ENDCS
      *
      *          ------------------------------------------
      *          Process
      *          ------------------------------------------
     C                   EXSR      SRVERW
      *
      *          ------------------------------------------
      *          Return
      *          ------------------------------------------
     C                   EXSR      SRTTLR
      * ------------------------------------------------------------ *
      /EJECT
      * ------------------------------------------------------------ *
      * SRVERW - Main process routine                                * /
      *                                                              * /
      * This routine handles the process of the program.             * /
      *                                                              *
      * This program copies the incident to the fix or request text. *
      *                                                              *
      * ------------------------------------------------------------ *
     C     SRVERW        BEGSR
      *
      *          ------------------------------------------
      *          Call the correct routinne
      *          ------------------------------------------
     C                   SELECT
     C     P#FROM        WHENEQ    'INC'
     C     P#TO          ANDEQ     'REQ'
     C                   EXSR      SRITR
      *
     C     P#FROM        WHENEQ    'INC'
     C     P#TO          ANDEQ     'FIX'
     C                   EXSR      SRITF
     C                   ENDSL
      *
      *          ------------------------------------------
      *          End of subroutine
      *          ------------------------------------------
     C                   ENDSR
      * ----------------------------------------------------------- *
      /EJECT
      * ----------------------------------------------------------- *
      * SRITR  - Incident text to request text.                     *
      *                                                             *
      * ----------------------------------------------------------- *
     C     SRITR         BEGSR
      *
      *          ------------------------------------------
      *          Get the last request sequence number
      *          ------------------------------------------
     C     $OK1K1        SETGT     OMERDL1
     C     $OK1K1        READPE    OMERDL1                                99
     C   99              Z-ADD     *ZEROS        RDSEQ#
      *
      *          ------------------------------------------
      *          Write incident line
      *          ------------------------------------------
     C                   MOVE      P#HEDC        D3HEDC
     C                   MOVE      P#INC#        D3INC#
     C                   MOVE      P#APPC        RDAPPC
     C                   MOVE      P#OKEY        RDERR#
     C                   ADD       10            RDSEQ#
     C                   MOVEL     INCID         RDERRD
     C                   WRITE     OMERDR
      *
      *          ------------------------------------------
      *          Read the first header.
      *          ------------------------------------------
     C     $IH1K1        CHAIN     OMTIHL1                            99
     C     *IN99         DOWEQ     *OFF
      *
      *          ------------------------------------------
      *          Write the header & a blank line
      *          ------------------------------------------
     C                   MOVE      IHUSID        D2USID
     C                   MOVE      IHITXT        D2ITXT
     C                   MOVE      P#APPC        RDAPPC
     C                   MOVE      P#OKEY        RDERR#
     C                   ADD       10            RDSEQ#
     C                   MOVE      IHSITD        RDERRD
     C                   MOVEL     HEADER        RDERRD
     C                   WRITE     OMERDR
      *
      *          ------------------------------------------
      *          Read the first detail.
      *          ------------------------------------------
     C     $ID1K1        CHAIN     OMTIDL1                            99
     C     *IN99         DOWEQ     *OFF
      *
      *          ------------------------------------------
      *          Write the detail
      *          ------------------------------------------
     C                   MOVE      P#APPC        RDAPPC
     C                   MOVE      P#OKEY        RDERR#
     C                   ADD       10            RDSEQ#
     C                   MOVE      IDINCD        RDERRD
     C                   WRITE     OMERDR
      *
      *          ------------------------------------------
      *          Read the next detail.
      *          ------------------------------------------
     C     $ID1K1        READE     OMTIDL1                                99
     C                   ENDDO
      *
      *          ------------------------------------------
      *          Read the next header.
      *          ------------------------------------------
     C     $IH1K1        READE     OMTIHL1                                99
     C     *IN99         IFEQ      *OFF
     C                   ADD       10            RDSEQ#
     C                   MOVE      *BLANKS       RDERRD
     C                   WRITE     OMERDR
     C                   ADD       10            RDSEQ#
     C                   MOVE      *BLANKS       RDERRD
     C                   WRITE     OMERDR
     C                   ENDIF
     C                   ENDDO
      *
      *          ------------------------------------------
      *          End of subroutine
      *          ------------------------------------------
     C                   ENDSR
      * ----------------------------------------------------------- *
      /EJECT
      * ----------------------------------------------------------- *
      * SRITF  - Incident text to fix text                          *
      *                                                             *
      * ----------------------------------------------------------- *
     C     SRITF         BEGSR
      *
      *          ------------------------------------------
      *          Get the last fix sequence number
      *          ------------------------------------------
     C     $OK1K1        SETGT     OMESDL1
     C     $OK1K1        READPE    OMESDL1                                99
     C   99              Z-ADD     *ZEROS        SDSEQ#
      *
      *          ------------------------------------------
      *          Write incident line
      *          ------------------------------------------
     C                   MOVE      P#HEDC        D3HEDC
     C                   MOVE      P#INC#        D3INC#
     C                   MOVE      P#APPC        SDAPPC
     C                   MOVE      P#OKEY        SDFIX#
     C                   ADD       10            SDSEQ#
     C                   MOVEL     INCID         SDSORD
     C                   WRITE     OMESDR
      *
      *          ------------------------------------------
      *          Read the first header.
      *          ------------------------------------------
     C     $IH1K1        CHAIN     OMTIHL1                            99
     C     *IN99         DOWEQ     *OFF
      *
      *          ------------------------------------------
      *          Write the header & a blank line
      *          ------------------------------------------
     C                   MOVE      IHUSID        D2USID
     C                   MOVE      IHITXT        D2ITXT
     C                   MOVE      P#APPC        SDAPPC
     C                   MOVE      P#OKEY        SDFIX#
     C                   ADD       10            SDSEQ#
     C                   MOVE      IHSITD        SDSORD
     C                   MOVEL     HEADER        SDSORD
     C                   WRITE     OMESDR
      *
      *          ------------------------------------------
      *          Read the first detail.
      *          ------------------------------------------
     C     $ID1K1        CHAIN     OMTIDL1                            99
     C     *IN99         DOWEQ     *OFF
      *
      *          ------------------------------------------
      *          Write the detail
      *          ------------------------------------------
     C                   MOVE      P#APPC        SDAPPC
     C                   MOVE      P#OKEY        SDFIX#
     C                   ADD       10            SDSEQ#
     C                   MOVE      IDINCD        SDSORD
     C                   WRITE     OMESDR
      *
      *          ------------------------------------------
      *          Read the next detail.
      *          ------------------------------------------
     C     $ID1K1        READE     OMTIDL1                                99
     C                   ENDDO
      *
      *          ------------------------------------------
      *          Read the next header.
      *          ------------------------------------------
     C     $IH1K1        READE     OMTIHL1                                99
     C     *IN99         IFEQ      *OFF
     C                   ADD       10            SDSEQ#
     C                   MOVE      *BLANKS       SDSORD
     C                   WRITE     OMESDR
     C                   ADD       10            SDSEQ#
     C                   MOVE      *BLANKS       SDSORD
     C                   WRITE     OMESDR
     C                   ENDIF
     C                   ENDDO
      *
      *          ------------------------------------------
      *          End of subroutine
      *          ------------------------------------------
     C                   ENDSR
      * ----------------------------------------------------------- *
      /EJECT
      * ----------------------------------------------------------- *
      * SRINIT - Program initialisation                             *
      *                                                             *
      * ----------------------------------------------------------- *
     C     *INZSR        BEGSR
      *
      *          ------------------------------------------
      *          Close the program if no parameters passed.
      *          ------------------------------------------
     C     D#PARM        CASEQ     *ZERO         SRTTLR
     C                   ENDCS
      *
      *          ------------------------------------------
      *          Parameters
      *          ------------------------------------------
     C     *LIKE         DEFINE    HEDC          P#HEDC
     C     *LIKE         DEFINE    INC#          P#INC#
     C     *LIKE         DEFINE    APPC          P#APPC
     C     *LIKE         DEFINE    ERR#          P#OKEY
      *
      *          ------------------------------------------
      *          Keylist for Request of fix text
      *          ------------------------------------------
     C     $OK1K1        KLIST
     C                   KFLD                    P#APPC
     C                   KFLD                    P#OKEY
      *
      *          ------------------------------------------
      *          Keylist for incident text.
      *          ------------------------------------------
     C     $IH1K1        KLIST
     C                   KFLD                    P#HEDC
     C                   KFLD                    P#INC#
      *
      *          ------------------------------------------
      *          Keylist for incident text.
      *          ------------------------------------------
     C     $ID1K1        KLIST
     C                   KFLD                    P#HEDC
     C                   KFLD                    P#INC#
     C                   KFLD                    IHITH#
      *
      *          ------------------------------------------
      *          End of subroutine
      *          ------------------------------------------
     C                   ENDSR
      * ----------------------------------------------------------- *
      /EJECT
      * ----------------------------------------------------------- *
      * *PSSR  - Error handler                                      *
      *                                                             *
      * Standard RPG error handler.                                 *
      * Make sure the data structure PGM is defined as the          *
      * program status data structure (SDS) with a length of 429.   *
      * The file information data structure is also passed, but     *
      * not the complete data structure, only the relevant info.    *
      * After the program is called, the messages in the queue      *
      * of this program are passes back to the queue of the         *
      * calling program and the *CANCL procedure is invoked.        *
      *                                                             *
      * ----------------------------------------------------------- *
     C     *PSSR         BEGSR
      *
      *          ------------------------------------------
      *          Do if error not in this routine.
      *          ------------------------------------------
     C     I#PSSR        IFNE      *ON
     C                   MOVE      *ON           I#PSSR            1
      *
      *          ------------------------------------------
      *          No file info is used.
      *          ------------------------------------------
     C                   MOVE      *BLANKS       FILE
      *
      *          ------------------------------------------
      *          Call the error handler
      *          ------------------------------------------
     C                   CALL      'OMX961'
     C                   PARM                    PGM
     C                   PARM                    FILE             57
      *
      *          ------------------------------------------
      *          Else exit immediately ...
      *          ------------------------------------------
     C                   ELSE
     C                   SETON                                        LR
     C                   RETURN
     C                   ENDIF
      *
      *          ------------------------------------------
      *          Exit
      *          ------------------------------------------
     C                   EXSR      SRTTLR
      *
      *          ------------------------------------------
      *          End of subroutine
      *          ------------------------------------------
     C                   ENDSR
      * ----------------------------------------------------------- *
      /EJECT
      * ----------------------------------------------------------- *
      * SRTTLR - Close the program                                  *
      *                                                             *
      * ----------------------------------------------------------- *
     C     SRTTLR        BEGSR
      *
      *          ------------------------------------------
      *          Return to caller
      *          ------------------------------------------
     C                   SETON                                        LR
     C                   RETURN
      *
      *          ------------------------------------------
      *          End of subroutine
      *          ------------------------------------------
     C                   ENDSR
      * ------------------------------------------------------------ *
