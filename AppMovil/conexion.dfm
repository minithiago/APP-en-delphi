object conexiones: Tconexiones
  Left = 0
  Top = 0
  ClientHeight = 561
  ClientWidth = 784
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object ADOConnection1: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=SQLOLEDB.1;Password=GRUPOCIE;Persist Security Info=True' +
      ';User ID=sa;Initial Catalog=GestionDivisasCS;Data Source=ANTONIO' +
      '-RODRIGU\SQLEXPRESS'
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 96
    Top = 70
  end
  object ADOQuery1: TADOQuery
    Connection = ADOConnection1
    Parameters = <
      item
        Name = 'Nombre'
        Size = -1
        Value = Null
      end
      item
        Name = 'Contrasena'
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      
        'SELECT * FROM Usuarios WHERE Nombre = :Nombre AND Contrasena = :' +
        'Contrasena')
    Left = 198
    Top = 70
  end
  object ADOQuery2: TADOQuery
    Connection = ADOConnection1
    Parameters = <>
    SQL.Strings = (
      
        'SELECT VentasPendientes.Fecha,Hora,Tiendas.Nombre AS NombreTiend' +
        'a,VentasPendientes.CodigoCliente, '
      
        'Clientes.Nombre,VentasPendientes.ClaveActivacion,VentasPendiente' +
        's.CodigoDivisaEntrada,'
      'VentasPendientes.CodigoDivisaSalida'
      'FROM'#160#160' VentasPendientes INNER JOIN'
      
        #160#160#160#160#160#160#160#160#160#160#160#160' Clientes ON VentasPendientes.CodigoCliente = Client' +
        'es.Codigo'
      #160#160#160#160#160#160#160#160#160#160#160#160#160#160#160#160#160#160#160#160' INNER JOIN'
      
        #160#160#160#160#160#160#160#160#160#160#160#160' Tiendas ON VentasPendientes.CodigoTienda = Tiendas.' +
        'Codigo'
      'ORDER BY Fecha,hora desc'
      '')
    Left = 198
    Top = 141
  end
  object ADOQuery3: TADOQuery
    Connection = ADOConnection1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT '
      '    VentasPendientes.Fecha,'
      '    CONVERT(VARCHAR(10), Hora, 108) AS Hora,'
      '    Tiendas.Nombre AS NombreTienda,'
      '    VentasPendientes.CodigoCliente, '
      '    Clientes.Nombre,'
      '    VentasPendientes.ClaveActivacion,'
      '    VentasPendientes.CodigoDivisaEntrada,'
      '    VentasPendientes.CodigoDivisaSalida'
      'FROM   '
      '    VentasPendientes '
      
        '    INNER JOIN Clientes ON VentasPendientes.CodigoCliente = Clie' +
        'ntes.Codigo'
      
        '    INNER JOIN Tiendas ON VentasPendientes.CodigoTienda = Tienda' +
        's.Codigo'
      'ORDER BY '
      '    Fecha, Hora DESC')
    Left = 160
    Top = 230
  end
  object DataSource3: TDataSource
    DataSet = ADOQuery3
    Left = 230
    Top = 230
  end
end
