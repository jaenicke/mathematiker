object Form1: TForm1
  Left = 166
  Top = 90
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Einsame Primzahl , lonely primes'
  ClientHeight = 526
  ClientWidth = 644
  Color = clWhite
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Verdana'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 16
  object Label1: TLabel
    Left = 384
    Top = 16
    Width = 34
    Height = 16
    Caption = 'Start'
  end
  object Label3: TLabel
    Left = 16
    Top = 16
    Width = 56
    Height = 16
    Caption = 'Testzahl'
  end
  object Label4: TLabel
    Left = 544
    Top = 16
    Width = 15
    Height = 16
    Caption = '...'
  end
  object Label2: TLabel
    Left = 80
    Top = 16
    Width = 15
    Height = 16
    Caption = '...'
  end
  object Label5: TLabel
    Left = 312
    Top = 492
    Width = 48
    Height = 16
    Caption = 'offen ='
  end
  object Label6: TLabel
    Left = 392
    Top = 492
    Width = 36
    Height = 16
    Caption = 'min ='
  end
  object Label7: TLabel
    Left = 288
    Top = 16
    Width = 15
    Height = 16
    Caption = '...'
  end
  object Label8: TLabel
    Left = 208
    Top = 16
    Width = 70
    Height = 16
    Caption = 'max Primz.'
  end
  object Label9: TLabel
    Left = 496
    Top = 492
    Width = 52
    Height = 16
    Caption = 'lonely ='
  end
  object Button1: TButton
    Left = 160
    Top = 488
    Width = 120
    Height = 25
    Caption = 'Suche'
    Default = True
    TabOrder = 0
    OnClick = Button1Click
  end
  object ListBox1: TListBox
    Left = 16
    Top = 40
    Width = 617
    Height = 244
    IntegralHeight = True
    ItemHeight = 16
    Sorted = True
    TabOrder = 1
    TabWidth = 70
  end
  object CheckBox1: TCheckBox
    Left = 24
    Top = 492
    Width = 121
    Height = 17
    Caption = 'Weiterrechnen'
    Checked = True
    State = cbChecked
    TabOrder = 2
  end
  object ListBox2: TListBox
    Left = 16
    Top = 296
    Width = 617
    Height = 180
    IntegralHeight = True
    ItemHeight = 16
    Sorted = True
    TabOrder = 3
    TabWidth = 70
  end
end
