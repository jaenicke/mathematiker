object Form1: TForm1
  Left = 140
  Top = 150
  Width = 507
  Height = 181
  Caption = 'Cäsarverfahren'
  Color = clWhite
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Verdana'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 18
  object lblShift: TLabel
    Left = 18
    Top = 11
    Width = 152
    Height = 18
    Alignment = taRightJustify
    Caption = 'Verschiebungsweite:'
  end
  object lblPlain: TLabel
    Left = 104
    Top = 52
    Width = 65
    Height = 18
    Alignment = taRightJustify
    Caption = 'Klartext:'
  end
  object lblCipher: TLabel
    Left = 76
    Top = 100
    Width = 94
    Height = 18
    Alignment = taRightJustify
    Caption = 'Geheimtext:'
  end
  object edtShift: TEdit
    Left = 176
    Top = 8
    Width = 33
    Height = 26
    TabOrder = 0
    Text = '3'
  end
  object edtPlain: TEdit
    Left = 176
    Top = 48
    Width = 145
    Height = 26
    TabOrder = 1
    Text = 'kepler'
  end
  object edtCipher: TEdit
    Left = 176
    Top = 96
    Width = 145
    Height = 26
    TabOrder = 2
  end
  object btnEncode: TButton
    Left = 336
    Top = 48
    Width = 137
    Height = 25
    Caption = 'Verschlüsseln'
    TabOrder = 3
    OnClick = Encode
  end
  object btnDecode: TButton
    Left = 336
    Top = 96
    Width = 137
    Height = 25
    Caption = 'Entschlüsseln'
    TabOrder = 4
    OnClick = Decode
  end
end
