object fsortier: Tfsortier
  Left = 183
  Top = -2
  HelpContext = 114
  BorderStyle = bsSingle
  Caption = 'Demonstration von Sortierverfahren'
  ClientHeight = 670
  ClientWidth = 979
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Verdana'
  Font.Style = []
  Menu = MM1
  OldCreateOrder = False
  Position = poDesktopCenter
  Scaled = False
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 14
  object sortier: TPanel
    Left = 0
    Top = 0
    Width = 979
    Height = 670
    Align = alClient
    BevelOuter = bvNone
    Caption = 'sortier'
    TabOrder = 0
    object Panel2: TPanel
      Left = 217
      Top = 0
      Width = 762
      Height = 670
      Align = alClient
      BevelOuter = bvNone
      Color = clWhite
      TabOrder = 0
      object Panel4: TPanel
        Left = 0
        Top = 0
        Width = 762
        Height = 670
        Align = alClient
        BevelOuter = bvNone
        Color = clBlack
        TabOrder = 0
        OnResize = Panel4Resize
        object PB5: TPaintBox
          Left = 184
          Top = -152
          Width = 584
          Height = 700
          OnPaint = PB5Paint
        end
        object PB1: TPaintBox
          Left = 0
          Top = 0
          Width = 105
          Height = 670
          Align = alLeft
          Color = clWhite
          ParentColor = False
          OnPaint = PB1Paint
        end
        object Panel1: TPanel
          Left = 144
          Top = 648
          Width = 82
          Height = 20
          BevelOuter = bvNone
          Caption = 'Elementindex '
          Color = clBlack
          Font.Charset = ANSI_CHARSET
          Font.Color = clWhite
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
        end
      end
    end
    object Panel3: TPanel
      Left = 0
      Top = 0
      Width = 217
      Height = 670
      Align = alLeft
      BevelOuter = bvNone
      Color = 15790320
      TabOrder = 1
      object Label2: TLabel
        Left = 16
        Top = 16
        Width = 111
        Height = 14
        Caption = 'Sortierverfahren'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -12
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label3: TLabel
        Left = 32
        Top = 316
        Width = 43
        Height = 14
        Caption = 'Zahlen'
      end
      object Label1: TLabel
        Left = 16
        Top = 420
        Width = 65
        Height = 14
        Caption = 'Sortierzeit'
      end
      object Label4: TLabel
        Left = 16
        Top = 442
        Width = 65
        Height = 14
        Caption = 'Vergleiche'
      end
      object Label5: TLabel
        Left = 16
        Top = 464
        Width = 84
        Height = 14
        Caption = 'Tauschungen'
      end
      object Label6: TLabel
        Left = 112
        Top = 464
        Width = 8
        Height = 14
        Caption = '0'
      end
      object Label7: TLabel
        Left = 112
        Top = 442
        Width = 8
        Height = 14
        Caption = '0'
      end
      object Label8: TLabel
        Left = 112
        Top = 420
        Width = 19
        Height = 14
        Caption = '0 s'
      end
      object LB1: TListBox
        Left = 16
        Top = 40
        Width = 185
        Height = 256
        Color = 15790320
        IntegralHeight = True
        ItemHeight = 14
        Items.Strings = (
          'Bitonic-Sort'#9'15'
          'B-Sort'#9'12'
          'Bubble-Sort 1'#9'0'
          'Bubble-Sort 2'#9'1'
          'Comb-Sort'#9'13'
          'Heapsort (Bottom-Up)'#9'9'
          'Heap-Sort'#9'8'
          'Insert-Sort (binär)'#9'5'
          'Insert-Sort'#9'4'
          'Jump-Sort'#9'2'
          'Oet-Sort'#9'16'
          'Quick-Sort'#9'7'
          'Ripple-Sort'#9'3'
          'Select-Sort'#9'6'
          'Shaker-Sort'#9'11'
          'Shell-Sort'#9'10'
          'Simple-Sort'#9'17'
          'Stooge-Sort'#9'14')
        Sorted = True
        TabOrder = 0
        TabWidth = 300
      end
      object D1: TButton
        Left = 24
        Top = 344
        Width = 169
        Height = 25
        Caption = 'Sortieren'
        TabOrder = 1
        OnClick = D18Click
      end
      object D2: TButton
        Left = 24
        Top = 376
        Width = 169
        Height = 25
        Caption = 'Zurücksetzen'
        TabOrder = 2
        OnClick = T3Change
      end
      object Edit1: TEdit
        Left = 96
        Top = 312
        Width = 65
        Height = 22
        ReadOnly = True
        TabOrder = 3
        Text = '1000'
      end
      object UpDown1: TUpDown
        Left = 161
        Top = 312
        Width = 16
        Height = 22
        Associate = Edit1
        Min = 200
        Max = 16000
        Increment = 200
        Position = 1000
        TabOrder = 4
        Thousands = False
        Wrap = False
        OnChanging = UpDown1Changing
      end
      object RadioGroup1: TRadioGroup
        Left = 16
        Top = 488
        Width = 185
        Height = 153
        Caption = 'Vorsortierung'
        ItemIndex = 0
        Items.Strings = (
          'unsortiert'
          'entgegengesetzt'
          'vorsortiert'
          '1.Hälfte vorsortiert'
          '2.Hälfte vorsortiert'
          'Drittel unsortiert'
          'Hälfte vorsortiert'
          'alternierend')
        TabOrder = 5
        OnClick = T3Change
      end
    end
  end
  object MM1: TMainMenu
    Left = 120
    Top = 16
    object M1: TMenuItem
      Caption = 'Ende'
      ShortCut = 27
      OnClick = S7Click
    end
  end
end
