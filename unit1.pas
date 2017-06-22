UNIT UNIT1;
{$MODE OBJFPC}{$H+}
INTERFACE
USES
  DOS,CRT,CLASSES, SYSUTILS, FILEUTIL, FORMS, CONTROLS, GRAPHICS, DIALOGS, STDCTRLS,
  COMCTRLS, MENUS, EDITBTN, EXTCTRLS, EXTDLGS, VALEDIT, SPIN,unit2;
TYPE

  { TFORM1 }

  TFORM1 = CLASS(TFORM)
    MAINMENU1: TMAINMENU;
    MENUITEM1: TMENUITEM;
    MENUITEM2: TMENUITEM;
    RYSUJ: TBUTTON;
    NASTEPNE: TBUTTON;
    POPRZEDNIE: TBUTTON;
    STATUSBAR1: TSTATUSBAR;
    ZAPISJPEG: TBUTTON;
    WEJSCIE_N: TEDIT;
    KOMUNIKAT: TLABEL;
    PROCEDURE BUTTON1CLICK(SENDER: TOBJECT);
    PROCEDURE MENUITEM1CLICK(SENDER: TOBJECT);
    PROCEDURE MENUITEM2CLICK(SENDER: TOBJECT);
    PROCEDURE RYSUJCLICK(SENDER: TOBJECT);
    PROCEDURE NASTEPNECLICK(SENDER: TOBJECT);
    PROCEDURE POPRZEDNIECLICK(SENDER: TOBJECT);
    PROCEDURE ZAPISJPEGCLICK(SENDER: TOBJECT);
    PROCEDURE WEJSCIE_NCHANGE(SENDER: TOBJECT);
  PRIVATE
  PUBLIC
  END;
VAR
FORM1: TFORM1;
 W:CARDINAL;
 N:BYTE  ;
 J,I,I2,KOLEJNE:INTEGER;
IMPLEMENTATION
{==============================}

PROCEDURE POTENGAN;
VAR J:CARDINAL;
    POT:BYTE;
    BEGIN
    W:=1;
    POT:=2*N;
             FOR J:=1 TO POT DO
             W := W * 2;
WRITELN('2^',2*N,' = ', W);
END;
/////////////////////////////////////////////////////
PROCEDURE BIN;
VAR
S:STRING;
ILE3,I:CARDINAL ;
LS,LS1:BYTE;
LL:SHORTINT;
PLIKBIN:TEXT;
BEGIN
I:=0;
ILE3:=0;
ASSIGN(PLIKBIN,'CIAGIBINARNECATALANA.TXT');
REWRITE(PLIKBIN);
FOR I:=1 TO W DO
BEGIN
         S:=BINSTR(i,2*N);
         LS:=0;
         LS1:=0;
         FOR LL := 1 TO LENGTH(S) DO
         BEGIN
            IF S[LL]='0'THEN LS:=LS+1; {LICZENIE ZER}
             IF S[LL]='1'THEN LS1:=LS1+1;
                  IF LS>=LS1 THEN ELSE BREAK;
                    IF LL=LENGTH(S) THEN
                       IF LS=LS1 THEN
                                 BEGIN WRITELN(PLIKBIN,S); ILE3:=ILE3+1; {WRITELN(S);}
                                 END;
         END;
END;
{WRITELN('LICZBA CIAGOW CATALANA ', ILE3);
WRITELN(PLIKBIN,'LICZBA CIAGOW CATALANA ', ILE3);
        WRITELN(PLIKBIN,'N= ', N); }
CLOSE(PLIKBIN);
END;
//////////////////////////////////////////////////////////////////////////////
{$R *.LFM}
PROCEDURE TFORM1.MENUITEM1CLICK(SENDER: TOBJECT);
BEGIN
close;
END;
PROCEDURE TFORM1.MENUITEM2CLICK(SENDER: TOBJECT);
BEGIN
         FORM2:=TFORM2.CREATE(FORM1);
        FORM2.SHOW;
END;
PROCEDURE TFORM1.RYSUJCLICK(SENDER: TOBJECT);
VAR
{I:INTEGER;}
X,Y,WIELKOSC:INT64;
PLIKBIN:TEXT;
ZNAK:CHAR;
BEGIN
CANVAS.BRUSH.COLOR:=CLDEFAULT;
CANVAS.FILLRECT(0,0,WIDTH,HEIGHT);
CANVAS.BRUSH.COLOR:=CLWHITE;
CASE WEJSCIE_N.CAPTION OF
'1':BEGIN N:=1; KOMUNIKAT.CAPTION:='N = 1';  END;
'2':BEGIN N:=2; KOMUNIKAT.CAPTION:='N = 2';  END;
'3':BEGIN N:=3; KOMUNIKAT.CAPTION:='N = 3';  END;
'4':BEGIN N:=4; KOMUNIKAT.CAPTION:='N = 4';  END;
'5':BEGIN N:=5; KOMUNIKAT.CAPTION:='N = 5';  END;
'6':BEGIN N:=6; KOMUNIKAT.CAPTION:='N = 6';  END;
'7':BEGIN N:=7; KOMUNIKAT.CAPTION:='N = 7';  END;
'8':BEGIN N:=8; KOMUNIKAT.CAPTION:='N = 8';  END;
'9':BEGIN N:=9; KOMUNIKAT.CAPTION:='N = 9';  END;
'10':BEGIN N:=10; KOMUNIKAT.CAPTION:='N = 10';  END;
ELSE KOMUNIKAT.CAPTION:='BLENDNE N';
END;
Canvas.Pen.Width := 2;
POTENGAN;
BIN;
I:=0;
ASSIGNFILE(PLIKBIN,'CIAGIBINARNECATALANA.TXT');
RESET(PLIKBIN);
X:=0;
Y:=100;
WIELKOSC:=5;
WHILE NOT EOF(PLIKBIN) DO BEGIN
           READ(PLIKBIN,ZNAK);
                  IF ZNAK<>CHAR(13) THEN
BEGIN
      BEGIN
             IF ZNAK='0'THEN
                 BEGIN
              CANVAS.PEN.COLOR := CLRED;
CANVAS.LINE(X,Y,X+WIELKOSC,Y-WIELKOSC);
                 Y:=Y-WIELKOSC;
                 X:=X+WIELKOSC;
                 END;
             IF ZNAK='1'THEN
                 BEGIN
                CANVAS.PEN.COLOR := CLGREEN;
CANVAS.LINE(X,Y,X+WIELKOSC,Y+WIELKOSC);
                 Y:=Y+WIELKOSC;
                 X:=X+WIELKOSC;
                 END;
    END;
END
             ELSE
             BEGIN X:=X+WIELKOSC;
              I:=I+1;
  IF I=10 THEN BEGIN Y:=Y+N*WIELKOSC;X:=0;I:=0; END;
             END;
END;
         CLOSEFILE(PLIKBIN);
         I:=0;
END;

  {ZAPIS DO PLIKU!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!}
PROCEDURE TFORM1.ZAPISJPEGCLICK(SENDER: TOBJECT);
 VAR
   PLIKBIN:TEXT;
ZNAK:CHAR;
   JPEG :TJPEGIMAGE;
   //MOZNA UZYC DOWOLNEJ KLASY: TGIFIMAGE, TPORTABLENETWORKGRAPHIC ITD.
    WIERSZE,IJ,KTORY:INTEGER;
    X,WIELKOSC,LICZ:INTEGER;
    Y,SZEROKOSC :INTEGER;
       POINTS :ARRAY [0..1000000] OF TPOINT;
   SAVEDIALOG :TSAVEDIALOG;
BEGIN
   JPEG := TJPEGIMAGE.CREATE;
   SAVEDIALOG := TSAVEDIALOG.CREATE(NIL);

   //////////////////////

   JPEG.CANVAS.PEN.COLOR := CLWHITE;
       ASSIGNFILE(PLIKBIN,'CIAGIBINARNECATALANA.TXT');
RESET(PLIKBIN);
X:=0;
WIELKOSC:=3;
Y:=WIELKOSC*N;
SZEROKOSC:=0;
I:=0;
I2:=1;
POINTS[0] := POINT(X, Y);

WHILE NOT EOF(PLIKBIN) DO BEGIN
           READ(PLIKBIN,ZNAK);
                  IF ZNAK<>CHAR(13) THEN     //SPRAWDZAJ CZY KONIEC  CIAGU/WYKRESU
BEGIN
      BEGIN
             IF ZNAK='0'THEN
                 BEGIN
                 POINTS[I2] := POINT(X, Y);
                         I2:=I2+1;
 //POINTS[I2] := POINT(X+WIELKOSC,Y-WIELKOSC);
 //JPEG.CANVAS.POLYLINE(POINTS, I2-1, I2);
                 Y:=Y-WIELKOSC;
                 X:=X+WIELKOSC;
                   POINTS[I2] := POINT(X, Y);
                 I2:=I2+1;
                 END;
             IF ZNAK='1'THEN
                 BEGIN
                 POINTS[I2] := POINT(X, Y);
                       I2:=I2+1;
//POINTS[I2] := POINT(X+WIELKOSC,Y+WIELKOSC);
//JPEG.CANVAS.POLYLINE(POINTS, I2-1, I2);
                 Y:=Y+WIELKOSC;
                 X:=X+WIELKOSC;
                   POINTS[I2] := POINT(X, Y);
                 I2:=I2+1;
                 END;
    END;
END
             ELSE
             BEGIN X:=X+WIELKOSC;      //ROB ODSTEP POMIEDZY WYKRESAMI
             IF X>SZEROKOSC THEN SZEROKOSC:=X ; //SPRAWDZANIE SZEOKOSCI DO JPEG'A
              I:=I+1;

        IF N<7 THEN  BEGIN

   IF I=10 THEN BEGIN
 POINTS[I2] := POINT(0, Y);
 I2:=I2+1;
  POINTS[I2] := POINT(X, Y);
 I2:=I2+1;
  POINTS[I2] := POINT(X, Y+30);
      I2:=I2+1;
       POINTS[I2] := POINT(0, Y+30);
                 I2:=I2+1;
                 Y:=Y+30;X:=0;I:=0;
   END;
            END;
            IF N<8 THEN  BEGIN

   IF I=20 THEN BEGIN
 POINTS[I2] := POINT(0, Y);
 I2:=I2+1;
  POINTS[I2] := POINT(X, Y);
 I2:=I2+1;
  POINTS[I2] := POINT(X, Y+30);
      I2:=I2+1;
       POINTS[I2] := POINT(0, Y+30);
                 I2:=I2+1;
                 Y:=Y+30;X:=0;I:=0;
   END;
            END;
IF N<9 THEN  BEGIN

   IF I=35 THEN BEGIN
 POINTS[I2] := POINT(0, Y);
 I2:=I2+1;
  POINTS[I2] := POINT(X, Y);
 I2:=I2+1;
  POINTS[I2] := POINT(X, Y+30);
      I2:=I2+1;
       POINTS[I2] := POINT(0, Y+30);
                 I2:=I2+1;
                 Y:=Y+30;X:=0;I:=0;
   END;
            END;
             IF N<10 THEN  BEGIN

    IF I=60 THEN BEGIN
  POINTS[I2] := POINT(0, Y);
  I2:=I2+1;
   POINTS[I2] := POINT(X, Y);
  I2:=I2+1;
   POINTS[I2] := POINT(X, Y+30);
       I2:=I2+1;
        POINTS[I2] := POINT(0, Y+30);
                  I2:=I2+1;
                  Y:=Y+30;X:=0;I:=0;
    END;
             END;
       IF N<11 THEN  BEGIN

    IF I=100 THEN BEGIN
  POINTS[I2] := POINT(0, Y);
  I2:=I2+1;
   POINTS[I2] := POINT(X, Y);
  I2:=I2+1;
   POINTS[I2] := POINT(X, Y+30);
       I2:=I2+1;
        POINTS[I2] := POINT(0, Y+30);
                  I2:=I2+1;
                  Y:=Y+30;X:=0;I:=0;
    END;
             END;


             END;
END;
JPEG.WIDTH :=SZEROKOSC-3;
JPEG.HEIGHT := Y;
         CLOSEFILE(PLIKBIN);
   IJ:=0;
   KTORY:=1;

  JPEG.CANVAS.POLYLINE(POINTS,0, I2);        //RYSUJ DO JPEG

      { FOR LICZ:=0 TO I2  DO
BEGIN
    IF  IJ<(2*N+2)   THEN  BEGIN
                           IJ:=IJ+1;
                          KTORY:=KTORY+1 ;
                           JPEG.CANVAS.POLYLINE(POINTS,KTORY-1, KTORY);
                  END
                          ELSE
                          BEGIN
                             IJ:=0;
                          KTORY:=KTORY+1;
                 END;
       END;

        }
    SAVEDIALOG.DEFAULTEXT := 'JPG';
    JPEG.COMPRESSIONQUALITY := 90;
    IF SAVEDIALOG.EXECUTE THEN
      JPEG.SAVETOFILE(SAVEDIALOG.FILENAME);
    JPEG.FREE;
    SAVEDIALOG.FREE;
       END;
PROCEDURE TFORM1.WEJSCIE_NCHANGE(SENDER: TOBJECT);
BEGIN
END;
PROCEDURE TFORM1.NASTEPNECLICK(SENDER: TOBJECT);
 VAR
 {I:INTEGER;}
 X,Y,WIELKOSC:INT64;
 PLIKBIN:TEXT;
 ZNAK:CHAR;
 BEGIN
   CANVAS.BRUSH.COLOR:=CLDEFAULT;
  CANVAS.FILLRECT(0,0,WIDTH,HEIGHT);
  CANVAS.BRUSH.COLOR:=CLWHITE;
 J:=J+1;
 I:=1;
 ASSIGNFILE(PLIKBIN,'CIAGIBINARNECATALANA.TXT');
 RESET(PLIKBIN);
 X:=0;
 Y:=100;
 WIELKOSC:=5;
 WHILE NOT EOF(PLIKBIN) DO BEGIN
            READ(PLIKBIN,ZNAK);
                   IF ZNAK<>CHAR(13) THEN
                       BEGIN
                       BEGIN
                                         IF ZNAK='0'THEN
                                             BEGIN
                                             IF I=J THEN  BEGIN   CANVAS.PEN.COLOR := CLYELLOW; CANVAS.LINE(X,Y,X+WIELKOSC,Y-WIELKOSC);
                                             END
                                             ELSE;
                                             Y:=Y-WIELKOSC;
                                             X:=X+WIELKOSC;
                                             END;
                                         IF ZNAK='1'THEN
                                             BEGIN
                                             IF I=J THEN
                                                IF I=J THEN  BEGIN  CANVAS.PEN.COLOR := CLBLUE; CANVAS.LINE(X,Y,X+WIELKOSC,Y+WIELKOSC);END
                                             ELSE;
                  Y:=Y+WIELKOSC;
                  X:=X+WIELKOSC;
                                             END;
                       END;
                       END
                   ELSE
                   BEGIN
                          I:=I+1;
                          X:=0;
                   END;
 END;
 CLOSEFILE(PLIKBIN);
 END;

PROCEDURE TFORM1.POPRZEDNIECLICK(SENDER: TOBJECT);
 VAR
 {I:INTEGER;}
 X,Y,WIELKOSC:INT64;
 PLIKBIN:TEXT;
 ZNAK:CHAR;
 BEGIN
  CANVAS.BRUSH.COLOR:=CLDEFAULT;
  CANVAS.FILLRECT(0,0,WIDTH,HEIGHT);
  CANVAS.BRUSH.COLOR:=CLWHITE;
J:=J-1;
 I:=1;
 ASSIGNFILE(PLIKBIN,'CIAGIBINARNECATALANA.TXT');
 RESET(PLIKBIN);
 X:=0;
 Y:=100;
 WIELKOSC:=5;
 WHILE NOT EOF(PLIKBIN) DO BEGIN
            READ(PLIKBIN,ZNAK);
                   IF ZNAK<>CHAR(13) THEN
                       BEGIN
                       BEGIN
                                         IF ZNAK='0'THEN
                                             BEGIN
                                             IF I=J THEN  BEGIN  CANVAS.PEN.COLOR := CLWHITE; CANVAS.LINE(X,Y,X+WIELKOSC,Y-WIELKOSC);
                                             END
                                             ELSE;
                                             Y:=Y-WIELKOSC;
                                             X:=X+WIELKOSC;
                                             END;
                                         IF ZNAK='1'THEN
                                             BEGIN
                                             IF I=J THEN
                                                IF I=J THEN  BEGIN  CANVAS.PEN.COLOR := CLBLACK; CANVAS.LINE(X,Y,X+WIELKOSC,Y+WIELKOSC);  END
                                             ELSE;
                                             Y:=Y+WIELKOSC;
                                             X:=X+WIELKOSC;
                                             END;
                       END;
                       END
                   ELSE
                   BEGIN
                          I:=I+1;
                          X:=0;
                   END;
 END;
 CLOSEFILE(PLIKBIN);
 END;
PROCEDURE TFORM1.BUTTON1CLICK(SENDER: TOBJECT);
 VAR
 {I:INTEGER;}
 X,Y,WIELKOSC:INT64;
 PLIKBIN:TEXT;
 ZNAK:CHAR;
 BEGIN
 I:=-1;
 ASSIGNFILE(PLIKBIN,'CIAGIBINARNECATALANA.TXT');
 RESET(PLIKBIN);
 X:=0;
 Y:=100;
 WIELKOSC:=5;
 WHILE NOT EOF(PLIKBIN) DO BEGIN
            READ(PLIKBIN,ZNAK);
                   IF ZNAK<>CHAR(13) THEN
 BEGIN
       BEGIN
              IF ZNAK='0'THEN
                  BEGIN
           IF I=J THEN  BEGIN   CANVAS.LINE(X,Y,X+WIELKOSC,Y-WIELKOSC); END
           ELSE;
                  Y:=Y-WIELKOSC;
                  X:=X+WIELKOSC;
                  END;
              IF ZNAK='1'THEN
                  BEGIN
                  IF I=J THEN
  IF I=J THEN  BEGIN CANVAS.LINE(X,Y,X+WIELKOSC,Y+WIELKOSC);   END
                  ELSE ;
                  Y:=Y+WIELKOSC;
                  X:=X+WIELKOSC;
                  END;
       END;
 END
                   ELSE
                   BEGIN
                    I:=I+1;
                    X:=0;
                   END;
 END;
          CLOSEFILE(PLIKBIN);
END;
END.

