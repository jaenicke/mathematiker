object ftictac: Tftictac
  Left = 221
  Top = 43
  Width = 969
  Height = 753
  Caption = 'Tic-Tac-Toe'
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clBlack
  Font.Height = -12
  Font.Name = 'Verdana'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 14
  object Panel5: TPanel
    Left = 0
    Top = 0
    Width = 953
    Height = 714
    Align = alClient
    BevelOuter = bvNone
    Color = clWhite
    TabOrder = 0
    object Panel2: TPanel
      Left = 0
      Top = 0
      Width = 953
      Height = 714
      Align = alClient
      BevelOuter = bvNone
      Color = clWhite
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      object Panel3: TPanel
        Left = 0
        Top = 0
        Width = 201
        Height = 714
        Align = alLeft
        BevelOuter = bvNone
        Color = 15790320
        TabOrder = 0
        object Label1: TLabel
          Left = 64
          Top = 116
          Width = 5
          Height = 16
          Alignment = taCenter
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Verdana'
          Font.Style = []
          ParentFont = False
        end
        object Label2: TLabel
          Left = 24
          Top = 164
          Width = 5
          Height = 16
          Alignment = taCenter
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Verdana'
          Font.Style = []
          ParentFont = False
        end
        object pb2: TPaintBox
          Left = 8
          Top = 192
          Width = 185
          Height = 169
          OnPaint = pb2Paint
        end
        object Label3: TLabel
          Left = 16
          Top = 140
          Width = 80
          Height = 16
          Caption = 'Ergebnisse'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -13
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label4: TLabel
          Left = 12
          Top = 376
          Width = 184
          Height = 154
          Caption = 
            'Spieler (blaues Kreuz) '#13#10'und Computer (roter Kreis) '#13#10'w'#228'hlen abw' +
            'echselnd ein '#13#10'freies Feld aus.'#13#10'Dazu ist mit der linken '#13#10'Maust' +
            'aste auf das Feld zu '#13#10'klicken.'#13#10'Sieger ist, wer in einer Zeile,' +
            ' '#13#10'Spalte oder Diagonale '#13#10'drei Zeichen positionieren '#13#10'kann.'
        end
        object Label5: TLabel
          Left = 24
          Top = 92
          Width = 151
          Height = 14
          Caption = 'Intelligenz                  %'
        end
        object Button1: TButton
          Left = 24
          Top = 24
          Width = 145
          Height = 25
          Caption = 'Neues Spiel'
          Default = True
          TabOrder = 1
          OnClick = Button1Click
        end
        object Button2: TButton
          Left = 8
          Top = 544
          Width = 182
          Height = 25
          Caption = 'Computer gegen Computer'
          TabOrder = 2
          OnClick = Button2Click
        end
        object CheckBox1: TCheckBox
          Left = 24
          Top = 60
          Width = 145
          Height = 17
          Caption = 'Computer beginnt'
          TabOrder = 0
        end
        object Spin1: TSpinEdit
          Left = 96
          Top = 88
          Width = 57
          Height = 23
          MaxValue = 100
          MinValue = 0
          TabOrder = 3
          Value = 100
        end
        object Liste: TListBox
          Left = 24
          Top = 584
          Width = 121
          Height = 97
          ItemHeight = 14
          Items.Strings = (
            '000000000'#9'123456789'
            '100000000'#9'5'
            '010000000'#9'5'
            '001000000'#9'5'
            '000100000'#9'5'
            '000010000'#9'1379'
            '000001000'#9'5'
            '000000100'#9'5'
            '000000010'#9'5'
            '000000001'#9'5'
            '200000000'#9'5'
            '020000000'#9'5'
            '002000000'#9'5'
            '000200000'#9'5'
            '000020000'#9'1379'
            '000002000'#9'5'
            '000000200'#9'5'
            '000000020'#9'5'
            '000000002'#9'5')
          TabOrder = 4
          Visible = False
        end
      end
      object Panel1: TPanel
        Left = 201
        Top = 0
        Width = 752
        Height = 714
        Align = alClient
        BevelOuter = bvNone
        Color = clWhite
        TabOrder = 1
        object pb1: TPaintBox
          Left = 0
          Top = 0
          Width = 752
          Height = 714
          Align = alClient
          OnMouseDown = pb1MouseDown
          OnPaint = pb1Paint
        end
      end
    end
  end
  object Timer1: TTimer
    Interval = 50
    OnTimer = Timer1Timer
    Left = 144
    Top = 264
  end
end
