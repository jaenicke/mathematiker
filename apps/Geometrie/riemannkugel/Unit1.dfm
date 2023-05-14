object Form1: TForm1
  Left = 224
  Top = 153
  BorderStyle = bsSingle
  Caption = 'Kugelspiegelung'
  ClientHeight = 562
  ClientWidth = 1017
  Color = clWhite
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Verdana'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 16
  object PaintBox1: TPaintBox
    Left = 520
    Top = 24
    Width = 481
    Height = 481
  end
  object Label1: TLabel
    Left = 528
    Top = 524
    Width = 233
    Height = 16
    Caption = 'waagerecht                  senkrecht'
  end
  object Image1: TImage
    Left = 24
    Top = 24
    Width = 480
    Height = 480
  end
  object Button1: TButton
    Left = 920
    Top = 520
    Width = 75
    Height = 25
    Caption = 'Start'
    Default = True
    TabOrder = 0
    OnClick = Button1Click
  end
  object SpinEdit1: TSpinEdit
    Left = 616
    Top = 520
    Width = 65
    Height = 26
    Increment = 20
    MaxValue = 1200
    MinValue = 600
    TabOrder = 1
    Value = 760
  end
  object SpinEdit2: TSpinEdit
    Left = 776
    Top = 520
    Width = 65
    Height = 26
    Increment = 20
    MaxValue = 1200
    MinValue = 600
    TabOrder = 2
    Value = 1080
  end
  object ComboBox1: TComboBox
    Left = 24
    Top = 520
    Width = 297
    Height = 24
    ItemHeight = 16
    TabOrder = 3
    Text = 'spirale'
    Items.Strings = (
      'palm'
      'sun'
      'spirale'
      'stonehenge')
  end
end
