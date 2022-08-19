uses crt;

var
	vent: real;
  i: byte;
  r: byte;

procedure GeneraVent;
	var
  	r: integer;

	begin
  	r:= random(100)+1;
    case r of
    	1..2: vent:= (random(10)+40)/10;		{  2% }
      3..6: vent:= (random(10)+30)/10;		{  4% }
      7..15: vent:= (random(10)+20)/10;		{  9% }
      16..35: vent:= (random(10)+10)/10;	{ 20% }
      36..100: vent:= (random(10))/10;		{ 65% }
    end;
  end;

begin
	Randomize;
  clrscr;
  generavent;
  for i:= 1 to 20 do
		begin
      writeln(vent + ((random(7)-3)/10):2:2);
    end;

end.