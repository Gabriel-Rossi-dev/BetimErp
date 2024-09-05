unit Betim.View.Splash;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Imaging.pngimage, Vcl.ComCtrls;

type
  TfrmSplash = class(TForm)
    pnlPrincipal: TPanel;
    ProgressBar1: TProgressBar;
    Image1: TImage;
    Label1: TLabel;
    lblStatus: TLabel;
    Timer1: TTimer;
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSplash: TfrmSplash;

implementation

uses
  Betim.View.Principal;

{$R *.dfm}


procedure TfrmSplash.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:= caFree;
end;

procedure TfrmSplash.FormCreate(Sender: TObject);
begin
  Timer1.OnTimer := Timer1Timer;
end;

procedure TfrmSplash.Timer1Timer(Sender: TObject);
begin
  if ProgressBar1.Position <= 100 then
  begin
    ProgressBar1.StepIt;
    case ProgressBar1.Position of
    10: lblStatus.Caption := 'Carregando Depencias...';
    25: lblStatus.Caption := 'Conectando ao Banco de dados...';
    45: lblStatus.Caption := 'Carregando as configurações...';
    75: lblStatus.Caption := 'Iniciando o Sistema...';
    end;
  end;
  if ProgressBar1.Position = 100 then
  begin
    Timer1.OnTimer := nil;
    ModalResult := mrOk;
    close;
    exit;
  end;

end;

end.
