object Form1: TForm1
  Left = 339
  Top = 182
  Width = 870
  Height = 640
  Caption = 'Ameisensimulation'
  Color = clWhite
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Verdana'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  object PaintBox1: TPaintBox
    Left = 153
    Top = 0
    Width = 701
    Height = 601
    Align = alClient
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 153
    Height = 601
    Align = alLeft
    ParentBackground = False
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 20
      Width = 54
      Height = 16
      Caption = 'Ameisen'
    end
    object Button1: TButton
      Left = 12
      Top = 56
      Width = 126
      Height = 25
      Caption = 'Darstellung'
      TabOrder = 0
      OnClick = Button1Click
    end
    object SpinEdit1: TSpinEdit
      Left = 88
      Top = 16
      Width = 49
      Height = 26
      MaxValue = 12
      MinValue = 1
      TabOrder = 1
      Value = 1
    end
  end
end
