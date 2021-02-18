unit TestCase01;

interface

uses
  TestFramework,
  System.Types,
  Logic.MyModule,
  DataRepository;

type
  TTestCase01 = class(TTestCase)
  strict private
    FMyModule: TMyModule;
    removed: Integer;
  private
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure RemoveItem_OneItem;
    procedure RemoveItem_OneNotExistItem;
    procedure RemoveItem_NineItemsAndThreeSame;
  end;

implementation

type
  TFakeDataRepository = class(TInterfacedObject, IDataRepository)
  class var
    FakeData: TArray<Integer>;
    function Get: TArray<Integer>;
  end;

function TFakeDataRepository.Get: TArray<Integer>;
begin
  Result := FakeData;
end;

function BuildRepository(const aData: TArray<Integer>): IDataRepository;
begin
  TFakeDataRepository.FakeData := aData;
  Result := TFakeDataRepository.Create;
end;

procedure TTestCase01.SetUp;
begin
  FMyModule := TMyModule.Create(nil);
end;

procedure TTestCase01.TearDown;
begin
  FMyModule.Free;
end;

procedure TTestCase01.RemoveItem_OneItem;
begin
  FMyModule.LoadData(BuildRepository([5]));
  removed := FMyModule.RemoveItem(5);
  CheckEquals(1, removed);
  CheckEquals(0, FMyModule.GetItemsCount);
end;

procedure TTestCase01.RemoveItem_OneNotExistItem;
begin
  FMyModule.LoadData(BuildRepository([5]));
  removed := FMyModule.RemoveItem(1);
  CheckEquals(0, removed);
  CheckEquals(1, FMyModule.GetItemsCount);
end;

procedure TTestCase01.RemoveItem_NineItemsAndThreeSame;
var
  removed: Integer;
begin
  FMyModule.LoadData(BuildRepository([5, 1, 18, 2, 9, 1, 14, 2, 1]));
  removed := FMyModule.RemoveItem(1);
  CheckEquals(3, removed);
  CheckEquals(6, FMyModule.GetItemsCount);
end;

initialization

// Register any test cases with the test runner
RegisterTest(TTestCase01.Suite);

end.
