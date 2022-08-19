unit bot_trip;

interface

uses
	DMON,Keyboard,Timer,Crono,
	TAux,Power,Filtro,PutItems,
	GestMarc,Llegir,Aire,Classif,
  Memory,crt;

  procedure ConcursTripleBot;
  procedure TurnoTripleBot(var j: jumper; id: byte);

implementation

const
	TOTAL_CARRERA = 440;					{ distÖncia en pixels fins la tabla       }
  TABLA = 68;										{ pixel on deu quedar-se la tabla         }
  FOSA = 211;										{ pixel on deu quedar-se la fosa          }
  DE_TABLA_A_FOSA = FOSA-TABLA;	{ distÖncia en pixels de tabla a fosa     }

procedure InventaResultat(var j: jumper); forward;

(* *********************************************************************** *)
(*          PROCEDIMENTS QUE CONTROL.LEN EL MOVIMENT DEL SALTADOR          *)
(* *********************************************************************** *)
procedure preparar(var j: jumper);
	begin
  	{ col.loquem el sprite }
		PutSprite(SP,0,j.sprite,WP,j.x,j.y,10,30);
    { el pintem amb els colors corresponents }
    Filtra(j);
    { i quan pulsem el bot¢ de correr... }
    if KeyPress(buttonA) or KeyPress(buttonB)
			then
				begin
					j.estat:= 1;
          StartCrono;
        end;

    { si estem en la final i ja ha passat el primer intent podrem consultar la classificaci¢ }
    if KeyPress(KeyTab) and (tipus_ronda = final) and (intents > 1)
			then MostraClassificacio('CLASSIFICACIO PROVISIONAL DURANT LA     RONDA  ',intents);

    { si volem no fer un bot ho fem amb la tecla A }
    if KeyPress(KeyA) and (j.control = h)
    	then
    		begin
      		j.valid:= 2;
          PutWrong(marcador.numerosx+(32*(intents-1)),marcador.numerosy);
        	altre:= true;
        end;

    { o si no volem veure el bot del rival pulsem ESC }
	  if KeyPress(KeyEsc) and (j.control = o)
			then
				begin
					InventaResultat(j);
          PutNumero(j.marca,j.valid,marcador.numerosx+(32*(intents-1)),marcador.numerosy,0,2);
          altre:= true;
        end;

    { si volem abandonar pulsem la Q }
    if KeyPress(KeyQ)
			then
				begin
					FreeKb;
					EndDM;
					AcabarCrono;
					halt;
				end;

  end;
(* *********************************************************************** *)
procedure caminar(var j: jumper);
	const
  	avan = 6;

	begin
    { col.loquem el sprite }
		PutSprite(SP,(j.f)*10,j.sprite,WP,j.x,j.y,10,30);
    { avancem }
    inc(j.carrereta,avan);
    { ens situem en el segÅent frame }
    inc(j.f);
    { perï sempre entre el 0 i el 3 }
    j.f:= (j.f mod 4);
    { indiquem que hem col.locat un frame mÇs }
    inc(i);
    { si hem fet 8 frames... }
    if (i = 8)
			then
				begin
        	{ comencem a correr }
					j.estat:= 2;
          { en el frame n£mero 4 }
          j.f:= 4;
          { resetejem el comptador de frames avanáats }
					i:= 0;
        end;
  end;
(* *********************************************************************** *)
procedure correr(var j: jumper);
	var
  	avan: shortint;

	begin
  	{ col.loquem el sprite }
   	PutSprite(SP,40+((j.f-4)*12),j.sprite,WP,j.x,j.y,12,30);
    { calculem la velocitat que porta el saltador }
    avan:= round((j.power/escala)+((j.potencia+vent.forsa)/2));
    { quan la tabla ja estÖ fixa aleshores ens desplacem per la pantalla }
    if (j.carrereta > TOTAL_CARRERA-TABLA) then inc(j.x,avan);
    { augmentem els metres avanáats }
    inc(j.carrereta,avan);
    { ens situem en el segÅent frame }
    inc(j.f);
    { perï sempre entre el 4 i el 7 }
    j.f:= (j.f mod 4) + 4;

    { si portem al saltador i pulsem espai i estem prop de la tabla o...    }
    { si va soles i estÖ a +/- 10 de la tabla hi ha un 95% de que salte     }
    { el 12 Çs perque en el dibuix de la tabla fins la plastilina van 3 pixels: 15-3 = 12 }
    if ((j.control = h) and KeyPress(KeySpace) and (j.carrereta > TOTAL_CARRERA-12)) or
    	 ((j.control = o) and (j.carrereta > TOTAL_CARRERA-10) and (j.carrereta < TOTAL_CARRERA+10) and (random(100) > 5))
       	then
        	begin
	         	{ comencem a botar }
  	       	j.estat:= 3;
    	      { en el frame n£mero 8 }
	    	    j.f:= 8;
            { resetetjem el comptador de frames avanáats }
	          i:= 0;
            { mirem en quin punt xafem }
	    			{ +12 perque en el frame des de la x fins la punta del peu van 12 }
						j.batuda:= j.x+12;
    				{ parem el crono }
				    StopCrono;
  	        { els sprites comencen mÇs cap a baix }
    	      j.sprite:= 34;
            { i calculem la velocitat a la que hem aplegat a la tabla }
            j.velocitat:= (j.carrereta/time.total)/escala;
	 	      end;

    { si superem en 25 la tabla abandonarem l'intent i no botarem }
    if (j.carrereta >= TOTAL_CARRERA+25)
			then
      	begin
        	{ comencem a abandonar }
					j.estat:= 5;
          { el salt resulta ser nul }
          j.valid:= 2;
          { estem en el frame n£mero 0 }
  	      j.f:= 0;
        end;
  end;
(* *********************************************************************** *)
procedure bot(var j: jumper);
	var
  	avan: shortint;

	begin
    { avancem segons la velocitat i la potäncia del saltador }
    avan:= round((j.velocitat)+(vent.forsa/2)+(j.potencia/1.075));
    { col.loquem el sprite }
		PutSprite(SP,88+((j.f-8)*20),j.sprite,WP,j.x,j.y,20,30);
    { avancem el calculat abans }
	  inc(j.x,avan);
    { ens situem en el segÅent frame }
		inc(j.f);
    { incrementem el comptador de frames avanáats }
    inc(i);
    { hem de fer la 2¶ batuda }
    if (i = 3) then j.f:= 8;
    { toca canviar de posici¢ en el pcx }
    if (i = 11)
			then
				begin
					j.f:= 14;
					j.sprite:= 0;

          { si batim abans de la tabla }
			    if (j.batuda < TABLA+7)
			    	{ el salt Çs vÖlid }
						then j.valid:= 0
			      { sino Çs nul }
			      else j.valid:= 1;

					{ mirem on caiem }
          { +5 perque en el frame des de la x fins el tal¢ van 5 }
          j.caiguda:= j.x+5;
    	    { comencem a revolcar-se }
      	  j.estat:= 4;
        end;

  end;
(* *********************************************************************** *)
procedure revolco(var j: jumper);
	const
  	avan = 5;

  begin
   	{ col.loquem el sprite }
  	PutSprite(SP,223+((j.f-15)*14),j.sprite,WP,j.x,j.y,14,30);
    { avancem 5 pixels }
   	inc(j.x,avan);
    { ens situem en el segÅent frame }
    inc(j.f);
    { si apleguem a l'ultim frame del revolc¢ calculem el resultat }
		if (j.f = 20) then j.estat:= 6;
  end;
(* *********************************************************************** *)
procedure abandono(var j: jumper);
	const
  	avan = 2;

	begin
  	{ col.loquem el sprite }
		PutSprite(SP,(j.f)*10,j.sprite,WP,j.x,j.y,10,30);
    { avancem 4 pixels }
    inc(j.x,avan);
    { ens situem en el segÅent frame }
    inc(j.f);
    { si apleguem a l'ultim frame de l'animaci¢ calculem el resultat }
    if (j.f = 4) then j.estat:= 6;
  end;
(* *********************************************************************** *)
(*           SI NO VEIEM EL BOT DEL CONTRARI, INVENTA UN RESULTAT          *)
(* *********************************************************************** *)
procedure InventaResultat(var j: jumper);
	var
    r: real;

	begin
  	case random(100) of
    	0..24:
				begin
					j.valid:= 1;
          j.marca:= 0;
        end;
      25..99:
      	begin
        	j.valid:= 0;
        	if (tipus_ronda = clas) or (tipus_ronda = prac)
          	then
							begin
               	if (j.best < 18)
                 	then r:= ((random(12)+962)/1000) + (vent.forsa/100)
                  else
                   	if (j.best < 17.05)
											then r:= ((random(24)+979)/1000) + (vent.forsa/100)
                      else r:= ((random(11)+926)/1000) + (vent.forsa/100);
                j.marca:= j.best*r;
		            CheckWR(j.marca);
              end;
          if (tipus_ronda = final)
          	then
            	begin
	            	case random(1000) of
						    	0..99:
										if (j.best < 18)
                    	then r:= ((random(15)+981)/1000) + (vent.forsa/100)
                      else
												if (j.best < 17.05)
													then r:= ((random(6)+1000)/1000) + (vent.forsa/100)
                          else r:= ((random(15)+943)/1000) + (vent.forsa/100);
						      100..999:
										if (j.best < 18)
                    	then r:= ((random(34)+985)/1000) + (vent.forsa/100)
                      else
												if (j.best < 17.05)
													then r:= ((random(9)+1001)/1000) + (vent.forsa/100)
                          else r:= ((random(33)+947)/1000) + (vent.forsa/100);
		  				  end;
                j.marca:= j.best*r;
{              	if CheckWR(j.marca) then NewWorldRecord;}
              end;
          end;
        end;
  end;
(* *********************************************************************** *)
(*                          EL TURNO DE CADA SALTADOR                      *)
(* *********************************************************************** *)
procedure TurnoTripleBot(var j: jumper; id: byte);
	var
  	s: string;

	begin
  	i:= 0;
    altre:= false;
    LlegirJumper(j,id);
		j.potencia:= (j.best / 2);
    j.power:= 1;
    if (j.control = h) or (tipus_ronda = final)
    	then
      	begin
			    NouVent;
          vent.forsa:= 0;
				  	repeat
            	c1:= 0;
              c2:= 0;

				    	Flip(BP,WP);

				      PutMarcador;

              if (id = josoc)
              	then
									begin
										PutText(j.nom,marcador.lletresx,marcador.lletresy,1);
                    PutText(j.nacio,marcador.naciox,marcador.lletresy,1);
                  end
                else
									begin
										PutText(j.nom,marcador.lletresx,marcador.lletresy,0);
                  	PutText(j.nacio,marcador.naciox,marcador.lletresy,0);
                  end;

				      PutResultats(intents,participant);
				      PutVent;
              PutCarrer;

              PutJutge(j,TOTAL_CARRERA+3,TABLA+3,17);
              PutTabla(j,TOTAL_CARRERA,TABLA,14);
              PutFosa(j,TOTAL_CARRERA+DE_TABLA_A_FOSA,FOSA,109);
              { +11 perque des de la fosa on comencem a posar els n£meros van 11 }
				      PutNumerosFosa(j,TOTAL_CARRERA+DE_TABLA_A_FOSA,FOSA+11,82,prova);

              if (tipus_ronda = final) then PutMedals(j,TOTAL_CARRERA,TABLA,10);
				      if (tipus_ronda <> prac) then PutWorldRecord(j,TOTAL_CARRERA,TABLA,1);

				      PintaPower(j.power);

              PutSprite(IP,158,0,WP,305,185,10,10);

				      { nomÇs podrem donar-li power mentres caminem o correm }
				      if (j.estat = 1) or (j.estat = 2) then
				      	if (j.control = h)
									then powerful(j.power,buttonA,buttonB,4,1)
						      else powerother(j.power,4,1);

              PutAlsaSorra(j,i);
              PutRemogutSorra(j);
				      PutXafaPlastilina(j,TABLA);

				      case j.estat of
      					0: preparar(j);
				        1: caminar(j);
        				2: correr(j);
				        3: bot(j);
        				4: revolco(j);
				        5: abandono(j);
								6: resultat(j,TABLA);
				      end;

              PutText('TEMPS',10,64,1);
              PintaCrono(78,64,2);

              str(j.carrereta/escala:4:2,s);
              PutText('METRES',10,74,1);
              PutText(s,70,74,1);

              str(j.power/escala:4:2,s);
              PutText('POWER',10,84,1);
              PutText(s,70,84,1);

				      WaitRetrace;
              repeat until (c2 > 0);
				      Flip(WP,VGA);

				    until (altre);

            if (j.control = h)
							then repeat until KeyPress(KeySpace)
              else delay(1000);

            ResetCrono;

        end;

    if (j.control = o) and (tipus_ronda = clas) then InventaResultat(j);

    GuardaResultat(j);

  end;
(* *********************************************************************** *)
  procedure ConcursTripleBot;
  	begin
    	GetMemoryRonda;

      tipus_ronda:= clas;
      {LlegirRecords(WR,prova);}

      GeneraVent;
		  for intents:= 1 to NINTENTSCLAS do
				for participant:= 1 to NPARTICIPANTS do TurnoTripleBot(saltador,participant);

		  CalculaFinalistes;
		  MostraFinalistes;
		  FadeChaos(1000,random(14)+1,BP);

		  FreeMemoryRonda;
      GetMemoryFinal;

		  tipus_ronda:= final;

		  for intents:= 1 to NINTENTSFINAL do
				for participant:= NFINALISTES downto 1 do
		    	begin
						TurnoTripleBot(saltador,finalistes^[participant]);
        		if (participant = 1)
							then
								if (intents <> NINTENTSFINAL)
									then MostraClassificacio('CLASSIFICACIO PROVISIONAL DESPRES DE    INTENTS',intents)
            		  else MostraClassificacio('CLASSIFICACIO FINAL',0);
		      end;

      FreeMemoryFinal;
    end;

end.