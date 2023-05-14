object Form1: TForm1
  Left = 323
  Top = 179
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Schr'#228'ger Wurf'
  ClientHeight = 605
  ClientWidth = 845
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object PaintBox1: TPaintBox
    Left = 169
    Top = 0
    Width = 676
    Height = 605
    Align = alClient
    OnPaint = PaintBox1Paint
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 169
    Height = 605
    Align = alLeft
    BevelOuter = bvNone
    Color = 15790320
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object Button1: TButton
      Left = 24
      Top = 560
      Width = 121
      Height = 25
      Caption = 'Beenden'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 24
      Top = 16
      Width = 121
      Height = 25
      Caption = 'Start'
      TabOrder = 1
      OnClick = Button2Click
    end
    object GroupBox1: TGroupBox
      Left = 8
      Top = 96
      Width = 150
      Height = 49
      Caption = 'Wurfwinkel'
      TabOrder = 2
      object Edit1: TEdit
        Left = 8
        Top = 18
        Width = 130
        Height = 22
        TabOrder = 0
        Text = '60'
      end
    end
    object GroupBox2: TGroupBox
      Left = 8
      Top = 152
      Width = 150
      Height = 49
      Caption = 'Startgeschwindigkeit'
      TabOrder = 3
      object Edit2: TEdit
        Left = 8
        Top = 16
        Width = 130
        Height = 22
        TabOrder = 0
        Text = '9'
      end
    end
    object GroupBox3: TGroupBox
      Left = 8
      Top = 208
      Width = 150
      Height = 49
      Caption = 'Fallbeschleunigung'
      TabOrder = 4
      object Edit3: TEdit
        Left = 8
        Top = 16
        Width = 130
        Height = 22
        TabOrder = 0
        Text = '0,1'
      end
    end
    object Button3: TButton
      Left = 24
      Top = 48
      Width = 121
      Height = 25
      Caption = 'Zur'#252'cksetzen'
      TabOrder = 5
      OnClick = Button3Click
    end
    object GroupBox4: TGroupBox
      Left = 8
      Top = 264
      Width = 150
      Height = 49
      Caption = 'Wind'
      TabOrder = 6
      object Edit4: TEdit
        Left = 8
        Top = 16
        Width = 130
        Height = 22
        TabOrder = 0
        Text = '0'
      end
    end
    object GroupBox5: TGroupBox
      Left = 8
      Top = 323
      Width = 150
      Height = 57
      Caption = 'Zeit'
      TabOrder = 7
      object TrackBar1: TTrackBar
        Left = 8
        Top = 16
        Width = 129
        Height = 33
        Hint = 'Zeitdehnung'
        Max = 100
        ParentShowHint = False
        Frequency = 10
        Position = 50
        ShowHint = True
        TabOrder = 0
        OnChange = TrackBar1Change
      end
    end
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 10
    OnTimer = Timer1Timer
    Left = 8
    Top = 544
  end
end
