unit FiltroPantalla;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects, FMX.Layouts, FMX.Edit,
  FMX.DateTimeCtrls, DateUtils, datasnap, json;

type
  TFiltro = class(TForm)
    header: TLayout;
    Rectangle1: TRectangle;
    Image2: TImage;
    tituloFiltro: TLabel;
    Layout1: TLayout;
    Layout3: TLayout;
    DateEdit1: TDateEdit;
    DateEdit2: TDateEdit;
    EditBuscar1: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Layout4: TLayout;
    Rectangle2: TRectangle;
    SpeedButtonBuscar: TSpeedButton;
    Image4: TImage;
    Label1: TLabel;
    Image1: TImage;
    procedure Image4Click(Sender: TObject);
    procedure SpeedButtonResetClick(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure EditBuscar1KeyUp(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure DateEdit1Change(Sender: TObject);
    procedure DateEdit2Change(Sender: TObject);
    procedure rellenarGrid1();

  private
    { Private declarations }
    JsonDetalles: TJSONArray;
  public
    { Public declarations }
  end;

var
  Filtro: TFiltro;
  clientRest: TserverMethods1client;

implementation

{$R *.fmx}

uses login, menu;

procedure TFiltro.DateEdit1Change(Sender: TObject);
begin
       EditBuscar1.Enabled := false;
end;

procedure TFiltro.DateEdit2Change(Sender: TObject);
begin
    EditBuscar1.Enabled := false;
end;

procedure TFiltro.EditBuscar1KeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
       if trim(EditBuscar1.text) = '' then
    begin
         DateEdit1.Enabled := true;
         DateEdit2.Enabled := true;
     end
     else
     begin
         DateEdit1.Enabled := false;
         DateEdit2.Enabled := false;
     end;

end;

procedure TFiltro.FormCreate(Sender: TObject);
begin
     DateEdit1.Date := date.now;
     DateEdit2.Date := date.now;
     EditBuscar1.Enabled := True;
     JsonDetalles := tJsonArray.Create ;
end;

procedure TFiltro.Image1Click(Sender: TObject);
begin
  clientRest:= TserverMethods1client.Create(loginApp.SQLConnection1.DBXConnection);
  clientRest.CargarGrid ;
  EditBuscar1.text := '';
  DateEdit1.Date := date.Now;
  DateEdit2.Date := date.Now;
  DateEdit1.Enabled := true;
  DateEdit2.Enabled := true;

  EditBuscar1.Enabled := true;


  try
    JsonDetalles := clientRest.CargarGrid;
    rellenarGrid1;
    except
    ShowMessage('Error');
  end;
end;

procedure TFiltro.Image2Click(Sender: TObject);
begin
    Close;
end;

procedure TFiltro.Image4Click(Sender: TObject);
begin
if trim(EditBuscar1.Text) = '' then
begin
  clientRest:= TserverMethods1client.Create(loginApp.SQLConnection1.DBXConnection);
  clientRest.buscarFiltro1(DateEdit1.text, DateEdit2.text);

  try
    JsonDetalles := clientRest.buscarFiltro1(DateEdit1.Text, DateEdit2.Text);
    rellenarGrid1();
    except
    ShowMessage('Error');
  end;
end
else
begin
  clientRest:= TserverMethods1client.Create(loginApp.SQLConnection1.DBXConnection);
  clientRest.buscarFiltro2(EditBuscar1.Text);

  try
    JsonDetalles := clientRest.buscarFiltro2(EditBuscar1.Text);
    rellenarGrid1();
    except
    ShowMessage('Error');
end;
    //conexiones.ADOQuery3.Open;
    close;
end;
end;

procedure TFiltro.rellenarGrid1;
var
  I: integer;
  Detalle: TJsonValue;
begin
   //StringGrid1.RowCount := 1;

   menuAPP.StringGrid1.RowCount := Jsondetalles.Count ;  //+1

for I := 0 to JSONDetalles.Count -1 do
begin
  Detalle := JSONDetalles.Items[I];
  //menuapp.StringGrid1.RowCount := menuapp.StringGrid1.RowCount + 1;

  menuAPP.StringGrid1.Cells[0, I] := Detalle.GetValue<String>('Fecha');
  menuAPP.StringGrid1.Cells[1, I] := Detalle.GetValue<String>('Hora');
  menuAPP.StringGrid1.Cells[2, I] := Detalle.GetValue<String>('NombreTienda');
  menuAPP.StringGrid1.Cells[3, I] := Detalle.GetValue<String>('CodigoCliente');
  menuAPP.StringGrid1.Cells[4, I] := Detalle.GetValue<String>('Nombre');
  menuAPP.StringGrid1.Cells[5, I] := Detalle.GetValue<String>('ClaveActivacion');
  menuAPP.StringGrid1.Cells[6, I] := Detalle.GetValue<String>('CodigoDivisaEntrada');
  menuAPP.StringGrid1.Cells[7, I] := Detalle.GetValue<String>('CodigoDivisaSalida');
end;

end;

procedure TFiltro.SpeedButtonResetClick(Sender: TObject);
begin
    close;
end;

end.
