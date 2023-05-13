object form1: Tform1
  Left = 267
  Top = 133
  HelpContext = 110
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Milchmädchenrechnung'
  ClientHeight = 685
  ClientWidth = 976
  Color = 15790320
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Verdana'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 14
  object milchm: TPanel
    Left = 0
    Top = 0
    Width = 976
    Height = 685
    Align = alClient
    BevelOuter = bvNone
    Color = clWhite
    TabOrder = 0
    object PaintB1: TPaintBox
      Left = 0
      Top = 0
      Width = 713
      Height = 685
      Align = alClient
      OnPaint = PaintB1Paint
    end
    object Panel1: TPanel
      Left = 713
      Top = 0
      Width = 263
      Height = 685
      Align = alRight
      BevelOuter = bvNone
      Color = 15790320
      TabOrder = 0
      object Label1: TLabel
        Left = 24
        Top = 16
        Width = 159
        Height = 14
        Caption = 'Volumen der Milchkannen'
      end
      object Label2: TLabel
        Left = 24
        Top = 44
        Width = 189
        Height = 14
        Caption = 'Kanne A           B                   C'
      end
      object Label3: TLabel
        Left = 24
        Top = 256
        Width = 139
        Height = 14
        Caption = 'Lösungsmöglichkeiten'
      end
      object Label4: TLabel
        Left = 88
        Top = 100
        Width = 75
        Height = 14
        Caption = 'Zielvolumen'
      end
      object Label5: TLabel
        Left = 24
        Top = 408
        Width = 153
        Height = 28
        Caption = 'Ausgewählte Lösung'#13#10'Kanne  A          B          C'
      end
      object LBox1: TListBox
        Left = 24
        Top = 280
        Width = 217
        Height = 116
        IntegralHeight = True
        ItemHeight = 14
        TabOrder = 0
        TabWidth = 40
        OnClick = LBox1Click
      end
      object Memo1: TMemo
        Left = 24
        Top = 136
        Width = 217
        Height = 105
        Color = 15790320
        Lines.Strings = (
          'Der Inhalt der vollständig '
          'gefüllten Kanne A soll so auf die '
          'leeren Kannen B und C '
          'umgefüllt werden, dass in einer '
          'der Kannen das Zielvolumen '
          'erreicht wird.')
        ReadOnly = True
        TabOrder = 1
      end
      object LBox2: TListBox
        Left = 24
        Top = 442
        Width = 217
        Height = 144
        IntegralHeight = True
        ItemHeight = 14
        TabOrder = 2
        TabWidth = 24
      end
      object Edit1: TEdit
        Left = 24
        Top = 64
        Width = 41
        Height = 22
        TabOrder = 3
        Text = '8'
        OnChange = rm1Change
      end
      object UpDown1: TUpDown
        Left = 65
        Top = 64
        Width = 16
        Height = 22
        Associate = Edit1
        Min = 3
        Max = 15
        Position = 8
        TabOrder = 4
        Wrap = False
      end
      object Edit2: TEdit
        Left = 104
        Top = 64
        Width = 41
        Height = 22
        TabOrder = 5
        Text = '5'
        OnChange = rm1Change
      end
      object UpDown2: TUpDown
        Left = 145
        Top = 64
        Width = 16
        Height = 22
        Associate = Edit2
        Min = 1
        Max = 15
        Position = 5
        TabOrder = 6
        Wrap = False
      end
      object Edit3: TEdit
        Left = 184
        Top = 64
        Width = 41
        Height = 22
        TabOrder = 7
        Text = '3'
        OnChange = rm1Change
      end
      object UpDown3: TUpDown
        Left = 225
        Top = 64
        Width = 16
        Height = 22
        Associate = Edit3
        Min = 1
        Max = 15
        Position = 3
        TabOrder = 8
        Wrap = False
      end
      object Edit4: TEdit
        Left = 184
        Top = 96
        Width = 41
        Height = 22
        TabOrder = 9
        Text = '4'
        OnChange = rm1Change
      end
      object UpDown4: TUpDown
        Left = 225
        Top = 96
        Width = 16
        Height = 22
        Associate = Edit4
        Min = 1
        Max = 15
        Position = 4
        TabOrder = 10
        Wrap = False
      end
    end
  end
end
