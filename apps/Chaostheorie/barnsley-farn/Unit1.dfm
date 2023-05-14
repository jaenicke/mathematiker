object Form1: TForm1
  Left = 192
  Top = 114
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Barnsley Farn'
  ClientHeight = 610
  ClientWidth = 589
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Verdana'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  OnActivate = FormActivate
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 16
  object PaintBox1: TPaintBox
    Left = 0
    Top = 0
    Width = 589
    Height = 561
    Align = alClient
    OnPaint = PaintBox1Paint
  end
  object Panel1: TPanel
    Left = 0
    Top = 561
    Width = 589
    Height = 49
    Align = alBottom
    Color = 15790320
    TabOrder = 0
    object Label1: TLabel
      Left = 160
      Top = 14
      Width = 45
      Height = 16
      Caption = 'Punkte'
    end
    object Button1: TButton
      Left = 16
      Top = 10
      Width = 121
      Height = 25
      Caption = 'Zeichnen'
      TabOrder = 0
      OnClick = PaintBox1Paint
    end
    object Edit1: TEdit
      Left = 219
      Top = 10
      Width = 113
      Height = 24
      TabOrder = 1
      Text = '100000'
    end
  end
end
