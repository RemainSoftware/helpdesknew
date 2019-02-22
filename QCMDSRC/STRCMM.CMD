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
 /*   *$$ PGM(OMH041C)                                                        */
 /*   *$$ MODE(*ALL)                                                          */
 /*   *$$ ALLOW(*ALL)                                                         */
 /*   *$$ PMTFILE(*NONE)                                                      */
 /*   *$$ MSGF(QCPFMSG)                                                       */
 /*   *$$ HLPPNLGRP(OMSCMDHD)                                                 */
 /*   *$$ HLPID(*CMD)                                                         */
 /*   *$$ HLPSCHIDX(REMAINHD)                                                 */
 /*   *$$\ENDOM                                                               */
             CMD        PROMPT('Customer Mail Extensions')

             PARM       KWD(CUSC) TYPE(*CHAR) LEN(10) MIN(1) +
                          CHOICE('Customer code') PROMPT('Customer +
                          code')

             PARM       KWD(STAT) TYPE(*CHAR) LEN(5) CONSTANT(' ')
