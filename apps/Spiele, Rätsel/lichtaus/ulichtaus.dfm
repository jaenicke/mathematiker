object FLichtaus: TFLichtaus
  Left = 339
  Top = 66
  HelpContext = 108
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Licht aus'
  ClientHeight = 624
  ClientWidth = 834
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Verdana'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  OnShow = Button1Click
  PixelsPerInch = 96
  TextHeight = 14
  object Panel3: TPanel
    Left = 0
    Top = 0
    Width = 834
    Height = 624
    Align = alClient
    BevelOuter = bvNone
    Color = clWhite
    TabOrder = 0
    object Panel2: TPanel
      Left = 0
      Top = 0
      Width = 834
      Height = 624
      Align = alClient
      BevelOuter = bvNone
      Color = clWhite
      TabOrder = 0
      object lichtaus: TPanel
        Left = 0
        Top = 0
        Width = 834
        Height = 624
        Align = alClient
        BevelOuter = bvNone
        Color = clWhite
        TabOrder = 0
        object Paintbox1: TPaintBox
          Left = 185
          Top = 0
          Width = 649
          Height = 624
          Align = alClient
          OnMouseDown = PB7MD
          OnPaint = PB7P
        end
        object Panel1: TPanel
          Left = 0
          Top = 0
          Width = 185
          Height = 624
          Align = alLeft
          BevelOuter = bvNone
          Color = 15790320
          TabOrder = 0
          object Label2: TLabel
            Left = 16
            Top = 16
            Width = 89
            Height = 14
            Caption = 'Spielfeldgröße'
          end
          object Label1: TLabel
            Left = 16
            Top = 72
            Width = 44
            Height = 14
            Caption = 'Züge 0'
          end
          object Button1: TButton
            Left = 24
            Top = 104
            Width = 129
            Height = 25
            Caption = 'Neues Spiel'
            TabOrder = 0
            OnClick = Button1Click
          end
          object Memo1: TMemo
            Left = 8
            Top = 144
            Width = 161
            Height = 145
            TabStop = False
            BorderStyle = bsNone
            Lines.Strings = (
              'Aufgabe: In allen Zellen '
              'ist das Licht '
              'auszuschalten!'
              ''
              'Ein Klick auf eine Zelle '
              'schaltet das Licht in '
              'dieser Zelle sowie '
              'davon links, rechts, '
              'oben und unten ein '
              'bzw. aus!')
            ParentColor = True
            TabOrder = 1
          end
          object Edit1: TEdit
            Left = 56
            Top = 40
            Width = 49
            Height = 22
            TabOrder = 2
            Text = '3'
          end
        end
      end
    end
  end
end
