uses TAux,crt;

type
	f= file of WorldRecords;

var
	WR: WorldRecords;
  myfile: f;

begin
	clrscr;
  write('BOT DE LLARG·RIA');
  writeln;
  write('Nom de l''atleta: ');
	readln(WR.bot_de_llargaria.nom);
  write('Naci¢ de l''atleta: ');
	readln(WR.bot_de_llargaria.nacio);
  write('Marca aconseguida: ');
	readln(WR.bot_de_llargaria.marca);
  write('Lloc i data del fet: ');
	readln(WR.bot_de_llargaria.lloc);
  assign(myfile,'records.rec');
  rewrite(myfile);
  write(myfile,WR);
  close(myfile);
end.