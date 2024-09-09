program Movil;

uses
  System.StartUpCopy,
  FMX.Forms,
  login in 'login.pas' {LoginAPP},
  bdcon in 'bdcon.pas' {ConnAPP},
  menu in 'menu.pas' {menuAPP},
  portada in 'portada.pas' {portadaAPP},
  FiltroPantalla in 'FiltroPantalla.pas' {Filtro},
  Datasnap in 'Datasnap.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TportadaAPP, portadaAPP);
  Application.CreateForm(TLoginAPP, LoginAPP);
  Application.CreateForm(TmenuAPP, menuAPP);
  Application.CreateForm(TConnAPP, ConnAPP);
  Application.CreateForm(TFiltro, Filtro);
  Application.Run;
end.
