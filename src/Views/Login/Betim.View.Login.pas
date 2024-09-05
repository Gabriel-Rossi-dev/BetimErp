unit Betim.View.Login;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Imaging.pngimage,
  Vcl.StdCtrls, FireDAC.Stan.Intf,Betim.Global, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,Betim.View.Principal;

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
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    EntidadeGlobal : Global;
  public
    { Public declarations }
  function GetGUsuario():String;
  function GetGCodigoUsuario():String;
  function GetGLoginUsuario():String;

  end;

var
  frmLogin: TfrmLogin;

implementation

uses
  UdmConexao,Betim.View.Splash;

{$R *.dfm}

procedure TfrmLogin.Button1Click(Sender: TObject);
var qryLogin : TFDQuery;
teste:string;
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

          EntidadeGlobal.GUsuario := (qryLogin.FieldByName('NOME').AsString);
          EntidadeGlobal.GCodigoUsuario := qryLogin.FieldByName('ID').AsString;
          EntidadeGlobal.GLoginUsuario := qryLogin.FieldByName('LOGIN').AsString;

          frmSplash := TfrmSplash.Create(nil);
          try
            frmSplash.ShowModal;
          finally
            FreeAndNil(frmSplash);
          end;

          FrmBetim := TFrmBetim.Create(nil);
          try
            FrmBetim.ShowModal;
            ModalResult := mrOk;
            close;
          finally
            FreeAndNil(FrmBetim);
          end;

      end;

    except
      on Erro: Exception do
      begin
        Application.MessageBox(PwideChar(Erro.Message),'Aten��o');
        editLogin.SetFocus;

        //qryLogin.Close;
        //qryLogin.Free;
      end;
    end;
  finally
    qryLogin.Close;
    qryLogin.Free;
    ModalResult := mrOk;
    //close;
  end;


end;

procedure TfrmLogin.Button2Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfrmLogin.FormCreate(Sender: TObject);
begin
  EntidadeGlobal := Global.Create;

{$IFDEF DEBUG}
 if IsDebuggerPresent then
 begin
   editLogin.text := 'GABRIEL';
   editSenha.Text := 'MASTERKEY';
 end;
{$ENDIF}
end;

procedure TfrmLogin.FormDestroy(Sender: TObject);
begin
  EntidadeGlobal.Free;
end;



function TfrmLogin.GetGCodigoUsuario(): String;
begin
result := EntidadeGlobal.GCodigoUsuario
end;

function TfrmLogin.GetGLoginUsuario(): String;
begin
result := EntidadeGlobal.GLoginUsuario
end;

function TfrmLogin.GetGUsuario(): String;
begin
result := EntidadeGlobal.GUsuario
end;

end.
