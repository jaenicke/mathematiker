object Bestenliste: TBestenliste
  Left = 561
  Top = 4
  ActiveControl = P1
  BorderIcons = [biSystemMenu]
  BorderStyle = bsToolWindow
  Caption = 'Bestenliste'
  ClientHeight = 443
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
  OnActivate = FormActivate
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 16
  object P1: TPanel
    Left = 0
    Top = 399
    Width = 451
    Height = 44
    Align = alBottom
    BevelOuter = bvNone
    Color = clWhite
    TabOrder = 0
    object Button1: TButton
      Left = 8
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Löschen'
      TabOrder = 0
      OnClick = D2Click
    end
    object Button2: TButton
      Left = 112
      Top = 8
      Width = 113
      Height = 25
      Caption = 'Schließen'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = D1Click
    end
    object Button3: TButton
      Left = 240
      Top = 8
      Width = 201
      Height = 25
      Caption = 'Spielername übernehmen'
      TabOrder = 2
      OnClick = D3Click
    end
  end
  object P2: TPanel
    Left = 0
    Top = 0
    Width = 451
    Height = 399
    Align = alClient
    BevelOuter = bvNone
    Caption = 'P2'
    Color = clWhite
    TabOrder = 1
    object P3: TPanel
      Left = 0
      Top = 26
      Width = 30
      Height = 341
      Align = alLeft
      BevelOuter = bvNone
      Color = clWhite
      TabOrder = 0
      object Memo1: TMemo
        Left = 6
        Top = 0
        Width = 24
        Height = 341
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
      Top = 367
      Width = 451
      Height = 32
      Align = alBottom
      BevelOuter = bvNone
      Color = 15790320
      TabOrder = 3
      object L1: TLabel
        Left = 168
        Top = 6
        Width = 91
        Height = 16
        Caption = 'Spielername'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Edit1: TEdit
        Left = 272
        Top = 4
        Width = 169
        Height = 24
        TabOrder = 0
        OnChange = Edit1Change
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
      Caption = 'Schließen'
      ShortCut = 13
      OnClick = D1Click
    end
    object M1: TMenuItem
      Caption = 'ende'
      ShortCut = 27
      OnClick = D1Click
    end
  end
end
