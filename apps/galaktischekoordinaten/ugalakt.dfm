object Form1: TForm1
  Left = 365
  Top = 110
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Galaktische Koordinaten'
  ClientHeight = 573
  ClientWidth = 671
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
    Top = 24
    Width = 94
    Height = 16
    Caption = 'geograf.Länge'
  end
  object Label2: TLabel
    Left = 24
    Top = 56
    Width = 93
    Height = 16
    Caption = 'geograf.Breite'
  end
  object Label3: TLabel
    Left = 24
    Top = 128
    Width = 87
    Height = 16
    Caption = 'Datum    Tag'
  end
  object Label4: TLabel
    Left = 72
    Top = 160
    Width = 41
    Height = 16
    Caption = 'Monat'
  end
  object Label5: TLabel
    Left = 88
    Top = 192
    Width = 27
    Height = 16
    Caption = 'Jahr'
  end
  object Label6: TLabel
    Left = 24
    Top = 232
    Width = 93
    Height = 16
    Caption = 'UT    Stunden'
  end
  object Label7: TLabel
    Left = 64
    Top = 264
    Width = 52
    Height = 16
    Caption = 'Minuten'
  end
  object Label8: TLabel
    Left = 56
    Top = 296
    Width = 64
    Height = 16
    Caption = 'Sekunden'
  end
  object Label9: TLabel
    Left = 24
    Top = 88
    Width = 90
    Height = 16
    Caption = 'Höhe über NN'
  end
  object Edit1: TEdit
    Left = 128
    Top = 20
    Width = 121
    Height = 24
    TabOrder = 0
    Text = '12,97'
  end
  object Edit2: TEdit
    Left = 128
    Top = 52
    Width = 121
    Height = 24
    TabOrder = 1
    Text = '50,98'
  end
  object Edit3: TEdit
    Left = 128
    Top = 124
    Width = 121
    Height = 24
    TabOrder = 2
    Text = '20'
  end
  object Edit4: TEdit
    Left = 128
    Top = 156
    Width = 121
    Height = 24
    TabOrder = 3
    Text = '20'
  end
  object Edit5: TEdit
    Left = 128
    Top = 188
    Width = 121
    Height = 24
    TabOrder = 4
    Text = '20'
  end
  object Edit6: TEdit
    Left = 128
    Top = 228
    Width = 121
    Height = 24
    TabOrder = 5
    Text = '20'
  end
  object Edit7: TEdit
    Left = 128
    Top = 260
    Width = 121
    Height = 24
    TabOrder = 6
    Text = '20'
  end
  object Edit8: TEdit
    Left = 128
    Top = 292
    Width = 121
    Height = 24
    TabOrder = 7
    Text = '20'
  end
  object Button1: TButton
    Left = 128
    Top = 400
    Width = 121
    Height = 25
    Caption = 'Berechnung'
    TabOrder = 8
    OnClick = Button1Click
  end
  object Memo1: TMemo
    Left = 272
    Top = 20
    Width = 385
    Height = 541
    ScrollBars = ssVertical
    TabOrder = 9
  end
  object CheckBox1: TCheckBox
    Left = 128
    Top = 336
    Width = 121
    Height = 17
    Caption = 'Aktualisieren'
    TabOrder = 10
    OnClick = CheckBox1Click
  end
  object CheckBox2: TCheckBox
    Left = 128
    Top = 360
    Width = 97
    Height = 17
    Caption = 'Kronos'
    TabOrder = 11
  end
  object Edit9: TEdit
    Left = 128
    Top = 84
    Width = 121
    Height = 24
    TabOrder = 12
    Text = '290'
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 500
    OnTimer = Timer1Timer
    Left = 16
    Top = 360
  end
end
