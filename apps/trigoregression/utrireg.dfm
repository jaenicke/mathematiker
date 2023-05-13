object Form1: TForm1
  Left = 317
  Top = 39
  HelpContext = 108
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Trigonometrische Regression'
  ClientHeight = 711
  ClientWidth = 1032
  Color = 15790320
  Font.Charset = ANSI_CHARSET
  Font.Color = clBlack
  Font.Height = -12
  Font.Name = 'Verdana'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 14
  object Panel5: TPanel
    Left = 0
    Top = 0
    Width = 1032
    Height = 711
    Align = alClient
    BevelOuter = bvNone
    Color = clWhite
    TabOrder = 0
    object Panel1: TPanel
      Left = 0
      Top = 0
      Width = 1032
      Height = 711
      Align = alClient
      BevelOuter = bvNone
      Color = clWhite
      TabOrder = 0
      object trigoreg: TPanel
        Left = 0
        Top = 0
        Width = 1032
        Height = 711
        Align = alClient
        BevelOuter = bvNone
        Caption = 'kquadrate'
        Color = clWhite
        TabOrder = 0
        object Panel4: TPanel
          Left = 0
          Top = 0
          Width = 249
          Height = 711
          Align = alLeft
          BevelOuter = bvNone
          Color = 15790320
          TabOrder = 0
          object Label6: TLabel
            Left = 16
            Top = 16
            Width = 79
            Height = 14
            Caption = 'Wertepaare'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -12
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label1: TLabel
            Left = 32
            Top = 296
            Width = 83
            Height = 14
            Caption = 'Anzahl Paare'
          end
          object Label2: TLabel
            Left = 136
            Top = 296
            Width = 5
            Height = 14
            Caption = '-'
          end
          object S1: TSpeedButton
            Left = 214
            Top = 12
            Width = 23
            Height = 23
            Caption = 'x'
            Flat = True
            OnClick = S1X
          end
          object Label4: TLabel
            Left = 16
            Top = 360
            Width = 78
            Height = 14
            Caption = 'Zielfunktion'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -12
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label5: TLabel
            Left = 32
            Top = 384
            Width = 163
            Height = 18
            Caption = 'y = a sin (bx + c) + d'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -15
            Font.Name = 'Verdana'
            Font.Style = []
            ParentFont = False
          end
          object Label3: TLabel
            Left = 16
            Top = 552
            Width = 141
            Height = 14
            Caption = 'maximaler Wert f'#252'r |b|'
          end
          object S11: TSpeedButton
            Left = 188
            Top = 12
            Width = 23
            Height = 22
            Caption = 'B'
            Flat = True
            OnClick = S11C
          end
          object Button1: TButton
            Left = 48
            Top = 320
            Width = 153
            Height = 25
            Caption = 'Berechnung'
            TabOrder = 11
            OnClick = D18C
          end
          object SG4: TStringGrid
            Left = 12
            Top = 40
            Width = 229
            Height = 241
            BorderStyle = bsNone
            Color = clWhite
            ColCount = 3
            DefaultColWidth = 70
            DefaultRowHeight = 19
            FixedColor = 15790320
            FixedCols = 0
            RowCount = 201
            Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing, goTabs]
            ScrollBars = ssVertical
            TabOrder = 0
          end
          object Edit1: TEdit
            Left = 112
            Top = 437
            Width = 121
            Height = 22
            TabOrder = 1
          end
          object Edit2: TEdit
            Left = 112
            Top = 461
            Width = 121
            Height = 22
            TabOrder = 2
          end
          object Edit3: TEdit
            Left = 112
            Top = 485
            Width = 121
            Height = 22
            TabOrder = 3
          end
          object Edit4: TEdit
            Left = 112
            Top = 509
            Width = 121
            Height = 22
            TabOrder = 4
          end
          object rt1: TRadioButton
            Left = 16
            Top = 416
            Width = 217
            Height = 17
            Caption = 'alle Parameter berechnen'
            Checked = True
            TabOrder = 5
            TabStop = True
          end
          object rt2: TRadioButton
            Left = 16
            Top = 440
            Width = 89
            Height = 17
            Caption = 'a ist fest ='
            TabOrder = 6
          end
          object rt3: TRadioButton
            Left = 16
            Top = 464
            Width = 89
            Height = 17
            Caption = 'b ist fest ='
            TabOrder = 7
          end
          object rt4: TRadioButton
            Left = 16
            Top = 488
            Width = 89
            Height = 17
            Caption = 'c ist fest ='
            TabOrder = 8
          end
          object rt5: TRadioButton
            Left = 16
            Top = 512
            Width = 89
            Height = 17
            Caption = 'd ist fest ='
            TabOrder = 9
          end
          object Edit5: TEdit
            Left = 168
            Top = 549
            Width = 65
            Height = 22
            TabOrder = 10
            Text = '200'
          end
        end
        object Panel3: TPanel
          Left = 249
          Top = 0
          Width = 783
          Height = 711
          Align = alClient
          BevelOuter = bvNone
          Color = clWhite
          TabOrder = 1
          object PB4: TPaintBox
            Left = 0
            Top = 0
            Width = 783
            Height = 499
            Align = alClient
            OnPaint = PB4Paint
          end
          object Panel2: TPanel
            Left = 0
            Top = 499
            Width = 783
            Height = 212
            Align = alBottom
            BevelOuter = bvNone
            Color = 15790320
            TabOrder = 0
            object Panel6: TPanel
              Left = 0
              Top = 0
              Width = 783
              Height = 25
              Align = alTop
              Alignment = taLeftJustify
              Caption = 'Summe der Fehlerquadrate         Funktion'
              Color = 15790320
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -12
              Font.Name = 'Verdana'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 0
            end
            object Listbox1: TListBox
              Left = 0
              Top = 25
              Width = 783
              Height = 187
              Align = alClient
              BorderStyle = bsNone
              Color = clWhite
              ItemHeight = 14
              Sorted = True
              TabOrder = 1
              TabWidth = 100
              OnClick = Listbox1Click
            end
          end
        end
      end
    end
  end
end
