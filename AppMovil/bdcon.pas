unit bdcon;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Layouts, FMX.Edit, FMX.StdCtrls, FMX.Controls.Presentation, FMX.Ani, IniFiles, //ADODB,
  Data.DB;

type
  TConnAPP = class(TForm)
    Header: TLayout;
    Rectangle7: TRectangle;
    Label1: TLabel;
    Label2: TLabel;
    Image1: TImage;
    Main: TLayout;
    Rectangle2: TRectangle;
    Rectangle1: TRectangle;
    Rectangle3: TRectangle;
    Conectar: TSpeedButton;
    EditHost: TEdit;
    EditPuerto: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    Rectangle4: TRectangle;
    Rectangle5: TRectangle;
    Lineas: TLayout;
    Rectangle6: TRectangle;
    Rectangle8: TRectangle;
    Rectangle9: TRectangle;
    luzverde: TImage;
    Label6: TLabel;
    luzroja: TImage;
    Desconectar: TSpeedButton;
    Rectangle10: TRectangle;
    Rectangle11: TRectangle;
    procedure ConectarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DesconectarClick(Sender: TObject);
    procedure guardarDatos();
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ConnAPP: TConnAPP;

implementation

{$R *.fmx}

uses login;

procedure TConnAPP.ConectarClick(Sender: TObject);
var
  host, puerto: string;
  IniFile: TIniFile;
begin
  host := EditHost.Text;
  puerto := Editpuerto.Text;

  guardarDatos();

  if not loginAPP.SQLConnection1.Connected then
  begin
    loginAPP.SQLConnection1.Params.add('HostName=' + host);
    loginAPP.SQLConnection1.Params.add('Port=' + puerto);
    try
      loginAPP.SQLConnection1.Open;
      luzverde.Visible := True;
      luzroja.Visible := False;
      //IniFile := TIniFile.Create('C:\Users\CHRISTIAN\Desktop\AppMovil\datos.ini');
    except
      on E: Exception do
      begin
        luzverde.Visible := False;
        luzroja.Visible := True;
        ShowMessage('Error al conectar con la base de datos: ' + E.Message);
      end;
    end;
  end;
end;


procedure TConnAPP.DesconectarClick(Sender: TObject);
begin
    loginAPP.SQLConnection1.Close;
    //loginAPP.SQLConnection1.Connected:= false;

    if not loginAPP.SQLConnection1.Connected then
    luzverde.Visible := False;
    luzroja.Visible := True;

end;

procedure TConnAPP.FormCreate(Sender: TObject);
begin
  luzverde.Visible := False;

  try
    if loginAPP.SQLConnection1.Connected then
    begin
      luzverde.Visible := True;
      luzroja.Visible := False;

    end
    else
    begin
      luzverde.Visible := False;
      luzroja.Visible := True;
    end;
  except
    on E: Exception do
    begin
      ShowMessage('Error al conectar con la base de datos: ' + E.Message);
      luzverde.Visible := False;
      luzroja.Visible := True;
    end;
  end;
end;


procedure TConnAPP.guardarDatos;
var
  IniFile: TIniFile;
begin
  IniFile := TIniFile.Create('C:\Users\CHRISTIAN\Desktop\AppMovil\datos.ini');
  try
    IniFile.WriteString('Conexion', 'host', edithost.Text	);
        IniFile.WriteString('Conexion', 'puerto', editpuerto.Text	);

  finally
    IniFile.Free;
  end;
end;

end.
