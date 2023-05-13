object Form1: TForm1
  Left = 282
  Top = 20
  Width = 731
  Height = 694
  Caption = 'Brüche in Positionssystemen'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 610
    Width = 715
    Height = 48
    Align = alBottom
    BevelOuter = bvNone
    Color = 15790320
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 12
      Width = 467
      Height = 16
      Caption = 
        'Zähler                        Nenner                   maximale ' +
        'Periodenlänge  '
    end
    object Edit1: TEdit
      Left = 72
      Top = 8
      Width = 80
      Height = 24
      TabOrder = 0
      Text = '1'
    end
    object Edit2: TEdit
      Left = 232
      Top = 8
      Width = 80
      Height = 24
      TabOrder = 1
      Text = '1403'
    end
    object Edit3: TEdit
      Left = 488
      Top = 8
      Width = 73
      Height = 24
      TabOrder = 2
      Text = '200'
    end
    object Button1: TButton
      Left = 576
      Top = 8
      Width = 105
      Height = 25
      Caption = 'Umwandlung'
      TabOrder = 3
      OnClick = Button1Click
    end
  end
  object Memo1: TMemo
    Left = 0
    Top = 0
    Width = 715
    Height = 610
    Align = alClient
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
  end
end
