unit portada;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.Objects, IniFiles, datasnap;

type
  TportadaAPP = class(TForm)
    Rectangle1: TRectangle;
    Layout1: TLayout;
    Image1: TImage;
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  portadaAPP: TportadaAPP;
  UserLoggedIn: Boolean = False;
  clientRest: TserverMethods1client;

implementation

{$R *.fmx}

uses login, menu;

procedure TportadaAPP.FormCreate(Sender: TObject);
var
  IniFile: TextFile;
  Username, Password: string;
begin
  Timer1.Interval := 3000;
end;

procedure TportadaAPP.FormShow(Sender: TObject);
begin
    clientRest:= TserverMethods1client.Create(loginApp.SQLConnection1.DBXConnection);   //nuevo
end;

procedure TportadaAPP.Timer1Timer(Sender: TObject);
var
  IniFile: TIniFile;
  usuario, pass, SQL: String;
  contador: Integer;
begin

  Timer1.Enabled := False;
  IniFile := TIniFile.Create('C:\Users\CHRISTIAN\Desktop\AppMovil\credenciales.ini');
  try
    usuario := IniFile.ReadString('User', 'Username', '');
    pass := IniFile.ReadString('User', 'Password', '');
    //loginAPP.Show;
  finally
    IniFile.Free;

  end;

  menuApp := TmenuAPP.Create(Application);
  loginApp := TLoginAPP.Create(Application);

  if clientrest.AutoLogin(usuario,pass) then
  begin
    menuAPp.Show ;
    hide;
  end
  else
  begin
    LoginApp.Show;
    //showMessage(usuario);
    //showMessage(pass);

  end;

end;

end.
