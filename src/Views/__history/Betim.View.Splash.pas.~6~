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
    Timer1: TTimer;
    lblStatus: TLabel;
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSplash: TfrmSplash;

implementation

{$R *.dfm}

procedure TfrmSplash.Timer1Timer(Sender: TObject);
begin
  {if ProgressBar1.Position <= 100 then
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
    Close;}
    Close;

end;

end.
