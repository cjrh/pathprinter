program pathprinter;

{$mode objfpc}{$H+}

{$apptype console}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes, SysUtils, CustApp
  { you can add units after this };

type

  { TPathPrinter }

  TPathPrinter = class(TCustomApplication)
  protected
    procedure DoRun; override;
  public
    constructor Create(TheOwner: TComponent); override;
    destructor Destroy; override;
    procedure WriteHelp; virtual;
  end;

{ TPathPrinter }

procedure TPathPrinter.DoRun;
var
  ErrorMsg: String;
  SL: TStringList;
  Path, x: String;
begin
  // quick check parameters
  ErrorMsg:=CheckOptions('h','help');
  if ErrorMsg<>'' then begin
    ShowException(Exception.Create(ErrorMsg));
    Terminate;
    Exit;
  end;

  // parse parameters
  if HasOption('h','help') then begin
    WriteHelp;
    Terminate;
    Exit;
  end;

  { add your program here }
  SL := TStringList.Create;
  try
    Path := GetEnvironmentVariable('PATH');
    SL.StrictDelimiter:=True;
    SL.Delimiter:=';';
    SL.DelimitedText:=Path;
    for x in SL do
        WriteLn(x);
  finally
    FreeAndNil(SL);
  end;


  // stop program loop
  Terminate;
end;

constructor TPathPrinter.Create(TheOwner: TComponent);
begin
  inherited Create(TheOwner);
  StopOnException:=True;
end;

destructor TPathPrinter.Destroy;
begin
  inherited Destroy;
end;

procedure TPathPrinter.WriteHelp;
begin
  { add your help code here }
  writeln('Usage: ',ExeName,' -h');
end;

var
  Application: TPathPrinter;
begin
  Application:=TPathPrinter.Create(nil);
  Application.Title:='Path Printer';
  Application.Run;
  Application.Free;
end.

