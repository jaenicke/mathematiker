object fgo: Tfgo
  Left = 308
  Top = 56
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Go'
  ClientHeight = 654
  ClientWidth = 875
  Color = clWhite
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Verdana'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 14
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 217
    Height = 654
    Align = alLeft
    Color = 15790320
    TabOrder = 0
    object Label7: TLabel
      Left = 88
      Top = 200
      Width = 113
      Height = 18
      Caption = 'Schwarz zieht'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 16
      Top = 248
      Width = 103
      Height = 18
      Caption = 'Punkte Wei'#223
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 160
      Top = 248
      Width = 10
      Height = 18
      Caption = '0'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 16
      Top = 280
      Width = 128
      Height = 18
      Caption = 'Punkte Schwarz'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 160
      Top = 280
      Width = 10
      Height = 18
      Caption = '0'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object S2: TShape
      Left = 24
      Top = 184
      Width = 49
      Height = 49
      Brush.Color = clBlack
      Shape = stCircle
    end
    object Label2: TLabel
      Left = 16
      Top = 24
      Width = 143
      Height = 16
      Caption = 'Go - Spielsteuerung'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -13
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label6: TLabel
      Left = 16
      Top = 512
      Width = 56
      Height = 14
      Caption = 'Beispiele'
    end
    object Button1: TButton
      Left = 16
      Top = 144
      Width = 185
      Height = 25
      Caption = 'Neues Spiel'
      TabOrder = 2
      OnClick = G1C
    end
    object Button2: TButton
      Left = 16
      Top = 312
      Width = 185
      Height = 25
      Caption = 'Zug passen'
      TabOrder = 3
      OnClick = D2C
    end
    object Button3: TButton
      Left = 16
      Top = 344
      Width = 185
      Height = 25
      Caption = 'Zug zur'#252'cknehmen'
      TabOrder = 4
      OnClick = D3C
    end
    object Button4: TButton
      Left = 16
      Top = 440
      Width = 185
      Height = 25
      Caption = 'Spielstand speichern'
      TabOrder = 5
      OnClick = D4C
    end
    object Button5: TButton
      Left = 16
      Top = 472
      Width = 185
      Height = 25
      Caption = 'Spielstand laden'
      TabOrder = 6
      OnClick = D5C
    end
    object RG1: TRadioGroup
      Left = 16
      Top = 48
      Width = 185
      Height = 81
      Caption = 'Spielfeldgr'#246#223'e'
      ItemIndex = 2
      Items.Strings = (
        '9 X 9'
        '13 X 13'
        '19 X 19')
      TabOrder = 0
      OnClick = G1C
    end
    object Checkbox1: TComboBox
      Left = 88
      Top = 508
      Width = 41
      Height = 22
      ItemHeight = 14
      TabOrder = 1
      Text = '-'
      OnChange = CB1C
      Items.Strings = (
        '-'
        '1'
        '2')
    end
    object ListBox1: TListBox
      Left = 16
      Top = 568
      Width = 121
      Height = 97
      ItemHeight = 14
      Items.Strings = (
        '2 0 0 0 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '0 1'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '1 2'
        '1 2'
        '1 2'
        '2 0'
        '2 0'
        '2 0'
        '1 3'
        '2 0'
        '2 0'
        '0 4'
        '2 0'
        '2 0'
        '0 5'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '0 6'
        '1 2'
        '0 7'
        '0 7'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '1 8'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '0 6'
        '0 6'
        '1 9'
        '1 9'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '0 6'
        '1 9'
        '1 9'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '1 10'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '0 6'
        '0 6'
        '1 9'
        '0 11'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '1 12'
        '0 13'
        '1 14'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '0 13'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '0 15'
        '2 0'
        '2 0'
        '0 13'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '1 16'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '1 17'
        '2 0'
        '1 18'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '1 16'
        '0 19'
        '2 0'
        '2 0'
        '2 0'
        '0 20'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '1 21'
        '2 0'
        '2 0'
        '2 0'
        '1 22'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '0 20'
        '1 23'
        '2 0'
        '0 24'
        '2 0'
        '2 0'
        '1 21'
        '0 25'
        '0 25'
        '0 25'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '1 26'
        '0 27'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '1 23'
        '2 0'
        '1 28'
        '0 29'
        '1 30'
        '2 0'
        '1 31'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '1 26'
        '2 0'
        '1 32'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '0 33'
        '2 0'
        '0 34'
        '2 0'
        '2 0'
        '1 35'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '1 36'
        '2 0'
        '0 37'
        '2 0'
        '0 38'
        '2 0'
        '2 0'
        '1 39'
        '1 39'
        '0 33'
        '2 0'
        '2 0'
        '0 40'
        '2 0'
        '2 0'
        '1 41'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '0 42'
        '2 0'
        '0 43'
        '1 44'
        '1 44'
        '1 44'
        '2 0'
        '0 45'
        '1 46'
        '1 46'
        '0 47'
        '2 0'
        '2 0'
        '0 48'
        '1 41'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '0 49'
        '0 49'
        '1 44'
        '2 0'
        '0 45'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '0 50'
        '2 0'
        '0 51'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0')
      TabOrder = 7
      Visible = False
    end
    object ListBox2: TListBox
      Left = 64
      Top = 568
      Width = 121
      Height = 97
      ItemHeight = 14
      Items.Strings = (
        '2 0 0 0 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '0 2'
        '0 2'
        '0 2'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '0 3'
        '1 4'
        '1 4'
        '1 4'
        '0 5'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '0 3'
        '2 0'
        '2 0'
        '1 4'
        '0 5'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '0 6'
        '1 7'
        '0 8'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '1 10'
        '1 10'
        '0 11'
        '0 11'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '1 10'
        '1 10'
        '1 10'
        '2 0'
        '2 0'
        '1 12'
        '0 13'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '1 10'
        '1 10'
        '0 15'
        '0 15'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0'
        '2 0')
      TabOrder = 8
      Visible = False
    end
  end
  object Panel2: TPanel
    Left = 217
    Top = 0
    Width = 658
    Height = 654
    Align = alClient
    BevelOuter = bvNone
    Color = clWhite
    TabOrder = 1
    object Im1: TImage
      Left = 17
      Top = 9
      Width = 557
      Height = 560
      OnMouseUp = Im1MU
    end
  end
  object SD1: TSaveDialog
    DefaultExt = 'go'
    Filter = 'Go-Spielfeld (*.go)|*.go'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 616
    Top = 24
  end
  object OD1: TOpenDialog
    DefaultExt = 'go'
    Filter = 'Go-Spielfeld (*.go)|*.go'
    Left = 544
    Top = 24
  end
end
