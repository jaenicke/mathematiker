object Fwahl: TFwahl
  Left = 379
  Top = 131
  HelpContext = 107
  BorderStyle = bsSingle
  Caption = 'Ergebnisse fr'#252'herer Wahlen'
  ClientHeight = 672
  ClientWidth = 1021
  Color = clWhite
  Font.Charset = ANSI_CHARSET
  Font.Color = clBlack
  Font.Height = -12
  Font.Name = 'Verdana'
  Font.Style = []
  Menu = Menu1
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  OnActivate = FormActivate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 14
  object wahl: TPanel
    Left = 0
    Top = 0
    Width = 1021
    Height = 672
    Align = alClient
    BevelOuter = bvNone
    Color = clWhite
    TabOrder = 0
    OnResize = wahlResize
    object Label1: TLabel
      Left = 16
      Top = 16
      Width = 331
      Height = 14
      Caption = 'Ermittlung der Mandatsverteilung nach einer Wahl'
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
      Width = 233
      Height = 14
      Caption = 'Anzahl der zu vergebenden Mandate'
    end
    object Label2: TLabel
      Left = 16
      Top = 80
      Width = 91
      Height = 14
      Caption = 'Wahlergebnis'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label6: TLabel
      Left = 408
      Top = 232
      Width = 4
      Height = 14
    end
    object Label7: TLabel
      Left = 424
      Top = 48
      Width = 55
      Height = 14
      Caption = '% H'#252'rde'
    end
    object Label5: TLabel
      Left = 49
      Top = 448
      Width = 101
      Height = 14
      Caption = 'Gesamtstimmen'
    end
    object Label4: TLabel
      Left = 16
      Top = 432
      Width = 134
      Height = 14
      Caption = 'Stimmen unter H'#252'rde'
    end
    object Label9: TLabel
      Left = 46
      Top = 416
      Width = 103
      Height = 14
      Caption = 'Wahlberechtigte'
    end
    object Label8: TLabel
      Left = 76
      Top = 464
      Width = 74
      Height = 14
      Caption = 'Nichtw'#228'hler'
    end
    object image1: TPaintBox
      Left = 304
      Top = 416
      Width = 420
      Height = 220
    end
    object Button1: TButton
      Left = 600
      Top = 72
      Width = 121
      Height = 25
      Caption = 'Berechnung'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      OnClick = Button1Click
    end
    object Edit2: TEdit
      Left = 264
      Top = 44
      Width = 73
      Height = 22
      TabOrder = 0
      Text = '500'
    end
    object Tabelle: TStringGrid
      Left = 16
      Top = 106
      Width = 841
      Height = 300
      BorderStyle = bsNone
      ColCount = 8
      DefaultColWidth = 120
      DefaultRowHeight = 20
      FixedColor = 15790320
      FixedCols = 0
      RowCount = 14
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing, goTabs]
      ScrollBars = ssNone
      TabOrder = 1
      ColWidths = (
        120
        120
        120
        120
        120
        120
        120
        120)
    end
    object CBwahl: TComboBox
      Left = 264
      Top = 75
      Width = 393
      Height = 22
      DropDownCount = 36
      ItemHeight = 14
      Sorted = True
      TabOrder = 2
      OnChange = CBwahlChange
    end
    object CB1: TCheckBox
      Left = 57
      Top = 480
      Width = 193
      Height = 17
      Caption = 'Nichtw'#228'hler einrechnen'
      TabOrder = 3
      OnClick = Button1Click
    end
    object CB2: TCheckBox
      Left = 504
      Top = 47
      Width = 154
      Height = 17
      Caption = 'nur Wahlen ab 1945'
      TabOrder = 4
      OnClick = CB2Click
    end
    object Edit1: TEdit
      Left = 368
      Top = 44
      Width = 33
      Height = 22
      TabOrder = 6
      Text = '5'
      OnChange = Button1Click
    end
    object UpDown1: TUpDown
      Left = 401
      Top = 44
      Width = 16
      Height = 22
      Associate = Edit1
      Max = 10
      Position = 5
      TabOrder = 7
    end
  end
  object Menu1: TMainMenu
    Left = 104
    Top = 92
    object M1: TMenuItem
      Caption = 'Datei'
      Visible = False
      object M3: TMenuItem
        Caption = 'Teilprogramm beenden'
        ShortCut = 27
      end
      object M4: TMenuItem
        Caption = 'M'
        ShortCut = 13
        Visible = False
      end
    end
  end
end
