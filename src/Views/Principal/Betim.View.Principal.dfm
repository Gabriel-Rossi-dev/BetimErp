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
  object Panel1: TPanel
    Left = 0
    Top = 712
    Width = 1189
    Height = 33
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object lblUsuarioLogado: TLabel
      AlignWithMargins = True
      Left = 30
      Top = 3
      Width = 3
      Height = 27
      Margins.Left = 30
      Align = alLeft
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitHeight = 15
    end
  end
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
