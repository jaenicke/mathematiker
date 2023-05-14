object Form1: TForm1
  Left = 192
  Top = 122
  Width = 378
  Height = 500
  Caption = 'Ägyptische Zerlegung'
  Color = clWhite
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Verdana'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 16
  object Label1: TLabel
    Left = 24
    Top = 20
    Width = 33
    Height = 16
    Caption = 'Zahl '
  end
  object Label2: TLabel
    Left = 152
    Top = 12
    Width = 55
    Height = 16
    Caption = 'Partition'
  end
  object Label3: TLabel
    Left = 152
    Top = 30
    Width = 26
    Height = 16
    Caption = 'Zeit'
  end
  object Button1: TButton
    Left = 240
    Top = 16
    Width = 105
    Height = 25
    Caption = 'Berechnung'
    TabOrder = 0
    OnClick = Button1Click
  end
  object ListBox1: TListBox
    Left = 16
    Top = 56
    Width = 329
    Height = 377
    ItemHeight = 16
    TabOrder = 1
  end
  object Edit1: TEdit
    Left = 64
    Top = 16
    Width = 65
    Height = 24
    TabOrder = 2
    Text = '80'
  end
  object CheckBox1: TCheckBox
    Left = 16
    Top = 440
    Width = 185
    Height = 17
    Caption = 'nur strenge Zerlegungen'
    Checked = True
    State = cbChecked
    TabOrder = 3
  end
end
