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
 /*   *$$ PGM(OMQCHGCOCP)                                                     */
 /*   *$$ MODE(*ALL)                                                          */
 /*   *$$ ALLOW(*ALL)                                                         */
 /*   *$$ PMTFILE(OMHDSP)                                                     */
 /*   *$$ MSGF(OMHMSG)                                                        */
 /*   *$$ HLPPNLGRP(OMSCMDHD)                                                 */
 /*   *$$ HLPID(*CMD)                                                         */
 /*   *$$ HLPSCHIDX(REMAINHD)                                                 */
 /*   *$$\ENDOM                                                               */
 /* ---------------------------------------------------------------- */
 /* Description                                                      */
 /* ---------------------------------------------------------------- */
 /*                                                                  */
 /* Command ....: OMQCHGCO                                           */
 /* Function ...: Change Customer Contact trough API                 */
 /* Author .....: Remain Software                                    */
 /*                                                                  */
 /* ---------------------------------------------------------------- */
             CMD        PROMPT('Change Customer Contact API')

          /* ------------------------------------------------------- */
          /* Action code                                             */
          /* ------------------------------------------------------- */
             PARM       KWD(ACTC) TYPE(*CHAR) LEN(2) RSTD(*YES) +
                          SPCVAL((*ADD 60) (*CHANGE 20) (*DELETE +
                          40) (*RENAME 21) (*CLOSE 99)) MIN(1) +
                          PROMPT('Action code' 1)

          /* ------------------------------------------------------- */
          /* Customer code                                           */
          /* ------------------------------------------------------- */
             PARM       KWD(CUSC) TYPE(*CHAR) LEN(10) PMTCTL(KEYL) +
                          PROMPT('Customer code')

          /* ------------------------------------------------------- */
          /* Customer Contact code                                   */
          /* ------------------------------------------------------- */
             PARM       KWD(CCTC) TYPE(*CHAR) LEN(10) PMTCTL(KEYL) +
                          PROMPT('Customer Contact code')

          /* ------------------------------------------------------- */
          /* Title                                                   */
          /* ------------------------------------------------------- */
             PARM       KWD(TITL) TYPE(*CHAR) LEN(30) DFT(*SAME) +
                          PMTCTL(CHGADD) PROMPT('Title')

          /* ------------------------------------------------------- */
          /* Contact name                                            */
          /* ------------------------------------------------------- */
             PARM       KWD(NAMD) TYPE(*CHAR) LEN(50) DFT(*SAME) +
                          PMTCTL(CHGADD) PROMPT('Name')

          /* ------------------------------------------------------- */
          /* Telephone                                               */
          /* ------------------------------------------------------- */
             PARM       KWD(TELN) TYPE(*CHAR) LEN(15) DFT(*SAME) +
                          PMTCTL(CHGADD) PROMPT('Telephone number')

          /* ------------------------------------------------------- */
          /* Contact status                                          */
          /* ------------------------------------------------------- */
             PARM       KWD(CNTI) TYPE(*CHAR) LEN(1) RSTD(*YES) +
                          DFT(*SAME) SPCVAL((*SAME ' ') (*NORMAL +
                          '0') (*DEFAULT '1') (*DISABLED '9')) +
                          PMTCTL(CHGADD) PROMPT('Status')

          /* ------------------------------------------------------- */
          /* E-mail                                                  */
          /* ------------------------------------------------------- */
             PARM       KWD(EMAC) TYPE(*CHAR) LEN(50) DFT(*SAME) +
                          PMTCTL(CHGADD) PROMPT('E-mail')

          /* ------------------------------------------------------- */
          /* E-mail template defaults                                */
          /* ------------------------------------------------------- */
             PARM       KWD(MTDI) TYPE(*CHAR) LEN(1) RSTD(*YES) +
                          DFT(*SAME) SPCVAL((*SAME ' ') (*NONE '9') +
                          (*CALC '1') (*SYSTEM '4') (*HELPDESK '3') +
                          (*CUSTOMER '2') (*CONTACT '0')) +
                          PMTCTL(CHGADD) PROMPT('E-mail templates +
                          to use')

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
 /* Other fields                                                     */
 /* ---------------------------------------------------------------- */

          /* ------------------------------------------------------- */
          /* New contact code                                        */
          /* ------------------------------------------------------- */
             PARM       KWD(NCCT) TYPE(*CHAR) LEN(10) +
                          PMTCTL(RENAME) PROMPT('New contact code')

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
 KEYL:       PMTCTL     CTL(ACTC) COND((*NE 99))

          /* ------------------------------------------------------- */
          /* Add.                                                    */
          /* ------------------------------------------------------- */
 ADD:        PMTCTL     CTL(ACTC) COND((*EQ 60))

          /* ------------------------------------------------------- */
          /* Rename                                                  */
          /* ------------------------------------------------------- */
 RENAME:     PMTCTL     CTL(ACTC) COND((*EQ 21))

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

