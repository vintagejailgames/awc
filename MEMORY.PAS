unit memory;

interface

uses TAux,Llegir;

	procedure GetMemoryRonda;
  procedure FreeMemoryRonda;
  procedure GetMemoryFinal;
  procedure FreeMemoryFinal;
  procedure GetMemoryPractica;
  procedure FreeMemoryPractica;
  procedure GetMemoryEscollir;
  procedure FreeMemoryEscollir;

implementation
	var
  	loop1,loop2: byte;

	procedure GetMemoryRonda;
  	begin
    	getmem(ResultatsRonda,sizeof(ResultatsDeLaClassificacio));
      getmem(ValidesesRonda,sizeof(ValidClassificacio));
      for loop1:= 1 to NINTENTSCLAS do
				for loop2:= 1 to NPARTICIPANTS do
        	begin
	        	ResultatsRonda^[loop1,loop2]:= 0;
            ValidesesRonda^[loop1,loop2]:= 0;
          end;
		  getmem(ClassificacioRonda,sizeof(MillorsMarquesClas));
		  getmem(Finalistes,sizeof(IDFinalistes));
    end;

  procedure FreeMemoryRonda;
  	begin
    	freemem(ResultatsRonda,sizeof(ResultatsDeLaClassificacio));
		  freemem(ValidesesRonda,sizeof(ValidClassificacio));
		  freemem(ClassificacioRonda,sizeof(MillorsMarquesClas));
    end;

  procedure GetMemoryFinal;
  	begin
      getmem(ResultatsFinal,sizeof(ResultatsDeLaFinal));
      getmem(ValidesesFinal,sizeof(ValidFinal));
      for loop1:= 1 to NINTENTSFINAL do
				for loop2:= 1 to NFINALISTES do
        	begin
	        	ResultatsFinal^[loop1,loop2]:= 0;
  	        ValidesesFinal^[loop1,loop2]:= 0;
          end;
		  getmem(MMFinal,sizeof(MillorsMarquesFinal));
		  getmem(ClassificacioFinal,sizeof(MillorsMarquesFinal));
      for loop1:= 1 to NFINALISTES do
      	begin
        	LlegirJumper(saltador,finalistes^[loop1]);
          MMFinal^[loop1].nom:= saltador.nom;
          MMFinal^[loop1].id:= saltador.id;
          ClassificacioFinal^[loop1].nom:= MMFinal^[loop1].nom;
	      	ClassificacioFinal^[loop1].marca:= 0;
          MMFinal^[loop1].marca:= 0;
        end;
    end;

  procedure FreeMemoryFinal;
  	begin
    	freemem(Finalistes,sizeof(IDFinalistes));
      freemem(ResultatsFinal,sizeof(ResultatsDeLaFinal));
		  freemem(ValidesesFinal,sizeof(ValidFinal));
		  freemem(MMFinal,sizeof(MillorsMarquesFinal));
		  freemem(ClassificacioFinal,sizeof(MillorsMarquesFinal));
    end;

  procedure GetMemoryPractica;
  	begin
    	getmem(ResultatsFinal,sizeof(ResultatsDeLaFinal));
      getmem(ValidesesFinal,sizeof(ValidFinal));
      for loop1:= 1 to NINTENTSFINAL do
				for loop2:= 1 to NFINALISTES do
        	begin
		       	ResultatsFinal^[loop1,loop2]:= 0;
  	        ValidesesFinal^[loop1,loop2]:= 0;
          end;
    end;

  procedure FreeMemoryPractica;
  	begin
    	freemem(ResultatsFinal,sizeof(ResultatsDeLaFinal));
		  freemem(ValidesesFinal,sizeof(ValidFinal));
    end;

  procedure GetMemoryEscollir;
  	begin
      getmem(Escollir,sizeof(MillorsMarquesClas));
    end;

  procedure FreeMemoryEscollir;
  	begin
      freemem(Escollir,sizeof(MillorsMarquesClas));
    end;

end.