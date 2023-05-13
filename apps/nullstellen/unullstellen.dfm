object Form1: TForm1
  Left = 374
  Top = 46
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Nullstellen ganzrationaler Gleichungen'
  ClientHeight = 360
  ClientWidth = 529
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Verdana'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 16
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 529
    Height = 360
    Align = alClient
    BevelOuter = bvNone
    Color = clWhite
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 16
      Width = 172
      Height = 14
      Caption = 'Koeffizienten der Gleichung'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -12
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 144
      Top = 44
      Width = 48
      Height = 16
      Caption = 'x^10 +'
    end
    object Label4: TLabel
      Left = 144
      Top = 68
      Width = 40
      Height = 16
      Caption = 'x^9 +'
    end
    object Label5: TLabel
      Left = 144
      Top = 92
      Width = 40
      Height = 16
      Caption = 'x^8 +'
    end
    object Label6: TLabel
      Left = 144
      Top = 116
      Width = 40
      Height = 16
      Caption = 'x^7 +'
    end
    object Label7: TLabel
      Left = 144
      Top = 140
      Width = 40
      Height = 16
      Caption = 'x^6 +'
    end
    object Label8: TLabel
      Left = 144
      Top = 164
      Width = 40
      Height = 16
      Caption = 'x^5 +'
    end
    object Label9: TLabel
      Left = 144
      Top = 188
      Width = 40
      Height = 16
      Caption = 'x^4 +'
    end
    object Label10: TLabel
      Left = 144
      Top = 212
      Width = 28
      Height = 16
      Caption = 'x'#179' +'
    end
    object Label11: TLabel
      Left = 144
      Top = 236
      Width = 28
      Height = 16
      Caption = 'x'#178' +'
    end
    object Label12: TLabel
      Left = 144
      Top = 260
      Width = 21
      Height = 16
      Caption = 'x +'
    end
    object Label13: TLabel
      Left = 144
      Top = 284
      Width = 22
      Height = 16
      Caption = '= 0'
    end
    object Label2: TLabel
      Left = 240
      Top = 16
      Width = 70
      Height = 14
      Caption = 'Nullstellen'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -12
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Button1: TButton
      Left = 32
      Top = 316
      Width = 161
      Height = 25
      Caption = 'Berechnung'
      Default = True
      TabOrder = 12
      OnClick = Button1Click
    end
    object E5: TEdit
      Left = 48
      Top = 40
      Width = 81
      Height = 24
      CharCase = ecUpperCase
      TabOrder = 0
      Text = '0'
    end
    object E6: TEdit
      Left = 48
      Top = 64
      Width = 81
      Height = 24
      CharCase = ecUpperCase
      TabOrder = 1
      Text = '0'
    end
    object E7: TEdit
      Left = 48
      Top = 88
      Width = 81
      Height = 24
      CharCase = ecUpperCase
      TabOrder = 2
      Text = '0'
    end
    object E8: TEdit
      Left = 48
      Top = 112
      Width = 81
      Height = 24
      CharCase = ecUpperCase
      TabOrder = 3
      Text = '0'
    end
    object E9: TEdit
      Left = 48
      Top = 136
      Width = 81
      Height = 24
      CharCase = ecUpperCase
      TabOrder = 4
      Text = '0'
    end
    object E10: TEdit
      Left = 48
      Top = 160
      Width = 81
      Height = 24
      CharCase = ecUpperCase
      TabOrder = 5
      Text = '0'
    end
    object E11: TEdit
      Left = 48
      Top = 184
      Width = 81
      Height = 24
      CharCase = ecUpperCase
      TabOrder = 6
      Text = '0'
    end
    object E12: TEdit
      Left = 48
      Top = 208
      Width = 81
      Height = 24
      CharCase = ecUpperCase
      TabOrder = 7
      Text = '1'
    end
    object E13: TEdit
      Left = 48
      Top = 232
      Width = 81
      Height = 24
      CharCase = ecUpperCase
      TabOrder = 8
      Text = '-1'
    end
    object E14: TEdit
      Left = 48
      Top = 256
      Width = 81
      Height = 24
      CharCase = ecUpperCase
      TabOrder = 9
      Text = '-1'
    end
    object E15: TEdit
      Left = 48
      Top = 280
      Width = 81
      Height = 24
      CharCase = ecUpperCase
      TabOrder = 10
      Text = '-3'
    end
    object Liste: TListBox
      Left = 240
      Top = 36
      Width = 265
      Height = 309
      BorderStyle = bsNone
      ItemHeight = 16
      ParentColor = True
      Sorted = True
      TabOrder = 11
      TabWidth = 50
    end
  end
end
