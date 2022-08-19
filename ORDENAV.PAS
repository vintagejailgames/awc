unit ordenav;

interface

uses TAux;

	procedure OrdenaMarques;
  procedure SortByMarca(b: boolean);
  procedure SortByName(b: boolean);
  {procedure SortByCaracter(ch: char; var actual,primer,ultim: byte; MAX: byte);}
  procedure SortByCountry(b: boolean);

implementation

	procedure OrdenaMarques;
  	var
    	loop1,loop2: byte;
      aux: ResultatIndividual;

  	begin
    	for loop1:= 1 to NFINALISTES do ClassificacioFinal^[loop1]:= MMFinal^[loop1];
    	for loop1:= 1 to NFINALISTES-1 do
      	for loop2:= loop1+1 to NFINALISTES do
        	if (ClassificacioFinal^[loop2].marca > ClassificacioFinal^[loop1].marca)
          	then
            	begin
              	aux:= ClassificacioFinal^[loop2];
                ClassificacioFinal^[loop2]:= ClassificacioFinal^[loop1];
                ClassificacioFinal^[loop1]:= aux;
              end;
    end;

  procedure SortByMarca(b: boolean);
  	var
    	loop1,loop2: byte;
      aux: ResultatIndividual;

    begin
    	for loop1:= 1 to NPARTICIPANTS-1 do
      	if (b)
        	then
          	for loop2:= loop1+1 to NPARTICIPANTS do
		        	if (Escollir^[loop2].marca > Escollir^[loop1].marca)
    		      	then
        		    	begin
            		  	aux:= Escollir^[loop2];
                		Escollir^[loop2]:= Escollir^[loop1];
		                Escollir^[loop1]:= aux;
    		          end
          else
            for loop2:= loop1+1 to NPARTICIPANTS do
		        	if (Escollir^[loop2].marca < Escollir^[loop1].marca)
    		      	then
        		    	begin
            		  	aux:= Escollir^[loop2];
                		Escollir^[loop2]:= Escollir^[loop1];
		                Escollir^[loop1]:= aux;
    		          end;
    end;

  procedure SortByName(b: boolean);
  	var
    	loop1,loop2: byte;
      aux: ResultatIndividual;

    begin
    	for loop1:= 1 to NPARTICIPANTS-1 do
      	if (b)
        	then
		      	for loop2:= loop1+1 to NPARTICIPANTS do
    		    	if (Escollir^[loop2].nom > Escollir^[loop1].nom)
        		  	then
            			begin
              			aux:= Escollir^[loop2];
		                Escollir^[loop2]:= Escollir^[loop1];
    		            Escollir^[loop1]:= aux;
        		      end
          else
            for loop2:= loop1+1 to NPARTICIPANTS do
    		    	if (Escollir^[loop2].nom < Escollir^[loop1].nom)
        		  	then
            			begin
              			aux:= Escollir^[loop2];
		                Escollir^[loop2]:= Escollir^[loop1];
    		            Escollir^[loop1]:= aux;
        		      end;
    end;

  {procedure SortByCaracter(ch: char; var actual,primer,ultim: byte; MAX: byte);
  	var
    	loop1,aux: byte;
      trobat: boolean;

    begin
    	aux:= 1;
      trobat:= false;
      while (aux < NPARTICIPANTS) or not(trobat) do
      	begin
        	if (Escollir^[loop1].nom[1] < ch) then inc(aux);
          if (Escollir^[loop1].nom[1] > ch)
						then
							begin
								actual:= 1;
                trobat:= true;
              end;
      		if (Escollir^[loop1].nom[1] = ch)
						then
							begin
								actual:= aux;
								trobat:= true;
							end;
        end;
        primer:= actual;
        if (actual > NPARTICIPANTS-MAX-1) then actual:= NPARTICIPANTS-MAX-1;
    end;}

  procedure SortByCountry(b: boolean);
  	var
    	loop1,loop2: byte;
      aux: ResultatIndividual;

    begin
    	for loop1:= 1 to NPARTICIPANTS-1 do
      	if (b)
        	then
          	for loop2:= loop1+1 to NPARTICIPANTS do
		        	if (Escollir^[loop2].nacio > Escollir^[loop1].nacio)
    		      	then
        		    	begin
            		  	aux:= Escollir^[loop2];
                		Escollir^[loop2]:= Escollir^[loop1];
		                Escollir^[loop1]:= aux;
    		          end
          else
            for loop2:= loop1+1 to NPARTICIPANTS do
		        	if (Escollir^[loop2].nacio < Escollir^[loop1].nacio)
    		      	then
        		    	begin
            		  	aux:= Escollir^[loop2];
                		Escollir^[loop2]:= Escollir^[loop1];
		                Escollir^[loop1]:= aux;
    		          end;
    end;

end.