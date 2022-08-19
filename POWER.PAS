unit power;

interface

uses DMON,keyboard,TAux;

	procedure PintaPower(pow: real);
	procedure Powerful(var pow: real; button1,button2: word; incr,decr: byte);
  procedure PowerOther(var pow: real; incr,decr: byte);

implementation

procedure pintapower(pow: real);
	begin
  	PutSprite(IP,0,3,WP,110,7,100,3);
    PutSprite(IP,0,0,WP,110,7,trunc(pow),3);
  end;

procedure powerful(var pow: real; button1,button2: word; incr,decr: byte);
	begin
  	if not(KeyPress(KeySpace)) then
    	begin
		    if QkeyPress then button:= getkey;
		    if (button = button1)
					then
    		  	begin
        			if (lastbutton = button2)
          			then
		            	begin
    		          	if (pow <= 100-incr) then pow:= pow+incr;
        		        lastbutton:= button1;
            		  end;
		        end;
				if (button = button2)
		    	then
    		  	begin
        			if (lastbutton = button1)
          			then
		            	begin
    		          	if (pow <= 100-incr) then pow:= pow+incr;
        		        lastbutton:= button2;
            		  end;
		        end;
    		if (pow > decr) then pow:= pow-decr;
		    if (pow <= 1) then pow:= 1;
    end;
	end;

procedure powerother(var pow: real; incr,decr: byte);
	begin
    if (random(100) > 20) then
			if (pow <= 100-incr) then pow:= pow+incr;
    if (pow > decr) then pow:= pow-decr;
    if (pow <= 1) then pow:= 1;
  end;

begin
	Randomize;
end.