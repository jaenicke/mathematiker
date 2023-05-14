object Form1: TForm1
  Left = 238
  Top = 118
  BorderStyle = bsSingle
  Caption = 'Quicksort'
  ClientHeight = 423
  ClientWidth = 571
  Color = clWhite
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Verdana'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 14
  object lblUnsort: TLabel
    Left = 8
    Top = 8
    Width = 122
    Height = 14
    Caption = 'unsortierte Zahlen:'
  end
  object lblSort: TLabel
    Left = 8
    Top = 216
    Width = 106
    Height = 14
    Caption = 'sortierte Zahlen:'
  end
  object lblTime: TLabel
    Left = 408
    Top = 392
    Width = 70
    Height = 14
    Caption = 'Sortierzeit:'
  end
  object lblSize: TLabel
    Left = 448
    Top = 28
    Width = 67
    Height = 14
    Caption = 'Feldgr'#246#223'e:'
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
    Left = 416
    Top = 176
    Width = 129
    Height = 33
    Caption = 'Zahlen erzeugen'
    TabOrder = 2
    OnClick = CreateNumbers
  end
  object btnSort: TButton
    Left = 416
    Top = 224
    Width = 129
    Height = 33
    Caption = 'Zahlen sortieren'
    Enabled = False
    TabOrder = 3
    OnClick = Sort
  end
  object edtSize: TEdit
    Left = 440
    Top = 56
    Width = 81
    Height = 22
    TabOrder = 4
    Text = '1000'
    OnChange = GetSize
  end
end
