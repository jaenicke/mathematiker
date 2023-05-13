object Form1: TForm1
  Left = 192
  Top = 125
  Width = 581
  Height = 269
  Caption = 'Stringoperationen'
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Verdana'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 16
  object Label1: TLabel
    Left = 24
    Top = 24
    Width = 32
    Height = 16
    Caption = 'Wort'
  end
  object Label2: TLabel
    Left = 208
    Top = 68
    Width = 115
    Height = 16
    Caption = '.......................'
  end
  object Label3: TLabel
    Left = 208
    Top = 108
    Width = 115
    Height = 16
    Caption = '.......................'
  end
  object Label4: TLabel
    Left = 440
    Top = 108
    Width = 40
    Height = 16
    Caption = 'gegen'
  end
  object Label5: TLabel
    Left = 208
    Top = 148
    Width = 115
    Height = 16
    Caption = '.......................'
  end
  object Label6: TLabel
    Left = 208
    Top = 188
    Width = 115
    Height = 16
    Caption = '.......................'
  end
  object Edit1: TEdit
    Left = 96
    Top = 20
    Width = 121
    Height = 24
    TabOrder = 0
  end
  object Button1: TButton
    Left = 24
    Top = 64
    Width = 153
    Height = 25
    Caption = 'Umdrehen'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 24
    Top = 104
    Width = 153
    Height = 25
    Caption = 'Buchstaben tauschen'
    TabOrder = 2
    OnClick = Button2Click
  end
  object Edit2: TEdit
    Left = 384
    Top = 104
    Width = 49
    Height = 24
    TabOrder = 3
    Text = 'a'
  end
  object Edit3: TEdit
    Left = 496
    Top = 104
    Width = 49
    Height = 24
    TabOrder = 4
    Text = 'i'
  end
  object Button3: TButton
    Left = 24
    Top = 144
    Width = 153
    Height = 25
    Caption = 'Groﬂbuchstaben'
    TabOrder = 5
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 24
    Top = 184
    Width = 153
    Height = 25
    Caption = 'C‰sar-Verschiebung'
    TabOrder = 6
    OnClick = Button4Click
  end
end
