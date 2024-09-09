unit menu;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, System.Threading,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Layouts, FMX.Controls.Presentation, FMX.MultiView, FMX.Ani, FMX.StdCtrls,
  System.Rtti, FMX.Grid.Style, FMX.ScrollBox, FMX.Grid, FMX.TabControl, conexion,
  Data.Bind.EngExt, Fmx.Bind.DBEngExt, Fmx.Bind.Grid, System.Bindings.Outputs,
  Fmx.Bind.Editors, Data.Bind.Components, Data.Bind.Grid, Data.Bind.DBScope,
  Data.DB, FMX.ListBox, FMX.Edit, FMX.DateTimeCtrls, DateUtils, FiltroPantalla, Datasnap, JSON, IniFiles;

type
    TmenuAPP = class(TForm)
    Rectangle1: TRectangle;
    Image1: TImage;
    header: TLayout;
    Contenido: TLayout;
    Image2: TImage;
    TabControl1: TTabControl;
    Home: TTabItem;
    Fpendientes: TTabItem;
    BindingsList1: TBindingsList;
    BindSourceDB2: TBindSourceDB;
    MultiView1: TMultiView;
    Image3: TImage;
    Rectangle2: TRectangle;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    Rectangle3: TRectangle;
    Rectangle4: TRectangle;
    Image6: TImage;
    ComboBox1: TComboBox;
    busca: TEdit;
    Rectangle5: TRectangle;
    Rectangle6: TRectangle;
    BporTienda: TRectangle;
    BporFecha: TRectangle;
    DateEdit1: TDateEdit;
    DateEdit2: TDateEdit;
    Label1: TLabel;
    Label2: TLabel;
    Rectangle7: TRectangle;
    Rectangle9: TRectangle;
    labelbuscar: TLabel;
    Image5: TImage;
    Image7: TImage;
    tituloventas: TLabel;
    tituloinicio: TLabel;
    Image8: TImage;
    Image4: TImage;
    Csesion: TSpeedButton;
    Rectangle8: TRectangle;
    Timer1: TTimer;
    StringGrid1: TStringGrid;
    StringColumn1: TStringColumn;
    StringColumn2: TStringColumn;
    StringColumn3: TStringColumn;
    StringColumn4: TStringColumn;
    StringColumn5: TStringColumn;
    StringColumn6: TStringColumn;
    StringColumn7: TStringColumn;
    StringColumn8: TStringColumn;
    Label3: TLabel;
    LabelUsuario: TLabel;
    Image9: TImage;
    BTNSalir: TSpeedButton;
    procedure Image2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure Image4Click(Sender: TObject);
    procedure BTNSalirClick(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure Buscarporfecha();
    procedure ajustarColumnas();
    procedure Image7Click(Sender: TObject);
    procedure Image5Click(Sender: TObject);
    procedure TabControl1Change(Sender: TObject);
    procedure CsesionClick(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure rellenarGrid();
    procedure reiniciarCredenciales();
    procedure FormShow(Sender: TObject);

  private
    JsonDetalles: TJSONArray;
  public
    { Public declarations }
  end;

var
  menuAPP: TmenuAPP;
  clientRest: TserverMethods1client;

implementation

{$R *.fmx}

uses login;

procedure TmenuAPP.ajustarColumnas;

begin   {
  grid1.Columns[0].Width := 75;
  grid1.Columns[2].Width := 80;
  grid1.Columns[3].Width := 100;
  grid1.Columns[4].Width := 200;
  grid1.Columns[5].Width := 50;
  grid1.Columns[6].Width := 50;
  grid1.Columns[7].Width := 50;
  grid1.Columns[2].Header := 'Tienda';
  grid1.Columns[3].Header := 'CIF';
  grid1.Columns[5].Header := 'Clave';
  grid1.Columns[6].Header := 'Entrada';
  grid1.Columns[7].Header := 'Salida';
      }
end;

procedure TmenuAPP.Buscarporfecha;
var
  FechaInicio, FechaFin: TDateTime;
  i: Integer;
begin{
  FechaInicio := DateEdit1.Date;
  FechaFin := DateEdit2.Date;

  for i := 0 to Grid1.RowCount - 1 do
  begin
    if (Grid1.Cells[1, i] <> '') then
    begin
      if (StrToDate(Grid1.Cells[1, i]) >= FechaInicio) and (StrToDate(Grid1.Cells[1, i]) <= FechaFin) then
      begin
        ShowMessage('La fecha ' + Grid1.Cells[1, i] + ' está dentro del rango seleccionado.');
      end;
    end;
  end;}
end;

procedure TmenuAPP.ComboBox1Change(Sender: TObject);
begin
  case ComboBox1.ItemIndex of
    0: begin
         BporTienda.Visible := False;
         BporFecha.Visible := True;
       end;
    1: begin
         BporTienda.Visible := True;
         BporFecha.Visible := False;
       end;
  end;
end;

procedure TmenuAPP.CsesionClick(Sender: TObject);
var
  LoginForm: TLoginAPP;
begin
  reiniciarCredenciales();
  LoginForm := TLoginAPP.Create(Application);
  LoginForm.Show;
  close;
end;


procedure TmenuAPP.FormCreate(Sender: TObject);
var
IniFile: TIniFile;
begin
  IniFile := TIniFile.Create('C:\Users\CHRISTIAN\Desktop\AppMovil\credenciales.ini');
  try
    LabelUsuario.Text := IniFile.ReadString('User', 'Username', '');

  finally
     Inifile.Free;
  end;

  JsonDetalles := tJsonArray.Create ;
  //ajustarColumnas;
  if TabControl1.TabIndex = 0 then
  begin
  rectangle4.Visible := True;
  rectangle3.Visible := False;
  image1.Visible := False;
  tituloventas.Visible := False;
  tituloinicio.Visible := True;
  end;

end;

procedure TmenuAPP.FormShow(Sender: TObject);
begin
  clientRest:= TserverMethods1client.Create(loginApp.SQLConnection1.DBXConnection);
  clientRest.CargarGrid ;

  try
    JsonDetalles := clientRest.CargarGrid;
    rellenarGrid;
    except
    ShowMessage('Error');
  end;
end;

procedure TmenuAPP.Image1Click(Sender: TObject);
begin
    filtro.ShowModal ;
end;

procedure TmenuAPP.Image2Click(Sender: TObject);
begin
  Multiview1.ShowMaster;
end;


procedure TmenuAPP.Image4Click(Sender: TObject);
begin
  TabControl1.TabIndex := 1;
end;

procedure TmenuAPP.Image5Click(Sender: TObject);
begin
 if ComboBox1.ItemIndex = 1 then
  begin
    {conexiones.ADOQuery3.Close;
    conexiones.ADOQuery3.SQL.Text := 'SELECT VentasPendientes.Fecha, CONVERT(VARCHAR(10), Hora, 108) AS Hora,Tiendas.Nombre AS NombreTienda,VentasPendientes.CodigoCliente, ' +
    'Clientes.Nombre,VentasPendientes.ClaveActivacion,VentasPendientes.CodigoDivisaEntrada, ' +
    'VentasPendientes.CodigoDivisaSalida ' +
    'FROM   VentasPendientes INNER JOIN ' +
             'Clientes ON VentasPendientes.CodigoCliente = Clientes.Codigo ' +
             'INNER JOIN ' +
             'Tiendas ON VentasPendientes.CodigoTienda = Tiendas.Codigo WHERE Tiendas.Nombre LIKE '
    +quotedstr('%' + busca.Text + '%');
    conexiones.ADOQuery3.Open;
  end;
  if ComboBox1.ItemIndex = 0 then
   begin
    conexiones.ADOQuery3.Close;
    conexiones.ADOQuery3.SQL.Text := 'SELECT VentasPendientes.Fecha,CONVERT(VARCHAR(10), Hora, 108) AS Hora,Tiendas.Nombre AS NombreTienda,VentasPendientes.CodigoCliente, ' +
    'Clientes.Nombre,VentasPendientes.ClaveActivacion,VentasPendientes.CodigoDivisaEntrada, ' +
    'VentasPendientes.CodigoDivisaSalida ' +
    'FROM   VentasPendientes INNER JOIN ' +
             'Clientes ON VentasPendientes.CodigoCliente = Clientes.Codigo ' +
             'INNER JOIN ' +
             'Tiendas ON VentasPendientes.CodigoTienda = Tiendas.Codigo WHERE VentasPendientes.Fecha >= '
    +quotedstr(Dateedit1.Text) +
    'AND VentasPendientes.Fecha <= ' +quotedstr(Dateedit2.Text);
    conexiones.ADOQuery3.Open;    }
end;
end;

procedure TmenuAPP.Image7Click(Sender: TObject);
begin
   { conexiones.ADOQuery3.SQL.Text := 'SELECT VentasPendientes.Fecha,CONVERT(VARCHAR(10), Hora, 108) AS Hora,Tiendas.Nombre AS NombreTienda,VentasPendientes.CodigoCliente, ' +
    'Clientes.Nombre,VentasPendientes.ClaveActivacion,VentasPendientes.CodigoDivisaEntrada, ' +
    'VentasPendientes.CodigoDivisaSalida ' +
    'FROM   VentasPendientes INNER JOIN ' +
             'Clientes ON VentasPendientes.CodigoCliente = Clientes.Codigo ' +
             'INNER JOIN ' +
             'Tiendas ON VentasPendientes.CodigoTienda = Tiendas.Codigo ';
    conexiones.ADOQuery3.Open;
    busca.Text := '';    }
end;

procedure TmenuAPP.reiniciarCredenciales;
var
  IniFile: TIniFile;
begin
  IniFile := TIniFile.Create('C:\Users\CHRISTIAN\Desktop\AppMovil\credenciales.ini');
  try
    IniFile.WriteString('User', 'Username', '');
    IniFile.WriteString('User', 'Password', '');
  finally
    IniFile.Free;
  end;
end;

procedure TmenuAPP.rellenarGrid;
var
  I: integer;
  Detalle: TJsonValue;
begin
   //StringGrid1.RowCount := 1;

   StringGrid1.RowCount := Jsondetalles.Count;

for I := 0 to JSONDetalles.Count -1 do
begin
  Detalle := JSONDetalles.Items[I];
  //StringGrid1.RowCount := StringGrid1.RowCount + 1;

  StringGrid1.Cells[0, I] := Detalle.GetValue<String>('Fecha');
  StringGrid1.Cells[1, I] := Detalle.GetValue<String>('Hora');
  StringGrid1.Cells[2, I] := Detalle.GetValue<String>('NombreTienda');
  StringGrid1.Cells[3, I] := Detalle.GetValue<String>('CodigoCliente');
  StringGrid1.Cells[4, I] := Detalle.GetValue<String>('Nombre');
  StringGrid1.Cells[5, I] := Detalle.GetValue<String>('ClaveActivacion');
  StringGrid1.Cells[6, I] := Detalle.GetValue<String>('CodigoDivisaEntrada');
  StringGrid1.Cells[7, I] := Detalle.GetValue<String>('CodigoDivisaSalida');
end;

end;

procedure TmenuAPP.SpeedButton1Click(Sender: TObject);
begin
    TabControl1.TabIndex := 0;
    MultiView1.HideMaster;
end;

procedure TmenuAPP.SpeedButton2Click(Sender: TObject);
begin
  TabControl1.TabIndex := 1;
  Multiview1.HideMaster;
end;

procedure TmenuAPP.BTNSalirClick(Sender: TObject);
begin
// if ComboBox1.ItemIndex = 1 then
   application.Terminate;

    {conexiones.ADOQuery3.Close;
    conexiones.ADOQuery3.SQL.Text := 'SELECT VentasPendientes.Fecha,CONVERT(VARCHAR(10), Hora, 108) AS Hora,Tiendas.Nombre AS NombreTienda,VentasPendientes.CodigoCliente, ' +
    'Clientes.Nombre,VentasPendientes.ClaveActivacion,VentasPendientes.CodigoDivisaEntrada, ' +
    'VentasPendientes.CodigoDivisaSalida ' +
    'FROM   VentasPendientes INNER JOIN ' +
             'Clientes ON VentasPendientes.CodigoCliente = Clientes.Codigo ' +
             'INNER JOIN ' +
             'Tiendas ON VentasPendientes.CodigoTienda = Tiendas.Codigo WHERE Tiendas.Nombre LIKE '
    +quotedstr('%' + busca.Text + '%');
    conexiones.ADOQuery3.Open;
  end;
  if ComboBox1.ItemIndex = 0 then
   begin
    conexiones.ADOQuery3.Close;
    conexiones.ADOQuery3.SQL.Text := 'SELECT VentasPendientes.Fecha,CONVERT(VARCHAR(10), Hora, 108) AS Hora,Tiendas.Nombre AS NombreTienda,VentasPendientes.CodigoCliente, ' +
    'Clientes.Nombre,VentasPendientes.ClaveActivacion,VentasPendientes.CodigoDivisaEntrada, ' +
    'VentasPendientes.CodigoDivisaSalida ' +
    'FROM   VentasPendientes INNER JOIN ' +
             'Clientes ON VentasPendientes.CodigoCliente = Clientes.Codigo ' +
             'INNER JOIN ' +
             'Tiendas ON VentasPendientes.CodigoTienda = Tiendas.Codigo WHERE VentasPendientes.Fecha >= '
    +quotedstr(Dateedit1.Text) +
    'AND VentasPendientes.Fecha <= ' +quotedstr(Dateedit2.Text);
    conexiones.ADOQuery3.Open; }

end;

procedure TmenuAPP.SpeedButton4Click(Sender: TObject);
begin
    {conexiones.ADOQuery3.SQL.Text := 'SELECT VentasPendientes.Fecha,CONVERT(VARCHAR(10), Hora, 108) AS Hora,Tiendas.Nombre AS NombreTienda,VentasPendientes.CodigoCliente, ' +
    'Clientes.Nombre,VentasPendientes.ClaveActivacion,VentasPendientes.CodigoDivisaEntrada, ' +
    'VentasPendientes.CodigoDivisaSalida ' +
    'FROM   VentasPendientes INNER JOIN ' +
             'Clientes ON VentasPendientes.CodigoCliente = Clientes.Codigo ' +
             'INNER JOIN ' +
             'Tiendas ON VentasPendientes.CodigoTienda = Tiendas.Codigo ';
    conexiones.ADOQuery3.Open;
    busca.Text := '';  }
end;

procedure TmenuAPP.TabControl1Change(Sender: TObject);
begin
if TabControl1.TabIndex = 1 then
begin
  rectangle3.Visible := True;
  rectangle4.Visible := False;
  image1.Visible := True;
  tituloventas.Visible := True;
  tituloinicio.Visible := False;
end;
if TabControl1.TabIndex = 0 then
begin
  tituloinicio.Visible := True;
  tituloventas.Visible := False;
  image1.Visible := False;
  rectangle4.Visible := True;
  rectangle3.Visible := False;
end;
end;

procedure TmenuAPP.Timer1Timer(Sender: TObject);
begin


   // ajustarColumnas;

end;

end.
