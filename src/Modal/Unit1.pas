unit Unit1;

interface

uses
  System.SysUtils, System.Classes;

type
  TDataModule1 = class(TDataModule)
  private
    { Private declarations }
  public
    { Public declarations }
    function dataUltimoAcesso : String; overload;
    procedure dataUltimoAcesso(aValue :TDateTime); overload;
    function usuarioUltimoAceso : String; overload;
    procedure usuarioUltimoAceso(avalue : String); overload;
  end;

var
  DataModule1: TDataModule1;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDataModule1 }

function TDataModule1.dataUltimoAcesso: String;
begin

end;

procedure TDataModule1.dataUltimoAcesso(aValue: TDateTime);
begin

end;

function TDataModule1.usuarioUltimoAceso: String;
begin

end;

procedure TDataModule1.usuarioUltimoAceso(avalue: String);
begin

end;

end.
