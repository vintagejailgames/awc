unit crono;

interface

uses timer,DMON;

type
	caracter = array [1..5,1..4] of byte;

const
  CN1: caracter = ((0,1,0,0),(0,2,0,0),(0,1,0,0),(0,2,0,0),(0,1,0,0));
  CN2: caracter = ((1,2,1,0),(0,0,2,0),(1,2,1,0),(2,0,0,0),(1,2,1,0));
  CN3: caracter = ((1,2,1,0),(0,0,2,0),(0,2,1,0),(0,0,2,0),(1,2,1,0));
  CN4: caracter = ((1,0,1,0),(2,0,2,0),(1,2,1,0),(0,0,2,0),(0,0,1,0));
  CN5: caracter = ((1,2,1,0),(2,0,0,0),(1,2,1,0),(0,0,2,0),(1,2,1,0));
  CN6: caracter = ((1,2,1,0),(2,0,0,0),(1,2,1,0),(2,0,2,0),(1,2,1,0));
  CN7: caracter = ((1,2,1,0),(0,0,2,0),(0,0,1,0),(0,0,2,0),(0,0,1,0));
  CN8: caracter = ((1,2,1,0),(2,0,2,0),(1,2,1,0),(2,0,2,0),(1,2,1,0));
  CN9: caracter = ((1,2,1,0),(2,0,2,0),(1,2,1,0),(0,0,2,0),(1,2,1,0));
  CN0: caracter = ((1,2,1,0),(2,0,2,0),(1,0,1,0),(2,0,2,0),(1,2,1,0));
  Cp: caracter = ((0,0,0,0),(0,0,0,0),(0,0,0,0),(0,0,0,0),(0,0,2,0));

var
	actualitza: boolean;

  procedure PintaCrono(x,y: integer; dec: byte);

implementation

(* ****************************************** *)
(*  PROCEDIMENT PER A DIBUIXAR EL CRONOMETRE  *)
(* ****************************************** *)
procedure PutText(s: string; x,y: integer);
	var
 		i,loop1,loop2: byte;
    ample: byte;
		which: caracter;

	begin
		ample:= 4;
    for i:= 1 to length(s) do
    	begin
      	case s[i] of
        	'1': which:= CN1;
					'2': which:= CN2;
					'3': which:= CN3;
					'4': which:= CN4;
					'5': which:= CN5;
					'6': which:= CN6;
					'7': which:= CN7;
					'8': which:= CN8;
					'9': which:= CN9;
					'0': which:= CN0;
					'.': which:= CP;
        end;
      	if (s[i] = '.') then dec(x,2);
        for loop1:= 1 to 5 do
        	for loop2:= 1 to 4 do
          	if (which[loop1,loop2] <> 0) then
            	mem[WP:320*(loop1+y-1)+(x+loop2-1)]:= which[loop1,loop2];
        inc(x,ample);
      end;
	end;

(* ****************************************** *)
(*         FUNCIà PER A FER POTÔNCIES         *)
(* ****************************************** *)
{ Aquesta funci¢ no funciona amb exponent negatiu }
function potencia(base,exp: integer): integer;
	var
  	i,
		res: integer;

	begin
  	res:= 1;
    if (exp <> 0) then
    	for i:= 1 to exp do
      	res:= res * base;
    potencia:= res;
  end;

(* ****************************************** *)
(*     COL.LOCA EL CRONOMETRE EN PANTALLA     *)
(* ****************************************** *)
procedure PintaCrono(x,y: integer; dec: byte);
  	var
    	es: string;
      roundem: word;
      loop,enters: byte;

  	begin
    	roundem:= potencia(10,dec);
     	time.total:= round(time.total*roundem)/roundem;
      str(time.total:0:dec,es);
      enters:= 1;
      for loop:= 1 to length(es) do
				if (es[enters] <> '.') then inc(enters);
			PutText(es,x-(enters*4),y);
    end;
end.