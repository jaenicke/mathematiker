object Form1: TForm1
  Left = 290
  Top = 223
  Width = 895
  Height = 487
  Caption = '196-Algorithmus'
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Verdana'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 16
  object Label1: TLabel
    Left = 16
    Top = 24
    Width = 28
    Height = 16
    Caption = 'Zahl'
  end
  object Label2: TLabel
    Left = 496
    Top = 24
    Width = 95
    Height = 16
    Caption = 'aktuelle Länge'
  end
  object Label3: TLabel
    Left = 152
    Top = 64
    Width = 5
    Height = 16
  end
  object Label4: TLabel
    Left = 608
    Top = 24
    Width = 7
    Height = 16
    Caption = '-'
  end
  object Label5: TLabel
    Left = 328
    Top = 24
    Width = 70
    Height = 16
    Caption = 'max.Länge'
  end
  object Label6: TLabel
    Left = 16
    Top = 424
    Width = 15
    Height = 16
    Caption = '...'
  end
  object Edit1: TEdit
    Left = 56
    Top = 20
    Width = 113
    Height = 24
    TabOrder = 0
    Text = '196'
  end
  object Button1: TButton
    Left = 720
    Top = 16
    Width = 145
    Height = 25
    Caption = 'Palindrom suchen'
    Default = True
    TabOrder = 1
    OnClick = Button1Click
  end
  object Memo1: TMemo
    Left = 16
    Top = 56
    Width = 849
    Height = 361
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
  end
  object CheckBox1: TCheckBox
    Left = 184
    Top = 24
    Width = 129
    Height = 17
    Caption = 'Glieder anzeigen'
    TabOrder = 3
  end
  object Edit2: TEdit
    Left = 408
    Top = 20
    Width = 73
    Height = 24
    TabOrder = 4
    Text = '10000'
  end
end
