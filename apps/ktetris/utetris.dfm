object GBoard: TGBoard
  Left = 726
  Top = 67
  HelpContext = 131
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Tetris'
  ClientHeight = 416
  ClientWidth = 373
  Color = 15790320
  Font.Charset = ANSI_CHARSET
  Font.Color = clBlack
  Font.Height = -12
  Font.Name = 'Verdana'
  Font.Style = [fsBold]
  Menu = MM1
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 14
  object S6: TShape
    Left = 244
    Top = 237
    Width = 94
    Height = 25
    Brush.Style = bsClear
    Pen.Color = clRed
  end
  object S2: TShape
    Left = 215
    Top = 3
    Width = 154
    Height = 409
    Brush.Style = bsClear
    Pen.Color = clBlue
  end
  object S4: TShape
    Left = 244
    Top = 133
    Width = 94
    Height = 25
    Brush.Style = bsClear
    Pen.Color = clRed
  end
  object L9: TLabel
    Left = 248
    Top = 136
    Width = 87
    Height = 20
    AutoSize = False
    Caption = '0'
    Color = clWhite
    ParentColor = False
  end
  object S1: TShape
    Left = 2
    Top = 3
    Width = 211
    Height = 409
    Brush.Style = bsClear
    Pen.Color = clBlue
  end
  object PB1: TPaintBox
    Left = 6
    Top = 6
    Width = 203
    Height = 403
    Color = clBlack
    ParentColor = False
    OnPaint = PB1Paint
  end
  object L1: TLabel
    Left = 244
    Top = 11
    Width = 97
    Height = 14
    Caption = 'N'#228'chster Stein'
  end
  object L2: TLabel
    Left = 243
    Top = 114
    Width = 46
    Height = 14
    Caption = 'Punkte'
  end
  object PB2: TPaintBox
    Left = 256
    Top = 30
    Width = 67
    Height = 67
    Color = clAqua
    ParentColor = False
    OnPaint = PB2Paint
  end
  object L5: TLabel
    Left = 243
    Top = 166
    Width = 40
    Height = 14
    Caption = 'Linien'
  end
  object S5: TShape
    Left = 244
    Top = 184
    Width = 94
    Height = 25
    Brush.Style = bsClear
    Pen.Color = clRed
  end
  object L8: TLabel
    Left = 248
    Top = 187
    Width = 87
    Height = 20
    AutoSize = False
    Caption = '0'
    Color = clWhite
    ParentColor = False
  end
  object L6: TLabel
    Left = 243
    Top = 219
    Width = 66
    Height = 14
    Caption = 'Spielstufe'
  end
  object L7: TLabel
    Left = 248
    Top = 240
    Width = 87
    Height = 20
    AutoSize = False
    Caption = '0'
    Color = clWhite
    ParentColor = False
  end
  object L4: TLabel
    Left = 257
    Top = 283
    Width = 65
    Height = 14
    Caption = 'Spielende'
  end
  object L3: TLabel
    Left = 224
    Top = 328
    Width = 130
    Height = 70
    Caption = 
      'Steuerung:'#13#10'Pfeiltasten links, '#13#10'rechts, abw'#228'rts'#13#10'Leertaste dreh' +
      't das '#13#10'Einzelteil'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
  end
  object MM1: TMainMenu
    Left = 200
    Top = 16
    object M1: TMenuItem
      Caption = 'Ende'
      ShortCut = 27
      OnClick = M1C
    end
    object M2: TMenuItem
      Caption = 'Neustart'
      OnClick = M2C
    end
  end
end
