object Form1: TForm1
  Left = 445
  Top = 273
  BorderStyle = bsSingle
  Caption = 'Gr'#246#223'ter gemeinsamer Teiler'
  ClientHeight = 372
  ClientWidth = 394
  Color = clWhite
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Verdana'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 16
  object lblTry: TLabel
    Left = 304
    Top = 88
    Width = 5
    Height = 16
  end
  object lblPrime: TLabel
    Left = 304
    Top = 128
    Width = 5
    Height = 16
  end
  object lblEuklid: TLabel
    Left = 304
    Top = 168
    Width = 5
    Height = 16
  end
  object Label1: TLabel
    Left = 16
    Top = 20
    Width = 207
    Height = 16
    Caption = 'Zahl 1                        Zahl 2 '
  end
  object Label2: TLabel
    Left = 16
    Top = 56
    Width = 271
    Height = 16
    Caption = 'Vergleich verschiedener ggT-Algorithmen'
  end
  object Label3: TLabel
    Left = 304
    Top = 248
    Width = 5
    Height = 16
  end
  object Label4: TLabel
    Left = 304
    Top = 288
    Width = 5
    Height = 16
  end
  object Label5: TLabel
    Left = 304
    Top = 208
    Width = 5
    Height = 16
  end
  object Label6: TLabel
    Left = 304
    Top = 328
    Width = 5
    Height = 16
  end
  object btnTry: TButton
    Left = 16
    Top = 84
    Width = 180
    Height = 30
    Caption = 'systematisches Probieren'
    TabOrder = 0
    OnClick = gcd_Try
  end
  object edtA: TEdit
    Left = 64
    Top = 16
    Width = 97
    Height = 24
    TabOrder = 1
    Text = '37512'
  end
  object edtB: TEdit
    Left = 232
    Top = 16
    Width = 97
    Height = 24
    TabOrder = 2
    Text = '23760'
  end
  object edtTry: TEdit
    Left = 216
    Top = 88
    Width = 73
    Height = 24
    TabOrder = 3
  end
  object btnPrime: TButton
    Left = 16
    Top = 124
    Width = 180
    Height = 30
    Caption = 'Primfaktorzerlegung'
    TabOrder = 4
    OnClick = gcd_Prime
  end
  object edtPrime: TEdit
    Left = 216
    Top = 128
    Width = 73
    Height = 24
    TabOrder = 5
  end
  object btnEuklid: TButton
    Left = 16
    Top = 164
    Width = 180
    Height = 30
    Caption = 'Euklidischer Algorithmus'
    TabOrder = 6
    OnClick = gcd_Euklid
  end
  object edtEuklid: TEdit
    Left = 216
    Top = 168
    Width = 73
    Height = 24
    TabOrder = 7
  end
  object Button1: TButton
    Left = 16
    Top = 244
    Width = 180
    Height = 30
    Caption = 'Euklid mit Restbildung'
    TabOrder = 8
    OnClick = gcd_mod
  end
  object Edit1: TEdit
    Left = 216
    Top = 248
    Width = 73
    Height = 24
    TabOrder = 9
  end
  object Button2: TButton
    Left = 16
    Top = 284
    Width = 180
    Height = 30
    Caption = 'Euklid: Assembler'
    TabOrder = 10
    OnClick = gcd_assembler
  end
  object Edit2: TEdit
    Left = 216
    Top = 288
    Width = 73
    Height = 24
    TabOrder = 11
  end
  object Button3: TButton
    Left = 16
    Top = 204
    Width = 180
    Height = 30
    Caption = 'Euklid: Rekursion'
    TabOrder = 12
    OnClick = gcd_rekursiv
  end
  object Edit3: TEdit
    Left = 216
    Top = 208
    Width = 73
    Height = 24
    TabOrder = 13
  end
  object Button4: TButton
    Left = 16
    Top = 324
    Width = 180
    Height = 30
    Caption = 'von Stein-Algorithmus'
    TabOrder = 14
    OnClick = gcd_stein
  end
  object Edit4: TEdit
    Left = 216
    Top = 328
    Width = 73
    Height = 24
    TabOrder = 15
  end
end
