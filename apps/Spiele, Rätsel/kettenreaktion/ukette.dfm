object nkette: Tnkette
  Left = 393
  Top = 50
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Kettenreaktion'
  ClientHeight = 673
  ClientWidth = 945
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MM1
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object P5: TPanel
    Left = 0
    Top = 0
    Width = 945
    Height = 673
    Align = alClient
    BevelOuter = bvNone
    Color = clWhite
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object kette: TPanel
      Left = 0
      Top = 0
      Width = 193
      Height = 673
      Align = alLeft
      BevelOuter = bvNone
      Color = 15790320
      TabOrder = 0
      object L1: TLabel
        Left = 32
        Top = 76
        Width = 53
        Height = 14
        Caption = 'Spielfeld'
      end
      object L0: TLabel
        Left = 40
        Top = 104
        Width = 43
        Height = 14
        Caption = 'Spieler'
      end
      object D3: TButton
        Left = 32
        Top = 28
        Width = 121
        Height = 25
        Caption = 'Neues Spiel'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
        OnClick = Button3click
      end
      object Memo2: TMemo
        Left = 8
        Top = 192
        Width = 177
        Height = 177
        BorderStyle = bsNone
        Color = 15790320
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Verdana'
        Font.Style = []
        Lines.Strings = (
          'Abwechselnd ist auf ein '
          'eigenes oder leeres Feld eine '
          'Kugel zu platzieren.'
          'Befinden sich 4 Kugeln (in '
          'Randfeldern 3, in Eckfeldern '
          '2) in einem Feld, werden '
          'diese auf die Nachbarfelder '
          'verteilt und dieses Feld von '
          'aktuellen Spieler '
          'eingenommen.'
          'Ziel ist es, alle Felder '
          'einzunehmen bzw. '
          'gegnerische zu löschen!')
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
      end
      object Panel15: TPanel
        Left = 8
        Top = 384
        Width = 177
        Height = 185
        BevelOuter = bvNone
        Color = 15790320
        TabOrder = 1
        object L2: TLabel
          Left = 40
          Top = 31
          Width = 4
          Height = 14
        end
        object Image2: TImage
          Left = 8
          Top = 24
          Width = 21
          Height = 155
          AutoSize = True
          Picture.Data = {
            0954474946496D616765E601000047494638396117009F00A20000FFFFFF0404
            04800080FC0404FCFC04444444008000FC04FC21F90401000000002C02000400
            15009B004003FF08BA10FE81AD30AABDF8C6967BDD522832C1619E686A46A5EA
            A6E0284B8161DFB811D779EFEF3E5C6C460C088EC8A432C95A3A99C4688340AD
            5AAF9BC075CB250C159047B1402E9B0BBBB37A8D26B1CB5F8A27939DDBBF8D30
            9ED6820DFB2F2F2080817B522441895989418687604F4A8391947F464B0E517A
            785A5D9E5E609F588F32016F6C59A76B7F7603ACAD182CB01DB2B316AF738EA4
            BB2184821381C10EC1850DC42A71BE0799BC879BA58C398BD13F3CD4D260D736
            86CFCD520E4ECC2494E10DE44FE0E79813EABADEBC9D9E7FA25B2CF45CF6F755
            F39FEEDEDD224CA9820366E02A8106CDA44AC84D8F2639B1F640BC43C2D62D0E
            166F4DB4E820ABA3468F1F3072AC084BE2C60FFEDEA96C0670843214718E9D18
            2413A6B19A305F121B8673E64D9C346BC61456C4E1CAA348C1581322F11A106D
            DB1A40653AF58683AADB96426551F5693493D5928A55D93220B938EA8E4C4AAB
            D61C5B24E9DE0A88FBB6495D7669D1562A1A66AC5F78F1AC88A3716F87BE7D53
            0EEF0B7CD881E2C58FA9E46B4CA2B04BC69253FEF5EBE0A04B8369129261215A
            21C2D29D4B8F3E2D9A346A37034D7A669000003B}
          Transparent = True
        end
        object L4: TLabel
          Left = 40
          Top = 58
          Width = 4
          Height = 14
        end
        object L5: TLabel
          Left = 40
          Top = 85
          Width = 4
          Height = 14
        end
        object L6: TLabel
          Left = 40
          Top = 112
          Width = 4
          Height = 14
        end
        object L7: TLabel
          Left = 40
          Top = 139
          Width = 4
          Height = 14
        end
        object L8: TLabel
          Left = 40
          Top = 166
          Width = 4
          Height = 14
        end
        object Panel16: TPanel
          Left = 0
          Top = 0
          Width = 177
          Height = 17
          Align = alTop
          Alignment = taLeftJustify
          BevelOuter = bvNone
          Caption = '  Spielstand'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -12
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          ParentColor = True
          ParentFont = False
          TabOrder = 0
        end
        object Pr1: TProgressBar
          Left = 80
          Top = 32
          Width = 86
          Height = 12
          Min = 0
          Max = 100
          Smooth = True
          Step = 1
          TabOrder = 1
        end
        object Pr2: TProgressBar
          Left = 80
          Top = 59
          Width = 86
          Height = 12
          Min = 0
          Max = 100
          Smooth = True
          Step = 1
          TabOrder = 2
        end
        object Pr3: TProgressBar
          Left = 80
          Top = 86
          Width = 86
          Height = 12
          Min = 0
          Max = 100
          Smooth = True
          Step = 1
          TabOrder = 3
        end
        object Pr4: TProgressBar
          Left = 80
          Top = 113
          Width = 86
          Height = 12
          Min = 0
          Max = 100
          Smooth = True
          Step = 1
          TabOrder = 4
        end
        object Pr5: TProgressBar
          Left = 80
          Top = 140
          Width = 86
          Height = 12
          Min = 0
          Max = 100
          Smooth = True
          Step = 1
          TabOrder = 5
        end
        object Pr6: TProgressBar
          Left = 80
          Top = 167
          Width = 86
          Height = 12
          Min = 0
          Max = 100
          Smooth = True
          Step = 1
          TabOrder = 6
        end
      end
      object CB8: TCheckBox
        Left = 16
        Top = 144
        Width = 97
        Height = 17
        Caption = 'Animation'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
      end
      object CB9: TCheckBox
        Left = 16
        Top = 160
        Width = 130
        Height = 17
        Caption = 'Computergegner'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
      end
      object r4: TRxSpinEdit
        Left = 96
        Top = 72
        Width = 49
        Height = 22
        EditorEnabled = False
        MaxValue = 15
        MinValue = 5
        Value = 15
        TabOrder = 4
        OnChange = TrackBar4Change
      end
      object r5: TRxSpinEdit
        Left = 96
        Top = 100
        Width = 49
        Height = 22
        EditorEnabled = False
        MaxValue = 6
        MinValue = 2
        Value = 4
        TabOrder = 5
        OnChange = TrackBar5Change
      end
    end
    object P7: TPanel
      Left = 193
      Top = 0
      Width = 752
      Height = 673
      Align = alClient
      BevelOuter = bvNone
      Color = clWhite
      TabOrder = 1
      object PB1: TPaintBox
        Left = 0
        Top = 0
        Width = 752
        Height = 673
        Align = alClient
        OnMouseDown = PB1MouseDown
        OnPaint = PB1Paint
      end
    end
  end
  object MM1: TMainMenu
    Left = 16
    Top = 40
    object M11: TMenuItem
      Caption = 'Ende'
      ShortCut = 27
      OnClick = S3Click
    end
  end
end
