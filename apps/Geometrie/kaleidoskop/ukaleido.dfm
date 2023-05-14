object kaform: Tkaform
  Left = 332
  Top = 78
  HelpContext = 118
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Kaleidoskop'
  ClientHeight = 652
  ClientWidth = 1029
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Verdana'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 14
  object Panel6: TPanel
    Left = 0
    Top = 0
    Width = 1029
    Height = 652
    Align = alClient
    BevelOuter = bvNone
    Color = clWhite
    TabOrder = 0
    object kaleido: TPanel
      Left = 0
      Top = 0
      Width = 1029
      Height = 652
      Align = alClient
      BevelOuter = bvNone
      Color = clWhite
      TabOrder = 0
      object Panel1: TPanel
        Left = 0
        Top = 539
        Width = 1029
        Height = 113
        Align = alBottom
        Color = 15790320
        TabOrder = 0
        object Image3: TImage
          Left = 368
          Top = -256
          Width = 480
          Height = 360
          AutoSize = True
          Visible = False
        end
        object Image1: TImage
          Left = 672
          Top = 40
          Width = 80
          Height = 80
          Visible = False
        end
        object Label1: TLabel
          Left = 88
          Top = 16
          Width = 90
          Height = 14
          Caption = 'Beispielbilder'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -12
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label2: TLabel
          Left = 768
          Top = 64
          Width = 230
          Height = 14
          Caption = 'Ausschnitt mit der Maus verschieben'
        end
        object Image2: TImage
          Left = 96
          Top = 80
          Width = 160
          Height = 160
          Visible = False
        end
        object Button1: TButton
          Left = 24
          Top = 40
          Width = 154
          Height = 25
          Caption = 'Abbildung laden'
          TabOrder = 3
          OnClick = Button1Click
        end
        object Liste: TListBox
          Left = 192
          Top = 16
          Width = 201
          Height = 74
          Color = 15790320
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Verdana'
          Font.Style = []
          IntegralHeight = True
          ItemHeight = 14
          Items.Strings = (
            'Adam-Ries-Museum'#9'93'
            'Azure-Window'#9'75'
            'Basilius-Kathedrale'#9'65'
            'Burg Kriebstein'#9'91'
            'Delphi'#9'72'
            'Dresden-Zwinger'#9'105'
            'Felsendom'#9'62'
            'Foto'#9'10'
            'Haus des Lehrers'#9'100'
            'Hiroshima-Memorial'#9'70'
            'Kreidefelsen'#9'78'
            'Meteora'#9'74'
            'Spaghettimonster'#9'7'
            'Taj Mahal'#9'37')
          ParentFont = False
          Sorted = True
          TabOrder = 0
          TabWidth = 160
          OnClick = ListeClick
        end
        object auswahl1: TRadioGroup
          Left = 400
          Top = 16
          Width = 353
          Height = 73
          Caption = 'Transformationsverfahren'
          Columns = 2
          ItemIndex = 3
          Items.Strings = (
            'Quadrat - Drehung'
            'Quadrat - Drehung II'
            'Quadrat - Spiegelung '
            'Quadrat - Spiegelung II'
            'Dreieck - Spiegelung'
            'Dreieck - Drehung')
          TabOrder = 1
          OnClick = PBrechtsPaint
        end
        object auswahl2: TRadioGroup
          Left = 768
          Top = 16
          Width = 193
          Height = 41
          Caption = 'Größe'
          Columns = 2
          ItemIndex = 0
          Items.Strings = (
            '16 Felder'
            '36 Felder')
          TabOrder = 2
          OnClick = auswahl2Click
        end
      end
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 1029
        Height = 539
        Align = alClient
        BevelOuter = bvNone
        Color = clWhite
        TabOrder = 1
        object Panel3: TPanel
          Left = 539
          Top = 0
          Width = 490
          Height = 539
          Align = alRight
          BevelOuter = bvNone
          Color = clWhite
          TabOrder = 0
          object PBrechts: TPaintBox
            Left = 5
            Top = 16
            Width = 480
            Height = 360
            OnMouseDown = PB3MDown
            OnMouseMove = PB3MMove
            OnMouseUp = PB3MUp
            OnPaint = PBrechtsPaint
          end
          object Panel7: TPanel
            Left = 0
            Top = 0
            Width = 490
            Height = 40
            Align = alTop
            BevelOuter = bvNone
            Caption = 'Originalbild'
            Color = clWhite
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -16
            Font.Name = 'Verdana'
            Font.Style = [fsBold, fsItalic]
            ParentFont = False
            TabOrder = 0
          end
        end
        object Panel4: TPanel
          Left = 0
          Top = 0
          Width = 539
          Height = 539
          Align = alClient
          BevelOuter = bvNone
          Color = clWhite
          TabOrder = 1
          OnResize = Panel51Resize
          object PBlinks: TPaintBox
            Left = 8
            Top = 32
            Width = 320
            Height = 320
            OnPaint = PBlinksPaint
          end
          object Panel5: TPanel
            Left = 0
            Top = 0
            Width = 539
            Height = 40
            Align = alTop
            BevelOuter = bvNone
            Caption = 'Kaleidoskopbild'
            Color = clWhite
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -16
            Font.Name = 'Verdana'
            Font.Style = [fsBold, fsItalic]
            ParentFont = False
            TabOrder = 0
          end
        end
      end
    end
  end
  object LadenD: TOpenPictureDialog
    Filter = 'JPEG Image File (*.jpg)|*.jpg|Bitmaps (*.bmp)|*.bmp'
    Left = 368
    Top = 8
  end
end
