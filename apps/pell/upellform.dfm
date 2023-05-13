object Form1: TForm1
  Left = 226
  Top = 117
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Pellsche Gleichung'
  ClientHeight = 511
  ClientWidth = 502
  Color = clWhite
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Verdana'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  PixelsPerInch = 96
  TextHeight = 14
  object Label1: TLabel
    Left = 24
    Top = 20
    Width = 26
    Height = 14
    Caption = 'D = '
  end
  object Edit1: TEdit
    Left = 72
    Top = 16
    Width = 121
    Height = 22
    TabOrder = 0
    Text = '1018879'
  end
  object ListBox1: TListBox
    Left = 16
    Top = 56
    Width = 473
    Height = 438
    IntegralHeight = True
    ItemHeight = 14
    TabOrder = 1
  end
  object Button1: TButton
    Left = 208
    Top = 16
    Width = 177
    Height = 25
    Caption = 'Berechnen'
    TabOrder = 2
    OnClick = Button1Click
  end
end
