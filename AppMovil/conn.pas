unit conn;

interface

uses
  System.SysUtils, System.Classes, Data.DB,
  Data.Win.ADODB
  ;

type
  TDataModule1 = class(TDataModule)
    ADOConnection1: TADOConnection;
    ADOQuery1: TADOQuery;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DataModule1: TDataModule1;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

end.
