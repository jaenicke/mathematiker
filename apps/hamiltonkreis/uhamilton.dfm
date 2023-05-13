object feuler: Tfeuler
  Left = 349
  Top = 36
  HelpContext = 119
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Euler- und Hamiltonkreise'
  ClientHeight = 749
  ClientWidth = 1120
  Color = 15790320
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Verdana'
  Font.Style = []
  Menu = MM1
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 14
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 1120
    Height = 749
    Align = alClient
    BevelOuter = bvNone
    Caption = 'Panel2'
    TabOrder = 0
    object Panel4: TPanel
      Left = 0
      Top = 0
      Width = 1120
      Height = 749
      Align = alClient
      BevelOuter = bvNone
      Color = clWhite
      TabOrder = 0
      object eulergraph: TPanel
        Left = 0
        Top = 0
        Width = 1120
        Height = 749
        Align = alClient
        BevelOuter = bvNone
        Color = clWhite
        TabOrder = 0
        object Panel12: TPanel
          Left = 0
          Top = 0
          Width = 201
          Height = 749
          Align = alLeft
          BevelOuter = bvNone
          Color = 15790320
          TabOrder = 0
          object Label3: TLabel
            Left = 16
            Top = 106
            Width = 74
            Height = 14
            Caption = 'Knotenliste'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -12
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label4: TLabel
            Left = 24
            Top = 242
            Width = 25
            Height = 14
            Caption = 'X = '
          end
          object Label5: TLabel
            Left = 24
            Top = 266
            Width = 24
            Height = 14
            Caption = 'Y = '
          end
          object Label6: TLabel
            Left = 16
            Top = 368
            Width = 74
            Height = 14
            Caption = 'Kantenliste'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -12
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label7: TLabel
            Left = 120
            Top = 394
            Width = 64
            Height = 56
            Caption = 'Kante von'#13#10#13#10#13#10'bis'
          end
          object B_Knoten: TButton
            Left = 24
            Top = 296
            Width = 153
            Height = 25
            Caption = 'Knoten hinzufügen'
            TabOrder = 9
            OnClick = B_KnotenC
          end
          object B_Loeschen: TButton
            Left = 24
            Top = 328
            Width = 73
            Height = 25
            Caption = 'Löschen'
            TabOrder = 10
            OnClick = B_LoeschenC
          end
          object B_Kante: TButton
            Left = 16
            Top = 488
            Width = 169
            Height = 25
            Caption = 'Kante hinzufügen'
            TabOrder = 11
            OnClick = B_KanteC
          end
          object B_KanteLoeschen: TButton
            Left = 16
            Top = 520
            Width = 169
            Height = 25
            Caption = 'Kante löschen'
            TabOrder = 12
            OnClick = B_KanteLoeschenC
          end
          object B_Aendern: TButton
            Left = 104
            Top = 328
            Width = 73
            Height = 25
            Caption = 'Ändern'
            TabOrder = 13
            OnClick = B_AendernC
          end
          object B_Suchen: TButton
            Left = 16
            Top = 601
            Width = 169
            Height = 25
            Caption = 'Eulerkreis suchen'
            TabOrder = 14
            OnClick = B_SuchenC
          end
          object B_Anzeige: TButton
            Left = 16
            Top = 633
            Width = 169
            Height = 25
            Caption = 'Eulerkreis anzeigen'
            TabOrder = 15
            OnClick = B_AnzeigeC
          end
          object LKnoten: TListBox
            Left = 16
            Top = 128
            Width = 177
            Height = 102
            Color = clWhite
            IntegralHeight = True
            ItemHeight = 14
            TabOrder = 0
            TabWidth = 20
            OnDblClick = LB7C
          end
          object EditX: TEdit
            Left = 56
            Top = 240
            Width = 121
            Height = 22
            Color = clWhite
            TabOrder = 1
          end
          object EditY: TEdit
            Left = 56
            Top = 264
            Width = 121
            Height = 22
            Color = clWhite
            TabOrder = 2
          end
          object LKanten: TListBox
            Left = 16
            Top = 392
            Width = 89
            Height = 88
            Color = clWhite
            IntegralHeight = True
            ItemHeight = 14
            Sorted = True
            TabOrder = 3
            TabWidth = 20
          end
          object Edit1: TEdit
            Left = 136
            Top = 412
            Width = 40
            Height = 22
            Color = clWhite
            TabOrder = 4
          end
          object Edit2: TEdit
            Left = 136
            Top = 452
            Width = 40
            Height = 22
            Color = clWhite
            TabOrder = 5
          end
          object C_Punkte: TCheckBox
            Left = 24
            Top = 558
            Width = 153
            Height = 17
            Caption = 'Punkte beschriften'
            Checked = True
            State = cbChecked
            TabOrder = 6
            OnClick = kp1Paint
          end
          object CB_Pfad: TCheckBox
            Left = 24
            Top = 576
            Width = 169
            Height = 17
            Caption = 'nur Hamilton-Pfad'
            TabOrder = 7
            Visible = False
            OnClick = CB6C
          end
          object R1: TRadioGroup
            Left = 16
            Top = 40
            Width = 177
            Height = 57
            ItemIndex = 0
            Items.Strings = (
              'Eulerkreis'
              'Hamiltonkreis')
            TabOrder = 8
            OnClick = R1C
          end
          object lh1: TListBox
            Left = 24
            Top = 680
            Width = 121
            Height = 97
            ItemHeight = 14
            Items.Strings = (
              'Dodekaeder-Graph'
              'Antiprismen-Graph 4'
              'Antiprismen-Graph 5'
              'Desargues-Graph'
              'Haus des Nikolaus'
              'Haus des Nikolaus 2'
              'Haus des Nikolaus (doppelt)'
              'Euler-Graph 1'
              'Euler-Graph 2'
              'Voll-bipartiter Graph 3,3'
              'Voll-bipartiter Graph 3,4'
              'Voll-bipartiter Graph 4,5'
              'Königsweg auf 3x3-Brett'
              'Königsweg auf 4x4-Brett'
              'Königsberger Brückengraph'
              'Prisma-4-Graph'
              'Springerzug auf 5x5-Brett'
              'Vollständiger Graph K5'
              'Vollständiger Graph K6'
              'Vollständiger Graph K7'
              'Vollständiger Graph K9'
              'Antiprismen-Graph 3'
              'Antiprismen-Graph 6'
              'Cocktail-Party-Graph 3'
              'Cocktail-Party-Graph 4'
              'Hanoi-Graph'
              'Hanoi-Graph 3'
              'Kuboktaeder-Graph'
              'Oktaeder-Graph'
              'Würfel-Graph'
              'Tetraederstumpf-Graph'
              'Petersen-Graph'
              '[Petersen-Graph'
              'A'#9'(0.76|2.14)'
              'B'#9'(-2.5|-0.78)'
              'C'#9'(2.26|-0.2)'
              'D'#9'(-1.42|-2.06)'
              'E'#9'(1.5|-2)'
              'F'#9'(2.04|1.04)'
              'G'#9'(-2.24|0.94)'
              'H'#9'(0.14|-2.58)'
              'I'#9'(-1.06|1.94)'
              'J'#9'(0|0)'
              '#'
              'A-F'
              'A-I'
              'A-J'
              'B-D'
              'B-G'
              'B-J'
              'C-E'
              'C-F'
              'C-G'
              'D-F'
              'D-H'
              'E-H'
              'E-J'
              'G-I'
              'H-I'
              '#'
              '[Tetraederstumpf-Graph'
              'A'#9'(-1|1)'
              'B'#9'(1|1)'
              'C'#9'(0|-1)'
              'D'#9'(-1.5|1.5)'
              'E'#9'(1.5|1.5)'
              'F'#9'(0|-1.5)'
              'G'#9'(-2|3)'
              'H'#9'(2|3)'
              'I'#9'(-3|1)'
              'J'#9'(-1.5|-2.5)'
              'K'#9'(1.5|-2.5)'
              'L'#9'(3|1)'
              '#'
              'A-B'
              'A-C'
              'A-D'
              'B-C'
              'B-E'
              'C-F'
              'D-G'
              'D-I'
              'E-H'
              'E-L'
              'F-J'
              'F-K'
              'G-H'
              'G-I'
              'H-L'
              'I-J'
              'J-K'
              'K-L'
              '#'
              '[Würfel-Graph'
              'A'#9'(-1|1)'
              'B'#9'(1|1)'
              'C'#9'(-1|-1)'
              'D'#9'(1|-1)'
              'E'#9'(-2|2)'
              'F'#9'(2|2)'
              'G'#9'(-2|-2)'
              'H'#9'(2|-2)'
              '#'
              'A-B'
              'A-C'
              'A-E'
              'B-D'
              'B-F'
              'C-D'
              'C-G'
              'D-H'
              'E-F'
              'E-G'
              'F-H'
              'G-H'
              '#'
              '[Oktaeder-Graph'
              'A'#9'(-0.5|0.5)'
              'B'#9'(0.5|0.5)'
              'C'#9'(0|-0.5)'
              'D'#9'(2|-1)'
              'E'#9'(0|2.5)'
              'F'#9'(-2|-1)'
              '#'
              'A-B'
              'A-C'
              'A-E'
              'A-F'
              'B-C'
              'B-D'
              'B-E'
              'C-D'
              'C-F'
              'D-E'
              'D-F'
              'E-F'
              '#'
              '[Kuboktaeder-Graph'
              'A'#9'(-1|1)'
              'B'#9'(1|1)'
              'C'#9'(1|-1)'
              'D'#9'(-1|-1)'
              'E'#9'(-1.5|-1.5)'
              'F'#9'(-1.5|1.5)'
              'G'#9'(1.5|-1.5)'
              'H'#9'(1.5|1.5)'
              'I'#9'(-2|0)'
              'J'#9'(0|2)'
              'K'#9'(2|0)'
              'L'#9'(0|-2)'
              '#'
              'A-B'
              'A-D'
              'A-I'
              'A-J'
              'B-C'
              'B-J'
              'B-K'
              'C-D'
              'C-K'
              'C-L'
              'D-I'
              'D-L'
              'E-F'
              'E-G'
              'E-I'
              'E-L'
              'F-H'
              'F-I'
              'F-J'
              'G-H'
              'G-K'
              'G-L'
              'H-J'
              'H-K'
              '#'
              '[Haus des Nikolaus 2'
              'A'#9'(2|-2)'
              'B'#9'(2|1)'
              'C'#9'(-2|1)'
              'D'#9'(-2|-2)'
              'E'#9'(0|4)'
              'F'#9'(0|-0.5)'
              '#'
              'A-B'
              'A-D'
              'A-F'
              'B-C'
              'B-E'
              'B-F'
              'C-D'
              'C-E'
              'C-F'
              'D-F'
              '#'
              '[Hanoi-Graph 3'
              'A'#9'(-2.56|-2.36)'
              'B'#9'(2.56|-2.36)'
              'C'#9'(-0.12|2.62)'
              'D'#9'(-1.5|-0.4)'
              'E'#9'(-0.46|-2.36)'
              'F'#9'(-1|0.72)'
              'G'#9'(0.32|-2.36)'
              'H'#9'(1.44|-0.36)'
              'I'#9'(0.9|0.72)'
              'J'#9'(-1.86|-2.36)'
              'K'#9'(-1.12|-2.36)'
              'L'#9'(-2.2|-1.72)'
              'M'#9'(-1.84|-1.08)'
              'N'#9'(-1.1|-1.08)'
              'O'#9'(-0.74|-1.72)'
              'P'#9'(1|-1.1)'
              'Q'#9'(0.7|-1.68)'
              'R'#9'(1.84|-1.1)'
              'S'#9'(2.16|-1.7)'
              'T'#9'(1.84|-2.36)'
              'U'#9'(1.1|-2.36)'
              'V'#9'(-0.46|0.72)'
              'W'#9'(0.16|0.72)'
              'X'#9'(-0.66|1.4)'
              'Y'#9'(-0.44|1.92)'
              'Z'#9'(0.52|1.36)'
              '['#9'(0.28|1.92)'
              '#'
              'A-J'
              'A-L'
              'B-S'
              'B-T'
              'C-['
              'C-Y'
              'D-F'
              'D-M'
              'D-N'
              'E-G'
              'E-K'
              'E-O'
              'F-V'
              'F-X'
              'G-Q'
              'G-U'
              'H-I'
              'H-P'
              'H-R'
              'I-W'
              'I-Z'
              'J-K'
              'J-L'
              'K-O'
              'L-M'
              'M-N'
              'N-O'
              'P-Q'
              'P-R'
              'Q-U'
              'R-S'
              'S-T'
              'T-U'
              'V-W'
              'V-X'
              'W-Z'
              'X-Y'
              'Y-['
              'Z-['
              '#'
              '[Hanoi-Graph'
              'A'#9'(-2.56|-2.36)'
              'B'#9'(1.26|-2.36)'
              'C'#9'(-0.64|1.18)'
              'D'#9'(-1.98|-1.38)'
              'E'#9'(-1.46|-2.36)'
              'F'#9'(-1.2|0.14)'
              'G'#9'(0.32|-2.36)'
              'H'#9'(0.78|-1.4)'
              'I'#9'(-0.04|0.14)'
              '#'
              'A-D'
              'A-E'
              'B-G'
              'B-H'
              'C-F'
              'C-I'
              'D-E'
              'D-F'
              'E-G'
              'F-I'
              'G-H'
              'H-I'
              '#'
              '[Cocktail-Party-Graph 3'
              'A'#9'(-2|1)'
              'B'#9'(0|2)'
              'C'#9'(2|1)'
              'D'#9'(-2|-1)'
              'E'#9'(0|-2)'
              'F'#9'(2|-1)'
              '#'
              'A-B'
              'A-C'
              'A-E'
              'A-F'
              'B-C'
              'B-D'
              'B-F'
              'C-D'
              'C-E'
              'D-E'
              'D-F'
              'E-F'
              '#'
              '[Cocktail-Party-Graph 4'
              'A'#9'(-2|1)'
              'B'#9'(-1|2)'
              'C'#9'(2|1)'
              'D'#9'(-2|-1)'
              'E'#9'(-1|-2)'
              'F'#9'(2|-1)'
              'G'#9'(1|-2)'
              'H'#9'(1|2)'
              '#'
              'A-B'
              'A-C'
              'A-E'
              'A-F'
              'A-G'
              'A-H'
              'B-C'
              'B-D'
              'B-F'
              'B-G'
              'B-H'
              'C-D'
              'C-E'
              'C-G'
              'C-H'
              'D-E'
              'D-F'
              'D-G'
              'D-H'
              'E-F'
              'E-G'
              'E-H'
              'F-G'
              'F-H'
              '#'
              '[Antiprismen-Graph 6'
              'A'#9'(-0.5|1)'
              'B'#9'(0.5|1)'
              'C'#9'(-1|0)'
              'D'#9'(-0.5|-1)'
              'E'#9'(0.5|-1)'
              'F'#9'(1|0)'
              'G'#9'(0|-2)'
              'H'#9'(-2|-1)'
              'I'#9'(-2|1)'
              'J'#9'(0|2)'
              'K'#9'(2|1)'
              'L'#9'(2|-1)'
              '#'
              'A-B'
              'A-C'
              'A-I'
              'A-J'
              'B-F'
              'B-J'
              'B-K'
              'C-D'
              'C-H'
              'C-I'
              'D-E'
              'D-G'
              'D-H'
              'E-F'
              'E-G'
              'E-L'
              'F-K'
              'F-L'
              'G-H'
              'G-L'
              'H-I'
              'I-J'
              'J-K'
              'K-L'
              '#'
              '[Antiprismen-Graph 3'
              'A'#9'(0.48|-0.58)'
              'B'#9'(-0.14|0.86)'
              'C'#9'(-1.04|-0.6)'
              'D'#9'(-2.96|0.72)'
              'E'#9'(0.44|-3.56)'
              'F'#9'(1.96|1.98)'
              '#'
              'A-B'
              'A-C'
              'A-E'
              'A-F'
              'B-C'
              'B-D'
              'B-F'
              'C-D'
              'C-E'
              'D-E'
              'D-F'
              'E-F'
              '#'
              '[Vollständiger Graph K5'
              'A'#9'(0|1.5)'
              'B'#9'(-1.5|0)'
              'C'#9'(1.5|0)'
              'D'#9'(-1|-2)'
              'E'#9'(1|-2)'
              '#'
              'A-B'
              'A-C'
              'A-D'
              'A-E'
              'B-C'
              'B-D'
              'B-E'
              'C-D'
              'C-E'
              'D-E'
              '#'
              '[Vollständiger Graph K6'
              'A'#9'(0|2)'
              'B'#9'(-2|-0.5)'
              'C'#9'(2|-0.5)'
              'D'#9'(-1|-2)'
              'E'#9'(1|-2)'
              'F'#9'(1.5|1)'
              '#'
              'A-B'
              'A-C'
              'A-D'
              'A-E'
              'A-F'
              'B-C'
              'B-D'
              'B-E'
              'B-F'
              'C-D'
              'C-E'
              'C-F'
              'D-E'
              'D-F'
              'E-F'
              '#'
              '[Vollständiger Graph K7'
              'A'#9'(0|2)'
              'B'#9'(-2|-0.5)'
              'C'#9'(2|-0.5)'
              'D'#9'(-1|-2)'
              'E'#9'(1|-2)'
              'F'#9'(1.5|1)'
              'G'#9'(-1.5|1)'
              '#'
              'A-B'
              'A-C'
              'A-D'
              'A-E'
              'A-F'
              'A-G'
              'B-C'
              'B-D'
              'B-E'
              'B-F'
              'B-G'
              'C-D'
              'C-E'
              'C-F'
              'C-G'
              'D-E'
              'D-F'
              'D-G'
              'E-F'
              'E-G'
              'F-G'
              '#'
              '[Vollständiger Graph K9'
              'A'#9'(0.76|2.14)'
              'B'#9'(-2.5|-0.78)'
              'C'#9'(2.18|-0.78)'
              'D'#9'(-1.42|-2.06)'
              'E'#9'(1.5|-2)'
              'F'#9'(2.04|1.04)'
              'G'#9'(-2.24|0.94)'
              'H'#9'(0.14|-2.58)'
              'I'#9'(-1.06|1.94)'
              '#'
              'A-B'
              'A-C'
              'A-D'
              'A-E'
              'A-F'
              'A-G'
              'A-H'
              'A-I'
              'B-C'
              'B-D'
              'B-E'
              'B-F'
              'B-G'
              'B-H'
              'B-I'
              'C-D'
              'C-E'
              'C-F'
              'C-G'
              'C-H'
              'C-I'
              'D-E'
              'D-F'
              'D-G'
              'D-H'
              'D-I'
              'E-F'
              'E-G'
              'E-H'
              'E-I'
              'F-G'
              'F-H'
              'F-I'
              'G-H'
              'G-I'
              'H-I'
              '#'
              '[Springerzug auf 5x5-Brett'
              'A'#9'(-3|-3)'
              'B'#9'(-1.5|-3)'
              'C'#9'(0|-3)'
              'D'#9'(1.5|-3)'
              'E'#9'(-3|-1.5)'
              'F'#9'(-1.5|-1.5)'
              'G'#9'(0|-1.5)'
              'H'#9'(1.5|-1.5)'
              'I'#9'(-3|0)'
              'J'#9'(-1.5|0)'
              'K'#9'(0|0)'
              'L'#9'(1.5|0)'
              'M'#9'(-3|1.5)'
              'N'#9'(-1.5|1.5)'
              'O'#9'(0|1.5)'
              'P'#9'(1.5|1.5)'
              'Q'#9'(3|-3)'
              'R'#9'(3|-1.5)'
              'S'#9'(3|0)'
              'T'#9'(3|1.5)'
              'U'#9'(3|3)'
              'V'#9'(1.5|3)'
              'W'#9'(0|3)'
              'X'#9'(-1.5|3)'
              'Y'#9'(-3|3)'
              '#'
              'A-G'
              'A-J'
              'B-H'
              'B-I'
              'B-K'
              'C-E'
              'C-J'
              'C-L'
              'C-R'
              'D-F'
              'D-K'
              'D-S'
              'E-K'
              'E-N'
              'F-L'
              'F-M'
              'F-O'
              'G-I'
              'G-N'
              'G-P'
              'G-Q'
              'G-S'
              'H-J'
              'H-O'
              'H-T'
              'I-O'
              'I-X'
              'J-P'
              'J-W'
              'J-Y'
              'K-M'
              'K-R'
              'K-T'
              'K-V'
              'K-X'
              'L-N'
              'L-Q'
              'L-U'
              'L-W'
              'M-W'
              'N-V'
              'O-S'
              'O-U'
              'O-Y'
              'P-R'
              'P-X'
              'S-V'
              'T-W'
              '#'
              '[Prisma-4-Graph'
              'A'#9'(1|0)'
              'B'#9'(0|1)'
              'C'#9'(0|-1)'
              'D'#9'(-1|0)'
              'E'#9'(2|0)'
              'F'#9'(0|2)'
              'G'#9'(0|-2)'
              'H'#9'(-2|0)'
              '#'
              'A-B'
              'A-C'
              'A-E'
              'B-D'
              'B-F'
              'C-D'
              'C-G'
              'D-H'
              'E-F'
              'E-G'
              'F-H'
              'G-H'
              '#'
              '[Königsberger Brückengraph'
              'A'#9'(-2|0)'
              'B'#9'(-1|2)'
              'C'#9'(0|0)'
              'D'#9'(1.5|2)'
              'E'#9'(2|0)'
              'F'#9'(-1|-2)'
              'G'#9'(1.5|-2)'
              '#'
              'A-B'
              'A-C'
              'A-F'
              'B-C'
              'B-D'
              'C-E'
              'C-F'
              'D-E'
              'E-G'
              'F-G'
              '#'
              '[Königsweg auf 3x3-Brett'
              'A'#9'(-3|-3)'
              'B'#9'(0|-3)'
              'C'#9'(3|-3)'
              'D'#9'(-3|0)'
              'E'#9'(0|0)'
              'F'#9'(3|0)'
              'G'#9'(-3|3)'
              'H'#9'(0|3)'
              'I'#9'(3|3)'
              '#'
              'A-B'
              'A-D'
              'A-E'
              'B-C'
              'B-D'
              'B-E'
              'B-F'
              'C-E'
              'C-F'
              'D-E'
              'D-G'
              'D-H'
              'E-F'
              'E-G'
              'E-H'
              'E-I'
              'F-H'
              'F-I'
              'G-H'
              'H-I'
              '#'
              '[Königsweg auf 4x4-Brett'
              'A'#9'(-3|-3)'
              'B'#9'(-1|-3)'
              'C'#9'(1|-3)'
              'D'#9'(3|-3)'
              'E'#9'(-3|-1)'
              'F'#9'(-1|-1)'
              'G'#9'(1|-1)'
              'H'#9'(3|-1)'
              'I'#9'(-3|1)'
              'J'#9'(-1|1)'
              'K'#9'(1|1)'
              'L'#9'(3|1)'
              'M'#9'(-3|3)'
              'N'#9'(-1|3)'
              'O'#9'(1|3)'
              'P'#9'(3|3)'
              '#'
              'A-B'
              'A-E'
              'A-F'
              'B-C'
              'B-E'
              'B-F'
              'B-G'
              'C-D'
              'C-F'
              'C-G'
              'C-H'
              'D-G'
              'D-H'
              'E-F'
              'E-I'
              'E-J'
              'F-G'
              'F-I'
              'F-J'
              'F-K'
              'G-H'
              'G-J'
              'G-K'
              'G-L'
              'H-K'
              'H-L'
              'I-J'
              'I-M'
              'I-N'
              'J-K'
              'J-M'
              'J-N'
              'J-O'
              'K-L'
              'K-N'
              'K-O'
              'K-P'
              'L-O'
              'L-P'
              'M-N'
              'N-O'
              'O-P'
              '#'
              '[Voll-bipartiter Graph 3,3'
              'A'#9'(-1.68|1.22)'
              'B'#9'(-1.74|-0.52)'
              'C'#9'(-1.72|-2.04)'
              'D'#9'(1.36|0.28)'
              'E'#9'(1.34|-1.36)'
              'F'#9'(1.36|-2.64)'
              '#'
              'A-D'
              'A-E'
              'A-F'
              'B-D'
              'B-E'
              'B-F'
              'C-D'
              'C-E'
              'C-F'
              '#'
              '[Voll-bipartiter Graph 3,4'
              'A'#9'(-1.68|1.22)'
              'B'#9'(-1.74|-0.52)'
              'C'#9'(-1.72|-2.04)'
              'D'#9'(1.36|0.28)'
              'E'#9'(1.34|-1.36)'
              'F'#9'(1.36|-2.64)'
              'G'#9'(1.36|1.6)'
              '#'
              'A-D'
              'A-E'
              'A-F'
              'A-G'
              'B-D'
              'B-E'
              'B-F'
              'B-G'
              'C-D'
              'C-E'
              'C-F'
              'C-G'
              '#'
              '[Voll-bipartiter Graph 4,5'
              'A'#9'(-1.68|1.22)'
              'B'#9'(-1.74|-0.52)'
              'C'#9'(-1.72|-2.04)'
              'D'#9'(1.36|0.28)'
              'E'#9'(1.34|-1.36)'
              'F'#9'(1.36|-2.64)'
              'G'#9'(1.36|1.6)'
              'H'#9'(1.38|2.68)'
              'I'#9'(-1.66|2.68)'
              '#'
              'A-D'
              'A-E'
              'A-F'
              'A-G'
              'A-H'
              'B-D'
              'B-E'
              'B-F'
              'B-G'
              'B-H'
              'C-D'
              'C-E'
              'C-F'
              'C-G'
              'C-H'
              'D-I'
              'E-I'
              'F-I'
              'G-I'
              'H-I'
              '#'
              '[Euler-Graph 2'
              'A'#9'(2|-2)'
              'B'#9'(2|1)'
              'C'#9'(-2|1)'
              'D'#9'(-2|-2)'
              'E'#9'(0|4)'
              'F'#9'(0|-4)'
              'G'#9'(0|2)'
              'H'#9'(-2.5|-1)'
              'I'#9'(2.5|-1)'
              'J'#9'(0.5|2.5)'
              'K'#9'(-0.5|2.5)'
              'L'#9'(0|0)'
              '#'
              'B-E'
              'A-B'
              'A-C'
              'C-D'
              'B-D'
              'A-D'
              'B-C'
              'C-E'
              'A-F'
              'D-F'
              'B-F'
              'C-F'
              'B-G'
              'C-G'
              'D-H'
              'F-H'
              'A-I'
              'F-I'
              'D-I'
              'A-H'
              'E-J'
              'G-J'
              'E-K'
              'G-K'
              'E-G'
              'K-J'
              'B-J'
              'C-K'
              'B-L'
              'C-L'
              'G-L'
              'I-L'
              'H-L'
              '#'
              '[Euler-Graph 1'
              'A'#9'(2|-2)'
              'B'#9'(2|1)'
              'C'#9'(-2|1)'
              'D'#9'(-2|-2)'
              'E'#9'(0|4)'
              'F'#9'(0|-4)'
              '#'
              'B-E'
              'A-B'
              'A-C'
              'C-D'
              'B-D'
              'A-D'
              'B-C'
              'C-E'
              'A-F'
              'D-F'
              'B-F'
              'C-F'
              '#'
              '[Haus des Nikolaus'
              'A'#9'(2|-2)'
              'B'#9'(2|1)'
              'C'#9'(-2|1)'
              'D'#9'(-2|-2)'
              'E'#9'(0|4)'
              '#'
              'A-B'
              'A-C'
              'A-D'
              'B-C'
              'B-D'
              'B-E'
              'C-D'
              'C-E'
              '#'
              '[Desargues-Graph'
              'A'#9'(-3|-3)'
              'B'#9'(3|-3)'
              'C'#9'(1|-2)'
              'D'#9'(2|-2)'
              'E'#9'(-2|-1)'
              'F'#9'(0|-1)'
              'G'#9'(-2|-2)'
              'H'#9'(3|-1)'
              'I'#9'(2|2)'
              'J'#9'(-3|1)'
              'K'#9'(0|1)'
              'L'#9'(2|1)'
              'M'#9'(-3|3)'
              'N'#9'(-2|2)'
              'O'#9'(-1|2)'
              'P'#9'(1|2)'
              'Q'#9'(1|0)'
              'R'#9'(-1|-2)'
              'S'#9'(-1|0)'
              'T'#9'(3|3)'
              '#'
              'A-B'
              'A-G'
              'A-J'
              'B-D'
              'B-H'
              'C-D'
              'C-Q'
              'C-R'
              'D-L'
              'E-F'
              'E-G'
              'E-N'
              'F-H'
              'F-Q'
              'G-R'
              'H-T'
              'I-L'
              'I-P'
              'I-T'
              'J-K'
              'J-M'
              'K-L'
              'K-S'
              'M-N'
              'M-T'
              'N-O'
              'O-P'
              'O-S'
              'P-Q'
              'R-S'
              '#'
              '[Antiprismen-Graph 5'
              'A'#9'(-1.16|0.56)'
              'B'#9'(1.22|0.52)'
              'C'#9'(-0.8|-1)'
              'D'#9'(0.8|-1)'
              'E'#9'(1.7|2.5)'
              'F'#9'(-3|-1)'
              'G'#9'(3|-1)'
              'H'#9'(0|-3)'
              'I'#9'(0|1.5)'
              'J'#9'(-1.7|2.5)'
              '#'
              'A-C'
              'A-F'
              'A-I'
              'A-J'
              'B-D'
              'B-E'
              'B-G'
              'B-I'
              'C-D'
              'C-F'
              'C-H'
              'D-G'
              'D-H'
              'E-G'
              'E-I'
              'E-J'
              'F-H'
              'F-J'
              'G-H'
              'I-J'
              '#'
              '[Antiprismen-Graph 4'
              'A'#9'(-1|1)'
              'B'#9'(1|1)'
              'C'#9'(-1|-1)'
              'D'#9'(1|-1)'
              'E'#9'(0|3)'
              'F'#9'(-3|0)'
              'G'#9'(3|0)'
              'H'#9'(0|-3)'
              '#'
              'A-B'
              'A-C'
              'A-E'
              'A-F'
              'B-D'
              'B-E'
              'B-G'
              'C-D'
              'C-F'
              'C-H'
              'D-G'
              'D-H'
              'E-F'
              'E-G'
              'F-H'
              'G-H'
              '#'
              '[Dodekaeder-Graph'
              'A'#9'(1.98|-2.7)'
              'B'#9'(-1.82|-2.62)'
              'C'#9'(-3|1.04)'
              'D'#9'(2.98|0.98)'
              'E'#9'(0.08|2.9)'
              'F'#9'(-1.92|0.7)'
              'G'#9'(-1.12|-1.8)'
              'H'#9'(1.24|-1.74)'
              'I'#9'(2.14|0.48)'
              'J'#9'(0.06|1.88)'
              'K'#9'(-0.64|1.02)'
              'L'#9'(-1.18|-0.42)'
              'M'#9'(0.1|-1.24)'
              'N'#9'(1.3|-0.42)'
              'O'#9'(0.96|0.82)'
              'P'#9'(-0.18|0.46)'
              'Q'#9'(-0.58|-0.18)'
              'R'#9'(0.02|-0.6)'
              'S'#9'(0.7|-0.34)'
              'T'#9'(0.6|0.46)'
              '#'
              'A-B'
              'A-D'
              'A-H'
              'B-C'
              'B-G'
              'C-E'
              'C-F'
              'D-E'
              'D-I'
              'E-J'
              'F-K'
              'F-L'
              'G-L'
              'G-M'
              'H-M'
              'H-N'
              'I-N'
              'I-O'
              'J-K'
              'J-O'
              'K-P'
              'L-Q'
              'M-R'
              'N-S'
              'O-T'
              'P-Q'
              'P-T'
              'Q-R'
              'R-S'
              'S-T'
              '#'
              '[Haus des Nikolaus (doppelt)'
              'A'#9'(2|-1)'
              'B'#9'(2|1)'
              'C'#9'(-2|1)'
              'D'#9'(-2|-1)'
              'E'#9'(0|2)'
              'F'#9'(-2|-3)'
              'G'#9'(2|-3)'
              'H'#9'(0|-4)'
              '#'
              'A-B'
              'A-C'
              'A-D'
              'A-F'
              'A-G'
              'B-C'
              'B-D'
              'B-E'
              'C-D'
              'C-E'
              'D-F'
              'D-G'
              'F-G'
              'F-H'
              'G-H'
              '#')
            TabOrder = 16
            Visible = False
          end
          object Panel1: TPanel
            Left = 0
            Top = 0
            Width = 201
            Height = 27
            Align = alTop
            BevelOuter = bvNone
            Color = 15790320
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -16
            Font.Name = 'Verdana'
            Font.Style = [fsBold, fsItalic]
            ParentFont = False
            TabOrder = 17
            object S2: TSpeedButton
              Left = 150
              Top = 3
              Width = 23
              Height = 24
              Caption = 'û'
              Flat = True
              Font.Charset = SYMBOL_CHARSET
              Font.Color = clBlue
              Font.Height = -27
              Font.Name = 'Wingdings'
              Font.Style = []
              ParentFont = False
              OnClick = SLoeschen
            end
            object S1: TSpeedButton
              Left = 127
              Top = 3
              Width = 23
              Height = 24
              Flat = True
              Glyph.Data = {
                66010000424D6601000000000000760000002800000014000000140000000100
                040000000000F0000000C40E0000C40E00001000000000000000000000000000
                80000080000000808000800000008000800080800000C0C0C000808080000000
                FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
                FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                FFFFFFFFFFFFFFFF0000FFFFFFFFCCFFFFFFFCCF0000FFFFFFFFCCFCCFFFFCCF
                0000FFFFFFFFCCFCCFFFFCCF0000FFFFFF0FCCFFFFFFFCCF0000FFFFFF00CCCC
                CCCCCCCF0000F00000000CCCCCCCCCCF0000F000000000BBBBBBBBCF0000F000
                000000BBBBBBBBCF0000F00000000BBBBBBBBBCF0000FFFFFF00CBBBBBBBBBCF
                0000FFFFFF0FCBBBBBBBBBCF0000FFFFFFFFCBBBBBBBBBCF0000FFFFFFFFFFFF
                FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                FFFFFFFFFFFFFFFF0000}
              OnClick = SSpeichern
            end
            object S4: TSpeedButton
              Left = 104
              Top = 3
              Width = 23
              Height = 24
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
              OnClick = SLaden
            end
            object S3: TSpeedButton
              Left = 65
              Top = 3
              Width = 23
              Height = 24
              Flat = True
              Glyph.Data = {
                4E010000424D4E01000000000000760000002800000012000000120000000100
                040000000000D800000000000000000000001000000000000000000000000000
                80000080000000808000800000008000800080800000C0C0C000808080000000
                FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
                FFFFFF000000FFFFFFF000000FFFFF000000FFFFFFF0AAAAA00FFF000000FFFF
                FFF0AAAAAA20FF000000FFFFFFF0AAAAA2A28F000000FFFFFFF000000A220F00
                0000FFFFFFFFFFFF80020F000000FFFFFFFFFFFFFF800F000000FFFFF0FFFFFF
                FF800F000000FFFF00FFFFFF80020F000000FFF0A00000000A220F000000FF0A
                AAAAAAAAA2A28F000000F0AAAAAAAAAAAA20FF000000FF0AAAAAAAAAA00FFF00
                0000FFF0A00000000FFFFF000000FFFF00FFFFFFFFFFFF000000FFFFF0FFFFFF
                FFFFFF000000FFFFFFFFFFFFFFFFFF000000}
              OnClick = SGroesse
            end
            object S6: TSpeedButton
              Left = 41
              Top = 3
              Width = 23
              Height = 24
              Flat = True
              Glyph.Data = {
                66010000424D6601000000000000760000002800000014000000140000000100
                040000000000F000000000000000000000001000000000000000000000000000
                80000080000000808000800000008000800080800000C0C0C000808080000000
                FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
                FFFFFFFF0000F0FFFFFFFFFFFFFFFF0F0000FF0FFFFFFFFFFFFFF0FF0000FFF0
                FFFFFFFFFFFF0FFF0000FFFF0FF0FFFF0FF0FFFF0000FFFFF0F0FFFF0F0FFFFF
                0000FFFFFF00FFFF00FFFFFF0000FFFF0000FFFF0000FFFF0000FFFFFFFFFFFF
                FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                FFFFFFFFFFFFFFFF0000FFFF0000FFFF0000FFFF0000FFFFFF00FFFF00FFFFFF
                0000FFFFF0F0FFFF0F0FFFFF0000FFFF0FF0FFFF0FF0FFFF0000FFF0FFFFFFFF
                FFFF0FFF0000FF0FFFFFFFFFFFFFF0FF0000F0FFFFFFFFFFFFFFFF0F0000FFFF
                FFFFFFFFFFFFFFFF0000}
              OnClick = SGroesse
            end
            object S5: TSpeedButton
              Left = 18
              Top = 3
              Width = 23
              Height = 24
              Flat = True
              Glyph.Data = {
                66010000424D6601000000000000760000002800000014000000140000000100
                040000000000F000000000000000000000001000000000000000000000000000
                80000080000000808000800000008000800080800000C0C0C000808080000000
                FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
                FFFFFFFF0000F0000FFFFFFFFFF0000F0000F00FFFFFFFFFFFFFF00F0000F0F0
                FFFFFFFFFFFF0F0F0000F0FF0FFFFFFFFFF0FF0F0000FFFFF0FFFFFFFF0FFFFF
                0000FFFFFF0FFFFFF0FFFFFF0000FFFFFFF0FFFF0FFFFFFF0000FFFFFFFF0FF0
                FFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFF0000FFFF
                FFFF0FF0FFFFFFFF0000FFFFFFF0FFFF0FFFFFFF0000FFFFFF0FFFFFF0FFFFFF
                0000FFFFF0FFFFFFFF0FFFFF0000F0FF0FFFFFFFFFF0FF0F0000F0F0FFFFFFFF
                FFFF0F0F0000F00FFFFFFFFFFFFFF00F0000F0000FFFFFFFFF00000F0000FFFF
                FFFFFFFFFFFFFFFF0000}
              OnClick = SGroesse
            end
          end
        end
        object Panel10: TPanel
          Left = 1040
          Top = 0
          Width = 80
          Height = 749
          Align = alRight
          Color = clWhite
          TabOrder = 1
          object kp2: TPaintBox
            Left = 1
            Top = 1
            Width = 78
            Height = 617
            Align = alClient
          end
          object Panel6: TPanel
            Left = 1
            Top = 618
            Width = 78
            Height = 130
            Align = alBottom
            BevelOuter = bvNone
            Color = 15790320
            TabOrder = 0
            object Liste_E: TListBox
              Left = 8
              Top = 20
              Width = 70
              Height = 98
              Align = alClient
              BorderStyle = bsNone
              IntegralHeight = True
              ItemHeight = 14
              ParentColor = True
              TabOrder = 0
              OnDblClick = B_AnzeigeC
            end
            object Panel8: TPanel
              Left = 0
              Top = 0
              Width = 78
              Height = 20
              Align = alTop
              BevelOuter = bvNone
              Caption = 'Eulerkreise'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -12
              Font.Name = 'Verdana'
              Font.Style = [fsBold]
              ParentColor = True
              ParentFont = False
              TabOrder = 1
            end
            object Panel11: TPanel
              Left = 0
              Top = 20
              Width = 8
              Height = 110
              Align = alLeft
              BevelOuter = bvNone
              ParentColor = True
              TabOrder = 2
            end
          end
        end
        object Panel9: TPanel
          Left = 201
          Top = 0
          Width = 839
          Height = 749
          Align = alClient
          Color = clWhite
          TabOrder = 2
          object kp1: TPaintBox
            Left = 1
            Top = 1
            Width = 837
            Height = 663
            Align = alClient
            OnMouseDown = kp1MD
            OnMouseMove = kp1MM
            OnMouseUp = kp1MU
            OnPaint = kp1Paint
          end
          object Panel5: TPanel
            Left = 1
            Top = 664
            Width = 837
            Height = 84
            Align = alBottom
            BevelOuter = bvNone
            Color = clWhite
            TabOrder = 0
            object Label1: TLabel
              Left = 24
              Top = 16
              Width = 146
              Height = 14
              Caption = '0 Eulerkreise gefunden'
            end
            object Label2: TLabel
              Left = 24
              Top = 46
              Width = 56
              Height = 14
              Caption = 'Beispiele'
            end
            object Liste: TComboBox
              Left = 92
              Top = 43
              Width = 269
              Height = 22
              ItemHeight = 14
              Sorted = True
              TabOrder = 0
              OnChange = Beispielrufen
            end
          end
        end
      end
    end
  end
  object OD3: TOpenDialog
    DefaultExt = 'kpo'
    Filter = 'Graph (*.egr)|*.egr'
    Left = 752
    Top = 431
  end
  object SD2: TSaveDialog
    DefaultExt = 'kpo'
    Filter = 'Graph (*.egr)|*.egr'
    Left = 752
    Top = 375
  end
  object MM1: TMainMenu
    Left = 264
    Top = 10
  end
end
