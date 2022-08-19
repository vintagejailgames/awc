unit Llegir;

interface

uses TAux;

	procedure LlegirJumper(var j: jumper; id: byte);
  procedure LlegirRecords(var WR: WorldRecord; n: IDprova);

implementation

var
	file_jumpers: file of jumper_register;	{ variable de tipus arxiu bda dels saltadors }
  file_records: file of WorldRecord; { variable de tipus arxiu bda dels records  }
  jr: jumper_register;

  procedure LlegirJumper(var j: jumper; id: byte);
  	var
	  	aux: byte;
      data: string;

		begin
    	data:= QuinaProva(prova);
  		assign(file_jumpers,data);
    	reset(file_jumpers);

 	    for aux:= 1 to id do read(file_jumpers,jr);
      j.nom:= jr.nom;
      j.nacio:= jr.nacio;
      j.best:= jr.best;
      j.pell:= jr.pell;

  	  j.id:= id;
    	j.x:= 0;
	    j.y:= 124;
  	  j.f:= 0;
      j.estat:= 0;
  	  j.sprite:= 0;
      j.velocitat:= 0;
  	  j.carrereta:= 0;

      if (id = Josoc)
	    	then j.control:= h
  	    else j.control:= o;

    	close(file_jumpers);
	  end;

  procedure LlegirRecords(var WR: WorldRecord; n: IDprova);
  	var
	  	aux: byte;

		begin
  		assign(file_records,Wrecords);
    	reset(file_records);
	    for aux:= 1 to n do read(file_records,WR);
      close(file_records);
    end;

end.