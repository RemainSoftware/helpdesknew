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
