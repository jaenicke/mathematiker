object Form1: TForm1
  Left = 290
  Top = 223
  BorderStyle = bsSingle
  Caption = 'Teilersummenfolge'
  ClientHeight = 419
  ClientWidth = 760
  Color = clWhite
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
    Left = 680
    Top = 22
    Width = 7
    Height = 16
    Caption = '-'
  end
  object Label3: TLabel
    Left = 600
    Top = 22
    Width = 73
    Height = 16
    Caption = 'Iterationen'
  end
  object Label4: TLabel
    Left = 464
    Top = 22
    Width = 44
    Height = 16
    Caption = 'Glieder'
  end
  object Edit1: TEdit
    Left = 72
    Top = 20
    Width = 65
    Height = 24
    TabOrder = 0
    Text = '276'
  end
  object Button1: TButton
    Left = 152
    Top = 18
    Width = 147
    Height = 25
    Caption = 'Folge berechnen'
    Default = True
    TabOrder = 1
    OnClick = Button1Click
  end
  object CheckBox1: TCheckBox
    Left = 312
    Top = 22
    Width = 65
    Height = 17
    Caption = 'Teiler'
    TabOrder = 2
  end
  object Memo1: TMemo
    Left = 16
    Top = 56
    Width = 729
    Height = 345
    TabOrder = 3
  end
  object Edit2: TEdit
    Left = 400
    Top = 20
    Width = 49
    Height = 24
    TabOrder = 4
    Text = '120'
  end
end
