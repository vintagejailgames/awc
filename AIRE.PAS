unit aire;

interface

uses TAux;

	procedure NouVent;
  procedure GeneraVent;

implementation

(* *********************************************************************** *)
(*                       FA VARIAR UNA MIQUETA EL VENT                     *)
(* *********************************************************************** *)
procedure NouVent;
	var
  	r: real;

	begin
  	r:= random(4)/10;
    if (random(2) = 0)
			then vent.forsa:= vent.forsa + r
      else vent.forsa:= vent.forsa - r;
    if (vent.forsa > 3.9) then vent.forsa:= 3.9;
    if (vent.forsa < -3.9) then vent.forsa:= -3.9;
    vent.fletxa:= 155;
    vent.numerosx:= 152;
  end;

(* *********************************************************************** *)
(*                           PER A GENERAR EL VENT                         *)
(* *********************************************************************** *)
procedure GeneraVent;
	var
  	r: integer;

	begin
  	r:= random(100)+1;
    case r of
    	1..6: vent.forsa:= (random(10)+30)/10;		{  6% }
      7..15: vent.forsa:= (random(10)+20)/10;		{  9% }
      16..35: vent.forsa:= (random(10)+10)/10;	{ 20% }
      36..100: vent.forsa:= (random(10))/10;		{ 65% }
    end;
    if (random(2) = 0) then vent.forsa:= -vent.forsa;
  end;

end.