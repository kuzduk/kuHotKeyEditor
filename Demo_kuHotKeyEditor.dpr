program Demo_kuHotKeyEditor;

uses
  Forms,
  kuHotKeysEditor;

{$R *.res}

begin
  Application.Initialize;
//  Application.MainFormOnTaskbar := True;
  kuHotKeyEditorExecute;
  Application.Run;
end.
