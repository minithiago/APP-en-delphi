unit login;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Effects,
  FMX.Objects, FMX.Layouts, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Edit, bdcon, IniFiles, menu,
  Data.DB, //conexion,
  Data.DBXDataSnap, Data.DBXCommon, IPPeerClient ,
  Data.SqlExpr, datasnap, Datasnap.DSClientRest, Datasnap.DBClient,
  Datasnap.DSConnect;

type
  TLoginAPP = class(TForm)
    Rectangle1: TRectangle;
    Image1: TImage;
    Rectangle2: TRectangle;
    Label1: TLabel;
    Label2: TLabel;
    Rectangle3: TRectangle;
    Entrar: TSpeedButton;
    Label3: TLabel;
    EditUser: TEdit;
    EditContra: TEdit;
    Image3: TImage;
    Header: TLayout;
    ZFooter: TLayout;
    Main: TLayout;
    Rectangle7: TRectangle;
    Rectangle8: TRectangle;
    Rectangle4: TRectangle;
    Rectangle5: TRectangle;
    Contraseña: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Image2: TImage;
    Rectangle6: TRectangle;
    Rectangle9: TRectangle;
    CheckBox1: TCheckBox;
    SQLConnection1: TSQLConnection;
    procedure Image3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure EntrarClick(Sender: TObject);
    procedure cargarCredenciales();
    procedure guardarCredenciales();
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

  private
    Logged: Boolean; // Variable para indicar si el usuario está logueado
  public
    { Public declarations }
  end;

var
  LoginAPP: TLoginAPP;
  clientRest: TserverMethods1client;

implementation

{$R *.fmx}

uses portada;


procedure TLoginAPP.cargarCredenciales;
var
  IniFile: TIniFile;
begin
  IniFile := TIniFile.Create('C:\Users\CHRISTIAN\Desktop\AppMovil\credenciales.ini');
  try
    if IniFile.ValueExists('User', 'Username') then
    begin
      EditUser.Text := IniFile.ReadString('User', 'Username', '');
      CheckBox1.IsChecked := True;
    end;
    if IniFile.ValueExists('User', 'Password') then
      EditContra.Text := IniFile.ReadString('User', 'Password', '');
  finally
    IniFile.Free;
  end;
end;

procedure TLoginAPP.EntrarClick(Sender: TObject);
begin
   if clientRest.IniciarSesion(EditUser.text, EditContra.text)then
   begin
     MenuApp.Show;
     if checkbox1.IsChecked then
      guardarCredenciales;
      menu.menuAPP.labelusuario.Text	 := editUser.Text;


   end;
   hide;
end;


procedure TLoginAPP.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    Application.Terminate ;
end;

procedure TLoginAPP.FormCreate(Sender: TObject);
var
  IniFile: TIniFile;
  Conexion, Usuario, Contraseña, BBDD: string;
begin
   loginApp.SQLConnection1.Connected := true;
  clientRest:= TserverMethods1client.Create(SQLConnection1.DBXConnection);
  if clientRest.IniciarSesion(EditUser.text, EditContra.text) then
  begin
   Application.CreateForm(TmenuAPP, MenuApp);
   if checkbox1.IsChecked then
    guardarCredenciales;

  end;



  Logged := False; // Inicialmente el usuario no está logueado
  cargarCredenciales;


  IniFile := TIniFile.Create('C:\Users\CHRISTIAN\Desktop\AppMovil\datos.ini');
 { try

    if not conexiones.ADOConnection1.Connected then
    begin
      Conexion := IniFile.ReadString('Conexion', 'Servidor', '');
      Usuario := IniFile.ReadString('Conexion', 'Usuario', '');
      Contraseña := IniFile.ReadString('Conexion', 'Contraseña', '');
      BBDD := IniFile.ReadString('Conexion', 'BaseDatos', '');

      conexiones.ADOConnection1.ConnectionString :=
        'Provider=SQLOLEDB;Data Source=' + Conexion + ';User ID=' + Usuario + ';Password=' + Contraseña + ';Initial Catalog=' + BBDD;
    end;
  finally
    IniFile.Free;
  end;
  if conexiones.ADOConnection1.ConnectionString <> '' then
  begin
    try
      conexiones.ADOConnection1.Open;
      //ShowMessage('Conexión establecida correctamente');
    except
      on E: Exception do
        ShowMessage('Error al conectar con la base de datos: ' + E.Message);
    end;
  end
  else
  begin
    ShowMessage('Error: La cadena de conexión está vacía. Verifica los datos en datos.ini.');
  end;  }

 // if Logged then
    //EntrarClick(nil); // Si el usuario está logueado, abrir directamente Form2
end;

procedure TLoginAPP.guardarCredenciales;
var
  IniFile: TIniFile;
begin
  IniFile := TIniFile.Create('C:\Users\CHRISTIAN\Desktop\AppMovil\credenciales.ini');
  try
    IniFile.WriteString('User', 'Username', EditUser.Text);
    IniFile.WriteString('User', 'Password', EditContra.Text);
  finally
    IniFile.Free;
  end;
end;

procedure TLoginAPP.Image3Click(Sender: TObject);
var
  IniFile: TIniFile;
begin
    IniFile := TIniFile.Create('C:\Users\CHRISTIAN\Desktop\AppMovil\datos.ini');
    ConnAPP.EditHost.Text := IniFile.ReadString('Conexion', 'host', '');
    ConnAPP.EditPuerto.Text := IniFile.ReadString('Conexion', 'puerto', '');
    ConnAPP.Show;
end;

end.

