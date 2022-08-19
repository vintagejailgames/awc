unit TAUX;

interface

uses DMON;

const
  ProvesMAX = 2;

	Sprites = '.\gfx\sprites.pcx';	{ sprites }
  Pista = '.\gfx\back.pcx';				{ pista   }
  Logo = '.\gfx\logo.pcx';				{ logo    }
  Items = '.\gfx\items.pcx';			{ items   }
  Menu = '.\gfx\main.pcx';				{ men£    }

  Wrecords = '.\data\records.rec';	{ arxiu base de dades dels records mundials }

  escala = 11;			{ escala a la que estÖ fet el joc: 11 pixels = 1 metre }

  NPARTICIPANTS = 39;
  NINTENTSCLAS = 3;

  NFINALISTES = 12;
  NINTENTSFINAL = 6;

type
	ctrls= (h,o);
  ronda= (clas,final,prac);

  { cada prova tÇ un n£mero assignat: }
  { 1: Bot de llargÖria               }
  { 2: Triple bot de llargÖria        }
  IDprova= 1..ProvesMAX;

  WorldRecord=
  	record
    	marca: real;
      nom,
      nacio,
			lloc: string;
    end;

  jumper_register=
   	record
     	nom,
      nacio: string;
      best: real;
      pell: byte;
    end;

	jumper=
  	record
    	id: byte;						{ ordre que ocupa en l'arxiu                      }
    	nom,								{ nom de l'atleta                                 }
			nacio: string;			{ nacionalitat de l'atleta                        }
      carrereta,					{ conta els metres que a avanáat el ninot         }
    	x,y,              	{ coordenades                                     }
			batuda,							{ punt x on fa la batuda                          }
      caiguda: integer;		{ punt x on cau                                   }
      sprite,							{ y on estÖ aquest corredor                       }
      f,									{ frame 			                                    }
			estat,							{ 0: preparat; 1: caminant; 2: corrent; 3: botant }
      										{ 4: revolcant-se; 5: abandono; 6: resultat;      }
      valid: byte;				{ 0: valid; 1: nulo; 2: abandona                  }
      best,								{ guarda la millor marca real de l'atleta         }
      velocitat,					{ velocitat                                       }
      power,              { power                                           }
      potencia,						{ potäcia del corredor                            }
      marca: real;				{ marca que ha fet                                }
      control: ctrls;			{ h si el porta un humÖ, o si l'ordinador         }
      pell: byte;					{ color de la pell                                }
    end;

  score=
  	record
    	x,y,								{ coordenades x i y de la pantalla }
			xs,ys,							{ coordenades x i y on es troben en el pcx }
			ample,alt,					{ ample i alt en pixels }
      lletresx,						{ coordenada x on escrivim el nom de l'atleta }
      lletresy,						{ coordenada y on escrivim }
      naciox,							{ coordenada x on escrivim la naci¢ de l'atleta }
      numerosx,						{ coordenada x (multiplicada per l'intent) on escrivim el resultat }
      numerosy: integer;	{ coordenada y on escrivim el resultat }
    end;

  viento=
  	record
      forsa: real;					{ la foráa del vent en m/s }
      numerosx,             { coordenada on es comenáa a escriure el valor }
			fletxa: integer;			{ on es pinta la fletxa								 }
    end;

  ResultatIndividual=
		record
    	id: byte;
			nom: string;
      nacio: string;
      marca: real;
    end;

  ResultatsDeLaClassificacio = array [1..NINTENTSCLAS,1..NPARTICIPANTS] of real;
  ValidClassificacio = array [1..NINTENTSCLAS,1..NPARTICIPANTS] of byte;
  MillorsMarquesClas = array [1..NPARTICIPANTS] of ResultatIndividual;

  IDFinalistes = array [1..NFINALISTES] of byte;

  ResultatsDeLaFinal = array [1..NINTENTSFINAL,1..NFINALISTES] of real;
  ValidFinal = array [1..NINTENTSFINAL,1..NFINALISTES] of byte;
  MillorsMarquesFinal = array [1..NFINALISTES] of ResultatIndividual;

var
	Intents,							{ intent en el qual es troba el saltador        }
  Participant: byte;		{ n£mero de participants                        }
  buttonA,buttonB,buttonFire: word;{ botons per al joc                  }
	marcador,							{ marcador que apareix baix de l'atleta         }
	marcadorP: score;			{ marcador on es mostra la classificaci¢ prov.  }
  vent: viento;					{ vent                                          }
  WR: WorldRecord;			{ World Record                                  }
  tipus_ronda: ronda;		{ classificaci¢, final, prÖctica...             }
  prova: IDprova;				{ cada disciplina tÇ un n£mero                  }
  gamepal,							{ paleta grÖfica que utilitzarem per al joc     }
  gamepal2: AuxPalette; { paleta grÖfica per als fitxers amb foto       }
  Josoc: byte;					{ id de l'atleta que control.lem nosaltres      }

  Altre: boolean;       { true quan Çs el torn d'un altre participant   }

  i: byte;							{ compta, en cada animaci¢, els frames avanáats }
  Saltador: jumper;			{ el saltador en qÅesti¢                        }

  { La matriu on guardarem els resultats de la fase de classificaci¢ }
  ResultatsRonda: ^ResultatsDeLaClassificacio;
  { La matriu on guardarem si cada bot de la fase de classificaci¢ Çs vÖlid o no }
  ValidesesRonda: ^ValidClassificacio;
  { Vector que contindrÖ les millors marques de la fase de classificaci¢ }
  ClassificacioRonda: ^MillorsMarquesClas;

  Escollir: ^MillorsMarquesClas;

  { Vector que guardarÖ els ID dels finalistes }
  Finalistes: ^IDFinalistes;

  { La matriu on guardarem els resultats de la final }
  ResultatsFinal: ^ResultatsDeLaFinal;
  { La matriu on guardarem si cada bot de la final Çs vÖlid o no }
  ValidesesFinal: ^ValidFinal;
  { Vector que contindrÖ la classificaci¢ final }
  MMFinal,ClassificacioFinal: ^MillorsMarquesFinal;

  {seg,deci,cent,mil: integer;}

  button,lastbutton: word;

  procedure SetButtons(A,B,C: word);
  function QuinaProva(n: byte): string;

implementation

	procedure SetButtons(A,B,C: word);
		begin
    	buttonA:= A;
      buttonB:= B;
      buttonFire:= C;
  	  button:= A;
    	lastbutton:= B;
	  end;

  function QuinaProva(n: byte): string;
  	begin
    	case prova of
      	1: QuinaProva:= '.\data\LJ.dat';
        2: QuinaProva:= '.\data\TJ.dat';
      end;
    end;

begin

	Randomize;

	{ INICIA EL MARCADOR }
  marcador.ample:= 193;
	marcador.alt:= 9;
	marcador.x:= (320-marcador.ample) shr 1;
	marcador.y:= 163;
  marcador.xs:= 0;
  marcador.ys:= 37;
  marcador.lletresx:= marcador.x+3;
  marcador.lletresy:= marcador.y+2;
  marcador.naciox:= marcador.x+marcador.ample-18;
  marcador.numerosx:= marcador.x+7;
  marcador.numerosy:= marcador.y+10;

end.