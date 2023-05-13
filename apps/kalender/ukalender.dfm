object Form1: TForm1
  Left = 249
  Top = 117
  Width = 305
  Height = 262
  Caption = 'Kalender'
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
    Left = 88
    Top = 32
    Width = 23
    Height = 16
    Caption = 'Tag'
  end
  object Label2: TLabel
    Left = 80
    Top = 64
    Width = 41
    Height = 16
    Caption = 'Monat'
  end
  object Label3: TLabel
    Left = 88
    Top = 96
    Width = 27
    Height = 16
    Caption = 'Jahr'
  end
  object Label4: TLabel
    Left = 40
    Top = 184
    Width = 74
    Height = 16
    Caption = 'Wochentag'
  end
  object Edit1: TEdit
    Left = 128
    Top = 24
    Width = 121
    Height = 24
    TabOrder = 0
  end
  object Edit2: TEdit
    Left = 128
    Top = 56
    Width = 121
    Height = 24
    TabOrder = 1
  end
  object Edit3: TEdit
    Left = 128
    Top = 88
    Width = 121
    Height = 24
    TabOrder = 2
  end
  object Button1: TButton
    Left = 32
    Top = 136
    Width = 217
    Height = 25
    Caption = 'Berechnung'
    TabOrder = 3
    OnClick = Button1Click
  end
  object Edit4: TEdit
    Left = 128
    Top = 176
    Width = 121
    Height = 24
    TabOrder = 4
  end
end
