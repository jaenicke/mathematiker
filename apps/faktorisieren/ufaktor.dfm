object Form1: TForm1
  Left = 290
  Top = 223
  Width = 457
  Height = 500
  Caption = 'Faktorisieren einer Zahl'
  Color = clBtnFace
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
    Left = 24
    Top = 24
    Width = 28
    Height = 16
    Caption = 'Zahl'
  end
  object Label2: TLabel
    Left = 24
    Top = 64
    Width = 26
    Height = 16
    Caption = 'Zeit'
  end
  object Label3: TLabel
    Left = 152
    Top = 64
    Width = 5
    Height = 16
  end
  object Label4: TLabel
    Left = 72
    Top = 64
    Width = 5
    Height = 16
  end
  object Edit1: TEdit
    Left = 72
    Top = 20
    Width = 345
    Height = 24
    TabOrder = 0
    Text = '111111111111111111111111111111111'
  end
  object Button1: TButton
    Left = 312
    Top = 56
    Width = 105
    Height = 25
    Caption = 'Faktorisieren'
    Default = True
    TabOrder = 1
    OnClick = Button1Click
  end
  object Memo1: TMemo
    Left = 16
    Top = 96
    Width = 409
    Height = 353
    TabOrder = 2
  end
end
