object zusatzbild2: Tzusatzbild2
  Left = 532
  Top = 91
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Pentomino-Lösung'
  ClientHeight = 223
  ClientWidth = 288
  Color = 15790320
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PopupMenu = PM1
  Position = poDefault
  Scaled = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object I1: TImage
    Left = 0
    Top = 0
    Width = 288
    Height = 223
    Align = alClient
  end
  object PM1: TPopupMenu
    Left = 56
    Top = 24
    object M2: TMenuItem
      Caption = 'ende'
      ShortCut = 27
      Visible = False
      OnClick = M2Click
    end
    object M11: TMenuItem
      Caption = 'Bild kopieren'
    end
    object M1: TMenuItem
      Caption = 'Bild drucken'
    end
  end
end
