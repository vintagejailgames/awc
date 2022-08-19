unit choisir;

interface

uses Memory,DMON,PutItems,TAux,Llegir,crt,KeyBoard,ordenav,timer;

  procedure EscollirProva;
	procedure EscollirAtleta;

implementation

  procedure EscollirProva;
		const
			MAXenPantalla = 2;

		var
 			aux: byte;
	  	primer,ultim: byte;	{ el primer i £ltim mostrats en pantalla       }
	  	actual: byte;				{ el que tenim seleccionat en aquestos moments }
		  color: byte;

		begin
	    primer:= 1;
  	  ultim:= MAXenPantalla;
    	actual:= primer;

      Cls(38,WP);
      Flip(WP,VGA);
      FadeIn(gamepal);

	    repeat
      	c1:= 0;
        c2:= 0;

		    Cls(38,WP);
				PutText('SELECCIONA UNA PROVA',119,15,2);

		    for aux:= 1 to MAXenPantalla do
  		  	begin
						if (actual = aux+primer-1)
  	  		  	then color:= 1
    	  		  else color:= 0;
            case aux of
            	1: PutText('BOT DE LLARGARIA',129,((aux-1)*10)+52,color);
              2: PutText('TRIPLE BOT DE LLARGARIA',116,((aux-1)*10)+52,color);
            end;
          end;

          {}

    	  if KeyPress(KeyArrowDown) and (actual < ProvesMAX)
					then
        		begin
          		inc(actual);
          	  if (actual > ultim)
	            	then
  	            	begin
    	            	inc(primer);
      	            inc(ultim);
        	        end;
          	end;

	      if KeyPress(KeyArrowUp) and (actual > 1)
					then
    	    	begin
      	    	dec(actual);
        	    if (actual < primer)
          	  	then
            	  	begin
              	  	dec(primer);
                	  dec(ultim);
	                end;
  	        end;

        WaitRetrace;
        repeat until (c1 > 0);
  		  Flip(WP,VGA);

	    until KeyPress(KeyEnter);

      prova:= actual;
	  end;

  procedure EscollirAtleta;
		const
			MAXenPantalla = 13;

		var
 			aux: byte;
	  	primer,ultim: byte;	{ el primer i £ltim mostrats en pantalla       }
	  	actual: byte;				{ el que tenim seleccionat en aquestos moments }
		  color: byte;
      straux: string;
      order: boolean;			{ indica l'ordre en que estan ordenats }

		begin
  		GetMemoryEscollir;

	    primer:= 1;
  	  ultim:= MAXenPantalla;
    	actual:= primer;
      order:= false;

	    for aux:= 1 to NPARTICIPANTS do
  	  	begin
    			LlegirJumper(saltador,aux);
      	 	Escollir^[aux].nom:= saltador.nom;
        	Escollir^[aux].nacio:= saltador.nacio;
	        Escollir^[aux].marca:= saltador.best;
          Escollir^[aux].id:= aux;
  	    end;

	    repeat
      	c1:= 0;
        c2:= 0;

		    Cls(38,WP);
				PutText('SELECCIONA AL TEU ATLETA',111,15,2);
  			PutText('NOM',55,40,2);
			  PutText('NACIO',178,40,2);
			  PutText('BEST',249,40,2);

		    for aux:= 1 to MAXenPantalla do
  		  	begin
						if (actual = aux+primer-1)
  	  		  	then color:= 1
    	  		  else color:= 0;
		      	PutText(Escollir^[aux+primer-1].nom,55,((aux-1)*10)+52,color);
			  	  PutText(Escollir^[aux+primer-1].nacio,182,((aux-1)*10)+52,color);
            str(Escollir^[aux+primer-1].marca:5:2,straux);
	          PutText(straux,247,((aux-1)*10)+52,color);
          end;

        {}

    	  if KeyPress(KeyArrowDown) and (actual < NPARTICIPANTS)
					then
        		begin
          		inc(actual);
          	  if (actual > ultim)
	            	then
  	            	begin
    	            	inc(primer);
      	            inc(ultim);
        	        end;
          	end;

	      if KeyPress(KeyArrowUp) and (actual > 1)
					then
    	    	begin
      	    	dec(actual);
        	    if (actual < primer)
          	  	then
            	  	begin
              	  	dec(primer);
                	  dec(ultim);
	                end;
  	        end;

        WaitRetrace;
        repeat until (c1 > 0);
  		  Flip(WP,VGA);

        {if (KeyPress(KeyLeftShift) or KeyPress(KeyRightShift))
					then
						begin
							if KeyPress(KeyA) then SortByCaracter('A',actual,primer,ultim);
							if KeyPress(KeyB) then SortByCaracter('B',actual,primer,ultim);;
              if KeyPress(KeyC) then SortByCaracter('C',actual,primer,ultim);
              if KeyPress(KeyD) then SortByCaracter('D',actual,primer,ultim);
              if KeyPress(KeyE) then SortByCaracter('E',actual,primer,ultim);
              if KeyPress(KeyF) then SortByCaracter('F',actual,primer,ultim);
              if KeyPress(KeyG) then SortByCaracter('G',actual,primer,ultim);
              if KeyPress(KeyH) then SortByCaracter('H',actual,primer,ultim);
              if KeyPress(KeyI) then SortByCaracter('I',actual,primer,ultim);
              if KeyPress(KeyJ) then SortByCaracter('J',actual,primer,ultim);
              if KeyPress(KeyK) then SortByCaracter('K',actual,primer,ultim);
              if KeyPress(KeyL) then SortByCaracter('L',actual,primer,ultim);
              if KeyPress(KeyM) then SortByCaracter('M',actual,primer,ultim);
              if KeyPress(KeyN) then SortByCaracter('N',actual,primer,ultim);
              if KeyPress(KeyO) then SortByCaracter('O',actual,primer,ultim);
              if KeyPress(KeyP) then SortByCaracter('P',actual,primer,ultim);
              if KeyPress(KeyQ) then SortByCaracter('Q',actual,primer,ultim);
              if KeyPress(KeyR) then SortByCaracter('R',actual,primer,ultim);
              if KeyPress(KeyS) then SortByCaracter('S',actual,primer,ultim);
              if KeyPress(KeyT) then SortByCaracter('T',actual,primer,ultim);
              if KeyPress(KeyU) then SortByCaracter('U',actual,primer,ultim);
              if KeyPress(KeyV) then SortByCaracter('V',actual,primer,ultim);
              if KeyPress(KeyW) then SortByCaracter('W',actual,primer,ultim);
              if KeyPress(KeyX) then SortByCaracter('X',actual,primer,ultim);
              if KeyPress(KeyY) then SortByCaracter('Y',actual,primer,ultim);
							if KeyPress(KeyZ) then SortByCaracter('Z',actual,primer,ultim);
            end;}

        if KeyPress(KeyN) then begin SortByName(not(order)); order:= not(order) end;
        if KeyPress(KeyC) then begin SortByCountry(not(order)); order:= not(order) end;
        if KeyPress(KeyB) then begin SortByMarca(not(order)); order:= not(order) end;

	    until KeyPress(KeyEnter);

      JoSoc:= Escollir^[actual].id;
  	  FreeMemoryEscollir;
      FadeOut;
      Cls(0,VGA);
	  end;

end.