unit UdmConexao;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, FireDAC.Comp.UI, FireDAC.Phys.IBBase,
  Data.DB, FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet;

type
  Tdm_dados = class(TDataModule)
    FDPhysFBDriverLink1: TFDPhysFBDriverLink;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDConnection1: TFDConnection;
    procedure DataModuleCreate(Sender: TObject);
    private
    { Private declarations }
    const ARQUIVOCONFIGURACAO = 'C:\Users\grgab\Project\DELPHIZAO\BETIM\bin\Betim.cfg';
  public
    { Public declarations }
    procedure CarregarConfigurcoes;
    procedure Conectar;
    procedure Desconectar;
  end;

var
  dm_dados: Tdm_dados;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ Tdm_dados }

procedure Tdm_dados.CarregarConfigurcoes;
var
  ParametroNome   : String;
  ParametroValor  : String;
  Contador        : Integer;
  ListaParametros : TStringList;
begin
  FDConnection1.Params.Clear;
  if not FileExists(ARQUIVOCONFIGURACAO) then
    raise Exception.Create('Arquivo de configura��o n�o encontrado');
  ListaParametros := TStringList.Create;
  try
    ListaParametros.LoadFromFile(ARQUIVOCONFIGURACAO);
    for Contador := 0 to Pred(ListaParametros.Count) do
    begin
      if ListaParametros[Contador].IndexOf('=') > 0 then
      begin
        ParametroNome := ListaParametros[Contador].Split(['='])[0].Trim;
        ParametroValor := ListaParametros[Contador].Split(['='])[1].Trim;
        FDConnection1.Params.Add(ParametroNome +'='+ ParametroValor);
      end;
    end;
  finally
    ListaParametros.Free;
  end;
end;

procedure Tdm_dados.Conectar;
begin
  FDConnection1.Connected;
end;

procedure Tdm_dados.DataModuleCreate(Sender: TObject);
begin
  CarregarConfigurcoes;
  Conectar;
end;

procedure Tdm_dados.Desconectar;
begin
  FDConnection1.Connected := false;
end;

end.
