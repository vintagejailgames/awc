unit GestMarc;

interface

uses DMON,PutItems,TAux,Keyboard,Llegir,Ordenav;

  procedure GuardaResultat(j: jumper);
  procedure CalculaFinalistes;
  procedure resultat(var j: jumper; TABLA: integer);

implementation
(*  ******************************************************************** *)
	procedure MillorMarcaDeCadaSaltador(p: byte);
  	begin
      if (ResultatsFinal^[intents,p] > MMfinal^[p].marca)
      	then MMfinal^[p].marca:= ResultatsFinal^[intents,p];
    end;
(*  ******************************************************************** *)
  procedure RecalculaClassificacio(j: jumper; id: byte);
   	var
     	p: byte;

   	begin
     	MMFinal^[id].nom:= j.nom;
      MMFinal^[id].nacio:= j.nacio;
     	for p:= 1 to NFINALISTES do
				MillorMarcaDeCadaSaltador(p);
      OrdenaMarques;
		end;
(*  ******************************************************************** *)
  procedure GuardaResultat(j: jumper);
   	begin
			if (tipus_ronda = clas)
			 	then
			   	begin
     		  	ResultatsRonda^[intents,participant]:= j.marca;
		  	    ValidesesRonda^[intents,participant]:= j.valid;
      	  end;
			if (tipus_ronda = final)
				then
				  begin
	    		  ResultatsFinal^[intents,participant]:= j.marca;
			    	ValidesesFinal^[intents,participant]:= j.valid;
			      RecalculaClassificacio(j,participant);
	    		end;
      if (tipus_ronda = prac)
				then
				  begin
	    		  ResultatsFinal^[intents,participant]:= j.marca;
			    	ValidesesFinal^[intents,participant]:= j.valid;
	    		end;
    end;
(*  ******************************************************************** *)
  procedure OrdenarRonda;
    var
    	loop1,loop2: byte;
      aux: ResultatIndividual;

  	begin
    	for loop1:= 1 to NPARTICIPANTS-1 do
      	for loop2:= loop1+1 to NPARTICIPANTS do
        	if (ClassificacioRonda^[loop2].marca > ClassificacioRonda^[loop1].marca)
          	then
            	begin
              	aux:= ClassificacioRonda^[loop2];
                ClassificacioRonda^[loop2]:= ClassificacioRonda^[loop1];
                ClassificacioRonda^[loop1]:= aux;
              end;
    end;
(*  ******************************************************************** *)
	function MillorResultat(aux: byte): real;
  	var
    	aux2: byte;
      MR: real;

    begin
    	MR:= 0;
      for aux2:= 1 to NINTENTSCLAS do
      	if (ResultatsRonda^[aux2,aux] > MR)
					then MR:= ResultatsRonda^[aux2,aux];
      MillorResultat:= MR;
    end;
(*  ******************************************************************** *)
	procedure CalculaFinalistes;
  	var
    	aux: byte;

  	begin
    	for aux:= 1 to NPARTICIPANTS do
      	begin
	      	ClassificacioRonda^[aux].id:= aux;
    	  	ClassificacioRonda^[aux].marca:= MillorResultat(aux);
        end;
      OrdenarRonda;
      for aux:= 1 to NFINALISTES do
      	Finalistes^[aux]:= ClassificacioRonda^[aux].id;
    end;
(* *********************************************************************** *)
(*                 PER A GESTIONAR EL CALCUL DEL RESULTAT                  *)
(* *********************************************************************** *)
	procedure resultat(var j: jumper; TABLA: integer);
  	var
    	aux: real;

		begin
  		{ pinta el ninot altra vegada, per a no perdre'l }
			if (j.valid = 2)
				then PutSprite(SP,0,j.sprite,WP,j.x-4,j.y,10,30)
				else PutSprite(SP,293,j.sprite,WP,j.x,j.y,14,30);

	    { si el salt ‚s valid }
  	  if (j.valid = 0)
    		{ calcul.lem la marca }
				then
					begin
						aux:= (random(6) / 100);
            { 4 es la distancia desde la x de la tabla fins el pixel que interesa }
						j.marca:= ((j.caiguda-TABLA-4) / escala);
            case random(2) of
            	0: j.marca:= j.marca + aux;
              1: j.marca:= j.marca - aux;
            end;
          end
        { si el resultat no ‚s v…lid }
        else j.marca:= 0;
			{ comprova si es el New WR }
			{if CheckWR(j.marca) then NewWorldRecord;}
    	{ i col.loca el resultat en el marcador }
			PutNumero(j.marca,j.valid,marcador.numerosx+(32*(intents-1)),marcador.numerosy,0,2);

	    { acabem el bot }
  	  altre:= true;
	  end;

end.