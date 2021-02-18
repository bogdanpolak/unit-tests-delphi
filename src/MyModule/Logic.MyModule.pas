unit Logic.MyModule;

interface

uses
  System.Classes,
  System.Generics.Collections,
  Helper.IntegerList,
  DataRepository;

type
  TMyModule = class(TDataModule)
  private
    FData: TList<Integer>;
  public
    constructor Create(Owner: TComponent); override;
    destructor Destroy; override;
    procedure LoadData(aDataRepository: IDataRepository);
    procedure AddItem(aValue: Integer);
    function RemoveItem(aValue: Integer): Integer;
    function GetItemsCount(): Integer;
  end;

var
  MyModule: TMyModule;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

{ TDataModule1 }

procedure TMyModule.AddItem(aValue: Integer);
begin
  FData.Add(aValue);
end;

constructor TMyModule.Create(Owner: TComponent);
begin
  inherited;
  FData := TList<Integer>.Create();
end;

destructor TMyModule.Destroy;
begin
  FData.Free;
  inherited;
end;

function TMyModule.GetItemsCount: Integer;
begin
  Result := FData.Count;
end;

procedure TMyModule.LoadData(aDataRepository: IDataRepository);
begin
  FData.AddRange(aDataRepository.Get());
end;

function TMyModule.RemoveItem(aValue: Integer): Integer;
var
  count: Integer;
begin
  count:=0;
  FData.ForEach(
    procedure(val: Integer)
    begin
      if (aValue=val) then inc(count);
    end);
  FData.Extract(aValue);
  Result := Count;
end;

end.
