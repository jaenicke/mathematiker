object Form1: TForm1
  Left = 850
  Top = 164
  BorderStyle = bsSingle
  Caption = 'Ampel'
  ClientHeight = 284
  ClientWidth = 313
  Color = clWhite
  Font.Charset = ANSI_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Verdana'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 16
  object Shape1: TShape
    Left = 24
    Top = 24
    Width = 97
    Height = 249
    Brush.Color = clGradientInactiveCaption
  end
  object Shape2: TShape
    Left = 40
    Top = 32
    Width = 65
    Height = 65
    Brush.Color = clBtnShadow
    Shape = stCircle
  end
  object Shape3: TShape
    Left = 40
    Top = 112
    Width = 65
    Height = 65
    Brush.Color = clBtnShadow
    Shape = stCircle
  end
  object Shape4: TShape
    Left = 40
    Top = 192
    Width = 65
    Height = 65
    Brush.Color = clBtnShadow
    Shape = stCircle
  end
  object Button1: TButton
    Left = 176
    Top = 24
    Width = 75
    Height = 25
    Caption = ' Rot'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 176
    Top = 56
    Width = 75
    Height = 25
    Caption = 'Gelb'
    TabOrder = 1
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 176
    Top = 88
    Width = 75
    Height = 25
    Caption = 'Gr'#252'n'
    TabOrder = 2
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 136
    Top = 168
    Width = 160
    Height = 25
    Caption = 'Ampel deaktivieren'
    TabOrder = 3
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 136
    Top = 240
    Width = 160
    Height = 25
    Caption = 'Programm schlie'#223'en'
    TabOrder = 4
    OnClick = Button5Click
  end
  object Button6: TButton
    Left = 136
    Top = 200
    Width = 160
    Height = 25
    Caption = 'Ampel zur'#252'cksetzen'
    TabOrder = 5
    OnClick = Button6Click
  end
  object Button7: TButton
    Left = 136
    Top = 136
    Width = 160
    Height = 25
    Caption = 'Ampel simulieren'
    TabOrder = 6
    OnClick = Button7Click
  end
  object Timer1: TTimer
    Enabled = False
    OnTimer = Timer1Timer
    Left = 272
    Top = 40
  end
  object Timer2: TTimer
    Enabled = False
    OnTimer = Timer2Timer
    Left = 272
    Top = 8
  end
end
