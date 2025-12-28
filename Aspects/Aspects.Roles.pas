unit Aspects.Roles;

interface
uses
  System.SysUtils, System.Classes, System.Generics.Collections;

type
  TAspectMenuItem = class(TObject)
  private
    FCaption: string;
    FOnClick: TNotifyEvent;
    FVisible: Boolean;
  public
    LstSubMenu: TList<TAspectMenuItem>;
    constructor Create(cap: string; clickEvent: TNotifyEvent);
    destructor Destroy; override;
    property Caption: string read FCaption write FCaption;
    property OnClick: TNotifyEvent read FOnClick write FOnClick;
    property Visible: Boolean read FVisible write FVisible;
  end;

  TRoleMainButton = class(TObject)
  private
    FOnClick: TNotifyEvent;
  public
    LstSubButtons: TList<TRoleMainButton>;
    property OnClick: TNotifyEvent read FOnClick write FOnClick;
  end;

  TRoleItem = class(TObject)
  public
    LstAspectMainMenu: TList<TAspectMenuItem>;
    LstAspectMainButtons: TList<TRoleMainButton>;

  end;


  TRoleOPL = class(TRoleItem)
  public
    constructor Create;
    destructor Destroy; override;
    procedure AddMenuOpl;
  end;

  var
    RoleOpl: TRoleOPL;


implementation

{ TRoleOPL }

procedure TRoleOPL.AddMenuOpl;
var
  ami: TAspectMenuItem;
begin
  ami := TAspectMenuItem.Create('Дейности', nil);
  LstAspectMainMenu.Add(ami);
  ami.LstSubMenu.Add(TAspectMenuItem.Create('Регистър', nil));
  ami.LstSubMenu.Add(TAspectMenuItem.Create('-', nil));
  ami.LstSubMenu.Add(TAspectMenuItem.Create('Прегледи', nil));


  LstAspectMainMenu.Add(TAspectMenuItem.Create('Списъци', nil));
  LstAspectMainMenu.Add(TAspectMenuItem.Create('Номенклатури', nil));
end;

constructor TRoleOPL.Create;
begin
  LstAspectMainMenu := TList<TAspectMenuItem>.Create;
  AddMenuOpl;
end;

destructor TRoleOPL.Destroy;
begin
  FreeAndNil(LstAspectMainMenu);
  inherited;
end;

{ TAspectMenuItem }

constructor TAspectMenuItem.Create(cap: string; clickEvent: TNotifyEvent);
begin
  Visible := True;
  Caption := cap;
  OnClick := clickEvent;
  LstSubMenu := TList<TAspectMenuItem>.create;
end;

destructor TAspectMenuItem.Destroy;
begin
  FreeAndNil(LstSubMenu);
  inherited;
end;

end.
