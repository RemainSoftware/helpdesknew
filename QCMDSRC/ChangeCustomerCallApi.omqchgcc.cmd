 /* ---------------------------------------------------------------- */
 /*  The MIT License (MIT)                                           */
 /*                                                                  */
 /*  Copyright (c) 2019 Remain (https://remainsoftware.com)          */
 /*                                                                  */
 /*  Permission is hereby granted, free of charge, to any person     */
 /*  obtaining a copy of this software and associated documentation  */
 /*  files (the "Software"), to deal in the Software without         */
 /*  restriction, including without limitation the rights to use,    */
 /*  copy, modify, merge, publish, distribute, sublicense, and/or    */
 /*  sell copies of the Software, and to permit persons to whom      */
 /*  the Software is furnished to do so, subject to the following    */
 /*  conditions:                                                     */
 /*                                                                  */
 /*  The above copyright notice and this permission notice shall     */
 /*  be included in all copies or substantial portions of the        */
 /*  Software.                                                       */
 /*                                                                  */
 /*  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY       */
 /*  KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE      */
 /*  WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR         */
 /*  PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS      */
 /*  OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR        */
 /*  OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR      */
 /*  OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE       */
 /*  SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.          */
 /*                                                                  */
 /*  Contributors:                                                   */
 /*      Remain Software - initial API and implementation            */
 /*                                                                  */
 /* ---------------------------------------------------------------- */


 /*   *$$\CRTOM CRTCMD                                                        */
 /*   *$$ PGM(OMQCHGCCCP)                                                     */
 /*   *$$ MODE(*ALL)                                                          */
 /*   *$$ ALLOW(*ALL)                                                         */
 /*   *$$ PMTFILE(*NONE)                                                      */
 /*   *$$ MSGF(QCPFMSG)                                                       */
 /*   *$$ HLPPNLGRP(OMSCMD)                                                   */
 /*   *$$ HLPID(*CMD)                                                         */
 /*   *$$ HLPSCHIDX(REMAINHD)                                                 */
 /*   *$$\ENDOM                                                               */
 /* ---------------------------------------------------------------- */
 /* Description                                                      */
 /* ---------------------------------------------------------------- */
 /*                                                                  */
 /* Command ....: OMQCHGCC                                           */
 /* Function ...: Change Customer Call through API                   */
 /* Author .....: Remain Software                                    */
 /*                                                                  */
 /* ---------------------------------------------------------------- */
             CMD        PROMPT('Change Customer Call (API)')

          /* ------------------------------------------------------- */
          /* Action code                                             */
          /* ------------------------------------------------------- */
             PARM       KWD(ACTC) TYPE(*CHAR) LEN(2) RSTD(*YES) +
                          SPCVAL((*ADD 60) (*CHANGE 20) (*DELETE +
                          40) (*CLOSE 99)) MIN(1) PROMPT('Action +
                          code' 1)

          /* ------------------------------------------------------- */
          /* HelpDesk                                                */
          /* ------------------------------------------------------- */
             PARM       KWD(DESK) TYPE(*CHAR) LEN(5) PMTCTL(KEYL) +
                          PROMPT('HelpDesk')

          /* ------------------------------------------------------- */
          /* Call track number                                       */
          /* ------------------------------------------------------- */
             PARM       KWD(CALL) TYPE(*CHAR) LEN(10) +
                          SPCVAL((*GEN)) PMTCTL(CHGADDDEL) +
                          PROMPT('Call track number')

          /* ------------------------------------------------------- */
          /* Customer code                                           */
          /* ------------------------------------------------------- */
             PARM       KWD(CUSC) TYPE(*CHAR) LEN(10) DFT(*SAME) +
                          SPCVAL((*SAME)) PMTCTL(CHGADD) +
                          PROMPT('Customer code')

          /* ------------------------------------------------------- */
          /* Customer contact                                        */
          /* ------------------------------------------------------- */
             PARM       KWD(CCTC) TYPE(*CHAR) LEN(10) DFT(*DFT) +
                          SPCVAL((*SAME) (*DFT)) PMTCTL(CHGADD) +
                          PROMPT('Customer contact')

          /* ------------------------------------------------------- */
          /* Income date                                             */
          /* ------------------------------------------------------- */
             PARM       KWD(INDT) TYPE(*DATE) DFT(*CURRENT) +
                          SPCVAL((*CURRENT 5555555)) PMTCTL(ADD) +
                          PROMPT('Income date')

          /* ------------------------------------------------------- */
          /* Income time                                             */
          /* ------------------------------------------------------- */
             PARM       KWD(INTM) TYPE(*TIME) DFT(*CURRENT) +
                          SPCVAL((*CURRENT 555555)) PMTCTL(ADD) +
                          PROMPT('Income time')

          /* ------------------------------------------------------- */
          /* Realized completion time                                */
          /* ------------------------------------------------------- */
             PARM       KWD(RCTM) TYPE(*TIME) DFT(*SAME) +
                          SPCVAL((*SAME 000000) (*CURRENT 555555)) +
                          PMTCTL(CHGADD) PROMPT('Realization +
                          completion time')

          /* ------------------------------------------------------- */
          /* User id.                                                */
          /* ------------------------------------------------------- */
             PARM       KWD(USID) TYPE(*CHAR) LEN(10) DFT(*CURRENT) +
                          SPCVAL((*CURRENT)) PMTCTL(CHGADD) +
                          PROMPT('User id.')

          /* ------------------------------------------------------- */
          /* Call source code                                        */
          /* ------------------------------------------------------- */
             PARM       KWD(CSRC) TYPE(*CHAR) LEN(1) RSTD(*YES) +
                          DFT(*TEL) SPCVAL((*TEL '0') (*EMAIL '1') +
                          ('*FAX' '2') ('*WWW' '3') ('*NOTES' '4')) +
                          PMTCTL(CHGADD) PROMPT('Call source code')

          /* ------------------------------------------------------- */
          /* User field 1                                            */
          /* ------------------------------------------------------- */
             PARM       KWD(USF1) TYPE(*CHAR) LEN(10) DFT(*SAME) +
                          PMTCTL(CHGADD) PROMPT('User field 1')

          /* ------------------------------------------------------- */
          /* User field 2                                            */
          /* ------------------------------------------------------- */
             PARM       KWD(USF2) TYPE(*CHAR) LEN(25) DFT(*SAME) +
                          PMTCTL(CHGADD) PROMPT('User field 2')

          /* ------------------------------------------------------- */
          /* User field 3                                            */
          /* ------------------------------------------------------- */
             PARM       KWD(USF3) TYPE(*DEC) LEN(15) DFT(*SAME) +
                          SPCVAL((*SAME 0)) PMTCTL(CHGADD) +
                          PROMPT('User field 3')

 /* ---------------------------------------------------------------- */
 /* API control codes                                                */
 /* ---------------------------------------------------------------- */

          /* ------------------------------------------------------- */
          /* Close indicator                                         */
          /* ------------------------------------------------------- */
             PARM       KWD(EOPI) TYPE(*CHAR) LEN(1) RSTD(*YES) +
                          DFT(*YES) SPCVAL((*YES 1) (*NO 0)) +
                          PMTCTL(KEYL) PROMPT('Close API indicator')

 /* ---------------------------------------------------------------- */
 /* Prompt controls                                                  */
 /* ---------------------------------------------------------------- */

          /* ------------------------------------------------------- */
          /* Key                                                     */
          /* ------------------------------------------------------- */
 KEYL:       PMTCTL     CTL(ACTC) COND((*EQ 20)) LGLREL(*OR)
             PMTCTL     CTL(ACTC) COND((*EQ 60)) LGLREL(*OR)
             PMTCTL     CTL(ACTC) COND((*EQ 40)) LGLREL(*OR)

          /* ------------------------------------------------------- */
          /* Add.                                                    */
          /* ------------------------------------------------------- */
 ADD:        PMTCTL     CTL(ACTC) COND((*EQ 60))

          /* ------------------------------------------------------- */
          /* Copy & add for the call track number.                   */
          /* ------------------------------------------------------- */
 CHGADD:     PMTCTL     CTL(ACTC) COND((*EQ 60))
             PMTCTL     CTL(ACTC) COND((*EQ 20)) LGLREL(*OR)

          /* ------------------------------------------------------- */
          /* Add.                                                    */
          /* ------------------------------------------------------- */
 CHGADDDEL:  PMTCTL     CTL(ACTC) COND((*EQ 60))
             PMTCTL     CTL(ACTC) COND((*EQ 40)) LGLREL(*OR)
             PMTCTL     CTL(ACTC) COND((*EQ 20)) LGLREL(*OR)

          /* ------------------------------------------------------- */
          /* Change, attributes can be entered                       */
          /* ------------------------------------------------------- */
 CHG:        PMTCTL     CTL(ACTC) COND((*EQ 20))

