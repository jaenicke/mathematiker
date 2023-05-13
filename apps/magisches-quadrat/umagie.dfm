object Form1: TForm1
  Left = 191
  Top = 117
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Magisches Quadrat'
  ClientHeight = 336
  ClientWidth = 297
  Color = clWhite
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Verdana'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 16
  object Button1: TButton
    Left = 48
    Top = 296
    Width = 185
    Height = 25
    Caption = 'Magisches Quadrat'
    TabOrder = 0
    OnClick = Button1Click
  end
  object StringGrid1: TStringGrid
    Left = 16
    Top = 16
    Width = 273
    Height = 273
    BorderStyle = bsNone
    ColCount = 4
    DefaultRowHeight = 64
    FixedCols = 0
    RowCount = 4
    FixedRows = 0
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -37
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
  end
end
