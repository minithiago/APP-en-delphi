unit login2;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Edit, FMX.Controls.Presentation, FMX.Objects, FMX.Layouts, bdcon, IniFiles, ADODB,
  Data.DB, conexion;

type
  TLoginn2 = class(TForm)
    Header: TLayout;
    Rectangle7: TRectangle;
    Image1: TImage;
    Main: TLayout;
    Rectangle2: TRectangle;
    Rectangle1: TRectangle;
    Label1: TLabel;
    Label3: TLabel;
    Contraseña: TLabel;
    Rectangle3: TRectangle;
    Entrar: TSpeedButton;
    Edit1: TEdit;
    Image3: TImage;
    Edit2: TEdit;
    CheckBox1: TCheckBox;
    ZFooter: TLayout;
    Rectangle8: TRectangle;
    Rectangle5: TRectangle;
    Rectangle9: TRectangle;
    Label2: TLabel;
    Rectangle4: TRectangle;
    Label4: TLabel;
    Label5: TLabel;
    Image2: TImage;
    Rectangle6: TRectangle;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Loginn2: TLoginn2;

implementation

{$R *.fmx}

end.
