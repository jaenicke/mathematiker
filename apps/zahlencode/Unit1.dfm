object Form1: TForm1
  Left = 199
  Top = 92
  Width = 394
  Height = 282
  Caption = 'Deutsches Zahlenalphabet'
  Color = clWhite
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Verdana'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 16
  object Label1: TLabel
    Left = 24
    Top = 208
    Width = 78
    Height = 16
    Caption = 'Auswertung'
  end
  object ListBox1: TListBox
    Left = 24
    Top = 24
    Width = 161
    Height = 169
    ItemHeight = 16
    Items.Strings = (
      'Fabian'
      'Julia'
      'Laura'
      'Obelix'
      'Roshan'
      'Thomas')
    Sorted = True
    TabOrder = 0
    OnClick = ListBox1Click
  end
  object Button1: TButton
    Left = 208
    Top = 72
    Width = 153
    Height = 25
    Caption = 'String aufnehmen'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Edit1: TEdit
    Left = 208
    Top = 32
    Width = 153
    Height = 24
    TabOrder = 2
    Text = 'Sandra'
  end
  object Button2: TButton
    Left = 208
    Top = 112
    Width = 153
    Height = 25
    Caption = 'Daten lesen'
    TabOrder = 3
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 208
    Top = 152
    Width = 153
    Height = 25
    Caption = 'Daten schreiben'
    TabOrder = 4
    OnClick = Button3Click
  end
end
