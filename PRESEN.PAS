unit presen;

interface

uses DMON,keyboard,TAux,Crono,Bot_Long,Bot_trip,Memory,Choisir,Llegir;

	procedure Presentacio;
  procedure MenuPrincipal;

implementation

var
	eixir_menu,
	abort: boolean;

	procedure Presentacio;
  	begin
    	LoadPCX(Logo,BP);
      SavePalette(gamepal);
      BlackOut;
      Flip(BP,VGA);
      FadeIn(gamepal);
      repeat until KeyPress(KeySpace);
      FadeOut;
      Cls(0,VGA);
    end;

  procedure MenuPrincipal2;
  	begin
      repeat
 	    	{if Keypress(Key1) then}
   	    if Keypress(Key2)
					then
          	begin
              FadeOut;
              EscollirProva;
              EscollirAtleta;

              LoadPCX(Pista,BP);
		          BlackOut;
				      Flip(BP,VGA);
        		  FadeIn(gamepal);

              tipus_ronda:= prac;

              GetMemoryPractica;

              for intents:= 1 to NINTENTSFINAL do
              	case prova of
                	1: TurnoBotLlargaria(saltador,josoc);
                  2: TurnoTripleBot(saltador,josoc);
                end;

              FreeMemoryPractica;

              eixir_menu:= true;

              Cls(0,BP);
				      Flip(BP,WP);
				      FadeChaos(1000,random(14)+1,BP);
            end;

     	  if Keypress(Key3)
					then
						begin
            	FadeOut;
              EscollirProva;
              EscollirAtleta;

              { si no pose aquesta linia apareix una bona idea }
							{ per a una demo: mentres est… el menu apareixen }
							{ distintes modalitats esportives                }
              LoadPCX(Pista,BP);
              {llegirRecords(WR,prova);}
		          BlackOut;
				      Flip(BP,VGA);
        		  FadeIn(gamepal);

              case prova of
              	1: ConcursBotLlargaria;
                2: ConcursTripleBot;
              end;

              eixir_menu:= true;
            end;

 	      if Keypress(Key4)
					then
						begin
							eixir_menu:= true;
              abort:= true;
            end;
   	  until (eixir_menu);
    end;

  Procedure MenuPrincipal;
  	begin
    	eixir_menu:= true;
		  abort:= false;
      while (eixir_menu) and not(abort) do
       	begin
		    	eixir_menu:= false;
          LoadPCX('.\gfx\Image.pcx'{Menu},BP);
          SavePalette(gamepal2);
          BlackOut;
		      Flip(BP,VGA);
          FadeIn(gamepal2);
          MenuPrincipal2;
        end;
    end;

end.