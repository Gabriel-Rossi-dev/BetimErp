program Betim;

uses
  Vcl.Forms,
  Betim.View.Principal in 'src\Views\Betim.View.Principal.pas' {FrmPrincipal};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.Run;
end.
