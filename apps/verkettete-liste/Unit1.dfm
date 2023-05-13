object Form1: TForm1
  Left = 363
  Top = 138
  Width = 377
  Height = 400
  Caption = 'Erstellung einer Vokabelliste'
  Color = clWhite
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Verdana'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = Init
  PixelsPerInch = 96
  TextHeight = 14
  object memWords: TMemo
    Left = 176
    Top = 16
    Width = 169
    Height = 257
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object btnSave: TButton
    Left = 16
    Top = 200
    Width = 144
    Height = 33
    Caption = 'Vokabeln speichern'
    TabOrder = 1
    OnClick = SaveWords
  end
  object btnLoad: TButton
    Left = 16
    Top = 240
    Width = 144
    Height = 33
    Caption = 'Vokabeln laden'
    TabOrder = 2
    OnClick = LoadWords
  end
  object rgWord: TRadioGroup
    Left = 16
    Top = 48
    Width = 145
    Height = 97
    Caption = 'das Wort'
    ItemIndex = 0
    Items.Strings = (
      'einsortieren'
      'l'#246'schen'
      'suchen')
    TabOrder = 3
  end
  object btnWord: TButton
    Left = 16
    Top = 152
    Width = 144
    Height = 33
    Caption = 'OK'
    TabOrder = 4
    OnClick = ModifyWords
  end
  object edtWord: TEdit
    Left = 16
    Top = 16
    Width = 145
    Height = 22
    TabOrder = 5
    Text = 'mouse'
  end
  object GroupBox1: TGroupBox
    Left = 16
    Top = 288
    Width = 329
    Height = 57
    Caption = 'Heap-Verwaltung'
    TabOrder = 6
    object lblHeap: TLabel
      Left = 128
      Top = 26
      Width = 84
      Height = 14
      Caption = 'Heap-Gr'#246#223'e: '
    end
    object cbDispose: TCheckBox
      Left = 8
      Top = 24
      Width = 105
      Height = 17
      Caption = 'mit dispose'
      Checked = True
      State = cbChecked
      TabOrder = 0
    end
  end
end
