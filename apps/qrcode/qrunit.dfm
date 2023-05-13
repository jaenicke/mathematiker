object qrform: Tqrform
  Left = 347
  Top = 116
  Width = 839
  Height = 510
  Caption = 'QR-Code-Generator'
  Color = clWhite
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Verdana'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 16
  object qrcode: TPanel
    Left = 0
    Top = 0
    Width = 823
    Height = 471
    Align = alClient
    BevelOuter = bvNone
    Color = clWhite
    TabOrder = 0
    object Panel2: TPanel
      Left = 599
      Top = 0
      Width = 224
      Height = 471
      Align = alRight
      BevelOuter = bvNone
      Color = 15790320
      TabOrder = 0
      object Label3: TLabel
        Left = 24
        Top = 16
        Width = 29
        Height = 16
        Caption = 'Text'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -13
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
      end
      object Label4: TLabel
        Left = 40
        Top = 372
        Width = 69
        Height = 16
        Caption = 'Randgröße'
      end
      object S5: TSpeedButton
        Left = 137
        Top = 10
        Width = 23
        Height = 23
        Hint = 'Text löschen'
        Caption = 'û'
        Flat = True
        Font.Charset = SYMBOL_CHARSET
        Font.Color = clRed
        Font.Height = -24
        Font.Name = 'Wingdings'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        OnClick = S5Click
      end
      object S33: TSpeedButton
        Left = 160
        Top = 10
        Width = 23
        Height = 23
        Hint = 'Text laden'
        Flat = True
        Glyph.Data = {
          66010000424D6601000000000000760000002800000014000000140000000100
          040000000000F0000000C40E0000C40E00001000000000000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
          FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
          FFFFFFFFFFFFFFFF0000FCCFFFFFFFCCFFFFFFFF0000FCCFCCFFFFCCFFFFFFFF
          0000FCCFCCFFFFCCFFFFFFFF0000FCCFFFFFFFCCFFF0FFFF0000FCCCCCCCCCCC
          FFF00FFF0000FCCCCCCCCC00000000FF0000FCBBBBBBBB000000000F0000FCBB
          BBBBBB000000000F0000FCBBBBBBBB00000000FF0000FCBBBBBBBBBCFFF00FFF
          0000FCBBBBBBBBBCFFF0FFFF0000FCBBBBBBBBBCFFFFFFFF0000FFFFFFFFFFFF
          FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
          FFFFFFFFFFFFFFFF0000}
        ParentShowHint = False
        ShowHint = True
        OnClick = S33Click
      end
      object S11: TSpeedButton
        Left = 183
        Top = 10
        Width = 23
        Height = 23
        Hint = 'Beispieltext'
        Caption = 'B'
        Flat = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Verdana'
        Font.Style = [fsBold, fsItalic]
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        OnClick = S11Click
      end
      object SpeedButton1: TSpeedButton
        Left = 104
        Top = 10
        Width = 23
        Height = 23
        Flat = True
        Glyph.Data = {
          66010000424D6601000000000000760000002800000014000000140000000100
          040000000000F000000000000000000000001000000000000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
          FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF77777777FFFFFFFF0000FF00
          000000007FFFFFFF0000FF0BFFFBFFF0777777FF0000FF0F444444F00000007F
          0000FF0FFBFFFBF0FBFFF07F0000FF0F444444F04444F07F0000FF0BFFFBFFF0
          FFFBF07F0000FF0F444444F04444F07F0000FF0FFBFFFBF0FBFFF07F0000FF0F
          44F000004440F07F0000FF0BFFF0FFF0FFFBF07F0000FF0F44F0FB00F000007F
          0000FF0FFBF0F0FFF0FFF0FF0000FF0000000F44F0FB0FFF0000FFFFFFFF0FFB
          F0F0FFFF0000FFFFFFFF0000000FFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
          FFFFFFFFFFFFFFFF0000}
        OnClick = SpeedButton1Click
      end
      object SpeedButton2: TSpeedButton
        Left = 80
        Top = 10
        Width = 23
        Height = 23
        Flat = True
        Glyph.Data = {
          66010000424D6601000000000000760000002800000014000000140000000100
          040000000000F000000000000000000000001000000000000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
          FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
          00000000000FFFFF0000FFF0888888888080FFFF0000FF000000000000080FFF
          0000FF0888888BBB88000FFF0000FF088888877788080FFF0000FF0000000000
          000880FF0000FF0888888888808080FF0000FFF000000000080800FF0000FFFF
          0FFFFFFFF08080FF0000FFFFF0F00000F0000FFF0000FFFFF0FFFFFFFF0FFFFF
          0000FFFFFF0F00000F0FFFFF0000FFFFFF0FFFFFFFF0FFFF0000FFFFFFF00000
          0000FFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
          FFFFFFFFFFFFFFFF0000}
        OnClick = SpeedButton2Click
      end
      object Button4: TButton
        Left = 32
        Top = 408
        Width = 161
        Height = 25
        Caption = 'QR-Code erzeugen '
        TabOrder = 0
        OnClick = Button4Click
      end
      object Memo2: TMemo
        Left = 12
        Top = 40
        Width = 201
        Height = 313
        TabOrder = 1
        WantTabs = True
      end
      object Edit1: TEdit
        Left = 120
        Top = 368
        Width = 49
        Height = 24
        TabOrder = 2
        Text = '5'
        OnChange = Button4Click
      end
      object UpDown1: TUpDown
        Left = 169
        Top = 368
        Width = 16
        Height = 24
        Associate = Edit1
        Min = 1
        Position = 5
        TabOrder = 3
        Wrap = False
      end
    end
    object Panel3: TPanel
      Left = 0
      Top = 0
      Width = 599
      Height = 471
      Align = alClient
      BevelOuter = bvNone
      Color = clWhite
      TabOrder = 1
      OnResize = Panel3Resize
      object Image3: TImage
        Left = 89
        Top = 0
        Width = 421
        Height = 471
        Align = alClient
        Stretch = True
      end
      object Panel4: TPanel
        Left = 0
        Top = 0
        Width = 89
        Height = 471
        Align = alLeft
        BevelOuter = bvNone
        Color = clWhite
        TabOrder = 0
      end
      object Panel5: TPanel
        Left = 510
        Top = 0
        Width = 89
        Height = 471
        Align = alRight
        BevelOuter = bvNone
        Color = clWhite
        TabOrder = 1
      end
    end
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = 'txt'
    Filter = 'Textdatei (*.txt)|*.txt'
    Left = 779
    Top = 360
  end
end
