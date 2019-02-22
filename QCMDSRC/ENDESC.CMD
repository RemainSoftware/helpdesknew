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
 /*   *$$ PGM(OMH026C)                                                        */
 /*   *$$ MODE(*ALL)                                                          */
 /*   *$$ ALLOW(*ALL)                                                         */
 /*   *$$ PMTFILE(OMHDSP)                                                     */
 /*   *$$ MSGF(QCPFMSG)                                                       */
 /*   *$$ HLPPNLGRP(OMSCMDHD)                                                 */
 /*   *$$ HLPID(*CMD)                                                         */
 /*   *$$ HLPSCHIDX(REMAINHD)                                                 */
 /*   *$$\ENDOM                                                               */
 /* ---------------------------------------------------------------- */
 /* Description                                                      */
 /* ---------------------------------------------------------------- */
 /*                                                                  */
 /* Command ....: ENDESC                                             */
 /* Function ...: End escalation                                     */
 /* Author .....: Remain Software                                    */
 /*                                                                  */
 /* ---------------------------------------------------------------- */
             CMD        PROMPT('End Escalation Job if Active')

             PARM       KWD(HEDC) TYPE(*NAME) LEN(8) DFT(*ALL) +
                          SPCVAL((*ALL)) MIN(0) PROMPT(MQP0002 2) +
                          /* Help Desk */

