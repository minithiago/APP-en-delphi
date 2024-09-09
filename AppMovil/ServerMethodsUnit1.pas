unit ServerMethodsUnit1;

interface

uses System.SysUtils, System.Classes, System.Json,
    DataSnap.DSProviderDataModuleAdapter,
    Datasnap.DSServer, Datasnap.DSAuth, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MSSQL,
  FireDAC.Phys.MSSQLDef, FireDAC.FMXUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Phys.ODBCBase, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, IniFiles, FMX.Dialogs,
  FireDAC.Comp.UI, DateUtils;

type
  TServerMethods1 = class(TDSServerModule)
    FDConnection1: TFDConnection;
    FDQueryGrid: TFDQuery;
    FDQueryLogin: TFDQuery;
    FDPhysMSSQLDriverLink1: TFDPhysMSSQLDriverLink;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDQueryAutoLogin: TFDQuery;
  private
    { Private declarations }
  public
    { Public declarations }
    function clientes(Value: string): string;
    function IniciarSesion(const nombre, contrasena: string): Boolean;
    function CargarGrid : tJsonArray;
    function AutoLogin(const nombre, contrasena: string) : Boolean;
    function buscarFiltro1(const fecha1, fecha2: string): tJsonArray;
    function buscarFiltro2(const Nombre : string): tJsonArray;
    function cargarCredenciales : Boolean;

  end;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}


uses System.StrUtils;


function TServermethods1.IniciarSesion(const nombre, contrasena: string): Boolean;
var
  IniFile: TIniFile;
begin
  Result := False; // Inicialmente establecemos el resultado como falso

  FDConnection1.Open;
  FDQueryLogin.SQL.Text := 'SELECT * FROM Usuarios WHERE Nombre = :Nombre AND Contrasena = :Contrasena';
  FDQueryLogin.Params.ParamByName('Nombre').Value := nombre;
  FDQueryLogin.Params.ParamByName('Contrasena').Value := contrasena;
  FDQueryLogin.Open;

  if not FDQueryLogin.IsEmpty then
  begin

    Result := True;

    IniFile := TIniFile.Create('C:\Users\CHRISTIAN\Documents\GitHub\AppCie\user.ini');
    try
      IniFile.WriteBool('User', 'LoggedIn', True);
    finally
      IniFile.Free;
    end;


  end
  else
  begin

    //ShowMessage('Usuario o contraseña incorrectos');
  end;

end;


function TServerMethods1.AutoLogin(const nombre,
  contrasena: string): Boolean;

  var
  SQL: String;
  contador: Integer;
begin
if (nombre <> '') and (contrasena <> '') then
  begin
    SQL := 'SELECT COUNT(*) FROM Usuarios WHERE Nombre = :Usuario AND Contrasena = :Password';
    fdqueryAutologin.SQL.Text := SQL;
    fdqueryAutologin.Params.ParamByName('Usuario').Value := nombre;
    fdqueryAutologin.Params.ParamByName('Password').Value := contrasena;

    try
      FDConnection1.Open;
      fdqueryAutologin.Open;
      contador := fdqueryAutologin.Fields[0].AsInteger;

      if contador >= 1 then
      begin
         Result := True;
         exit;
      end

      else
        Result := false;

    except
      on E: Exception do
      begin
        //ShowMessage('Error al intentar iniciar sesión: ' + E.Message);
      end;
    end;
  end
  else
    //Result := false;

end;

function TServerMethods1.buscarFiltro1(const fecha1, fecha2: string) : tJsonArray;
var Row: TJSONObject;
begin
Result := tJsonArray.Create ;
try
    FDQueryGrid.SQL.Text := 'SELECT VentasPendientes.Fecha, CONVERT(VARCHAR(10), Hora, 108) AS Hora, Tiendas.Nombre AS NombreTienda, VentasPendientes.CodigoCliente, ' +
  'Clientes.Nombre, VentasPendientes.ClaveActivacion, VentasPendientes.CodigoDivisaEntrada, ' +
  'VentasPendientes.CodigoDivisaSalida ' +
  'FROM VentasPendientes ' +
  'INNER JOIN Clientes ON VentasPendientes.CodigoCliente = Clientes.Codigo ' +
  'INNER JOIN Tiendas ON VentasPendientes.CodigoTienda = Tiendas.Codigo ' +
  'WHERE ' +
  ' VentasPendientes.Fecha >= ' + QuotedStr(fecha1) +
  ' AND VentasPendientes.Fecha <= ' + QuotedStr(fecha2) +
  ' ORDER BY Fecha, Hora DESC;';
  FDQueryGrid.Open;
  FDQueryGrid.First;
  while not FdqueryGrid.eof do
  begin
    Row:= TjsonObject.Create ;
    Row.AddPair('Fecha', fdquerygrid.FieldByName('Fecha').AsString);
    Row.AddPair('Hora', fdquerygrid.FieldByName('Hora').AsString);
    Row.AddPair('NombreTienda', fdquerygrid.FieldByName('NombreTienda').AsString);
    Row.AddPair('CodigoCliente', fdquerygrid.FieldByName('CodigoCliente').AsString);
    Row.AddPair('Nombre', fdquerygrid.FieldByName('Nombre').AsString);
    Row.AddPair('ClaveActivacion', fdquerygrid.FieldByName('ClaveActivacion').AsString);
    Row.AddPair('CodigoDivisaEntrada', fdquerygrid.FieldByName('CodigoDivisaEntrada').AsString);
    Row.AddPair('CodigoDivisaSalida', fdquerygrid.FieldByName('CodigoDivisaSalida').AsString);
    Result.AddElement(row);
    FdqueryGrid.Next;
  end;
except
on E:Exception do
      //showMessage('error en funcion cargarGrid');
end;
end;


function TServerMethods1.buscarFiltro2(const Nombre: string): tJsonArray;
var Row: TJSONObject;
begin
Result := tJsonArray.Create ;
try
  FDQueryGrid.SQL.Text := 'SELECT VentasPendientes.Fecha, CONVERT(VARCHAR(10), Hora, 108) AS Hora, Tiendas.Nombre AS NombreTienda, VentasPendientes.CodigoCliente, ' +
  'Clientes.Nombre, VentasPendientes.ClaveActivacion, VentasPendientes.CodigoDivisaEntrada, ' +
  'VentasPendientes.CodigoDivisaSalida ' +
  'FROM VentasPendientes ' +
  'INNER JOIN Clientes ON VentasPendientes.CodigoCliente = Clientes.Codigo ' +
  'INNER JOIN Tiendas ON VentasPendientes.CodigoTienda = Tiendas.Codigo ' +
  'WHERE Tiendas.nombre LIKE ' + QuotedStr('%' + Nombre + '%') +
  ' ORDER BY Fecha, Hora DESC;';
  FDQueryGrid.Open;
  FDQueryGrid.First;
  while not FdqueryGrid.eof do
  begin
    Row:= TjsonObject.Create ;
    Row.AddPair('Fecha', fdquerygrid.FieldByName('Fecha').AsString);
    Row.AddPair('Hora', fdquerygrid.FieldByName('Hora').AsString);
    Row.AddPair('NombreTienda', fdquerygrid.FieldByName('NombreTienda').AsString);
    Row.AddPair('CodigoCliente', fdquerygrid.FieldByName('CodigoCliente').AsString);
    Row.AddPair('Nombre', fdquerygrid.FieldByName('Nombre').AsString);
    Row.AddPair('ClaveActivacion', fdquerygrid.FieldByName('ClaveActivacion').AsString);
    Row.AddPair('CodigoDivisaEntrada', fdquerygrid.FieldByName('CodigoDivisaEntrada').AsString);
    Row.AddPair('CodigoDivisaSalida', fdquerygrid.FieldByName('CodigoDivisaSalida').AsString);
    Result.AddElement(row);
    FdqueryGrid.Next;
  end;
except
on E:Exception do
      //showMessage('error en funcion cargarGrid');
end;
end;

function TServerMethods1.cargarCredenciales: Boolean;
begin
   //Result := false;
end;

function TServerMethods1.CargarGrid: tjsonArray;
var Row: TJSONObject;
begin


Result := tJsonArray.Create ;
try
    FDQueryGrid.SQL.Text := 'SELECT VentasPendientes.Fecha,CONVERT(VARCHAR(10), Hora, 108) AS Hora,Tiendas.Nombre AS NombreTienda,VentasPendientes.CodigoCliente, ' +
    'Clientes.Nombre,VentasPendientes.ClaveActivacion,VentasPendientes.CodigoDivisaEntrada, ' +
    'VentasPendientes.CodigoDivisaSalida ' +
    'FROM   VentasPendientes INNER JOIN ' +
             'Clientes ON VentasPendientes.CodigoCliente = Clientes.Codigo ' +
                     'INNER JOIN ' +
    'Tiendas ON VentasPendientes.CodigoTienda = Tiendas.Codigo ' +
    'ORDER BY Fecha,hora desc';
  FDQueryGrid.Open;
  FDQueryGrid.First;
  while not FdqueryGrid.eof do
  begin
    Row:= TjsonObject.Create ;
    Row.AddPair('Fecha', fdquerygrid.FieldByName('Fecha').AsString);
    Row.AddPair('Hora', fdquerygrid.FieldByName('Hora').AsString);
    Row.AddPair('NombreTienda', fdquerygrid.FieldByName('NombreTienda').AsString);
    Row.AddPair('CodigoCliente', fdquerygrid.FieldByName('CodigoCliente').AsString);
    Row.AddPair('Nombre', fdquerygrid.FieldByName('Nombre').AsString);
    Row.AddPair('ClaveActivacion', fdquerygrid.FieldByName('ClaveActivacion').AsString);
    Row.AddPair('CodigoDivisaEntrada', fdquerygrid.FieldByName('CodigoDivisaEntrada').AsString);
    Row.AddPair('CodigoDivisaSalida', fdquerygrid.FieldByName('CodigoDivisaSalida').AsString);
    Result.AddElement(row);
    FdqueryGrid.Next;
  end;
except
on E:Exception do
      showMessage('error en funcion cargarGrid');
end;



end;

function TServerMethods1.clientes(Value: string): string;
begin


  Result := System.StrUtils.ReverseString(Value);
end;


end.

