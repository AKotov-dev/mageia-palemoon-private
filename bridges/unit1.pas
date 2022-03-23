unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Buttons,
  ExtCtrls, Process;

type

  { TMainForm }

  TMainForm = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Memo1: TMemo;
    RadioGroup1: TRadioGroup;
    Shape1: TShape;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
    procedure RestartTor;

  private

  public

  end;

var
  MainForm: TMainForm;

implementation

uses pingtrd;

{$R *.lfm}

{ TMainForm }

//Перезапуск tor с новыми настройками (асинхронно) --runasdaemon 1 - показать вывод realtime
procedure TMainForm.RestartTor;
var
  ExProcess: TProcess;
begin
  Application.ProcessMessages;
  ExProcess := TProcess.Create(nil);
  try
    ExProcess.Executable := 'bash';
    ExProcess.Parameters.Add('-c');
    ExProcess.Parameters.Add(
      'killall tor obfs4proxy; sleep 2; /usr/bin/tor --runasdaemon 1 ' +
      '--defaults-torrc /usr/share/defaults-torrc -f /etc/tor/torrc');

    //  ExProcess.Options := ExProcess.Options + [poWaitOnExit];
    ExProcess.Execute;
  finally
    ExProcess.Free;
  end;
end;

procedure TMainForm.FormCreate(Sender: TObject);
var
  FCheckPingThread: TThread;
begin
  MainForm.Caption := Application.Title;
  MainForm.Left := 0;
  MainForm.Top := 0;

  //Запуск проверки пинга
  FCheckPingThread := CheckPing.Create(False);
  FCheckPingThread.Priority := tpNormal;
end;

procedure TMainForm.RadioGroup1Click(Sender: TObject);
begin
  if RadioGroup1.ItemIndex = 0 then
  begin
    Memo1.Font.Color := clSilver;
    Memo1.Enabled := False;
  end
  else
  begin
    Memo1.Font.Color := clDefault;
    Memo1.Enabled := True;
  end;
end;

procedure TMainForm.BitBtn2Click(Sender: TObject);
begin
  Memo1.Clear;
end;

//Построение запись конфига /etc/tor/torrc
procedure TMainForm.BitBtn1Click(Sender: TObject);
var
  i: integer;
  S: TStringList;
begin
  try
    Shape1.Brush.Color := clYellow;
    S := TStringList.Create;

    if (RadioGroup1.ItemIndex = 0) or (Pos('obfs4', Memo1.Text) = 0) then
    begin
      S.Add('SocksPort 9055');
      S.Add('Exitpolicy reject *:*');
      S.Add('ExtORPort auto');
      S.Add('LearnCircuitBuildTimeout 0');
      S.Add('CircuitBuildTimeout 60');
    end
    else
    begin
      S.Add('UseBridges 1');
      S.Add('SocksPort 9055');
      S.Add('Exitpolicy reject *:*');
      S.Add('ExtORPort auto');
      S.Add('LearnCircuitBuildTimeout 0');
      S.Add('CircuitBuildTimeout 60');

      S.Add('');
      S.Add('ClientTransportPlugin obfs4 exec /usr/bin/obfs4proxy managed');
      for i := 0 to Memo1.Lines.Count - 1 do
        if Pos('obfs4', Memo1.Lines[i]) <> 0 then
          S.Add('Bridge ' + Trim(Memo1.Lines[i]));
    end;

    S.SaveToFile('/etc/tor/torrc');
    RestartTor;

  finally
    S.Free;
  end;
end;

end.
