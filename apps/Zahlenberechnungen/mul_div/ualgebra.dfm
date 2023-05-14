object Falgebra: TFalgebra
  Left = 185
  Top = 75
  HelpContext = 106
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Schriftliche Multiplikation und Division'
  ClientHeight = 690
  ClientWidth = 1022
  Color = 15790320
  Font.Charset = ANSI_CHARSET
  Font.Color = clBlack
  Font.Height = -12
  Font.Name = 'Verdana'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  OnShow = RG1Click
  PixelsPerInch = 96
  TextHeight = 14
  object P7: TPanel
    Left = 0
    Top = 0
    Width = 1022
    Height = 690
    Align = alClient
    BevelOuter = bvNone
    Color = clWhite
    TabOrder = 0
    object gleichungx: TPanel
      Left = 0
      Top = 0
      Width = 1022
      Height = 690
      Align = alClient
      BevelOuter = bvNone
      Color = clWhite
      TabOrder = 0
      object schrimul: TPanel
        Left = 0
        Top = 0
        Width = 1022
        Height = 690
        Align = alClient
        BevelOuter = bvNone
        Color = clWhite
        TabOrder = 0
        object PB8: TPaintBox
          Left = 0
          Top = 81
          Width = 1022
          Height = 609
          Align = alClient
          OnPaint = PB8P
        end
        object P33: TPanel
          Left = 0
          Top = 0
          Width = 1022
          Height = 81
          Align = alTop
          BevelOuter = bvNone
          Color = 15790320
          TabOrder = 0
          object L41: TLabel
            Left = 24
            Top = 16
            Width = 265
            Height = 14
            Caption = 'Schriftliche Multiplikation zweier Zahlen'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -12
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object L17: TLabel
            Left = 24
            Top = 48
            Width = 52
            Height = 14
            Caption = 'Zahl 1 ='
          end
          object L20: TLabel
            Left = 240
            Top = 48
            Width = 52
            Height = 14
            Caption = 'Zahl 2 ='
          end
          object K13: TLabel
            Left = 448
            Top = 48
            Width = 265
            Height = 14
            Caption = 'Zahlen dürfen maximal 9 Stellen besitzen!'
          end
          object E57: TEdit
            Left = 88
            Top = 44
            Width = 121
            Height = 22
            TabOrder = 0
            Text = '145,8'
            OnChange = PB8P
          end
          object E58: TEdit
            Left = 304
            Top = 44
            Width = 121
            Height = 22
            TabOrder = 1
            Text = '14,03'
            OnChange = PB8P
          end
          object RG1: TRadioGroup
            Left = 776
            Top = 12
            Width = 137
            Height = 57
            ItemIndex = 0
            Items.Strings = (
              'Multiplikation'
              'Division')
            TabOrder = 2
            OnClick = RG1Click
          end
        end
      end
    end
  end
end
