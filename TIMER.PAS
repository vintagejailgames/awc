{ WARNING !!! }

{ SI GASTEU AQUESTA UNIT NO OBLIDEU CRIDAR AL PROCEDIMENT: "AcabarCrono"    }
{ quan abandoneu el programa que el gasta, ja que no restaurarieu la        }
{ interrupci¢ per defecte del timer                                         }

unit TIMER;

interface

uses STimer,TAux;

type
	temps=
  	record
    	total: real;
      segons,
      decimes,
			centesimes,
			milesimes: integer;
      enmarxa: boolean;
    end;

var
	c1,c2: integer;					{ vbles que usar… el timer per a fer-ho igual     }
	c: longint;							{ variable que incrementar… el timer per al crono }
  OldHandler: pointer;		{ guardarem la interrupci¢ per defecte del timer  }
  time: temps;						{ variable de tipus temps                         }

  procedure StartCrono;
  procedure StopCrono;
  procedure ResetCrono;
  procedure AcabarCrono;
	function CronoRunning: boolean;
  procedure CalculaTemps;
  procedure NouTimer;

implementation

(* ************************************ *)
(* PER A POSAR EN FUNCIONAMENT EL CRONO *)
(* ************************************ *)
procedure StartCrono;
	begin
  	time.enmarxa:= true;
    time.total:= 0;
    time.segons:= 0;
    time.decimes:= 0;
		time.centesimes:= 0;
    time.milesimes:= 0;
  end;

(* ************************************ *)
(*         PER A PARAR EL CRONO         *)
(* ************************************ *)
procedure StopCrono;
  begin
  	time.enmarxa:= false;
  end;

(* ********************************** *)
(*     POSA A ZERO EL CRONOMETRE      *)
(* ********************************** *)
procedure ResetCrono;
	begin
    c:= 0;
    time.enmarxa:= false;
    time.total:= 0;
    time.segons:= 0;
    time.decimes:= 0;
		time.centesimes:= 0;
    time.milesimes:= 0;
  end;

(* *************************************** *)
(* PER A RESTAURAR LA INTERRUPCIà ORIGINAL *)
(* *************************************** *)
procedure AcabarCrono;
	begin
  	Timer_Done;
  end;

(* ****************************************** *)
(* FUNCIà QUE TORNA SI EL CRONO EST· EN MARXA *)
(* ****************************************** *)
function CronoRunning: boolean;
	begin
    CronoRunning:= (time.enmarxa);
  end;

(* ************************************* *)
(* COMPOSA EL TEMPS EN UNA VARIABLE REAL *)
(* ************************************* *)
procedure CalculaTemps;
	begin
  	time.total:= time.segons + (time.decimes * 0.1) + (time.centesimes * 0.01) + (time.milesimes * 0.001);
  end;

(* ********************************************* *)
(* PASA LA VARIABLE DEL TIMER A DÔCIMES I SEGONS *)
(* ********************************************* *)
procedure CalculaNumeros(c: longint);
	begin
    time.segons:= (c div 1024);
    c:= c - time.segons * 1024;
    time.decimes:= (c div 102) mod 10;		{ en lloc de 102 deuria ser 102.4 }
    c:= c - time.decimes * 102;
    time.centesimes:= (c div 10) mod 10;	{ en lloc de 10 deuria ser 10.24  }
    c:= c - time.centesimes * 10;
    time.milesimes:= c mod 10;
    CalculaTemps;
  end;

(* ********************************** *)
(* PROCEDIMENT AL QUAL CRIDA EL TIMER *)
(* ********************************** *)
procedure TimeHandler(l : longint); far;
		begin
  		inc(c1);
			if (c1 = 50)
				then
      		begin
        		inc(c2);
	          c1:= 0;
  	      end;
      if time.enmarxa
			then
				begin
					inc(c,1);
          CalculaNumeros(c);
        end;
	  end;

(* ********************************** *)
(*     NOVA INTERRUPCIà DEL TIMER     *)
(* ********************************** *)
procedure NouTimer;
	begin
  	OldHandler:= @TimerHandler;
    Timer_Init(10000);
    Timer_SetHandler(TimeHandler);
    ResetCrono;
  end;

end.
