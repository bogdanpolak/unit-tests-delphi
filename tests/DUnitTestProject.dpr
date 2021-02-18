program DUnitTestProject;

{ $DEFINE CONSOLE_TESTRUNNER}

{$IFDEF CONSOLE_TESTRUNNER}
{$APPTYPE CONSOLE}
{$ENDIF}

uses
  DUnitTestRunner,
  TestCase01 in 'TestCase01.pas',
  DataRepository in '..\src\MyModule\DataRepository.pas',
  Logic.MyModule in '..\src\MyModule\Logic.MyModule.pas' {MyModule: TDataModule},
  XMLTestRunner2 in 'XMLTestRunner2.pas',
  Helper.IntegerList in '..\src\Helpers\Helper.IntegerList.pas';

{$R *.RES}

begin
  DUnitTestRunner.RunRegisteredTests;
  XMLTestRunner2.RunRegisteredTests.Free;
end.

