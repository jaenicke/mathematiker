object Form1: TForm1
  Left = 192
  Top = 122
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Bernoulli-Zahlen'
  ClientHeight = 549
  ClientWidth = 914
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
    Left = 312
    Top = 508
    Width = 18
    Height = 16
    Caption = 'bis'
  end
  object Label2: TLabel
    Left = 160
    Top = 508
    Width = 65
    Height = 16
    Caption = 'Index von'
  end
  object Label3: TLabel
    Left = 440
    Top = 508
    Width = 7
    Height = 16
    Caption = '-'
  end
  object Label4: TLabel
    Left = 636
    Top = 508
    Width = 7
    Height = 16
    Caption = '-'
  end
  object Memo1: TMemo
    Left = 24
    Top = 16
    Width = 873
    Height = 473
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
  end
  object Button1: TButton
    Left = 24
    Top = 504
    Width = 113
    Height = 25
    Caption = 'Berechnung'
    Default = True
    TabOrder = 0
    OnClick = Button1Click
  end
  object Edit1: TEdit
    Left = 352
    Top = 504
    Width = 65
    Height = 24
    TabOrder = 3
    Text = '500'
  end
  object Edit2: TEdit
    Left = 240
    Top = 504
    Width = 57
    Height = 24
    TabOrder = 2
    Text = '500'
  end
end
