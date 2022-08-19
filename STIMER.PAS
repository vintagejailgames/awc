unit STimer;

(* Information
   ßßßßßßßßßßß

   Program Title : Programmable Interval Timer (PIT) unit.
   External name : STIMER.TPU
   Version       : 1.0
   Start date    : 13/10/96
   Last update   : 13/10/96
   Author        : Rob Anderton.
   Description   : Intel 8253 PIT routines for timing events.
                   Based on code from PIT.TXT by Mark Feldman for the PCGPE.

*)

interface

{******}

type TimerFunc = procedure(ClockTicks : longint);

{******}

const TimerHandler : TimerFunc = nil;

{******}

procedure Timer_Init(Freq : word);
procedure Timer_SetHandler(Handler : TimerFunc);
procedure Timer_Done;

{******}

implementation

uses DOS;

{******}

const TIMER_INT  = 8;
      TIMER_FREQ : longint = $1234DD;

{******}

var OldExit     : pointer;
    TimerActive : boolean;
    BIOSHandler : procedure;
    Counter     : longint;
    Ticks       : longint;

{******}

procedure Timer_Exit; far;

begin
     ExitProc:= OldExit;
     if TimerActive then Timer_Done;
end;

{******}

procedure Timer_Handler; interrupt;

begin
     Inc(Ticks, Counter);

     if @TimerHandler <> nil then TimerHandler(Ticks);

     if Ticks >= $10000 then
     begin
          Dec(Ticks, $10000);

          asm
             pushf
          end;

          BIOSHandler;
     end
     else Port[$20]:= $20;
end;

{******}

procedure Timer_Init(Freq : word);

begin
     if Freq = 0 then exit;
     Ticks:= 0;
     Counter:= TIMER_FREQ div Freq;

     GetIntVec(TIMER_INT, @BIOSHandler);
     SetIntVec(TIMER_INT, @Timer_Handler);

     TimerHandler:= nil;
     TimerActive:= true;

     Port[$43]:= $34;
     Port[$40]:= byte(Counter mod 256);
     Port[$40]:= byte(Counter shr 8);
end;

{******}

procedure Timer_SetHandler(Handler : TimerFunc);

begin
     if @Handler <> nil then TimerHandler:= Handler;
end;

{******}

procedure Timer_Done;

begin
     if TimerActive then
     begin
          Port[$43]:= $34;
          Port[$40]:= 0;
          Port[$40]:= 0;

          SetIntVec(TIMER_INT, @BIOSHandler);
          TimerHandler:= nil;
          TimerActive:= false;
     end;
end;

{******}

begin
     OldExit:= ExitProc;
     ExitProc:= @Timer_Exit;
     TimerActive:= false;
end.