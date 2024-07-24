program Betim;

uses
  Vcl.Forms,
  Betim.View.Principal in 'src\Views\Principal\Betim.View.Principal.pas' {FrmBetim},
  Betim.View.CadastroUsuario in 'src\Views\Usuarios\Betim.View.CadastroUsuario.pas' {FrmCadUsuario},
  Betim.View.Splash in 'src\Views\Betim.View.Splash.pas' {frmSplash},
  UdmConexao in 'db\UdmConexao.pas' {dm_dados: TDataModule},
  Betim.Model.CadastroUsuario in 'src\Views\Usuarios\Betim.Model.CadastroUsuario.pas' {dmUsuarios: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(Tdm_dados, dm_dados);
  Application.CreateForm(TFrmBetim, FrmBetim);
  Application.CreateForm(TFrmCadUsuario, FrmCadUsuario);
  Application.CreateForm(TdmUsuarios, dmUsuarios);
  Application.Run;
end.
