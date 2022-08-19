unit filtro;

interface

uses DMON,taux;

	procedure filtra(j: jumper);

implementation

const
	PELL = 178;
  SAMARRETA = 66;
  PANTALO = 54;

  procedure SetColor(part,color: byte);
  	var
    	r,g,b: byte;

  	begin
    	case color of
	    	0: { blanc       } begin r:= 63; g:= 63; b:= 63; end;
  	    1: { negre       } begin r:= 0; g:= 0; b:= 0; end;
    	  2: { groc c.     } begin r:= 63; g:= 60; b:= 0; end;
      	3: { groc o.     } begin r:= 48; g:= 47; b:= 3; end;
	      4: { taronja c.  } begin r:= 59; g:= 41; b:= 17; end;
  	    5: { taronja o.  } begin r:= 48; g:= 33; b:= 3; end;
    	  6: { verd clar   } begin r:= 17; g:= 63; b:= 19; end;
      	7: { verd oscur  } begin r:= 18; g:= 34; b:= 34; end;
	      8: { roig clar   } begin r:= 62; g:= 6; b:= 6; end;
  	    9: { roig oscur  } begin r:= 37; g:= 5; b:= 0; end;
    	  10: { blau clar  } begin r:= 8; g:= 61; b:= 63; end;
      	11: { blau clar/oscur } begin r:= 9; g:= 8; b:= 63; end;
	      12: { blau oscur } begin r:= 0; g:= 0; b:= 33; end;
  	    13: { morat      } begin r:= 32; g:= 0; b:= 32; end;
    	  14: { marr¢      } begin r:= 37; g:= 25; b:= 17; end;
      end;

    	SetRGB(part,r,g,b);
    end;

  procedure filtra(j: jumper);
  	begin
    	case j.pell of
      	0: SetRGB(PELL,63,51,51);
        1: SetRGB(PELL,38,26,13);
      end;
      { n*63 / 255 }
      if (j.nacio = 'ARM') then
      	begin
					SetColor(SAMARRETA,8);
					SetColor(PANTALO,13);
				end;
    	{}if (j.nacio = 'AUS') then
      	begin
					SetColor(SAMARRETA,7);
					SetColor(PANTALO,7);
				end;
      if (j.nacio = 'AZE') then
      	begin
					SetColor(SAMARRETA,14);
					SetColor(PANTALO,0);
				end;
      if (j.nacio = 'BEL') then
      	begin
					SetColor(SAMARRETA,0);
					SetColor(PANTALO,8);
				end;
      if (j.nacio = 'BER') then
      	begin
					SetColor(SAMARRETA,7);
					SetColor(PANTALO,0);
				end;
      if (j.nacio = 'BOT') then
      	begin
					SetColor(SAMARRETA,4);
					SetColor(PANTALO,1);
				end;
      if (j.nacio = 'BRA') then
      	begin
					SetColor(SAMARRETA,2);
					SetColor(PANTALO,7);
				end;
      if (j.nacio = 'BUL') then
      	begin
					SetColor(SAMARRETA,0);
					SetColor(PANTALO,6);
				end;
      {}if (j.nacio = 'CAN') then
      	begin
					SetColor(SAMARRETA,8);
					SetColor(PANTALO,1);
				end;
      if (j.nacio = 'CAY') then
      	begin
					SetColor(SAMARRETA,2);
					SetColor(PANTALO,2);
				end;
      {}if (j.nacio = 'CHN') then
      	begin
					SetColor(SAMARRETA,0);
					SetColor(PANTALO,8);
				end;
      {}if (j.nacio = 'CUB') then
      	begin
					SetColor(SAMARRETA,8);
					SetColor(PANTALO,8);
				end;
      if (j.nacio = 'CZE') then
      	begin
					SetColor(SAMARRETA,8);
					SetColor(PANTALO,0);
				end;
      if (j.nacio = 'EGY') then
      	begin
					SetColor(SAMARRETA,2);
					SetColor(PANTALO,2);
				end;
      {}if (j.nacio = 'ESP') then
      	begin
					SetColor(SAMARRETA,8);
					SetColor(PANTALO,8);
				end;
      {}if (j.nacio = 'FIN') then
      	begin
					SetColor(SAMARRETA,0);
					SetColor(PANTALO,10);
				end;
      if (j.nacio = 'FRA') then
      	begin
					SetColor(SAMARRETA,11);
					SetColor(PANTALO,11);
				end;
      {}if (j.nacio = 'GBR') then
      	begin
					SetColor(SAMARRETA,0);
					SetColor(PANTALO,11);
				end;
      {}if (j.nacio = 'GER') then
      	begin
					SetColor(SAMARRETA,0);
					SetColor(PANTALO,0);
				end;
      if (j.nacio = 'GHA') then
      	begin
					SetColor(SAMARRETA,2);
					SetColor(PANTALO,9);
				end;
      {}if (j.nacio = 'GRE') then
      	begin
					SetColor(SAMARRETA,12);
					SetColor(PANTALO,12);
				end;
      if (j.nacio = 'HUN') then
      	begin
					SetColor(SAMARRETA,8);
					SetColor(PANTALO,6);
				end;
      if (j.nacio = 'IRL') then
      	begin
					SetColor(SAMARRETA,6);
					SetColor(PANTALO,0);
				end;
      if (j.nacio = 'ISR') then
      	begin
					SetColor(SAMARRETA,10);
					SetColor(PANTALO,0);
				end;
      if (j.nacio = 'ITA') then
      	begin
					SetColor(SAMARRETA,0);
					SetColor(PANTALO,10);
				end;
      if (j.nacio = 'JPN') then
      	begin
					SetColor(SAMARRETA,0);
					SetColor(PANTALO,8);
				end;
      if (j.nacio = 'KEN') then
      	begin
					SetColor(SAMARRETA,7);
					SetColor(PANTALO,7);
				end;
      if (j.nacio = 'KOR') then
      	begin
					SetColor(SAMARRETA,0);
					SetColor(PANTALO,0);
				end;
      if (j.nacio = 'KSA') then
      	begin
					SetColor(SAMARRETA,5);
					SetColor(PANTALO,5);
				end;
      if (j.nacio = 'KZK') then
      	begin
					SetColor(SAMARRETA,0);
					SetColor(PANTALO,9);
				end;
      if (j.nacio = 'LIT') then
      	begin
					SetColor(SAMARRETA,4);
					SetColor(PANTALO,6);
				end;
      if (j.nacio = 'MAR') then
      	begin
					SetColor(SAMARRETA,8);
					SetColor(PANTALO,7);
				end;
    	if (j.nacio = 'NOR') then
      	begin
					SetColor(SAMARRETA,0);
					SetColor(PANTALO,0);
				end;
      if (j.nacio = 'POR') then
      	begin
					SetColor(SAMARRETA,8);
					SetColor(PANTALO,7);
				end;
      if (j.nacio = 'QAT') then
      	begin
					SetColor(SAMARRETA,0);
					SetColor(PANTALO,0);
				end;
      if (j.nacio = 'ROM') then
      	begin
					SetColor(SAMARRETA,2);
					SetColor(PANTALO,10);
				end;
      if (j.nacio = 'RUS') then
      	begin
					SetColor(SAMARRETA,0);
					SetColor(PANTALO,10);
				end;
      if (j.nacio = 'SLO') then
      	begin
					SetColor(SAMARRETA,2);
					SetColor(PANTALO,10);
				end;
      if (j.nacio = 'SWE') then
      	begin
					SetColor(SAMARRETA,2);
					SetColor(PANTALO,10);
				end;
      if (j.nacio = 'UKR') then
      	begin
					SetColor(SAMARRETA,2);
					SetColor(PANTALO,10);
				end;
      if (j.nacio = 'USA') then
      	begin
					SetColor(SAMARRETA,12);
					SetColor(PANTALO,12);
				end;
      if (j.nacio = 'YUG') then
      	begin
					SetColor(SAMARRETA,8);
					SetColor(PANTALO,0);
				end;
      {if (j.nacio = '') then
      	begin
					SetColor(SAMARRETA,);
					SetColor(PANTALO,);
				end;}
    end;
end.