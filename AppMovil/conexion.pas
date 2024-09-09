unit conexion;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Data.Win.ADODB;

type
  Tconexiones = class(TDataModule)
   ADOConnection1: TADOConnection;
    ADOQuery1: TADOQuery;
    ADOQuery2: TADOQuery;
    ADOQuery3: TADOQuery;
    DataSource3: TDataSource;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  conexiones: Tconexiones;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

end.
