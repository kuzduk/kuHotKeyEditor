unit kuHotKeys;
{
Автор Горкун Григорий
https://kuzduk.ru/delphi/kulibrary
Key - клавиша-не-модификатор (A..Z, 1..2, F1-F12, Del, Ins...)
Mod - клавиша моджификатор CSAW
CSAW - Ctrl, Shift, Alt, Win

ShiftState - набор модификаторов ssCtrl, ssShift, ssAlt. БЕЗ клавиши Win

ShortCutToText - uses Vcl.Menus
GetKeyNameText - uses Winapi.Windows
}
interface

uses
  Windows, SysUtils, Classes;


//Key ~ Mod ~ Str
function  ModToStr: string; overload;
function  ModToStr(sMod: word): string; overload;
function  KeyToStr(Key: word): string;

function  StrToKey(const KeyStr: string): DWord;
procedure StrToKeyMod(ShortcutStr: string; var vKey, vMod: word);


//Key Down
function KeyDownly(Key: integer): Boolean;

function CtrlDown: Boolean;
function ShiftDown: Boolean;
function AltDown: Boolean;
function WinDown: Boolean;

function CtrlOnly: Boolean;
function ShiftOnly: Boolean;
function AltOnly: Boolean;

function ModDown(AMods: string): Boolean;
function NoCSA: Boolean;


implementation



{$REGION '  Key ~ Mod ~ Str  '}


//------------------------------------------------------------------------------
function StrToKey(const KeyStr: string): DWord;
begin
  if SameText(KeyStr, 'Space') or SameText(KeyStr, ' ') then
    Result := VK_SPACE
  else if SameText(KeyStr, 'Enter') or SameText(KeyStr, 'Return') then
    Result := VK_RETURN
  else if SameText(KeyStr, 'Tab') then
    Result := VK_TAB
  else if SameText(KeyStr, 'Esc') or SameText(KeyStr, 'Escape') then
    Result := VK_ESCAPE
  else if SameText(KeyStr, 'Backspace') then
    Result := VK_BACK
  else if SameText(KeyStr, 'Insert') then
    Result := VK_INSERT
  else if SameText(KeyStr, 'Delete') then
    Result := VK_DELETE
  else if SameText(KeyStr, 'Home') then
    Result := VK_HOME
  else if SameText(KeyStr, 'End') then
    Result := VK_END
  else if SameText(KeyStr, 'PageUp') then
    Result := VK_PRIOR
  else if SameText(KeyStr, 'PageDown') then
    Result := VK_NEXT
  else if SameText(KeyStr, 'Left') then
    Result := VK_LEFT
  else if SameText(KeyStr, 'Right') then
    Result := VK_RIGHT
  else if SameText(KeyStr, 'Up') then
    Result := VK_UP
  else if SameText(KeyStr, 'Down') then
    Result := VK_DOWN
  else if SameText(KeyStr, 'PrintScreen') or SameText(KeyStr, 'PrtSc') then
    Result := VK_SNAPSHOT
  else if SameText(KeyStr, 'ScrollLock') then
    Result := VK_SCROLL
  else if SameText(KeyStr, 'Pause') or SameText(KeyStr, 'Break') then
    Result := VK_PAUSE
  else if SameText(KeyStr, 'NumLock') then
    Result := VK_NUMLOCK
  else if SameText(KeyStr, 'CapsLock') then
    Result := VK_CAPITAL
  // F-клавиши
  else if SameText(KeyStr, 'F1') then
    Result := VK_F1
  else if SameText(KeyStr, 'F2') then
    Result := VK_F2
  else if SameText(KeyStr, 'F3') then
    Result := VK_F3
  else if SameText(KeyStr, 'F4') then
    Result := VK_F4
  else if SameText(KeyStr, 'F5') then
    Result := VK_F5
  else if SameText(KeyStr, 'F6') then
    Result := VK_F6
  else if SameText(KeyStr, 'F7') then
    Result := VK_F7
  else if SameText(KeyStr, 'F8') then
    Result := VK_F8
  else if SameText(KeyStr, 'F9') then
    Result := VK_F9
  else if SameText(KeyStr, 'F10') then
    Result := VK_F10
  else if SameText(KeyStr, 'F11') then
    Result := VK_F11
  else if SameText(KeyStr, 'F12') then
    Result := VK_F12
  else if SameText(KeyStr, 'F13') then
    Result := VK_F13
  else if SameText(KeyStr, 'F14') then
    Result := VK_F14
  else if SameText(KeyStr, 'F15') then
    Result := VK_F15
  else if SameText(KeyStr, 'F16') then
    Result := VK_F16
  else if SameText(KeyStr, 'F17') then
    Result := VK_F17
  else if SameText(KeyStr, 'F18') then
    Result := VK_F18
  else if SameText(KeyStr, 'F19') then
    Result := VK_F19
  else if SameText(KeyStr, 'F20') then
    Result := VK_F20
  else if SameText(KeyStr, 'F21') then
    Result := VK_F21
  else if SameText(KeyStr, 'F22') then
    Result := VK_F22
  else if SameText(KeyStr, 'F23') then
    Result := VK_F23
  else if SameText(KeyStr, 'F24') then
    Result := VK_F24
  // Цифровые клавиши
  else if (Length(KeyStr) = 1) and (KeyStr[1] in ['0'..'9']) then
    Result := Ord(KeyStr[1])
  // Буквенные клавиши (A-Z)
  else if (Length(KeyStr) = 1) and (KeyStr[1] in ['A'..'Z']) then
    Result := Ord(KeyStr[1])

  // Символьные клавиши (для международных раскладок)
  else if SameText(KeyStr, ',' {'OemComma'}) or SameText(KeyStr, ',') then
    Result := VK_OEM_COMMA
  else if SameText(KeyStr, '.' {'OemPeriod'}) or SameText(KeyStr, '.') then
    Result := VK_OEM_PERIOD
  else if SameText(KeyStr, '-' {'OemMinus'}) or SameText(KeyStr, '-') then
    Result := VK_OEM_MINUS
  else if SameText(KeyStr, '+' {'OemPlus'}) or SameText(KeyStr, '+') then
    Result := VK_OEM_PLUS
  else if SameText(KeyStr, ';' {'Oem1'}) or SameText(KeyStr, ';') then
    Result := VK_OEM_1
  else if SameText(KeyStr, '/' {'Oem2'}) or SameText(KeyStr, '/') then
    Result := VK_OEM_2
  else if SameText(KeyStr, '`' {'Oem3'}) or SameText(KeyStr, '`') then
    Result := VK_OEM_3
  else if SameText(KeyStr, '[' {'Oem4'}) or SameText(KeyStr, '[') then
    Result := VK_OEM_4
  else if SameText(KeyStr, '\' {'Oem5'}) or SameText(KeyStr, '\') then
    Result := VK_OEM_5
  else if SameText(KeyStr, ']' {'Oem6'}) or SameText(KeyStr, ']') then
    Result := VK_OEM_6
  else if SameText(KeyStr, '''' {'Oem7'}) or SameText(KeyStr, '''') then
    Result := VK_OEM_7
  else
    Result := 0; // Неизвестная клавиша
end;



//------------------------------------------------------------------------------
procedure StrToKeyMod(ShortcutStr: string; var vKey, vMod: word);
var
k: word;
KeyPart: string;

begin

vKey := 0;
vMod := 0;

if ShortcutStr = '' then Exit;

// Обработка модификаторов
if Pos('Win+', ShortcutStr) <> 0 then
begin
  vMod := vMod or MOD_WIN;
  ShortcutStr := StringReplace(ShortcutStr, 'Win+', '', [rfReplaceAll]);
end;

if Pos('Shift+', ShortcutStr) <> 0 then
begin
  vMod := vMod or MOD_SHIFT;
  ShortcutStr := StringReplace(ShortcutStr, 'Shift+', '', [rfReplaceAll]);
end;

if Pos('Ctrl+', ShortcutStr) <> 0 then
begin
  vMod := vMod or MOD_CONTROL;
  ShortcutStr := StringReplace(ShortcutStr, 'Ctrl+', '', [rfReplaceAll]);
end;

if Pos('Alt+', ShortcutStr) <> 0 then
begin
  vMod := vMod or MOD_ALT;
  ShortcutStr := StringReplace(ShortcutStr, 'Alt+', '', [rfReplaceAll]);
end;


//yy(ShortcutStr);

// Обработка клавиши немодификатора
k := StrToKey(ShortcutStr);
if k <> 0
then
begin
  vKey := k;
end;

end;


//------------------------------------------------------------------------------ Str To KeyMod
procedure StrToKeyMod2(ShortcutStr: string; var vKey, vMod: word);
var k: word;
begin

if ShortcutStr <> '' then exit;

//vMod := 0;
if pos('Win+',  ShortcutStr)<>0 then vMod := vMod or MOD_WIN;
if pos('Shift+',ShortcutStr)<>0 then vMod := vMod or MOD_SHIFT;
if pos('Ctrl+', ShortcutStr)<>0 then vMod := vMod or MOD_CONTROL;
if pos('Alt+',  ShortcutStr)<>0 then vMod := vMod or MOD_ALT;

////if vMod <> 0 then begin
//  if pos('Win+',  ShortcutStr)<>0 then Delete(ShortcutStr, pos('Win+',  ShortcutStr),4);
//  if pos('Shift+',ShortcutStr)<>0 then Delete(ShortcutStr, pos('Shift+',ShortcutStr),6);
//  if pos('Ctrl+', ShortcutStr)<>0 then Delete(ShortcutStr, pos('Ctrl+', ShortcutStr),5);
//  if pos('Alt+',  ShortcutStr)<>0 then Delete(ShortcutStr, pos('Alt+',  ShortcutStr),4);
//end;


for k := 3 to 226 do
  if pos(ShortcutStr, KeyToStr(k)) <> 0 then begin
    vKey := k;
//   yy(ShortcutString+'|||'+Chr(vkey));
    Break;
  end;

end;


//------------------------------------------------------------------------------ Key To Str
function KeyToStr(Key: word): string;
//спасибо n0wheremany
begin

case key of
     3: Result := 'Scroll Lock';
     8: Result := 'BackSpace';
     9: Result := 'Tab';
    12: Result := 'Num 5';
    13: Result := 'Enter';

    20: Result := 'Caps Lock';
    27: Result := 'Esc';
    32: Result := 'Space';
    33: Result := 'PgUp';
    34: Result := 'PgDn';
    35: Result := 'End';
    36: Result := 'Home';
    37: Result := 'Left';
    38: Result := 'Up';
    39: Result := 'Right';
    40: Result := 'Down';
    44: Result := 'PrintScreen';
    45: Result := 'Ins';
    46: Result := 'Del';

    48..57,
    65..90: Result := Chr(key);

    96..105: Result := 'Num ' + inttostr(key-96);

   106: Result := 'Num *';
   107: Result := 'Num +';
   109: Result := 'Num -';
   110: Result := 'Num Del';
   111: Result := 'Num /';

   112..135: Result := 'F' + inttostr(key-111);

   144: Result := 'PauseBreak';
   145: Result := 'ScrollLock';

   172: Result := 'M';
   173: Result := 'D';
   174: Result := 'C';
   175: Result := 'B';
   176: Result := 'P';
   177: Result := 'Q';
   178: Result := 'J';
   179: Result := 'G';
   183: Result := 'F';

   186: Result := ';';
   187: Result := '=';
   188: Result := '<';
   190: Result := '>';
   189: Result := '-';
   192: Result := '~';
//   194: Result := 'F15';
   219: Result := '[';
   221: Result := ']';
   222: Result := '''';

   191: Result := '/';
   220: Result := '\';
   226: Result := '\';

   else
   begin
     Result := '';
//     exit;
   end;

end;


end;


//------------------------------------------------------------------------------ Mod To Str
function ModToStr: string; overload;
begin

Result := '';

//if ((HiWord(GetKeyState(VK_LWIN))<>0) or (HiWord(GetKeyState(VK_RWIN))<>0)) then Result := 'Win+';
//if HiWord(GetKeyState(VK_CONTROL))<>0 then Result := Result + 'Ctrl+';
//if HiWord(GetKeyState(VK_SHIFT))<>0   then Result := Result + 'Shift+';
//if HiWord(GetKeyState(VK_MENU))<>0    then Result := Result + 'Alt+';

if WinDown   then Result := 'Win+';
if CtrlDown  then Result := Result + 'Ctrl+';
if ShiftDown then Result := Result + 'Shift+';
if AltDown   then Result := Result + 'Alt+';

end;


//------------------------------------------------------------------------------ Mod To Str
function ModToStr(sMod: word): string; overload;
begin

Result := '';

if (sMod = sMod or MOD_WIN)     then Result := 'Win+';
if (sMod = sMod or MOD_CONTROL) then Result := Result + 'Ctrl+';
if (sMod = sMod or MOD_SHIFT)   then Result := Result + 'Shift+';
if (sMod = sMod or MOD_ALT)     then Result := Result + 'Alt+';

end;


{$ENDREGION}






{$REGION '  Key Down  '}



//------------------------------------------------------------------------------ Key Downly
function KeyDownly(Key: integer): Boolean;
{
вжата ли клавиша?
Ctrl  = VK_Control
Shift = VK_Shift
Alt   = VK_Menu
MouseRight = VK_RBUTTON
}
var
  State : TKeyboardState;

begin

GetKeyboardState(State);
Result := ( (State[Key] and 128) <> 0 );
//Result := HiWord(GetKeyState(Key)) <> 0 ;

end;



//------------------------------------------------------------------------------ Ctrl Down
function CtrlDown: Boolean;
//вжата ли клавиша Ctrl?
begin

Result := KeyDownly(VK_CONTROL);

end;



//------------------------------------------------------------------------------ Shift Down
function ShiftDown: Boolean;
//вжата ли клавиша Shift?
begin

Result := KeyDownly(VK_SHIFT);

end;



//------------------------------------------------------------------------------ Alt Down
function AltDown: Boolean;
//вжата ли клавиша Alt?
begin

Result := KeyDownly(VK_MENU);

end;



//------------------------------------------------------------------------------ Win Down
function WinDown: Boolean;
//вжата ли клавиша Win?
begin

Result := KeyDownly(VK_LWIN) or KeyDownly(VK_RWIN);

end;






//------------------------------------------------------------------------------ not CSA
function NoCSA: Boolean;
begin

Result := not CtrlDown
      and not ShiftDown
      and not AltDown;

end;





//------------------------------------------------------------------------------ Ctrl Only
function CtrlOnly: Boolean;
begin

Result := CtrlDown
  and not ShiftDown
  and not AltDown;

end;



//------------------------------------------------------------------------------ Shift Only
function ShiftOnly: Boolean;
begin

Result := ShiftDown
  and not CtrlDown
  and not AltDown;

end;



//------------------------------------------------------------------------------ Alt Only
function AltOnly: Boolean;
begin

Result := AltDown
  and not CtrlDown
  and not ShiftDown;

end;



//------------------------------------------------------------------------------ ModDown
function ModDown(AMods: string): Boolean;
begin

//if AMods = '' then begin
//  Result := not WinDown and not CtrlDown and not ShiftDown and not AltDown;
////  yy(AMOds);
//
//  exit;
//end;

Result := True;
AMods := AnsiLowerCase(AMods);

if (pos('c', AMods) = 0) = CtrlDown then begin
  Result := False;
  exit;
 end;


if (pos('s', AMods) = 0) = ShiftDown then begin
    Result := False;
    exit;
end;


if (pos('a', AMods) = 0) = AltDown then begin
  Result := False;
  exit;
end;


if (pos('w', AMods) = 0) = WinDown then begin
  Result := False;
  exit;
end;



//if pos('c', AMods) <> 0 then begin
//  if not CtrlDown then begin
//    Result := False;
//    exit;
//  end;
////  Result := True;
//end
//else begin
//   if CtrlDown then begin
//    Result := False;
//    exit;
//  end;
////  Result := True;
//end;
//
//
//
//if pos('s', AMods) <> 0 then begin
//  if not ShiftDown then begin
//    Result := False;
//    exit;
//  end;
////  Result := True;
//end
//else begin
//   if ShiftDown then begin
//    Result := False;
//    exit;
//  end;
////  Result := True;
//end;
//
//
//if pos('a', AMods) <> 0 then begin
//  if not AltDown then begin
//    Result := False;
//    exit;
//  end;
////  Result := True;
//end
//else begin
//   if AltDown then begin
//    Result := False;
//    exit;
//  end;
////  Result := True;
//end;
//
//
//if pos('w', AMods) <> 0 then begin
//  if not WinDown then begin
//    Result := False;
//    exit;
//  end;
////  Result := True;
//end
//else begin
//   if WinDown then begin
//    Result := False;
//    exit;
//  end;
////  Result := True;
//end;
//
//


end;


//------------------------------------------------------------------------------ KeyDownEmulate
procedure KeyDownEmulate(Component: TComponent;  Key: Word; Shift: TShiftState = []);
var k: word;
begin

//эмулируем нажатие клавиши чтоб всё сработало точно также как и в kuShellListView.pas
k := Key;
//LVS.KeyDown(k, []);

end;




{$ENDREGION}




end.
