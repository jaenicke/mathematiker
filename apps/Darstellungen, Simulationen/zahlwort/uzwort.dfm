object Form1: TForm1
  Left = 172
  Top = 113
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Zahlwörter in verschiedenen Sprachen'
  ClientHeight = 472
  ClientWidth = 984
  Color = clWhite
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Verdana'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 16
  object Label1: TLabel
    Left = 160
    Top = 20
    Width = 24
    Height = 16
    Caption = 'von'
  end
  object Label2: TLabel
    Left = 344
    Top = 20
    Width = 18
    Height = 16
    Caption = 'bis'
  end
  object Label3: TLabel
    Left = 496
    Top = 446
    Width = 478
    Height = 13
    Caption = 
      'Bitte beachten: obere Grenze ist 1 Milliarde, maximal 25000 Zahl' +
      'wörter je Anzeige.'
    Font.Charset = ANSI_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
  end
  object Label4: TLabel
    Left = 160
    Top = 446
    Width = 5
    Height = 13
    Caption = '-'
    Font.Charset = ANSI_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
  end
  object Edit1: TEdit
    Left = 208
    Top = 16
    Width = 121
    Height = 24
    TabOrder = 0
    Text = '1'
  end
  object Edit2: TEdit
    Left = 392
    Top = 16
    Width = 121
    Height = 24
    TabOrder = 1
    Text = '200'
  end
  object Button1: TButton
    Left = 24
    Top = 432
    Width = 115
    Height = 25
    Caption = 'Anzeigen'
    Default = True
    TabOrder = 2
    OnClick = Button1Click
  end
  object RadioGroup1: TRadioGroup
    Left = 16
    Top = 8
    Width = 130
    Height = 415
    Caption = 'Sprachauswahl'
    ItemIndex = 0
    Items.Strings = (
      'Deutsch'
      'Dänisch'
      'Englisch'
      'Esperanto'
      'Französisch'
      'Griechisch'
      'Italienisch'
      'Japanisch'
      'Japanisch A.'
      'Latein'
      'Niederländisch'
      'Plattdeutsch'
      'Polnisch'
      'Russisch'
      'Schwedisch'
      'Sorbisch'
      'Spanisch'
      'Tschechisch'
      'Türkisch'
      'Ungarisch'
      'UNI-Sprache'
      '"Zwanzig-Eins"'
      'Klingonisch')
    TabOrder = 3
  end
  object ListBox1: TListBox
    Left = 248
    Top = 48
    Width = 728
    Height = 388
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Verdana'
    Font.Style = []
    IntegralHeight = True
    ItemHeight = 16
    ParentFont = False
    TabOrder = 4
    TabWidth = 44
    OnClick = ListBox1Click
  end
  object ListBox2: TListBox
    Left = 152
    Top = 48
    Width = 92
    Height = 388
    IntegralHeight = True
    ItemHeight = 16
    TabOrder = 5
    OnClick = ListBox2Click
  end
end
