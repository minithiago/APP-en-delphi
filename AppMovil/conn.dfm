object DataModule1: TDataModule1
  Height = 750
  Width = 1000
  PixelsPerInch = 120
  object ADOConnection1: TADOConnection
    ConnectionString = 
      'Provider=SQLOLEDB.1;Persist Security Info=False;User ID=Antonio;' +
      'Initial Catalog=GestionDivisasCS;Data Source=ANTONIO-GUTIERR\SQL' +
      'EXPRESS'
    Provider = 'SQLOLEDB.1'
    Left = 88
    Top = 80
  end
  object ADOQuery1: TADOQuery
    Parameters = <>
    Left = 200
    Top = 80
  end
end
