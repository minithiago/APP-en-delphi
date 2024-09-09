unit servidor;

interface

uses Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.Types,
  FMX.StdCtrls, FMX.Controls.Presentation, FMX.Effects;

type
  Tfdm = class(TForm)
    StyleBook1: TStyleBook;
    Label1: TLabel;
    Button1: TButton;
    Switch1: TSwitch;
    ShadowEffect1: TShadowEffect;
    procedure Switch1Switch(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fdm: Tfdm;

implementation

{$R *.fmx}

uses ServerContainerUnit1;

procedure Tfdm.Button1Click(Sender: TObject);
begin
    application.Terminate;
end;

procedure Tfdm.Switch1Switch(Sender: TObject);
begin
     if Switch1.IsChecked = True then
     begin
       servercontainer1.DSServer1.Start;
       shadowEffect1.Enabled := True;
     end
     else
     begin
       servercontainer1.DSServer1.Stop;
       shadowEffect1.Enabled := False;
     end;
end;

end.

