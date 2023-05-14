object Form1: TForm1
  Left = 254
  Top = 128
  Width = 513
  Height = 395
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Morsebaum'
  Color = clWhite
  Font.Charset = ANSI_CHARSET
  Font.Color = clBlack
  Font.Height = -12
  Font.Name = 'Verdana'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = Init
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 14
  object imgTree: TImage
    Left = 16
    Top = 184
    Width = 465
    Height = 161
  end
  object Label1: TLabel
    Left = 16
    Top = 116
    Width = 49
    Height = 14
    Caption = 'Klartext'
  end
  object panNum: TPanel
    Left = 16
    Top = 16
    Width = 297
    Height = 81
    BevelOuter = bvSpace
    BorderWidth = 3
    BorderStyle = bsSingle
    Color = clWhite
    TabOrder = 0
    object btnPath: TButton
      Left = 56
      Top = 40
      Width = 112
      Height = 25
      Caption = 'Pfad verfolgen'
      TabOrder = 0
      OnClick = TracePath
    end
    object btnSearch: TButton
      Left = 56
      Top = 8
      Width = 112
      Height = 25
      Caption = 'Morsecode'
      TabOrder = 1
      OnClick = SearchNode
    end
    object edtNum: TEdit
      Left = 16
      Top = 12
      Width = 25
      Height = 22
      TabOrder = 2
      Text = 'b'
    end
    object edtPath: TEdit
      Left = 184
      Top = 40
      Width = 89
      Height = 24
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
    end
    object edtMorse: TEdit
      Left = 184
      Top = 8
      Width = 89
      Height = 24
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
    end
  end
  object edtPlain: TEdit
    Left = 72
    Top = 112
    Width = 401
    Height = 22
    TabOrder = 1
    Text = 'morsen macht spa'#223
  end
  object edtChiffre: TEdit
    Left = 16
    Top = 144
    Width = 457
    Height = 24
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
  end
  object btnEncode: TButton
    Left = 352
    Top = 16
    Width = 121
    Height = 25
    Caption = 'Verschl'#252'sseln'
    TabOrder = 3
    OnClick = EncodeText
  end
  object btnDecode: TButton
    Left = 352
    Top = 72
    Width = 121
    Height = 25
    Caption = 'Entschl'#252'sseln'
    TabOrder = 4
    OnClick = DecodeText
  end
end
