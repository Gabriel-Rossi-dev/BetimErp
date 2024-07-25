unit Betim.View.Login;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Imaging.pngimage,
  Vcl.StdCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TfrmLogin = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Image1: TImage;
    Panel3: TPanel;
    Panel4: TPanel;
    Label1: TLabel;
    Panel5: TPanel;
    Panel6: TPanel;
    Label3: TLabel;
    editSenha: TEdit;
    Panel7: TPanel;
    Label4: TLabel;
    editLogin: TEdit;
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLogin: TfrmLogin;

implementation

uses
  UdmConexao;

{$R *.dfm}

procedure TfrmLogin.Button1Click(Sender: TObject);
var qryLogin : TFDQuery;
begin

  qryLogin := TFDQuery.Create(nil);
  qryLogin.Connection := dm_dados.FDConnection1;
  qryLogin.Close;

  if editLogin.Text = '' then
    Application.MessageBox('� necessario preencher o campo login para conectar ao sistema','Alerta',MB_ICONINFORMATION);

  if editSenha.Text = '' then
    Application.MessageBox('� necessario preencher o campo senha para conectar ao sistema','Alerta',MB_ICONINFORMATION);

  try
    try
      qryLogin.SQL.Text := 'SELECT * FROM USUARIOS WHERE LOGIN = :LOGIN AND SENHA = :SENHA';
      qryLogin.ParamByName('SENHA').AsString := editSenha.Text;
      qryLogin.ParamByName('LOGIN').AsString := editLogin.Text;
      qryLogin.Open;

      if qryLogin.IsEmpty then
      begin
        raise Exception.Create('Login e/ou senha inv�lidos');
      end
      else
      begin
        if qryLogin.FieldByName('STATUS').AsString <> '1' then
        begin
          raise Exception.Create('Usu�rio Bloqueado');
        end;
        Application.MessageBox('Login efetuado com sucesso','ATEN��O');
        Close;
      end;

    except
      on Erro: Exception do
      begin
        Application.MessageBox(PwideChar(Erro.Message),'Aten��o');
        editLogin.SetFocus;
      end;
    end;

  finally
    qryLogin.Close;
    qryLogin.Free;
  end;


end;

procedure TfrmLogin.Button2Click(Sender: TObject);
begin
CLOSE;
end;

end.
