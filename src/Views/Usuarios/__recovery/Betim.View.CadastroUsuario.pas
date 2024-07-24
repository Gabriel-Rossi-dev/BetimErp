unit Betim.View.CadastroUsuario;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.WinXPanels, Vcl.ExtCtrls, Data.DB,
  Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, System.ImageList, Vcl.ImgList,
  Data.FMTBcd, Data.SqlExpr, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TFrmCadUsuario = class(TForm)
    CardPrincipal: TCardPanel;
    CardCadastro: TCard;
    CardPesquisa: TCard;
    pnlPesquisa: TPanel;
    pnlBotoesPesquisa: TPanel;
    pnlGrid: TPanel;
    gridCadUsuario: TDBGrid;
    EditPesquisar: TEdit;
    lblPesquisar: TLabel;
    btnPesquisar: TButton;
    ImageList1: TImageList;
    btnFecharPesquisa: TButton;
    btnSalvarPesquisa: TButton;
    btnEditarPesquisa: TButton;
    Panel1: TPanel;
    btnFecharCadastro: TButton;
    btnSalvarCadastro: TButton;
    btnEditarCadastro: TButton;
    btnImprimirPesquisa: TButton;
    dsUsuarios: TDataSource;
    editName: TEdit;
    lblUsuario: TLabel;
    Label1: TLabel;
    EditLogin: TEdit;
    Label2: TLabel;
    EditSenha: TEdit;
    editId: TEdit;
    lblId: TLabel;
    qryNovoUsuario: TFDQuery;
    chkAtivo: TCheckBox;
    procedure btnFecharPesquisaClick(Sender: TObject);
    procedure btnIncluirPesquisaClick(Sender: TObject);
    procedure btnFecharCadastroClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure gridCadUsuarioDblClick(Sender: TObject);
    procedure btnEditarPesquisaClick(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure  chamaqrygrid();
    procedure LimpaCampos();
    procedure EditPesquisarKeyPress(Sender: TObject; var Key: Char);
    procedure btnSalvarCadastroClick(Sender: TObject);
    procedure btnEditarCadastroClick(Sender: TObject);
    procedure gridCadUsuarioDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    { Private declarations }
    var newId:Integer;
  public
    { Public declarations }
    var status: String;
    qryConsulta,qryDelete : TFDQuery;
    insere :Boolean;
  end;

var
  FrmCadUsuario: TFrmCadUsuario;

implementation

uses
  UdmConexao, Betim.Model.CadastroUsuario;

{$R *.dfm}

procedure TFrmCadUsuario.btnEditarCadastroClick(Sender: TObject);
begin
  try
    try
      qryConsulta := TFDQuery.Create(nil);
      qryConsulta.Connection := dm_dados.FDConnection1;

      qryConsulta.Close;
      qryConsulta.SQL.Text :=  'SELECT ID,NOME,LOGIN,SENHA,STATUS FROM USUARIOS WHERE ID = :pID';
      qryConsulta.ParamByName('pID').asString := editId.text ;
      qryConsulta.Open();
      if qryConsulta.RecordCount > 0 then
      begin

        case Application.MessageBox('Tem certeza que deseja apagar esse usuário','ATENÇÃO!',MB_ICONEXCLAMATION + MB_YESNO ) of
          mrYes:
          begin
            qryDelete := TFDQuery.Create(nil);
            qryDelete.Connection := dm_dados.FDConnection1;
            qryDelete.Connection.StartTransaction;
            qryDelete.Close;

            qryDelete.SQL.Text:=            ' DELETE FROM USUARIOS WHERE ID = :pID';
            qryDelete.ParamByName('pID').AsString                 := editId.text ;
            qryDelete.ExecSQL;
          end;
          mrNo:Abort;
        end;
      end;

    except
    Application.MessageBox('Erro ao apagar Cliente','ERRO');
    Abort;
    end;
  finally
     qryConsulta.Free;
     qryDelete.Free;
  end;
    CardPrincipal.ActiveCard :=  CardPesquisa;
    dmUsuarios.cdsUsuarios.Close;

end;

procedure TFrmCadUsuario.btnEditarPesquisaClick(Sender: TObject);
begin
  if dmUsuarios.cdsUsuarios.Active then
    dmUsuarios.cdsUsuarios.Edit
  else
    Application.MessageBox('Selecione pelo menos um registro para editar','Atenção!',MB_ICONEXCLAMATION );

  if dmUsuarios.cdsUsuariosSTATUS.asInteger = 1 then
    chkAtivo.Checked := True
  else
    chkAtivo.Checked := False;
  editID.Text   := dmUsuarios.cdsUsuariosID.asString;
  editName.Text   := dmUsuarios.cdsUsuariosNOME.asString;
  EditLogin.Text  := dmUsuarios.cdsUsuariosLOGIN.asString;
  EditSenha.Text  := dmUsuarios.cdsUsuariosSENHA.asString;

  CardPrincipal.ActiveCard :=  CardCadastro;

end;

procedure TFrmCadUsuario.btnFecharCadastroClick(Sender: TObject);
begin
  case Application.MessageBox('Tem certeza que quer cancelar o cadastro ?','Cancelar',MB_ICONQUESTION + MB_YESNO ) of
    mrYes:
    begin
     CardPrincipal.ActiveCard :=  CardPesquisa;
     LimpaCampos;
     dmUsuarios.cdsUsuarios.Cancel;
    end;
  end;


end;

procedure TFrmCadUsuario.btnFecharPesquisaClick(Sender: TObject);
begin
  FrmCadUsuario.Close;
end;

procedure TFrmCadUsuario.btnPesquisarClick(Sender: TObject);
begin
  chamaQryGrid();
end;

procedure TFrmCadUsuario.btnSalvarCadastroClick(Sender: TObject);
begin


  try
    qryConsulta := TFDQuery.Create(nil);
    qryConsulta.Connection := dm_dados.FDConnection1;
    qryConsulta.Connection.StartTransaction;

    if dmUsuarios.cdsUsuarios.State in [dsEdit] then
    begin
      if editName.Text = '' then
      begin
        Application.MessageBox('O campo nome não pode estar vazio','Atenção',MB_OK + MB_ICONWARNING);
        abort;
      end;
        if EditLogin.Text = '' then
      begin
        Application.MessageBox('O campo login não pode estar vazio','Atenção',MB_OK + MB_ICONWARNING);
        abort;
      end;
        if EditSenha.Text = '' then
      begin
        Application.MessageBox('O campo senha não pode estar vazio','Atenção',MB_OK + MB_ICONWARNING);
        abort;
      end;


      if chkAtivo.Checked then
        status := '1'
      else
        status := '2';

      try
        qryConsulta.Close;
        qryConsulta.SQL.Text:=            ' UPDATE USUARIOS                                   ' +
                                          '        SET                                        ' +
                                          '             NOME           =   :pNOME             ' +
                                          '            ,LOGIN          =   :pLOGIN            ' +
                                          '            ,SENHA         =    :pSENHA            ' +
                                          '            ,STATUS        =    :pSTATUS           ' +
                                          '  WHERE ID = :pID                                  ';


          qryConsulta.ParamByName('pNOME').AsString               := editName.Text;
          qryConsulta.ParamByName('pLOGIN').AsString              := EditLogin.Text;
          qryConsulta.ParamByName('pSENHA').AsString              := EditSenha.Text;
          qryConsulta.ParamByName('pSTATUS').AsString             := status ;
          qryConsulta.ParamByName('pID').AsString                 := editId.text ;

          qryConsulta.ExecSQL;

      except
        Application.MessageBox('Erro ao salvar alterações','ERRO');
        Abort;
      end;

    end
    else if insere then
    begin
      if chkAtivo.Checked then
        status := '1'
      else
        status := '2';

            try
        qryConsulta.Close;
        qryConsulta.SQL.Text:=            ' INSERT INTO                                       ' +
                                          '       USUARIOS( ID                                ' +
                                          '                ,NOME                              ' +
                                          '                ,LOGIN                             ' +
                                          '                ,SENHA                             ' +
                                          '                ,STATUS                            ' +
                                          '                ,DATA_CADASTRO )                   ' +
                                          '       VALUES(  :pID                               ' +
                                          '               ,:pNOME                             ' +
                                          '               ,:pLOGIN                            ' +
                                          '               ,:pSENHA                            ' +
                                          '               ,:pSTATUS                           ' +
                                          '               ,:pDATA_CADASTRO)                   ' ;



          qryConsulta.ParamByName('pNOME').AsString               := editName.Text;
          qryConsulta.ParamByName('pLOGIN').AsString              := EditLogin.Text;
          qryConsulta.ParamByName('pSENHA').AsString              := EditSenha.Text;
          qryConsulta.ParamByName('pSTATUS').AsString             := status ;
          qryConsulta.ParamByName('pID').AsString                 := editId.text ;
          qryConsulta.ParamByName('pDATA_CADASTRO').AsDateTime    := NOW;
          qryConsulta.ExecSQL;

      except
        Application.MessageBox('Erro ao inserir Cliente','ERRO');
        Abort;
      end;
    end
    else
    begin
     Application.MessageBox('Erro Inesperado','ERRO');
        Abort;
      end;

  finally
    qryConsulta.Free;
  end;

  Application.MessageBox('Registro Alterado com sucesso','Atenção',MB_OK + MB_ICONINFORMATION);
  LimpaCampos;
  CardPrincipal.ActiveCard :=  CardPesquisa;
  insere := false;
  dmUsuarios.cdsUsuarios.Close;
end;

procedure TFrmCadUsuario.btnIncluirPesquisaClick(Sender: TObject);
begin
  insere := true;
  qryNovoUsuario.SQL.Text  := 'SELECT MAX(ID) MAX_ID FROM USUARIOS';
  qryNovoUsuario.Open();
  newId := qryNovoUsuario.FieldByName('MAX_ID').AsInteger;
  editId.Text := IntToStr(newId + 1);

  CardPrincipal.ActiveCard :=  CardCadastro;
end;

procedure TFrmCadUsuario.chamaqrygrid;
begin
  dmUsuarios.cdsUsuarios.Close;

    if EditPesquisar.text = '' then
  begin
  dmUsuarios.cdsUsuarios.CommandText := 'SELECT ID,NOME,LOGIN,SENHA,STATUS FROM USUARIOS';
  dmUsuarios.cdsUsuarios.Open;
  end
  else
  begin
    dmUsuarios.cdsUsuarios.CommandText  := 'SELECT ID,NOME,LOGIN,SENHA,STATUS FROM USUARIOS WHERE NOME LIKE UPPER('+ QuotedStr(EditPesquisar.text)+')';
    dmUsuarios.cdsUsuarios.Open;
    if dmUsuarios.cdsUsuarios.RecordCount <= 0 then
    begin
      ShowMessage('Não foi possível encontrar nenhum usuário com esse nome')
    end;
  end;

end;



procedure TFrmCadUsuario.EditPesquisarKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    chamaQryGrid();
end;

procedure TFrmCadUsuario.FormActivate(Sender: TObject);
begin
  CardPrincipal.ActiveCard :=  CardPesquisa;
end;


procedure TFrmCadUsuario.gridCadUsuarioDblClick(Sender: TObject);
begin
  CardPrincipal.ActiveCard :=  CardCadastro;
end;

procedure TFrmCadUsuario.gridCadUsuarioDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin

end;

procedure TFrmCadUsuario.LimpaCampos;
var Contador:Integer;
begin
  for Contador := 0 to Pred(ComponentCount) do
  begin
    if Components[Contador] is TCustomEdit then
      TCustomEdit(Components[Contador]).Clear
    else if Components[Contador] is TCheckBox then
      TCheckBox(Components[Contador]).Checked := False;
  end;


end;

end.
