object Form1: TForm1
  Left = 192
  Top = 122
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Skytale'
  ClientHeight = 561
  ClientWidth = 578
  Color = clWhite
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Verdana'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  Scaled = False
  PixelsPerInch = 96
  TextHeight = 16
  object Label1: TLabel
    Left = 24
    Top = 16
    Width = 51
    Height = 16
    Caption = 'Klartext'
  end
  object Label2: TLabel
    Left = 24
    Top = 288
    Width = 74
    Height = 16
    Caption = 'Geheimtext'
  end
  object Label3: TLabel
    Left = 320
    Top = 12
    Width = 38
    Height = 16
    Caption = 'Modul'
  end
  object memo_klar: TMemo
    Left = 16
    Top = 40
    Width = 545
    Height = 233
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
  end
  object b_kodieren: TButton
    Left = 440
    Top = 8
    Width = 121
    Height = 25
    Caption = 'Kodieren'
    TabOrder = 1
    OnClick = b_kodierenClick
  end
  object memo_geheim: TMemo
    Left = 16
    Top = 312
    Width = 545
    Height = 233
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Verdana'
    Font.Style = []
    Lines.Strings = (
      
        'Temii nh irfsn mcs srsw ncrrlr itnönKesam nA fsgnhb sagölh Mdb t' +
        'netirgtceeu auui. '
      '(teeleh ieoAeEsi)')
    ParentFont = False
    TabOrder = 2
  end
  object b_dekodieren: TButton
    Left = 440
    Top = 280
    Width = 121
    Height = 25
    Caption = 'Dekodieren'
    TabOrder = 3
    OnClick = b_dekodierenClick
  end
  object Edit1: TEdit
    Left = 376
    Top = 8
    Width = 49
    Height = 24
    TabOrder = 4
    Text = '3'
  end
end
