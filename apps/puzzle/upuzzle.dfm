object Formpu: TFormpu
  Left = 242
  Top = 45
  HelpContext = 1
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Puzzle'
  ClientHeight = 637
  ClientWidth = 920
  Color = clWhite
  Font.Charset = ANSI_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Verdana'
  Font.Style = []
  Menu = MM1
  OldCreateOrder = False
  PopupMenu = PM1
  Position = poScreenCenter
  Scaled = False
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 16
  object f_puzzle: TPanel
    Left = 0
    Top = 0
    Width = 920
    Height = 637
    Align = alClient
    BevelOuter = bvNone
    Color = clWhite
    TabOrder = 0
    object Panel1: TPanel
      Left = 0
      Top = 0
      Width = 192
      Height = 637
      Align = alLeft
      BevelOuter = bvNone
      Color = 15790320
      TabOrder = 0
      object RG1: TRadioGroup
        Left = 16
        Top = 152
        Width = 161
        Height = 81
        Caption = 'Teile'
        ItemIndex = 1
        Items.Strings = (
          '12 - leicht'
          '48 - schwierig'
          '192 - extrem')
        TabOrder = 0
        TabStop = True
      end
      object RG2: TRadioGroup
        Left = 16
        Top = 248
        Width = 161
        Height = 65
        Caption = 'Schwierigkeitsgrad'
        ItemIndex = 0
        Items.Strings = (
          'ohne Drehung'
          'mit Drehung')
        TabOrder = 1
      end
      object Memo1: TMemo
        Left = 16
        Top = 368
        Width = 161
        Height = 169
        BorderStyle = bsNone
        Color = 15790320
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Verdana'
        Font.Style = []
        Lines.Strings = (
          'Ein linker Mausklick und '
          'Bewegung der Maus '
          'verschiebt das '
          'ausgewählte Teil.'
          'Ein rechter Mausklick '
          'dreht das Einzelteil um '
          '90°.'
          'Eigene Bilder werden '
          'auf das Format 640 x '
          '480 gestreckt oder '
          'gestaucht.')
        ParentFont = False
        ReadOnly = True
        TabOrder = 2
      end
      object Listbox1: TListBox
        Left = 16
        Top = 54
        Width = 161
        Height = 84
        BorderStyle = bsNone
        Color = 15790320
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Verdana'
        Font.Style = []
        IntegralHeight = True
        ItemHeight = 14
        Items.Strings = (
          'Abu Simbel'#9'38'
          'Adam-Ries-Museum'#9'93'
          'Azure-Window'#9'75'
          'Basilius-Kathedrale'#9'65'
          'Burg Kriebstein'#9'91'
          'Che Guevara'#9'95'
          'Chichén Itzá'#9'50'
          'Delphi'#9'72'
          'Dresden-Zwinger'#9'105'
          'Galilei-Plastik'#9'83'
          'Gemälde'#9'104'
          'Göltzschtalbrücke'#9'52'
          'Hiroshima-Memorial'#9'70'
          'Karl Marx Monument'#9'41'
          'Kleine Meerjungfrau'#9'90'
          'Kreidefelsen'#9'78'
          'Meerschweinchen'#9'87'
          'Meteora'#9'74'
          'Porträtfoto'#9'10'
          'Saturn'#9'11'
          'Spaghettimonster'#9'7'
          'Spirale'#9'94'
          'Taj Mahal'#9'37'
          'Warnemünde'#9'107'
          'Wartburg'#9'33')
        ParentFont = False
        Sorted = True
        TabOrder = 3
        TabWidth = 160
        OnClick = ListBox1Click
      end
      object Button1: TButton
        Left = 16
        Top = 16
        Width = 161
        Height = 25
        Caption = 'Zufallsbild laden'
        TabOrder = 4
        OnClick = Button1Click
      end
      object Button4: TButton
        Left = 16
        Top = 328
        Width = 161
        Height = 25
        Caption = 'Eigenes Bild laden'
        TabOrder = 5
        OnClick = Button4Click
      end
      object Button2: TButton
        Left = 16
        Top = 536
        Width = 161
        Height = 25
        Caption = 'Lösung zeigen'
        TabOrder = 6
        OnClick = Button2Click
      end
    end
    object Panel4: TPanel
      Left = 196
      Top = 0
      Width = 724
      Height = 637
      Align = alClient
      BevelOuter = bvNone
      Color = clWhite
      TabOrder = 1
      object PaintBox1: TPaintBox
        Left = 40
        Top = 48
        Width = 640
        Height = 480
        OnMouseDown = PaintBox1MouseDown
        OnMouseMove = PaintBox1MouseMove
        OnMouseUp = PaintBox1MouseUp
        OnPaint = puzzledarstellen
      end
      object Image5: TImage
        Left = 40
        Top = 48
        Width = 640
        Height = 480
        Visible = False
      end
      object Image1: TImage
        Left = 760
        Top = 344
        Width = 160
        Height = 160
        Visible = False
      end
      object Image2: TImage
        Left = 744
        Top = 256
        Width = 80
        Height = 80
        Visible = False
      end
      object Label1: TLabel
        Left = 72
        Top = 552
        Width = 81
        Height = 25
        Caption = 'Züge 0'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -21
        Font.Name = 'Verdana'
        Font.Style = [fsBold, fsItalic]
        ParentFont = False
      end
      object Label2: TLabel
        Left = 408
        Top = 552
        Width = 46
        Height = 25
        Caption = 'Zeit'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -21
        Font.Name = 'Verdana'
        Font.Style = [fsBold, fsItalic]
        ParentFont = False
      end
      object Label3: TLabel
        Left = 72
        Top = 584
        Width = 70
        Height = 25
        Caption = 'xxxxx'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -21
        Font.Name = 'Verdana'
        Font.Style = [fsBold, fsItalic]
        ParentFont = False
      end
      object Image3: TImage
        Left = 32
        Top = 480
        Width = 105
        Height = 105
        AutoSize = True
        Visible = False
      end
      object Image4: TImage
        Left = 24
        Top = 416
        Width = 40
        Height = 40
        Visible = False
      end
    end
    object Panel17: TPanel
      Left = 192
      Top = 0
      Width = 4
      Height = 637
      Align = alLeft
      BevelOuter = bvNone
      Color = clWhite
      TabOrder = 2
    end
  end
  object PM1: TPopupMenu
    Left = 744
    object M57: TMenuItem
      Caption = 'enter'
      ShortCut = 13
      Visible = False
    end
    object M35: TMenuItem
      Caption = 'schließen'
      ShortCut = 8219
      Visible = False
      OnClick = S1Click
    end
  end
  object MM1: TMainMenu
    Left = 264
    Top = 120
    object M33: TMenuItem
      Caption = 'Ende'
      ShortCut = 27
      Visible = False
      OnClick = S1Click
    end
  end
  object Timer1: TTimer
    Enabled = False
    OnTimer = Timer1Timer
    Left = 657
    Top = 4
  end
  object OP1: TOpenPictureDialog
    Filter = 'JPEG Image File (*.jpg)|*.jpg'
    Left = 521
    Top = 10
  end
end
