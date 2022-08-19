unit classif;

interface

uses DMON,TAux,Keyboard,PutItems,Llegir;

  procedure MostraFinalistes;
  procedure MostraClassificacio(s: string; int: byte);

implementation

var
	j: jumper;
  aux: byte;

	procedure MostraFinalistes;
  	var
    	color: byte;
      data,straux: string;

  	begin
			Cls(72,WP);
			PutText('CLASSIFICATS PER A LA FINAL',109,15,2);
		  PutText('NOM',55,40,2);
		  PutText('NACIO',178,40,2);
		  PutText('MARCA',237,40,2);
      PutText('PULSA     PER A TORNAR',117,185,1);
      PutText('      TAB             ',117,185,2);
		  for aux:= NFINALISTES downto 1 do
		  	begin
		  		LlegirJumper(j,finalistes^[aux]);
          if (finalistes^[aux] = JoSoc)
						then color:= 1
            else color:= 0;
          PutText(j.nom,55,((aux-1)*10)+52,color);
	  	    PutText(j.nacio,182,((aux-1)*10)+52,color);
					str(ClassificacioRonda^[aux].marca:4:2,straux);
          PutText(straux,263-(length(straux)*4+2),((aux-1)*10)+52,color);
	    	end;
      FadeChaos(1000,random(14)+1,WP);
	  	repeat until keypress(KeyTab);
    end;

  procedure MostraClassificacio(s: string; int: byte);
  	var
    	color: byte;
      longcad: integer;
      straux: string;

  	begin
			Cls(72,WP);
      if (int = 1)
				then longcad:= (320 - (length(s)-1) shl 2) div 2
        else longcad:= (320 - length(s) shl 2) div 2;
			PutText(s,longcad,15,2);
      if (int = 1) then PutSprite(IP,7,27,WP,246,15,3,5);
      if (int <> 0) then PutSprite(IP,280+((int-1) shl 2),185,WP,208,15,4,5);
		  PutText('NOM',55,40,2);
		  PutText('NACIO',178,40,2);
		  PutText('MARCA',237,40,2);
      PutText('PULSA     PER A TORNAR',117,185,1);
      PutText('      TAB             ',117,185,2);
		  for aux:= 1 to NFINALISTES do
		  	begin
        	if (ClassificacioFinal^[aux].id = JoSoc)
						then color:= 1
            else color:= 0;
  				PutText(ClassificacioFinal^[aux].nom,55,((aux-1)*10)+52,color);
	  	    PutText(ClassificacioFinal^[aux].nacio,182,((aux-1)*10)+52,color);
         	str(ClassificacioFinal^[aux].marca:4:2,straux);
          PutText(straux,262-(length(straux)*4+2),((aux-1)*10)+52,color);
          str(aux:3,straux);
          PutText(straux,37,((aux-1)*10)+52,color);
	    	end;
			FadeChaos(1000,random(14)+1,WP);
      repeat until keypress(KeyTab);
      if (int = 0) then Cls(0,BP);
      Flip(BP,WP);
      FadeChaos(1000,random(14)+1,BP);
    end;

end.