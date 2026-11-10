object FormHK: TFormHK
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Hot Key Editor'
  ClientHeight = 212
  ClientWidth = 578
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = True
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 18
  object btnAdd: TSpeedButton
    Left = 146
    Top = 160
    Width = 151
    Height = 33
    Cursor = crHandPoint
    Caption = 'Add'
    OnClick = btnAddClick
  end
  object btnDel: TSpeedButton
    Left = 328
    Top = 160
    Width = 151
    Height = 33
    Cursor = crHandPoint
    Caption = 'Delete'
    OnClick = btnDelClick
  end
  object chWin: TCheckBox
    Left = 18
    Top = 86
    Width = 55
    Height = 17
    Cursor = crHandPoint
    Caption = 'Win'
    TabOrder = 3
    OnClick = chWinClick
  end
  object chAlt: TCheckBox
    Left = 18
    Top = 63
    Width = 55
    Height = 17
    Cursor = crHandPoint
    Caption = 'Alt'
    TabOrder = 2
    OnClick = chAltClick
  end
  object chShift: TCheckBox
    Left = 18
    Top = 40
    Width = 55
    Height = 17
    Cursor = crHandPoint
    Caption = 'Shift'
    TabOrder = 1
    OnClick = chShiftClick
  end
  object chCtrl: TCheckBox
    Left = 18
    Top = 17
    Width = 55
    Height = 17
    Cursor = crHandPoint
    Caption = 'Ctrl'
    TabOrder = 0
    OnClick = chCtrlClick
  end
  object ComboBox1: TComboBox
    Left = 152
    Top = 16
    Width = 145
    Height = 26
    Cursor = crHandPoint
    Style = csDropDownList
    DropDownCount = 33
    ItemHeight = 18
    TabOrder = 4
    OnChange = ComboBox1Change
    OnKeyDown = ComboBox1KeyDown
    Items.Strings = (
      '0'
      '1'
      '2'
      '3'
      '4'
      '5'
      '6'
      '7'
      '8'
      '9'
      'A'
      'B'
      'C'
      'D'
      'E'
      'F'
      'G'
      'H'
      'I'
      'J'
      'K'
      'L'
      'M'
      'N'
      'O'
      'P'
      'Q'
      'R'
      'S'
      'T'
      'U'
      'V'
      'W'
      'X'
      'Y'
      'Z'
      'F1'
      'F2'
      'F3'
      'F4'
      'F5'
      'F6'
      'F7'
      'F8'
      'F9'
      'F10'
      'F11'
      'F12'
      'Space'
      'Tab'
      'Up'
      'Down'
      'Left'
      'Right'
      'Home'
      'End'
      'PgUp'
      'PgDn'
      'Ins'
      'Enter'
      'Del'
      'Backspace'
      'Esc'
      'Menu'
      'CapsLock'
      'PauseBreak'
      'PrintScreen'
      'ScrollLock'
      '~'
      '-'
      '='
      '['
      ']'
      '<'
      '>'
      ';'
      #39
      '/'
      '\'
      'Num 0'
      'Num 1'
      'Num 2'
      'Num 3'
      'Num 4'
      'Num 5'
      'Num 6'
      'Num 7'
      'Num 8'
      'Num 9'
      'Num +'
      'Num -'
      'Num *'
      'Num /'
      'Num .')
  end
  object Edit1: TEdit
    Left = 18
    Top = 128
    Width = 279
    Height = 26
    AutoSelect = False
    Color = 15268093
    ReadOnly = True
    TabOrder = 5
    OnKeyDown = Edit1KeyDown
    OnKeyPress = Edit1KeyPress
    OnKeyUp = Edit1KeyUp
  end
  object ListBox1: TListBox
    Left = 328
    Top = 16
    Width = 233
    Height = 138
    ItemHeight = 18
    MultiSelect = True
    TabOrder = 6
  end
end
