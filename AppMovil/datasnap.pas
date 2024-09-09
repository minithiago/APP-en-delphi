//
// Created by the DataSnap proxy generator.
// 25/04/2024 13:49:23
//

unit datasnap;

interface

uses System.JSON, Data.DBXCommon, Data.DBXClient, Data.DBXDataSnap, Data.DBXJSON, Datasnap.DSProxy, System.Classes, System.SysUtils, Data.DB, Data.SqlExpr, Data.DBXDBReaders, Data.DBXCDSReaders, Data.DBXJSONReflect;

type
  TServerMethods1Client = class(TDSAdminClient)
  private
    FclientesCommand: TDBXCommand;
    FIniciarSesionCommand: TDBXCommand;
    FCargarGridCommand: TDBXCommand;
    FAutoLoginCommand: TDBXCommand;
    FbuscarFiltro1Command: TDBXCommand;
    FbuscarFiltro2Command: TDBXCommand;
    FcargarCredencialesCommand: TDBXCommand;
  public
    constructor Create(ADBXConnection: TDBXConnection); overload;
    constructor Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
    function clientes(Value: string): string;
    function IniciarSesion(nombre: string; contrasena: string): Boolean;
    function CargarGrid: TJSONArray;
    function AutoLogin(nombre: string; contrasena: string): Boolean;
    function buscarFiltro1(fecha1: string; fecha2: string): TJSONArray;
    function buscarFiltro2(Nombre: string): TJSONArray;
    function cargarCredenciales: Boolean;
  end;

implementation

function TServerMethods1Client.clientes(Value: string): string;
begin
  if FclientesCommand = nil then
  begin
    FclientesCommand := FDBXConnection.CreateCommand;
    FclientesCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FclientesCommand.Text := 'TServerMethods1.clientes';
    FclientesCommand.Prepare;
  end;
  FclientesCommand.Parameters[0].Value.SetWideString(Value);
  FclientesCommand.ExecuteUpdate;
  Result := FclientesCommand.Parameters[1].Value.GetWideString;
end;

function TServerMethods1Client.IniciarSesion(nombre: string; contrasena: string): Boolean;
begin
  if FIniciarSesionCommand = nil then
  begin
    FIniciarSesionCommand := FDBXConnection.CreateCommand;
    FIniciarSesionCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FIniciarSesionCommand.Text := 'TServerMethods1.IniciarSesion';
    FIniciarSesionCommand.Prepare;
  end;
  FIniciarSesionCommand.Parameters[0].Value.SetWideString(nombre);
  FIniciarSesionCommand.Parameters[1].Value.SetWideString(contrasena);
  FIniciarSesionCommand.ExecuteUpdate;
  Result := FIniciarSesionCommand.Parameters[2].Value.GetBoolean;
end;

function TServerMethods1Client.CargarGrid: TJSONArray;
begin
  if FCargarGridCommand = nil then
  begin
    FCargarGridCommand := FDBXConnection.CreateCommand;
    FCargarGridCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FCargarGridCommand.Text := 'TServerMethods1.CargarGrid';
    FCargarGridCommand.Prepare;
  end;
  FCargarGridCommand.ExecuteUpdate;
  Result := TJSONArray(FCargarGridCommand.Parameters[0].Value.GetJSONValue(FInstanceOwner));
end;

function TServerMethods1Client.AutoLogin(nombre: string; contrasena: string): Boolean;
begin
  if FAutoLoginCommand = nil then
  begin
    FAutoLoginCommand := FDBXConnection.CreateCommand;
    FAutoLoginCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FAutoLoginCommand.Text := 'TServerMethods1.AutoLogin';
    FAutoLoginCommand.Prepare;
  end;
  FAutoLoginCommand.Parameters[0].Value.SetWideString(nombre);
  FAutoLoginCommand.Parameters[1].Value.SetWideString(contrasena);
  FAutoLoginCommand.ExecuteUpdate;
  Result := FAutoLoginCommand.Parameters[2].Value.GetBoolean;
end;

function TServerMethods1Client.buscarFiltro1(fecha1: string; fecha2: string): TJSONArray;
begin
  if FbuscarFiltro1Command = nil then
  begin
    FbuscarFiltro1Command := FDBXConnection.CreateCommand;
    FbuscarFiltro1Command.CommandType := TDBXCommandTypes.DSServerMethod;
    FbuscarFiltro1Command.Text := 'TServerMethods1.buscarFiltro1';
    FbuscarFiltro1Command.Prepare;
  end;
  FbuscarFiltro1Command.Parameters[0].Value.SetWideString(fecha1);
  FbuscarFiltro1Command.Parameters[1].Value.SetWideString(fecha2);
  FbuscarFiltro1Command.ExecuteUpdate;
  Result := TJSONArray(FbuscarFiltro1Command.Parameters[2].Value.GetJSONValue(FInstanceOwner));
end;

function TServerMethods1Client.buscarFiltro2(Nombre: string): TJSONArray;
begin
  if FbuscarFiltro2Command = nil then
  begin
    FbuscarFiltro2Command := FDBXConnection.CreateCommand;
    FbuscarFiltro2Command.CommandType := TDBXCommandTypes.DSServerMethod;
    FbuscarFiltro2Command.Text := 'TServerMethods1.buscarFiltro2';
    FbuscarFiltro2Command.Prepare;
  end;
  FbuscarFiltro2Command.Parameters[0].Value.SetWideString(Nombre);
  FbuscarFiltro2Command.ExecuteUpdate;
  Result := TJSONArray(FbuscarFiltro2Command.Parameters[1].Value.GetJSONValue(FInstanceOwner));
end;

function TServerMethods1Client.cargarCredenciales: Boolean;
begin
  if FcargarCredencialesCommand = nil then
  begin
    FcargarCredencialesCommand := FDBXConnection.CreateCommand;
    FcargarCredencialesCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FcargarCredencialesCommand.Text := 'TServerMethods1.cargarCredenciales';
    FcargarCredencialesCommand.Prepare;
  end;
  FcargarCredencialesCommand.ExecuteUpdate;
  Result := FcargarCredencialesCommand.Parameters[0].Value.GetBoolean;
end;

constructor TServerMethods1Client.Create(ADBXConnection: TDBXConnection);
begin
  inherited Create(ADBXConnection);
end;

constructor TServerMethods1Client.Create(ADBXConnection: TDBXConnection; AInstanceOwner: Boolean);
begin
  inherited Create(ADBXConnection, AInstanceOwner);
end;

destructor TServerMethods1Client.Destroy;
begin
  FclientesCommand.DisposeOf;
  FIniciarSesionCommand.DisposeOf;
  FCargarGridCommand.DisposeOf;
  FAutoLoginCommand.DisposeOf;
  FbuscarFiltro1Command.DisposeOf;
  FbuscarFiltro2Command.DisposeOf;
  FcargarCredencialesCommand.DisposeOf;
  inherited;
end;

end.

