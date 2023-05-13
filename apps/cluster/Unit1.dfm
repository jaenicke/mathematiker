object Cluster: TCluster
  Left = 419
  Top = 86
  Width = 665
  Height = 653
  Caption = 'Clusterbildung'
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
  object Paintbox1: TPaintBox
    Left = 0
    Top = 0
    Width = 649
    Height = 614
    Align = alClient
  end
  object Button1: TButton
    Left = 8
    Top = 12
    Width = 81
    Height = 25
    Caption = 'Zeichnen'
    TabOrder = 0
    OnClick = Button1Click
  end
  object SpinEdit1: TSpinEdit
    Left = 16
    Top = 48
    Width = 57
    Height = 23
    MaxValue = 10
    MinValue = 0
    TabOrder = 1
    Value = 0
  end
end
