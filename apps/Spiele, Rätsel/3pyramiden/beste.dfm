object Bestenliste: TBestenliste
  Left = 705
  Top = 48
  ActiveControl = P1
  BorderIcons = [biSystemMenu]
  BorderStyle = bsToolWindow
  ClientHeight = 441
  ClientWidth = 451
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Verdana'
  Font.Style = []
  OldCreateOrder = False
  PopupMenu = PM1
  Scaled = False
  OnCreate = FormCreate
  OnShow = FormActivate
  PixelsPerInch = 96
  TextHeight = 16
  object P1: TPanel
    Left = 0
    Top = 396
    Width = 451
    Height = 45
    Align = alBottom
    BevelOuter = bvNone
    Color = clWhite
    TabOrder = 0
    object D1: TButton
      Left = 136
      Top = 10
      Width = 97
      Height = 25
      Caption = 'Schlie'#223'en'
      TabOrder = 0
      OnClick = D1C
    end
    object D2: TButton
      Tag = 1
      Left = 16
      Top = 10
      Width = 97
      Height = 25
      Caption = 'L'#246'schen'
      TabOrder = 1
      OnClick = D2C
    end
    object D3: TButton
      Left = 248
      Top = 10
      Width = 193
      Height = 25
      Caption = 'Spielername '#252'bernehmen'
      TabOrder = 2
      OnClick = D3C
    end
  end
  object P2: TPanel
    Left = 0
    Top = 0
    Width = 451
    Height = 396
    Align = alClient
    BevelOuter = bvNone
    Caption = 'P2'
    Color = clWhite
    TabOrder = 1
    object P3: TPanel
      Left = 0
      Top = 26
      Width = 30
      Height = 338
      Align = alLeft
      BevelOuter = bvNone
      Color = clWhite
      TabOrder = 0
      object Memo1: TMemo
        Left = 6
        Top = 0
        Width = 24
        Height = 338
        Align = alRight
        BorderStyle = bsNone
        Color = clBlue
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -13
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        Lines.Strings = (
          ' 1'
          ' 2'
          ' 3'
          ' 4'
          ' 5'
          ' 6'
          ' 7'
          ' 8'
          ' 9'
          '10'
          '11'
          '12'
          '13'
          '14'
          '15'
          '16'
          '17'
          '18'
          '19'
          '20')
        ParentFont = False
        TabOrder = 0
      end
    end
    object LB1: TListBox
      Left = 30
      Top = 26
      Width = 421
      Height = 336
      Align = alClient
      BorderStyle = bsNone
      IntegralHeight = True
      ItemHeight = 16
      TabOrder = 1
      TabWidth = 60
    end
    object P4: TPanel
      Left = 0
      Top = 0
      Width = 451
      Height = 26
      Align = alTop
      BevelOuter = bvNone
      Color = 15790320
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -16
      Font.Name = 'Verdana'
      Font.Style = [fsBold, fsItalic]
      ParentFont = False
      TabOrder = 2
    end
    object P5: TPanel
      Left = 0
      Top = 364
      Width = 451
      Height = 32
      Align = alBottom
      BevelOuter = bvNone
      Color = 15790320
      TabOrder = 3
      object L1: TLabel
        Left = 168
        Top = 8
        Width = 79
        Height = 16
        Caption = 'Spielername'
      end
      object Edit1: TEdit
        Left = 272
        Top = 4
        Width = 169
        Height = 24
        TabOrder = 0
        OnChange = E1C
      end
      object CB1: TCheckBox
        Left = 16
        Top = 8
        Width = 97
        Height = 17
        Caption = 'Bestwert'
        Checked = True
        State = cbChecked
        TabOrder = 1
      end
    end
  end
  object PM1: TPopupMenu
    Left = 232
    Top = 56
    object M2: TMenuItem
      Caption = 'Schlie'#223'en'
      ShortCut = 13
      OnClick = D1C
    end
    object M1: TMenuItem
      Caption = 'ende'
      ShortCut = 27
      OnClick = D1C
    end
  end
end
