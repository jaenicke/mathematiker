object Form1: TForm1
  Left = 297
  Top = 117
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Mandelbrotmenge'
  ClientHeight = 627
  ClientWidth = 894
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
  object PaintBox1: TPaintBox
    Left = 0
    Top = 0
    Width = 894
    Height = 576
    Align = alClient
  end
  object Panel1: TPanel
    Left = 0
    Top = 576
    Width = 894
    Height = 51
    Align = alBottom
    BevelOuter = bvNone
    Color = 15790320
    TabOrder = 0
    object Label1: TLabel
      Left = 608
      Top = 16
      Width = 71
      Height = 14
      Caption = 'Iterationen'
    end
    object Button1: TButton
      Left = 784
      Top = 12
      Width = 97
      Height = 25
      Caption = 'Zeichnen'
      Default = True
      TabOrder = 0
      OnClick = Button1Click
    end
    object Edit1: TEdit
      Left = 688
      Top = 12
      Width = 81
      Height = 22
      TabOrder = 1
      Text = '240'
    end
  end
end
