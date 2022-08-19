{ Programa per a convertir un fitxer .txt a base de dades }
uses crt,Taux;

var
	i : integer;
  j: jumper_register;
  fileorigen,filedesti: string;
  filetext: file of char;
  datafile: file of jumper_register;

procedure NouLlegirJumper;
	var
  	aux: integer;
    ch: char;
    cadena: string;

  begin
  	assign(filetext,fileorigen);
    reset(filetext);
    assign(datafile,filedesti);
    rewrite(datafile);
    aux:= 1;
    cadena:= '';

    while not(eof(filetext{cont = 46})) do
     	begin

        repeat
	        read(filetext,ch);
  	      if (ch <> '#') then cadena := cadena + ch;
          inc(aux);
        until (ch = '#');
        j.nom:= cadena;

        cadena:= '';
        repeat
	        read(filetext,ch);
  	      if (ch <> '#') then cadena := cadena + ch;
        until (ch = '#');
        j.nacio:= cadena;

        cadena:= '';
        repeat
         	read(filetext,ch);
          if (ch <> '#') then cadena:= cadena+ch;
        until (ch = '#');
        val(cadena,j.best,aux);
        cadena := '';

        cadena:= '';
        repeat
         	read(filetext,ch);
          if (ch <> #13) then cadena:= cadena+ch;
        until (ch = #13);
        val(cadena,j.pell,aux);
        cadena := '';

        read(filetext,ch);
        write(datafile,j);
      end;
    close(filetext);
    close(datafile);
  end;

begin
	clrscr;
  write('Nom del fitxer origen: ');
  readln(fileorigen);
  fileorigen:= fileorigen+'.txt';
  write('Nom del fitxer desti: ');
  readln(filedesti);
  filedesti:= filedesti+'.dat';
  NoullegirJumper;
  reset(datafile);
  writeln('L''arxiu ha sigut creat');
	close(datafile);
end.