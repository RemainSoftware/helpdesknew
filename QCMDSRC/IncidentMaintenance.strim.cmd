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
 /*   *$$ PGM(OMH018C)                                                        */
 /*   *$$ MODE(*ALL)                                                          */
 /*   *$$ ALLOW(*INTERACT *IPGM *IREXX *EXEC *IMOD)                           */
 /*   *$$ PMTFILE(OMHDSP)                                                     */
 /*   *$$ MSGF(OMHMSG)                                                        */
 /*   *$$ HLPPNLGRP(OMSCMDHD)                                                 */
 /*   *$$ HLPID(*CMD)                                                         */
 /*   *$$ HLPSCHIDX(REMAINHD)                                                 */
 /*   *$$\ENDOM                                                               */
             CMD        PROMPT('Incident Maintenance')

             PARM       KWD(HEDC) TYPE(*CHAR) LEN(5) DFT(*CURRENT) +
                          SPCVAL((*BLANKS ' ') (*CURRENT ' ')) +
                          CHOICE('Code, *CURRENT') PROMPT('HelpDesk')

             PARM       KWD(CTN) TYPE(*CHAR) LEN(10) DFT(*ALL) +
                          SPCVAL((*BLANKS ' ') (*ALL ' ')) +
                          CHOICE('Call number, *ALL') +
                          PROMPT('Customer Call Number')

             PARM       KWD(CUSC) TYPE(*CHAR) LEN(10) DFT(*ALL) +
                          SPCVAL((*ALL ' ')) CHOICE('Code, *ALL') +
                          PROMPT('Customer')

             PARM       KWD(CCTC) TYPE(*CHAR) LEN(10) DFT(*ALL) +
                          SPCVAL((*ALL ' ')) CHOICE('Code, *ALL') +
                          PROMPT('Customer Contact')

             PARM       KWD(STAT) TYPE(*CHAR) LEN(5) CONSTANT(' ')
