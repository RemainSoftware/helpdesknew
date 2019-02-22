 /* ---------------------------------------------------------------- */
 /*  Copyright (c) 2019 Remain BV (https://remainsoftware.com)       */
 /*                                                                  */
 /*  This program and the accompanying materials are made            */
 /*  available under the terms of the Eclipse Public License 2.0     */
 /*  which accompanies this distribution, and is available at        */
 /*  https://www.eclipse.org/legal/epl-2.0/                          */
 /*                                                                  */
 /*  SPDX-License-Identifier: EPL-2.0                                */
 /*                                                                  */
 /*  Contributors:                                                   */
 /*      Remain Software - initial API and implementation            */
 /*                                                                  */
 /* ---------------------------------------------------------------- */


 /*   *$$\CRTOM CRTCMD                                                        */
 /*   *$$ PGM(OMQRTVCOCP)                                                     */
 /*   *$$ MODE(*ALL)                                                          */
 /*   *$$ ALLOW(*BPGM *IPGM *BREXX *IREXX *BMOD *IMOD)                        */
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
 /* Command ....: OMQRTVCO                                           */
 /* Function ...: Retrieve Customer Contact                          */
 /* Author .....: Remain Software                                    */
 /* Module .....: Helpdesk                                           */
 /*                                                                  */
 /* ---------------------------------------------------------------- */
             CMD        PROMPT('Retrieve Customer Contact')

          /* ------------------------------------------------------- */
          /* Customer                                                */
          /* ------------------------------------------------------- */
             PARM       KWD(CUSC) TYPE(*CHAR) LEN(10) MIN(1) +
                          PROMPT('Customer')

          /* ------------------------------------------------------- */
          /* Customer contact                                        */
          /* ------------------------------------------------------- */
             PARM       KWD(CCTC) TYPE(*CHAR) LEN(10) DFT(*DFT) +
                          PROMPT('Customer contact')

          /* ------------------------------------------------------- */
          /* Returnval for title                                     */
          /* ------------------------------------------------------- */
             PARM       KWD(TITEL) TYPE(*CHAR) LEN(30) RTNVAL(*YES) +
                          PROMPT('CL var for TITEL        (30)')

          /* ------------------------------------------------------- */
          /* Returnval for name                                      */
          /* ------------------------------------------------------- */
             PARM       KWD(NAME)   TYPE(*CHAR) LEN(50) RTNVAL(*YES) +
                          PROMPT('CL var for NAME         (50)')

          /* ------------------------------------------------------- */
          /* Returnval for telephone                                 */
          /* ------------------------------------------------------- */
             PARM       KWD(TEL) TYPE(*CHAR) LEN(15) RTNVAL(*YES) +
                          PROMPT('CL var for TEL          (15)')

          /* ------------------------------------------------------- */
          /* Returnval for Email                                     */
          /* ------------------------------------------------------- */
             PARM       KWD(EMAIL) TYPE(*CHAR) LEN(50) +
                          RTNVAL(*YES) PROMPT('CL var for +
                          EMAIL        (50)')

          /* ------------------------------------------------------- */
          /* Returnval for User field 1                              */
          /* ------------------------------------------------------- */
             PARM       KWD(USF1) TYPE(*CHAR) LEN(10) RTNVAL(*YES) +
                          PROMPT('CL var for USF1         (10)')

          /* ------------------------------------------------------- */
          /* Returnval for User field 2                              */
          /* ------------------------------------------------------- */
             PARM       KWD(USF2) TYPE(*CHAR) LEN(25) RTNVAL(*YES) +
                          PROMPT('CL var for USF2         (25)')

          /* ------------------------------------------------------- */
          /* Returnval for User field 3                              */
          /* ------------------------------------------------------- */
             PARM       KWD(USF3) TYPE(*DEC) LEN(15 0) RTNVAL(*YES) +
                          PROMPT('CL var for USF3       (15 0)')
