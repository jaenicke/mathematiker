object Form1: TForm1
  Left = 471
  Top = 180
  BorderStyle = bsSingle
  Caption = 'Geldwechsel'
  ClientHeight = 524
  ClientWidth = 726
  Color = clWhite
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Verdana'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 16
  object Label1: TLabel
    Left = 16
    Top = 20
    Width = 50
    Height = 16
    Caption = 'M'#252'nzen'
  end
  object Label2: TLabel
    Left = 16
    Top = 56
    Width = 43
    Height = 16
    Caption = 'Betrag'
  end
  object Label3: TLabel
    Left = 272
    Top = 56
    Width = 89
    Height = 16
    Caption = 'M'#246'glichkeiten'
  end
  object Edit1: TEdit
    Left = 80
    Top = 16
    Width = 625
    Height = 24
    TabOrder = 0
    Text = '50,25,10,5,1'
  end
  object Edit2: TEdit
    Left = 80
    Top = 52
    Width = 73
    Height = 24
    TabOrder = 1
    Text = '100'
  end
  object Button1: TButton
    Left = 544
    Top = 52
    Width = 161
    Height = 25
    Caption = 'Geld wechseln'
    TabOrder = 2
    OnClick = Button1Click
  end
  object ListBox1: TListBox
    Left = 16
    Top = 96
    Width = 689
    Height = 409
    ItemHeight = 16
    TabOrder = 3
  end
end
