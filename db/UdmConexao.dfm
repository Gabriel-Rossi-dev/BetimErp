object dm_dados: Tdm_dados
  OnCreate = DataModuleCreate
  Height = 267
  Width = 338
  object FDPhysFBDriverLink1: TFDPhysFBDriverLink
    VendorLib = 'C:\Program Files (x86)\Firebird\Firebird_5_0\fbclient.dll'
    Left = 112
    Top = 40
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 104
    Top = 112
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=C:\Users\grgab\Project\DELPHIZAO\BETIM\db\BETIM_DB.FDB'
      'User_Name=sysdba'
      'Password=masterkey'
      'DriverID=FB')
    Left = 216
    Top = 40
  end
end
