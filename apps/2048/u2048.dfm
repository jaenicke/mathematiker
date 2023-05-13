object f2048: Tf2048
  Left = 459
  Top = 135
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = '2048'
  ClientHeight = 623
  ClientWidth = 881
  Color = clWhite
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Verdana'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  OnActivate = FormActivate
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 16
  object PaintBox1: TPaintBox
    Left = 177
    Top = 0
    Width = 704
    Height = 623
    Align = alClient
    OnPaint = PaintBox1Paint
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 177
    Height = 623
    Align = alLeft
    BevelOuter = bvNone
    Color = 15790320
    TabOrder = 0
    object Label1: TLabel
      Left = 40
      Top = 72
      Width = 82
      Height = 16
      Caption = 'Punktestand'
    end
    object Label2: TLabel
      Left = 63
      Top = 96
      Width = 11
      Height = 18
      Alignment = taCenter
      Caption = '0'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -16
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 24
      Top = 128
      Width = 38
      Height = 16
      Caption = 'Breite'
    end
    object Label4: TLabel
      Left = 24
      Top = 160
      Width = 33
      Height = 16
      Caption = 'Höhe'
    end
    object Button1: TButton
      Left = 32
      Top = 24
      Width = 105
      Height = 25
      Caption = 'Neues Spiel'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Memo1: TMemo
      Left = 8
      Top = 244
      Width = 153
      Height = 285
      TabStop = False
      BorderStyle = bsNone
      Color = 15790320
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Verdana'
      Font.Style = []
      Lines.Strings = (
        'Die Felder werden mit '
        'den Cursor-Tasten '
        'links, rechts, hoch, '
        'runter gesteuert.'
        'Die Felder bewegen '
        'sich dann in die '
        'jeweilige Richtung.'
        'Haben zwei Felder in '
        'der gewählten '
        'Richtung den gleichen '
        'Zahlenwert, so '
        'verschmelzen sie zu '
        'einem mit dem '
        'doppelten Wert.'
        ''
        'Ziel des Spiels ist, ein '
        'Feld mit dem '
        'Zahlenwert 2048 zu '
        'erreichen.')
      ParentFont = False
      TabOrder = 1
    end
    object CheckBox1: TCheckBox
      Left = 24
      Top = 192
      Width = 97
      Height = 17
      Caption = 'Buchstaben'
      TabOrder = 2
      OnClick = PaintBox1Paint
    end
    object Edit1: TEdit
      Left = 76
      Top = 124
      Width = 48
      Height = 24
      TabOrder = 3
      Text = '4'
      OnChange = Edit1Change
    end
    object UpDown1: TUpDown
      Left = 124
      Top = 124
      Width = 16
      Height = 24
      Associate = Edit1
      Min = 3
      Max = 9
      Position = 4
      TabOrder = 4
      Wrap = False
    end
    object Button2: TButton
      Left = 32
      Top = 560
      Width = 105
      Height = 25
      Caption = 'Suchen'
      TabOrder = 5
      OnClick = Button2Click
    end
    object CheckBox2: TCheckBox
      Left = 24
      Top = 212
      Width = 137
      Height = 17
      Caption = 'nur "2" erzeugen'
      TabOrder = 6
      OnClick = CheckBox2Click
    end
    object Edit2: TEdit
      Left = 76
      Top = 156
      Width = 48
      Height = 24
      TabOrder = 7
      Text = '4'
      OnChange = Edit2Change
    end
    object UpDown2: TUpDown
      Left = 124
      Top = 156
      Width = 16
      Height = 24
      Associate = Edit2
      Min = 3
      Max = 9
      Position = 4
      TabOrder = 8
      Wrap = False
    end
  end
  object MainMenu1: TMainMenu
    Left = 24
    Top = 16
    object Tasten1: TMenuItem
      Caption = 'Tasten'
      Visible = False
      object links1: TMenuItem
        Caption = 'links'
        ShortCut = 37
        OnClick = links1Click
      end
      object rechts1: TMenuItem
        Caption = 'rechts'
        ShortCut = 39
        OnClick = rechts1Click
      end
      object hoch1: TMenuItem
        Caption = 'hoch'
        ShortCut = 38
        OnClick = hoch1Click
      end
      object runter1: TMenuItem
        Caption = 'runter'
        ShortCut = 40
        OnClick = runter1Click
      end
    end
  end
end
