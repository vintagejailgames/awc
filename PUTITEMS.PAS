unit PutItems;

interface

uses DMON,taux,crono;

  function ScrollD(carr,tcarr,pix,maxamp: integer; var x,amp: integer): boolean;

  (* ********************************************************************* *)
  (*					PROCEDIMENTS PER AL BOT I TRIPLE BOT DE LLARG·RIA            *)
  (* ********************************************************************* *)
	procedure PutCarrer;
  procedure PutFosa(j: jumper; tcarr,pix,maxamp: integer);
  procedure PutWorldRecord(j: jumper; tcarr,pix,maxamp: integer);
  procedure PutMarcador;
  procedure PutText(s: string; x,y: integer; col: byte);
  procedure PutVent;
  procedure PutJutge(j: jumper; tcarr,pix,maxamp: integer);
  procedure PutTabla(j: jumper; tcarr,pix,maxamp: integer);
  procedure PutNumerosFosa(j: jumper; tcarr,pix,maxamp: integer; idprova: byte);
  procedure PutRemogutSorra(j: jumper);
  procedure PutAlsaSorra(j: jumper; i: byte);
  procedure PutXafaPlastilina(j: jumper; TABLA: integer);
  procedure PutMedals(j: jumper; tcarr,pix,maxamp: integer);
  procedure PutWrong(x,y: integer);
  procedure PutNumero(marca,valid: real; x,y: integer; col: byte; dec: byte);
  procedure PutResultats(intents,participant: byte);
  function CheckWR(marca: real): boolean;
  procedure NewWorldRecord;


implementation

	(* ********************************************************************* *)
  (*					PROCEDIMENTS PER AL BOT I TRIPLE BOT DE LLARG·RIA            *)
  (* ********************************************************************* *)

var
	x,ample: integer;

	function ScrollD(carr,tcarr,pix,maxamp: integer; var x,amp: integer): boolean;
  { carr: carrereta que porta l'atleta, normalment j.carrereta               }
  { tcarr: total de metres que ha de recorrer l'atleta fins el item          }
  { pix: coordenada x d'on volem que es quede situat el item                 }
  { maxamp: maxima ampl…ria que t‚ el item                                   }
  	var
    	qqq: integer;

  	begin
    	qqq:= (tcarr-pix)-(319-pix);
    	if (319-(carr-qqq) > pix)
      	then x:= 319-(carr-qqq)
        else x:= pix;
      if (carr >= qqq)
      	then
        	begin
          	ScrollD:= true;
          	if (carr-maxamp > qqq)
            	then amp:= maxamp
              else amp:= carr-qqq;
            if (amp <= 0) then amp:= 1;
          end
        else ScrollD:= false;
    end;

  { col.loca el carrer pel que es corre }
  procedure PutCarrer;
   	begin
      PutSprite(IP,0,11,WP,0,151,320,5);
    end;

  { col.loca la fosa per a botar }
  procedure PutFosa(j: jumper; tcarr,pix,maxamp: integer);
	  begin
    	if ScrollD(j.carrereta,tcarr,pix,maxamp,x,ample)
      	then PutSprite(IP,0,16,WP,x,151,ample,5)
    end;

  { col.loca un puntet on est… establit el World Record }
  procedure PutWorldRecord(j: jumper; tcarr,pix,maxamp: integer);
  	begin
      if ScrollD(j.carrereta,tcarr+(round(WR.marca*escala)),pix+(round(WR.marca*escala)),maxamp,x,ample)
      	then PutPixel(x,155,4,WP);
    end;

  procedure PutMarcador;
  	var
    	loop: byte;

  	begin
    	{ col.loca el marcador }
      for loop:= 0 to 1 do
      	PutSprite(IP,marcador.xs,marcador.ys,WP,marcador.x,marcador.y+((marcador.alt-1)*loop),marcador.ample,marcador.alt);
      {PutSprite(IP,marcador.xs,marcador.ys,WP,marcador.x,marcador.y+marcador.alt-1,marcador.ample,marcador.alt);}
      { col.loca les 6 divisions per a cada intent }
      for loop:= 0 to 5 do
      	PutSprite(IP,194,37,WP,marcador.x+(loop*32),marcador.y+marcador.alt-1,32,9);
      { col.loca el marcador de les tres medalles }
      if (tipus_ronda = final) then
      	begin
					for loop:= 0 to 2 do
          	begin
							PutSprite(IP,marcador.xs,marcador.ys,WP,marcador.x,17+((marcador.alt-1)*loop),marcador.ample,marcador.alt);
              PutSprite(IP,118+(loop*3),0,WP,marcador.x+3,20+((marcador.alt-1)*loop),3,3);
              PutSprite(IP,194,37,WP,223,17+((marcador.alt-1)*loop),33,9);
            end;
        end;
    end;

  { col.loca una cadena de caracters en les coordenades especificades }
  procedure PutText(s: string; x,y: integer; col: byte);
  	{ la variable col indica el color: }
		{ 0: groc; 1: roig; 2: blanc }
		var
  		i: byte;
      xs,ys: integer;		{ en quina x i y del pcx comencem a mirar }
      ample: byte; 			{ les lletres tenen un ample, els nos. en altre  }
      comensa: integer;	{ les lletres comencen en un lloc, nos. en altre }

		begin
    	case col of
      	0: ys:= 195;
        1: ys:= 190;
        2: ys:= 185;
      end;
  		for i:= 1 to length(s) do
				begin
        	s[i]:= UpCase(s[i]);

        	case ord(s[i]) of
          	65..90: begin xs:= 65; ample:= 6; comensa:= 0 end;
            46..58: begin xs:= 46; ample:= 4; comensa:= 269 end;
          end;

      		if (s[i] = 'I') then dec(x);
          if (s[i] = '.') then dec(x,2);

      		if not(ord(s[i]) = 32) then PutSprite(IP,((ord(s[i])-xs)*ample)+comensa,ys,WP,x,y,ample,5);

	        if (s[i] = 'M') or (s[i] = 'N') or (s[i] = 'W')
  	      	then inc(x,6)
    	      else inc(x,4);

      	  if (s[i] = 'I') then dec(x);
	      end;
  end;

	procedure PutVent;
  	var
    	x: integer;

		begin
			if (vent.forsa < 0)
				then
					begin
						PutSprite(IP,100,0,WP,vent.fletxa,194,9,3);	{ col.loca la fletxa }
          	PutSprite(IP,266,187,WP,151,189,3,1);					{ col.loca el signe  }
	        end
        else
		  	  if (vent.forsa > 0)
						then
							begin
								PutSprite(IP,109,0,WP,vent.fletxa,194,9,3);	{ col.loca la fletxa }
    		      	PutSprite(IP,260,186,WP,151,188,3,3);  				{ col.loca el signe  }
	      		  end;
      PutNumero(abs(vent.forsa),0,vent.numerosx,187,2,1);
  	end;

	procedure PutJutge(j: jumper; tcarr,pix,maxamp: integer);
  	begin
    	if ScrollD(j.carrereta,tcarr,pix,maxamp,x,ample)
	      then
  		  	if (j.estat < 6)
      			then PutSprite(IP,0,21,WP,x,132,ample,16)
			      else
      		  	case j.valid of
		          	0: PutSprite(IP,34,21,WP,x,132,ample+1,16);
    		        1..2: PutSprite(IP,17,21,WP,x,132,ample,16);
        		  end;
    end;

  procedure PutTabla(j: jumper; tcarr,pix,maxamp: integer);
  	begin
    	{ col.loca la tabla }
      if ScrollD(j.carrereta,tcarr,pix,maxamp,x,ample)
      	then PutSprite(IP,0,6,WP,x,151,ample,5);
    end;

  procedure PutNumerosFosa(j: jumper; tcarr,pix,maxamp: integer; idprova: byte);
  	var
    	xs: integer;

  	begin
    	{ col.loca els n£meros de la fosa }
      case idprova of
	      1: xs:= 236;
	      2: xs:= 123;
      end;
      if ScrollD(j.carrereta,tcarr,pix,maxamp,x,ample)
      	then PutSprite(IP,xs,17,WP,x,157,ample,5);
    end;

  procedure PutRemogutSorra(j: jumper);
  	begin
    	{ col.loca un sprite aposta per a que es note que ha remogut la sorra }
      if ((j.estat > 3) and (j.estat <> 5) and (j.valid <> 2))
				then
          if (j.caiguda > 180)
          	then PutSprite(IP,16,6,WP,j.caiguda,j.y+28,6+(j.x-j.caiguda),3)
            else
							if (j.x > 180) then PutSprite(IP,47,6,WP,229,j.y+28,(j.x-200)+3,3);
    end;

  procedure PutAlsaSorra(j: jumper; i: byte);
  	begin
    	if ((j.estat = 4) and (i > 0) and (j.caiguda > 225))
      	then PutSprite(IP,0,61,WP,j.x-6,j.y+22,14,10);
    end;

  procedure PutXafaPlastilina(j: jumper; TABLA: integer);
  	var
    	ample: byte;
  	begin
    	{ col.loca una marca blanca en la plastilina si la xafa }
      if ((j.batuda = TABLA+7) or (j.batuda = TABLA+9)) then ample:= 1;
      if (j.batuda = TABLA+8) then ample:= 2;
      if ((j.f > 9) and ((j.batuda >= TABLA+7) and (j.batuda <= TABLA+9)))
      	then PutSprite(IP,14,6,WP,j.batuda,153,ample,1);
    end;

  procedure PutMedals(j: jumper; tcarr,pix,maxamp: integer);
  	var
    	col: byte;

  	begin
      if (ClassificacioFinal^[3].marca > 0)
				then
					begin
          	if ScrollD(j.carrereta,tcarr+(round(ClassificacioFinal^[3].marca*escala)),
												pix+(round(ClassificacioFinal^[3].marca*escala)),maxamp,x,ample)
            	then PutSprite(IP,97,6,WP,x,151,ample,5);
            if (josoc = ClassificacioFinal^[3].id)
							then col:= 1
              else col:= 0;
            PutText(ClassificacioFinal^[3].nom,73,35,col);
            PutText(ClassificacioFinal^[3].nacio,206,35,col);
            PutNumero(ClassificacioFinal^[3].marca,0,231,35,col,2);
          end;
      if (ClassificacioFinal^[2].marca > 0)
				then
					begin
          	if ScrollD(j.carrereta,tcarr+(round(ClassificacioFinal^[2].marca*escala)),
												pix+(round(ClassificacioFinal^[2].marca*escala)),maxamp,x,ample)
            		then PutSprite(IP,86,6,WP,x,151,ample,5);
          	if (josoc = ClassificacioFinal^[2].id)
							then col:= 1
              else col:= 0;
            PutText(ClassificacioFinal^[2].nom,73,27,col);
            PutText(ClassificacioFinal^[2].nacio,206,27,col);
            PutNumero(ClassificacioFinal^[2].marca,0,231,27,col,2);
          end;
      if (ClassificacioFinal^[1].marca > 0)
				then
					begin
          	if ScrollD(j.carrereta,tcarr+(round(ClassificacioFinal^[1].marca*escala)),
												pix+(round(ClassificacioFinal^[1].marca*escala)),maxamp,x,ample)
            	then PutSprite(IP,75,6,WP,x,151,ample,5);
            if (josoc = ClassificacioFinal^[1].id)
							then col:= 1
              else col:= 0;
            PutText(ClassificacioFinal^[1].nom,73,19,col);
            PutText(ClassificacioFinal^[1].nacio,206,19,col);
            PutNumero(ClassificacioFinal^[1].marca,0,231,19,col,2);
          end;
    end;

  procedure PutWrong(x,y: integer);
  	begin
      PutSprite(IP,107,4,WP,x-6,y-1,31,7);
    end;

  procedure PutNumero(marca,valid: real; x,y: integer; col: byte; dec: byte);
  { col: 0: groc; 1: roig; 2: blanc) }
  	var
    	es: string;

  	begin
      if (valid <> 0)
      	then PutWrong(x,y)
        else
        	begin
          	marca:= round(marca*100)/100;
            str(marca:0:dec,es);
            PutText(es,x+3,y,col);
          end;
    end;

  procedure PutResultats(intents,participant: byte);
  	var
    	i: byte;
      x,y: integer;

  	begin
    	for i:= 1 to intents-1 do
      	begin
        	x:= marcador.numerosx+(32*(i-1));
		      y:= marcador.numerosy;
          if (tipus_ronda = clas)
          	then PutNumero(ResultatsRonda^[i,participant],ValidesesRonda^[i,participant],x,y,0,2);
         	if (tipus_ronda = final) or (tipus_ronda = prac)
           	then PutNumero(ResultatsFinal^[i,participant],ValidesesFinal^[i,participant],x,y,0,2);
        end;
    end;

  function CheckWR(marca: real): boolean;
  	begin
    	if (marca > WR.marca) and (vent.forsa < 2.1) and (tipus_ronda <> prac)
      	then
        	begin
          	WR.marca:= marca;
            CheckWR:= true;
          end
        else CheckWR:= false;
		end;

  procedure NewWorldRecord;
  	var
    	i: byte;

  	begin
    	for i:= 1 to 15 do
      	begin
				  PutText('NEW WR',marcador.x+(32*(intents-1))+2,marcador.y+10,0);
          {Retarda(50);}
          Flip(WP,VGA);
          PutSprite(IP,194,37,WP,marcador.x+(32*(intents-1)),marcador.y+8,33,9);
          {Retarda(50);}
          Flip(WP,VGA);
        end;
    end;

end.