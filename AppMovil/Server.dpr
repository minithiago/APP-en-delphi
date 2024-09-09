program Server;

uses
  FMX.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  servidor in 'servidor.pas' {fdm},
  ServerMethodsUnit1 in 'ServerMethodsUnit1.pas' {ServerMethods1: TDSServerModule},
  ServerContainerUnit1 in 'ServerContainerUnit1.pas' {ServerContainer1: TDataModule},
  servidorapp in 'servidorapp.pas' {DataModule2: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tfdm, fdm);
  Application.CreateForm(TServerContainer1, ServerContainer1);
  Application.CreateForm(TDataModule2, DataModule2);
  Application.Run;
end.

