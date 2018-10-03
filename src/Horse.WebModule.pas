unit Horse.WebModule;

interface

uses System.SysUtils, System.IOUtils, System.Classes, Web.HTTPApp, Horse,
  System.RegularExpressions;

type
  THorseWebModule = class(TWebModule)
    procedure HandlerAction(Sender: TObject; Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
  private
    FHorse: THorse;
  public
    property Horse: THorse read FHorse write FHorse;
    constructor Create(AOwner: TComponent); override;
  end;

var
  WebModuleClass: TComponentClass = THorseWebModule;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}
{$R *.dfm}

constructor THorseWebModule.Create(AOwner: TComponent);
begin
  inherited;
  FHorse := THorse.GetInstance;
end;

procedure THorseWebModule.HandlerAction(Sender: TObject; Request: TWebRequest; Response: TWebResponse;
  var Handled: Boolean);
var
  LRequest: THorseRequest;
  LResponse: THorseResponse;
begin
  LRequest := THorseRequest.Create(Request);
  LResponse := THorseResponse.Create(Response);

  if FHorse.Routes.CanExecute(LRequest) then
  begin
    FHorse.Routes.Execute(LRequest, LResponse);
  end
  else
  begin
    Response.Content := 'Not Found';
    Response.StatusCode := 404;
  end;
end;


end.
