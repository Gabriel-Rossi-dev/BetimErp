unit Betim.View.Principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.WinXPanels, Vcl.ExtCtrls;

type
  TFrmBetim = class(TForm)
    MainMenu1: TMainMenu;
    mnuCadastro: TMenuItem;
    mnuRelatorio: TMenuItem;
    mnuAjuda: TMenuItem;
    mnuCadUsuario: TMenuItem;
    procedure mnuCadUsuarioClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmBetim: TFrmBetim;

implementation

uses
  Betim.View.CadastroUsuario,
  Betim.View.Splash;

{$R *.dfm}

procedure TFrmBetim.FormCreate(Sender: TObject);
begin
  frmSplash := TfrmSplash.Create(nil);
  try
    frmSplash.ShowModal;
  finally
    FreeAndNil(frmSplash);
  end;

end;

procedure TFrmBetim.mnuCadUsuarioClick(Sender: TObject);
begin
 FrmCadUsuario.Show;
end;

end.
