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
 /*   *$$ PGM(OMH048)                                                         */
 /*   *$$ MODE(*ALL)                                                          */
 /*   *$$ ALLOW(*INTERACT *IPGM *IREXX *EXEC *IMOD)                           */
 /*   *$$ PMTFILE(OMHDSP)                                                     */
 /*   *$$ MSGF(OMHMSG)                                                        */
 /*   *$$ HLPPNLGRP(OMSCMD)                                                   */
 /*   *$$ HLPID(*CMD)                                                         */
 /*   *$$ HLPSCHIDX(REMAIN)                                                   */
 /*   *$$\ENDOM                                                               */
             CMD        PROMPT('Predefined Text Maintenance')

             PARM       KWD(HEDC) TYPE(*CHAR) LEN(5) DFT(*CURRENT) +
                          SPCVAL((*CURRENT '     ')) +
                          CHOICE('Code, *CURRENT') +
                          PROMPT('HelpDesk')

             PARM       KWD(STAT) TYPE(*CHAR) LEN(5) CONSTANT(' ')
