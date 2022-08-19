program Athletics_World_Championship_de_Zebiya_99;

uses DMON,Keyboard,TAux,Presen,Timer;

procedure IniciaTot;
 	begin
		InitDM;											{ Inicia Direct MON                       }
    HookKb;											{ col.loca la nova interrupci¢ del teclat }
		NouTimer;										{ col.loca la nova interrupci¢ del timer  }

    LoadPCX(Sprites,SP);     		{ carrega la imatge dels sprites          }
    LoadPCX(Items,IP);      	  { carrega la imatge dels items            }

    SetButtons(KeyO,KeyP,KeySpace);		{ estableix els botons del joc      }

    Presentacio;	{ The IAAF World Championship in Athletics de Zebiya'99 }
    MenuPrincipal;																			{ Men£ Principal  }
  end;

procedure AcabaTot;
 	begin
    Flip(VGA,WP);
    Goin_Out_V;
    EndDM;							{ Acaba Direct MON                              }
	  AcabarCrono;				{ Col.loca l'interrupci¢ per defecte del timer  }
    FreeKb;							{ Col.loca l'interrupci¢ per defecte del teclat }
  end;

begin
	IniciaTot;
  AcabaTot;
end.
