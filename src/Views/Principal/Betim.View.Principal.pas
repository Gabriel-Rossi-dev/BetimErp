unit Betim.View.Principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,Betim.Global, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.WinXPanels, Vcl.ExtCtrls,
  Vcl.StdCtrls;

type
  TFrmBetim = class(TForm)
    MainMenu1: TMainMenu;
    mnuCadastro: TMenuItem;
    mnuRelatorio: TMenuItem;
    mnuAjuda: TMenuItem;
    mnuCadUsuario: TMenuItem;
    Panel1: TPanel;
    lblUsuarioLogado: TLabel;
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
  Betim.View.CadastroUsuario, Betim.View.Login;

{$R *.dfm}

procedure TFrmBetim.FormCreate(Sender: TObject);
begin
  lblUsuarioLogado.Caption := frmLogin.GetGUsuario();
  //frmLogin.Action := caFree;
  frmLogin.ModalResult := mrOk;
  frmLogin.FreeOnRelease;
end;

procedure TFrmBetim.mnuCadUsuarioClick(Sender: TObject);
begin
 FrmCadUsuario.Show;
end;

end.
