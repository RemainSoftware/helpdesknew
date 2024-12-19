      *  -------------------------------------------------------------
      *  The MIT License (MIT)
      *
      *  Copyright (c) 2019 Remain (https://remainsoftware.com)
      *
      *  Permission is hereby granted, free of charge, to any person 
      *  obtaining a copy of this software and associated documentation 
      *  files (the "Software"), to deal in the Software without 
      *  restriction, including without limitation the rights to use, 
      *  copy, modify, merge, publish, distribute, sublicense, and/or 
      *  sell copies of the Software, and to permit persons to whom 
      *  the Software is furnished to do so, subject to the following 
      *  conditions:
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
      *  -------------------------------------------------------------


      *
      *          ------------------------------------------
      *          API parameter definition.
      *
      *          All fields start with 'P#', followed by a three
      *          character meaningfull code and end with;
      *
      *          # -  4 byte binary number
      *          Q - 20 byte qualifier
      *          C - xx byte code field
      *          D - xx byte description field
      *          A - Array
      *            - Buffer field
      *          ------------------------------------------
      *
      *          ------------------------------------------
      *          Do not initialise fields
      *          ------------------------------------------
     C     'PASEN'       IFEQ      'PINKSTRN'
      *
      *          ------------------------------------------
      *          Define internal references
      *          (other references come from OMSREF)
      *          ------------------------------------------
     C                   MOVE      *BLANKS       $OBJC$           10
     C                   MOVE      *BLANKS       $QUAL$           20
     C                   MOVE      *BLANKS       $CD4A$            4
     C                   MOVE      *BLANKS       $HNDC$            8
     C                   MOVE      *BLANKS       $FMTC$            8
      *
      *          ------------------------------------------
      *          Define fields used by API's.
      *          ------------------------------------------
     C     *LIKE         DEFINE    INDI          P#ATAC
     C     *LIKE         DEFINE    $OBJC$        P#AFNC
      *
     C     *LIKE         DEFINE    INDI          P#CLOC
     C     *LIKE         DEFINE    INDI          P#COPC
     C     *LIKE         DEFINE    INDI          P#CPOC
     C     *LIKE         DEFINE    $QUAL$        P#CMDQ
      *
     C     *LIKE         DEFINE    $CD4A$        P#DPAC
      *
     C     *LIKE         DEFINE    AUTH          P#EXAC
     C     *LIKE         DEFINE    $CD4A$        P#ELEC
     C     *LIKE         DEFINE    INDI          P#EJOC
     C     *LIKE         DEFINE    INDI          P#ELAC
      *
     C     *LIKE         DEFINE    $OBJC$        P#FMIC
     C     *LIKE         DEFINE    $OBJC$        P#FMOC
     C     *LIKE         DEFINE    $FMTC$        P#FMTC
     C     *LIKE         DEFINE    INDI          P#FSHC
     C     *LIKE         DEFINE    INDI          P#FRCC
     C     *LIKE         DEFINE    $CD4A$        P#FXLC
      *
     C     *LIKE         DEFINE    $HNDC$        P#HNDC
      *
     C     *LIKE         DEFINE    INDI          P#IVAC
     C     *LIKE         DEFINE    INDI          P#IMUC
      *
     C     *LIKE         DEFINE    $CD4A$        P#KEYC
     C     *LIKE         DEFINE    INDI          P#KINC
      *
     C     *LIKE         DEFINE    $OBJC$        P#LSTC
     C     *LIKE         DEFINE    $CD4A$        P#LEHC
     C     *LIKE         DEFINE    $CD4A$        P#LCOC
     C     *LIKE         DEFINE    $CD4A$        P#LLEC
      *
     C     *LIKE         DEFINE    MSID          P#MIDC
     C     *LIKE         DEFINE    $QUAL$        P#MSGQ
     C     *LIKE         DEFINE    $OBJC$        P#MSTC
     C     *LIKE         DEFINE    $OBJC$        P#MTRC
     C     *LIKE         DEFINE    $CD4A$        P#MSKC
     C     *LIKE         DEFINE    $OBJC$        P#MSAC
     C     *LIKE         DEFINE    $CD4A$        P#MRKC
      *
     C     *LIKE         DEFINE    $QUAL$        P#OALQ
     C     *LIKE         DEFINE    $CD4A$        P#OPTC
     C     *LIKE         DEFINE    INDI          P#OVRC
     C     *LIKE         DEFINE    $OBJC$        P#OBTC
     C     *LIKE         DEFINE    INDI          P#OPMC
      *
     C     *LIKE         DEFINE    $OBJC$        P#PNLC
     C     *LIKE         DEFINE    $OBJC$        P#PMQC
     C     *LIKE         DEFINE    $CD4A$        P#POSC
     C     *LIKE         DEFINE    $QUAL$        P#PDFQ
     C     *LIKE         DEFINE    $QUAL$        P#PNLQ
     C     *LIKE         DEFINE    $QUAL$        P#PMQQ
     C     *LIKE         DEFINE    $OBJC$        P#PWLC
     C     *LIKE         DEFINE    AUTH          P#PAUC
     C     *LIKE         DEFINE    $OBJC$        P#PDVC
      *
     C     *LIKE         DEFINE    INDI          P#RMQQ
     C     *LIKE         DEFINE    INDI          P#RDOC
     C     *LIKE         DEFINE    $OBJC$        P#RDMC
     C     *LIKE         DEFINE    $OBJC$        P#RPLC
     C     *LIKE         DEFINE    $OBJC$        P#RFCC
     C     *LIKE         DEFINE    $OBJC$        P#RSVC
     C     *LIKE         DEFINE    INDI          P#ROPC
      *
     C     *LIKE         DEFINE    $QUAL$        P#SECC
     C     *LIKE         DEFINE    $CD4A$        P#SHNC
     C     *LIKE         DEFINE    INDI          P#SODC
      *
      ****new DB desc. in graphic format can not be used
     C                   MOVE      *BLANKS       P#TXTD           50
      *
      ****new DB desc. in graphic format can not be used
     C                   MOVE      *BLANKS       P#USPD           50
     C     *LIKE         DEFINE    $QUAL$        P#USPQ
     C     *LIKE         DEFINE    $QUAL$        P#UIXQ
     C     *LIKE         DEFINE    INDI          P#USTC
     C     *LIKE         DEFINE    $OBJC$        P#USDT
      *
     C     *LIKE         DEFINE    $OBJC$        P#VRNC
      *
     C     *LIKE         DEFINE    INDI          P#XOPC
      *
     C                   ENDIF
