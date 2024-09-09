object DataModule2: TDataModule2
  Height = 425
  Width = 546
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=GestionDivisasCS'
      'User_Name=sa'
      'Password=GRUPOCIE'
      'Server=ANTONIO-RODRIGU\SQLEXPRESS'
      'DriverID=MSSQL')
    Left = 184
    Top = 88
  end
  object FDQueryGrid: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      
        'SELECT VentasPendientes.Fecha,CONVERT(VARCHAR(10), Hora, 108) AS' +
        ' Hora,Tiendas.Nombre AS NombreTienda,VentasPendientes.CodigoClie' +
        'nte, '
      
        '    Clientes.Nombre,VentasPendientes.ClaveActivacion,VentasPendi' +
        'entes.CodigoDivisaEntrada, '
      '    VentasPendientes.CodigoDivisaSalida '
      '    FROM   VentasPendientes INNER JOIN '
      
        '             Clientes ON VentasPendientes.CodigoCliente = Client' +
        'es.Codigo '
      '                     INNER JOIN '
      '    Tiendas ON VentasPendientes.CodigoTienda = Tiendas.Codigo')
    Left = 184
    Top = 184
  end
  object FDQueryLogin: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'select * from usuarios')
    Left = 184
    Top = 280
  end
  object FDPhysMSSQLDriverLink1: TFDPhysMSSQLDriverLink
    Left = 400
    Top = 80
  end
end
