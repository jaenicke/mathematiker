object FLsystem: TFLsystem
  Left = 350
  Top = 91
  HelpContext = 22001
  BorderStyle = bsSingle
  Caption = 'L-System'
  ClientHeight = 713
  ClientWidth = 966
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clBlack
  Font.Height = -12
  Font.Name = 'Verdana'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  OnDestroy = FormDestroy
  OnShow = Formshow
  PixelsPerInch = 96
  TextHeight = 14
  object lsystem: TPanel
    Left = 0
    Top = 0
    Width = 966
    Height = 713
    Align = alClient
    BevelOuter = bvNone
    Color = clWhite
    TabOrder = 0
    object PBox: TPaintBox
      Left = 209
      Top = 0
      Width = 757
      Height = 713
      Align = alClient
    end
    object Panel1: TPanel
      Left = 0
      Top = 0
      Width = 209
      Height = 713
      Align = alLeft
      BevelOuter = bvNone
      Color = 15790320
      TabOrder = 0
      object Label2: TLabel
        Left = 16
        Top = 16
        Width = 84
        Height = 14
        Caption = 'Regelsystem'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -12
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label3: TLabel
        Left = 16
        Top = 48
        Width = 36
        Height = 14
        Caption = 'Name'
      end
      object Label5: TLabel
        Left = 16
        Top = 284
        Width = 71
        Height = 14
        Caption = 'Iterationen'
      end
      object Label6: TLabel
        Left = 16
        Top = 308
        Width = 42
        Height = 14
        Caption = 'Winkel'
      end
      object Label4: TLabel
        Left = 16
        Top = 72
        Width = 37
        Height = 14
        Caption = 'Axiom'
      end
      object Label8: TLabel
        Left = 104
        Top = 332
        Width = 12
        Height = 14
        Caption = '...'
      end
      object Label7: TLabel
        Left = 16
        Top = 332
        Width = 79
        Height = 14
        Caption = 'Kurvenl'#228'nge'
      end
      object Label9: TLabel
        Left = 16
        Top = 456
        Width = 129
        Height = 14
        Caption = 'L-System-Beispiele'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -12
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label1: TLabel
        Left = 189
        Top = 664
        Width = 5
        Height = 14
        Alignment = taRightJustify
        Caption = '-'
      end
      object Button1: TButton
        Left = 24
        Top = 376
        Width = 161
        Height = 25
        Caption = 'Darstellung'
        Default = True
        TabOrder = 11
        OnClick = B1Darst
      end
      object Button3: TButton
        Left = 96
        Top = 624
        Width = 97
        Height = 25
        Caption = 'Speichern'
        TabOrder = 12
        TabStop = False
        OnClick = B3Spei
      end
      object Button2: TButton
        Left = 16
        Top = 624
        Width = 65
        Height = 25
        Caption = 'L'#246'schen'
        TabOrder = 13
        TabStop = False
        OnClick = B2Loesch
      end
      object eaxiom: TEdit
        Left = 72
        Top = 68
        Width = 126
        Height = 22
        CharCase = ecUpperCase
        TabOrder = 0
      end
      object SG3: TStringGrid
        Left = 16
        Top = 96
        Width = 25
        Height = 171
        TabStop = False
        BorderStyle = bsNone
        Color = 15790320
        ColCount = 1
        DefaultColWidth = 88
        DefaultRowHeight = 18
        Enabled = False
        FixedColor = 15790320
        FixedCols = 0
        RowCount = 9
        FixedRows = 0
        Options = [goHorzLine]
        ScrollBars = ssNone
        TabOrder = 2
      end
      object SG2: TStringGrid
        Left = 48
        Top = 96
        Width = 150
        Height = 171
        BorderStyle = bsNone
        Color = clWhite
        ColCount = 1
        DefaultColWidth = 150
        DefaultRowHeight = 18
        FixedColor = clWhite
        FixedCols = 0
        RowCount = 9
        FixedRows = 0
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
        ScrollBars = ssNone
        TabOrder = 1
      end
      object CB2: TCheckBox
        Left = 24
        Top = 408
        Width = 161
        Height = 17
        Caption = 'farbiges Axiom'
        TabOrder = 3
      end
      object LBox: TListBox
        Left = 16
        Top = 480
        Width = 182
        Height = 130
        Color = clWhite
        IntegralHeight = True
        ItemHeight = 14
        Sorted = True
        TabOrder = 4
        OnClick = LBClick
      end
      object ewinkel: TEdit
        Left = 104
        Top = 304
        Width = 89
        Height = 22
        TabOrder = 5
      end
      object ename: TEdit
        Left = 72
        Top = 44
        Width = 126
        Height = 22
        TabOrder = 6
      end
      object R1: TRadioButton
        Left = 16
        Top = 352
        Width = 73
        Height = 17
        Caption = '1 Stufe'
        Checked = True
        TabOrder = 7
        TabStop = True
      end
      object R2: TRadioButton
        Left = 104
        Top = 352
        Width = 113
        Height = 17
        Caption = '4 Stufen'
        TabOrder = 8
      end
      object eitera: TEdit
        Left = 104
        Top = 280
        Width = 89
        Height = 22
        TabOrder = 9
        Text = '2'
      end
      object CB1: TCheckBox
        Left = 24
        Top = 428
        Width = 177
        Height = 17
        Caption = 'schwarzer Hintergrund'
        TabOrder = 10
      end
    end
  end
end
