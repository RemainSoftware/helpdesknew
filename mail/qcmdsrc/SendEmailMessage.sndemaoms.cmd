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
 /*   *$$ PGM(OMH032C)                                                        */
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
 /* Command ....: SNDEMAOMS                                          */
 /* Function ...: Send e-mail message                                */
 /* Author .....: Remain Software                                    */
 /*                                                                  */
 /* ---------------------------------------------------------------- */

             CMD        PROMPT('Send E-mail Message')

             PARM       KWD(SERVER) TYPE(*CHAR) LEN(15) +
                          DFT(*LOCALHOST) SPCVAL((*LOCALHOST +
                          '127.0.0.1')) MIN(0) CHOICE('*LOCALHOST, +
                          Server') PROMPT('Mail server')

             PARM       KWD(PORT) TYPE(*CHAR) LEN(4) DFT(*DFT) +
                          RANGE(0000 9999) SPCVAL((*DFT)) MIN(0) +
                          CHOICE('*DFT, port') PROMPT('Port')

             PARM       KWD(FROM) TYPE(*CHAR) LEN(50) MIN(1) +
                          CHOICE('Address') PROMPT('From')

             PARM       KWD(TO) TYPE(*CHAR) LEN(50) MIN(1) +
                          CHOICE('Address') PROMPT('To')

             PARM       KWD(BCC) TYPE(*CHAR) LEN(50) MIN(1) +
                          CHOICE('Address') PROMPT('Blind copy')

             PARM       KWD(SUBJ) TYPE(*CHAR) LEN(70) PROMPT('Subject')

             PARM       KWD(TYPE) TYPE(*CHAR) LEN(9) RSTD(*YES) +
                          DFT(*PLAIN) VALUES(*PLAIN *TEMPLATE) +
                          PROMPT('Plain text or use template')

             PARM       KWD(SRCF) TYPE(NAME1) PROMPT('Source file')

             PARM       KWD(SRCM) TYPE(*NAME) PROMPT('Member')

             PARM       KWD(HEDC) TYPE(*CHAR) LEN(5) PROMPT('Helpdesk')
             PARM       KWD(INC) TYPE(*CHAR) LEN(10) PROMPT('Incident')

 NAME1:      QUAL       TYPE(*NAME)
             QUAL       TYPE(*NAME) DFT(*LIBL) SPCVAL((*LIBL)) +
                          PROMPT('Library')

