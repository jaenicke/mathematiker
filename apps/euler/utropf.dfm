object Form1: TForm1
  Left = 268
  Top = 90
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Tröpfchenalgorithmus für e'
  ClientHeight = 646
  ClientWidth = 917
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Verdana'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  PixelsPerInch = 96
  TextHeight = 16
  object Label1: TLabel
    Left = 24
    Top = 24
    Width = 43
    Height = 16
    Caption = 'Ziffern'
  end
  object Label2: TLabel
    Left = 408
    Top = 24
    Width = 37
    Height = 16
    Caption = 'Zeit: '
  end
  object Edit1: TEdit
    Left = 80
    Top = 20
    Width = 121
    Height = 24
    TabOrder = 0
    Text = '10000'
  end
  object Memo1: TMemo
    Left = 16
    Top = 56
    Width = 881
    Height = 569
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 1
  end
  object Button1: TButton
    Left = 216
    Top = 20
    Width = 161
    Height = 25
    Caption = 'Berechnung'
    TabOrder = 2
    OnClick = Button1Click
  end
end
