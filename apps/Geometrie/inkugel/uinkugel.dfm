object FInkugel: TFInkugel
  Left = 432
  Top = 58
  HelpContext = 901
  BorderStyle = bsSingle
  Caption = 'In- und Umkugel von Polyedern'
  ClientHeight = 663
  ClientWidth = 874
  Color = 15790320
  Font.Charset = ANSI_CHARSET
  Font.Color = clBlack
  Font.Height = -12
  Font.Name = 'Verdana'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 14
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 874
    Height = 663
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object Panel2: TPanel
      Left = 634
      Top = 0
      Width = 240
      Height = 663
      Align = alRight
      BevelOuter = bvNone
      Color = 15790320
      TabOrder = 0
      object Panel4: TPanel
        Left = 0
        Top = 0
        Width = 240
        Height = 663
        Align = alClient
        BevelOuter = bvNone
        Color = 15790320
        TabOrder = 0
        object Label1: TLabel
          Left = 38
          Top = 536
          Width = 82
          Height = 14
          Caption = 'x-Drehwinkel'
        end
        object Label2: TLabel
          Left = 38
          Top = 568
          Width = 82
          Height = 14
          Caption = 'y-Drehwinkel'
        end
        object Label3: TLabel
          Left = 38
          Top = 600
          Width = 82
          Height = 14
          Caption = 'z-Drehwinkel'
        end
        object Speed2: TSpeedButton
          Left = 147
          Top = 498
          Width = 23
          Height = 24
          Flat = True
          Glyph.Data = {
            66010000424D6601000000000000760000002800000014000000140000000100
            040000000000F000000000000000000000001000000000000000000000000000
            80000080000000808000800000008000800080800000C0C0C000808080000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
            FFFFFFFF0000F0000FFFFFFFFFF0000F0000F00FFFFFFFFFFFFFF00F0000F0F0
            FFFFFFFFFFFF0F0F0000F0FF0FFFFFFFFFF0FF0F0000FFFFF0FFFFFFFF0FFFFF
            0000FFFFFF0FFFFFF0FFFFFF0000FFFFFFF0FFFF0FFFFFFF0000FFFFFFFF0FF0
            FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
            FFFF0FF0FFFFFFFF0000FFFFFFF0FFFF0FFFFFFF0000FFFFFF0FFFFFF0FFFFFF
            0000FFFFF0FFFFFFFF0FFFFF0000F0FF0FFFFFFFFFF0FF0F0000F0F0FFFFFFFF
            FFFF0F0F0000F00FFFFFFFFFFFFFF00F0000F0000FFFFFFFFF00000F0000FFFF
            FFFFFFFFFFFFFFFF0000}
          OnClick = S8C
        end
        object Speed3: TSpeedButton
          Left = 177
          Top = 498
          Width = 23
          Height = 24
          Flat = True
          Glyph.Data = {
            66010000424D6601000000000000760000002800000014000000140000000100
            040000000000F000000000000000000000001000000000000000000000000000
            80000080000000808000800000008000800080800000C0C0C000808080000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
            FFFFFFFF0000F0FFFFFFFFFFFFFFFF0F0000FF0FFFFFFFFFFFFFF0FF0000FFF0
            FFFFFFFFFFFF0FFF0000FFFF0FF0FFFF0FF0FFFF0000FFFFF0F0FFFF0F0FFFFF
            0000FFFFFF00FFFF00FFFFFF0000FFFF0000FFFF0000FFFF0000FFFFFFFFFFFF
            FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
            FFFFFFFFFFFFFFFF0000FFFF0000FFFF0000FFFF0000FFFFFF00FFFF00FFFFFF
            0000FFFFF0F0FFFF0F0FFFFF0000FFFF0FF0FFFF0FF0FFFF0000FFF0FFFFFFFF
            FFFF0FFF0000FF0FFFFFFFFFFFFFF0FF0000F0FFFFFFFFFFFFFFFF0F0000FFFF
            FFFFFFFFFFFFFFFF0000}
          OnClick = S8C
        end
        object Button1: TButton
          Left = 136
          Top = 466
          Width = 89
          Height = 25
          Caption = 'Rotation'
          TabOrder = 5
          OnClick = B2C
        end
        object CPunkte: TCheckBox
          Left = 40
          Top = 626
          Width = 146
          Height = 17
          Caption = 'Punkte markieren'
          TabOrder = 3
          OnClick = CB1C
        end
        object Listbox1: TListBox
          Left = 16
          Top = 16
          Width = 209
          Height = 438
          Color = clWhite
          IntegralHeight = True
          ItemHeight = 14
          TabOrder = 4
          TabWidth = 200
          OnClick = LB1C
        end
        object RadioB2: TRadioButton
          Left = 24
          Top = 488
          Width = 113
          Height = 17
          Caption = 'Inkugel'
          TabOrder = 1
          OnClick = zeichnen
        end
        object RadioB3: TRadioButton
          Left = 24
          Top = 504
          Width = 113
          Height = 17
          Caption = 'Umkugel'
          TabOrder = 2
          OnClick = zeichnen
        end
        object RadioB1: TRadioButton
          Left = 24
          Top = 472
          Width = 113
          Height = 17
          Caption = 'Polyeder'
          Checked = True
          TabOrder = 0
          TabStop = True
          OnClick = zeichnen
        end
        object SpinEdit1: TSpinEdit
          Left = 136
          Top = 532
          Width = 57
          Height = 23
          MaxValue = 15
          MinValue = -15
          TabOrder = 6
          Value = 1
          OnChange = t6C
        end
        object SpinEdit2: TSpinEdit
          Left = 136
          Top = 564
          Width = 57
          Height = 23
          MaxValue = 15
          MinValue = -15
          TabOrder = 7
          Value = 0
          OnChange = t6C
        end
        object SpinEdit3: TSpinEdit
          Left = 136
          Top = 596
          Width = 57
          Height = 23
          MaxValue = 15
          MinValue = -15
          TabOrder = 8
          Value = 2
          OnChange = t6C
        end
      end
    end
    object Panel3: TPanel
      Left = 0
      Top = 0
      Width = 634
      Height = 663
      Align = alClient
      BevelOuter = bvNone
      Color = clWhite
      TabOrder = 1
      object Panel5: TPanel
        Left = 0
        Top = 0
        Width = 634
        Height = 663
        Align = alClient
        BevelOuter = bvNone
        Color = clWhite
        TabOrder = 0
        object PB1: TPaintBox
          Left = 0
          Top = 0
          Width = 634
          Height = 663
          Align = alClient
          OnMouseDown = PB1MD
          OnMouseMove = PB1MM
          OnMouseUp = PB1MU
          OnPaint = B1C
        end
      end
    end
  end
  object Timer1: TTimer
    Interval = 0
    OnTimer = T1Tim
    Left = 88
    Top = 38
  end
end
