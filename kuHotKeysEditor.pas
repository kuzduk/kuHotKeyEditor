unit kuHotKeysEditor;
{
Редактор горячих клавиш Delphi
Отлавливает не только Ctrl, Shift, Alt но и Win
Автор Горкун Григорий https://kuzduk.ru/delphi

НУЖНО ДОДЕЛАТЬ:
Запретить в ComboBox все HK: Up Dn Left Right PgUp PgDown чтоб при OnKeyDown они не меняли строку а делали только KeyToStr
Запретить потрею фокуса по Tab в ComboBox и Edit1
Перехватить все глобальные клавиши системы, чтоб они не выпонгялись, а только отображались редакторе, например,чтоб по Win не включалось меню пуск, или например Win + E не включал "Мой компьютер"
}
interface

uses
  Classes, Forms, Buttons, Controls, StdCtrls, Windows,

  kuHotKeys;

type
  TFormHK = class(TForm)
    chWin: TCheckBox;
    chAlt: TCheckBox;
    chShift: TCheckBox;
    chCtrl: TCheckBox;
    ComboBox1: TComboBox;
    Edit1: TEdit;
    ListBox1: TListBox;
    btnAdd: TSpeedButton;
    btnDel: TSpeedButton;

    procedure Edit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Edit1KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);

    procedure chCtrlClick(Sender: TObject);
    procedure chShiftClick(Sender: TObject);
    procedure chAltClick(Sender: TObject);
    procedure chWinClick(Sender: TObject);
    procedure ModToCheckBox(const ModStr: string = '');

    procedure ComboBox1Change(Sender: TObject);
    procedure ComboBox1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);

    procedure btnAddClick(Sender: TObject);
    procedure btnDelClick(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);

    private
      _KeyDown: Boolean;
  end;

var
  FormHK: TFormHK;

function kuHotKeyEditorExecute: Boolean;


implementation

{$R *.dfm}




//============================================================================== kuHotKeyEditorExecute
function kuHotKeyEditorExecute: Boolean;
begin

if Application.FindComponent('FormHotKeys') = nil then
  Application.CreateForm(TFormHK, FormHK);

end;





//------------------------------------------------------------------------------ Edit1 Key Down
procedure TFormHK.Edit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  sMod, sKey: string;

begin

  if Key = VK_TAB then
  begin
    (Sender as TEdit).SelText := 'Tab';
    Key := 0; // Отменяем стандартную обработку
    exit;
  end;

//if (Key = 9) and (ActiveControl = Self) then begin
//  //не работает!
//  Perform(CM_DialogKey, VK_TAB, 0);
//  ActiveControl := Self;
//  Self.SetFocus;
//end;


sMod := ModToStr;
sKey := KeyToStr(Key);

_KeyDown := sKey <> '';

Edit1.text := sMod + sKey;
ModToCheckBox;
FormHK.ComboBox1.ItemIndex := FormHK.ComboBox1.Items.IndexOf(sKey);

end;



procedure TFormHK.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #9 then  // #9 - это ASCII код Tab
  begin
    TEdit(Sender).Text := TEdit(Sender).Text + 'Tab'; // Или просто Edit1.Text := Edit1.Text + 'Tab';
    Key := #0; // Отменяем стандартное поведение Tab (переход фокуса)
  end;
end;

//------------------------------------------------------------------------------ Edit1 Key Up
procedure TFormHK.Edit1KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin

if not _KeyDown then begin
  ModToCheckBox('');
  Edit1.text := '';
end;

//if (KeyToStr(Key) = '') and (ModToStr = '') then

end;










//------------------------------------------------------------------------------ ComboBox Change
procedure TFormHK.ComboBox1Change(Sender: TObject);
var
p: integer;
s: string;
sKey, sMod: word;

begin

StrToKeyMod(Edit1.Text, sKey, sMod);
Edit1.Text := ModToStr(sMod) + ComboBox1.Text;

end;



//------------------------------------------------------------------------------ ComboBox KeyDown
procedure TFormHK.ComboBox1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
s: string;
//k: Word;

begin
s := KeyToStr(Key);
//k := Key;





ComboBox1.ItemIndex := ComboBox1.Items.IndexOf(s);

//if Key = VK_TAB then ActiveControl := ComboBox1; //не работает
Key := 0; //чтобы не обрабатывать клавиши Up, Down, Left, Right, Home, End, PgUp, PgDown,
end;










//------------------------------------------------------------------------------ chWin
procedure TFormHK.chWinClick(Sender: TObject);
var
p: integer;
s: string;
sKey, sMod: word;

begin

if chWin.Checked

then begin
  StrToKeyMod(Edit1.Text, sKey, sMod);
  sMod := sMod xor MOD_WIN;
  Edit1.Text := ModToStr(sMod) + KeyToStr(sKey);
end

else begin
  s := Edit1.Text;
  p := pos('Win+', Edit1.Text);
  if p <> 0 then Delete(s, p, 4);
  Edit1.Text := s;
end;

end;



//------------------------------------------------------------------------------ chCtrl
procedure TFormHK.chCtrlClick(Sender: TObject);
var
p: integer;
s: string;
sKey, sMod: word;

begin

if chCtrl.Checked

then begin
  StrToKeyMod(Edit1.Text, sKey, sMod);
  sMod := sMod xor MOD_CONTROL;
  Edit1.Text := ModToStr(sMod) + KeyToStr(sKey);
end

else begin
  s := Edit1.Text;
  p := pos('Ctrl+', Edit1.Text);
  if p <> 0 then Delete(s, p, 5);
  Edit1.Text := s;
end;


end;



//------------------------------------------------------------------------------ chShift
procedure TFormHK.chShiftClick(Sender: TObject);
var
p: integer;
s: string;
sKey, sMod: word;

begin

if chShift.Checked

then begin
  StrToKeyMod(Edit1.Text, sKey, sMod);
  sMod := sMod xor MOD_SHIFT;
  Edit1.Text := ModToStr(sMod) + KeyToStr(sKey);
end

else begin
  s := Edit1.Text;
  p := pos('Shift+', Edit1.Text);
  if p <> 0 then Delete(s, p, 6);
  Edit1.Text := s;
end;

end;



//------------------------------------------------------------------------------ chAlt
procedure TFormHK.chAltClick(Sender: TObject);
var
p: integer;
s: string;
sKey, sMod: word;

begin

if chAlt.Checked

then begin
  StrToKeyMod(Edit1.Text, sKey, sMod);
  sMod := sMod xor MOD_ALT;
//  FormHotKeys.Caption := ModToStr(sMod) + '|||' + KeyToStr(sKey);
  Edit1.Text := ModToStr(sMod) + KeyToStr(sKey);
end

else begin
  s := Edit1.Text;
  p := pos('Alt+', Edit1.Text);
  if p <> 0 then Delete(s, p, 4);
  Edit1.Text := s;
end;

end;



//------------------------------------------------------------------------------ Moding To CheckBox
procedure TFormHK.ModToCheckBox(const ModStr: string = '');
begin
if ModStr <> '' then begin
  chCtrl.Checked  := pos('Ctrl',  ModStr) <> 0;
  chShift.Checked := pos('Shift', ModStr) <> 0;
  chAlt.Checked   := pos('Ctrl',  ModStr) <> 0;
  chWin.Checked   := pos('Win',   ModStr) <> 0;
  exit;
end;

chCtrl.Checked  := CtrlDown;
chShift.Checked := ShiftDown;
chAlt.Checked   := AltDown;
chWin.Checked   := WinDown;
end;










//------------------------------------------------------------------------------ btnAdd
procedure TFormHK.btnAddClick(Sender: TObject);
begin
if ListBox1.Items.IndexOf(Edit1.Text) <> -1 then exit;

ListBox1.Items.Add(Edit1.Text)
end;




//------------------------------------------------------------------------------ btnDel
procedure TFormHK.btnDelClick(Sender: TObject);
var
  i, r: Integer;

//  function isItemSelected(iItem: integer): Boolean;
//  begin
//    Result := ListBox1.Selected[iItem];
//  end;

begin

//r := List_SmartSelectAfterDeleteMulti(ListBox1.ItemIndex, ListBox1.Count, @isItemSelected) ;


for i := ListBox1.Count - 1 downto 0
do
begin
   if ListBox1.Selected[i]
   then
   begin
     ListBox1.Items.Delete(i);
   end;
end;



//if ListBox1.Count > 0 then begin
//  ListBox1.ItemIndex := r;
//  ListBox1.Selected[r] := True;
//end;

end;






end.
