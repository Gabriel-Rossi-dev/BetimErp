object FrmBetim: TFrmBetim
  Left = 0
  Top = 0
  Caption = 'Betim'
  ClientHeight = 745
  ClientWidth = 1189
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Menu = MainMenu1
  Position = poScreenCenter
  WindowState = wsMaximized
  OnCreate = FormCreate
  TextHeight = 15
  object MainMenu1: TMainMenu
    Left = 1064
    Top = 16
    object mnuCadastro: TMenuItem
      Caption = 'Cadastro'
      object mnuCadUsuario: TMenuItem
        Caption = 'Cadastro Usu'#225'rio'
        OnClick = mnuCadUsuarioClick
      end
    end
    object mnuRelatorio: TMenuItem
      Caption = 'Relat'#243'rio'
    end
    object mnuAjuda: TMenuItem
      Caption = 'Ajuda'
    end
  end
end
