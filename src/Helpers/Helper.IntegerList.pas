unit Helper.IntegerList;

interface

uses
  System.SysUtils,
  System.Generics.Collections;

type
  TIntegerList = TList<Integer>;

  TIntegerListHelper = class helper for TIntegerList
    procedure ForEach(proc: TProc<Integer>);
  end;

implementation


procedure TIntegerListHelper.ForEach(proc: TProc<Integer>);
var
  elem: Integer;
begin
  for elem in self do
    proc(elem);
end;

end.
