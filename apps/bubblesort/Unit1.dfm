object Form1: TForm1
  Left = 268
  Top = 109
  Width = 633
  Height = 463
  Caption = 'Bubblesort'
  Color = clWhite
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Verdana'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 16
  object lblUnsort: TLabel
    Left = 8
    Top = 8
    Width = 127
    Height = 16
    Caption = 'unsortierte Zahlen:'
  end
  object lblSort: TLabel
    Left = 8
    Top = 216
    Width = 111
    Height = 16
    Caption = 'sortierte Zahlen:'
  end
  object lblTime: TLabel
    Left = 408
    Top = 344
    Width = 74
    Height = 16
    Caption = 'Sortierzeit:'
  end
  object lblExchange: TLabel
    Left = 408
    Top = 392
    Width = 130
    Height = 16
    Caption = 'Tauschoperationen:'
  end
  object lblCompare: TLabel
    Left = 408
    Top = 368
    Width = 150
    Height = 16
    Caption = 'Vergleichsoperationen:'
  end
  object memUnsort: TMemo
    Left = 8
    Top = 24
    Width = 377
    Height = 177
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object memSort: TMemo
    Left = 8
    Top = 232
    Width = 377
    Height = 177
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 1
  end
  object btnCreate: TButton
    Left = 424
    Top = 24
    Width = 160
    Height = 33
    Caption = 'Zahlen erzeugen'
    TabOrder = 2
    OnClick = CreateNumbers
  end
  object btnSort: TButton
    Left = 424
    Top = 72
    Width = 160
    Height = 33
    Caption = 'Zahlen sortieren'
    Enabled = False
    TabOrder = 3
    OnClick = Sort
  end
end
