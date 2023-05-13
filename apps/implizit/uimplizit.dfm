object Fimpkurv: TFimpkurv
  Left = 269
  Top = 83
  HelpContext = 107
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Implizite Kurven'
  ClientHeight = 681
  ClientWidth = 1004
  Color = 15790320
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Verdana'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 14
  object Panel3: TPanel
    Left = 0
    Top = 0
    Width = 1004
    Height = 681
    Align = alClient
    BevelOuter = bvNone
    Color = clWhite
    TabOrder = 0
    object implizit: TPanel
      Left = 0
      Top = 0
      Width = 1004
      Height = 681
      Align = alClient
      BevelOuter = bvNone
      Color = clWhite
      TabOrder = 0
      object Paintbox1: TPaintBox
        Left = 0
        Top = 0
        Width = 755
        Height = 681
        Align = alClient
        OnPaint = pb1Click
      end
      object Panel2: TPanel
        Left = 755
        Top = 0
        Width = 249
        Height = 681
        Align = alRight
        BevelOuter = bvNone
        Color = 15790320
        TabOrder = 0
        object Panel5: TPanel
          Left = 0
          Top = 0
          Width = 249
          Height = 257
          Align = alTop
          BevelOuter = bvNone
          Color = 15790320
          TabOrder = 0
          object Label1: TLabel
            Left = 16
            Top = 16
            Width = 172
            Height = 14
            Caption = 'Implizite Kurvengleichung'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -12
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label2: TLabel
            Left = 16
            Top = 72
            Width = 21
            Height = 14
            Caption = '0 ='
          end
          object Label6: TLabel
            Left = 16
            Top = 104
            Width = 91
            Height = 14
            Caption = 'Parameter P ='
          end
          object Label3: TLabel
            Left = 16
            Top = 232
            Width = 102
            Height = 14
            Caption = 'Kurvenauswahl'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -12
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label4: TLabel
            Left = 16
            Top = 136
            Width = 18
            Height = 14
            Caption = 'bis'
          end
          object Label5: TLabel
            Left = 128
            Top = 132
            Width = 21
            Height = 19
            Caption = 'D ='
            Font.Charset = SYMBOL_CHARSET
            Font.Color = clWindowText
            Font.Height = -15
            Font.Name = 'Symbol'
            Font.Style = []
            ParentFont = False
          end
          object Speed2: TSpeedButton
            Left = 64
            Top = 193
            Width = 24
            Height = 24
            Hint = 'Darstellung verkleinern'
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
            ParentShowHint = False
            ShowHint = True
            OnClick = Speed2Click
          end
          object Speed1: TSpeedButton
            Left = 16
            Top = 193
            Width = 24
            Height = 24
            Hint = 'Darstellung vergr'#246#223'ern'
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
            ParentShowHint = False
            ShowHint = True
            OnClick = Speed1Click
          end
          object Speed3: TSpeedButton
            Left = 40
            Top = 193
            Width = 24
            Height = 24
            Hint = 'Standardeinstellung'
            Flat = True
            Glyph.Data = {
              F6000000424DF600000000000000760000002800000010000000100000000100
              0400000000008000000000000000000000001000000010000000000000000000
              BF0000BF000000BFBF00BF000000BF00BF00BFBF0000C0C0C000808080000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
              7777777777777777777777777777777777777777777777777777777777777777
              7777777777777778477777444447777748777744447777777477774447777777
              7477774474777777747777477744777748777777777744448777777777777777
              7777777777777777777777777777777777777777777777777777}
            ParentShowHint = False
            ShowHint = True
            OnClick = Speed3Click
          end
          object Button1: TButton
            Left = 120
            Top = 192
            Width = 113
            Height = 25
            Caption = 'Darstellung'
            Default = True
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Verdana'
            Font.Style = []
            ParentFont = False
            TabOrder = 5
            OnClick = pb1Click
          end
          object Edit1: TEdit
            Left = 49
            Top = 68
            Width = 184
            Height = 22
            CharCase = ecUpperCase
            TabOrder = 0
            Text = 'X*X+Y*Y-4'
          end
          object Edit2: TEdit
            Left = 120
            Top = 100
            Width = 113
            Height = 22
            TabOrder = 1
            Text = '1'
          end
          object Edit3: TEdit
            Left = 48
            Top = 132
            Width = 65
            Height = 22
            TabOrder = 2
            Text = '4'
          end
          object Edit4: TEdit
            Left = 160
            Top = 132
            Width = 73
            Height = 22
            TabOrder = 3
            Text = '1'
          end
          object kurvenschar: TCheckBox
            Left = 48
            Top = 162
            Width = 121
            Height = 17
            Caption = 'Kurvenschar'
            TabOrder = 4
          end
          object Edit5: TEdit
            Left = 17
            Top = 40
            Width = 216
            Height = 22
            TabOrder = 6
          end
        end
        object Panel7: TPanel
          Left = 0
          Top = 257
          Width = 249
          Height = 424
          Align = alClient
          BevelOuter = bvNone
          Color = 15790320
          TabOrder = 1
          object Liste1: TListBox
            Left = 8
            Top = 0
            Width = 233
            Height = 410
            Align = alClient
            Color = 15790320
            IntegralHeight = True
            ItemHeight = 14
            Items.Strings = (
              'Achsenparalleles Blatt'#9'X*X*(P+X)/(P-3*X)-Y*Y'
              'Achteck'#9'2*(|X|+|Y|)+SQRT(2)*(|X-Y|+|X+Y|)-8'
              'Acht-Kurve'#9'X^4-P*P*(X*X-Y*Y)'
              'Ampersand-Kurve'#9'(Y^2-X^2)*(X - 1)*(2*X-3)-4*(X^2+Y^2-2*X)^2'
              'Arkussinus-Kurve'#9'X-SIN(Y)'
              'Astroide'#9'ABS(X/2)^(2/3)+ABS(Y/2)^(2/3)-1'
              'Bernoullische Lemniskate'#9'(X*X+Y*Y)^2-2*P*P*(X*X-Y*Y)'
              'Bernoullische Quartik'#9'((2+P)^2/4-Y^2)*(Y^2-(2-P)^2/4)-X^2*Y^2'
              'Both-Lemniskate'#9'(X^2+Y^2)^2-9*X^2-Y^2'
              'Cundy-Rollett-Kurve'#9'Y^4-X^4-Y*X'
              'Delangessche Trisektrix'#9'(X^2+Y^2-2*P^2)^2-X^2*(X^2+Y^2)'
              'Deltoid-Kurve'#9'(X^2+Y^2)^2-8*X*(X^2-3*Y^2)+18*(X^2+Y^2)-27'
              'Dipolkurve'#9'(X^2+Y^2)^3-P^4*X^2'
              'Doppel-Ei'#9'(X*X+Y*Y)^3-P*P*X^4'
              'Doppelhorn-Kurve'#9'Y*Y*(P*P-X*X)-(X*X+2*P*Y-P)^2'
              'Doppelkreisquartik (2)'#9'(X^2+Y^2-X-Y)^2-X^2-P*Y^2'
              'Doppelkreisquartik'#9'(X^2+Y^2-X-Y)^2-P^2*X^2-Y^2'
              'Doppeltropfen-Kurve'#9'Y^2-X^4*(P^2-X^2)'
              'Doppel-U-Kurve'#9'Y^2*(P^2-X^2)-P^4'
              'D'#252'rer-Konchoide'#9'(X*Y+1-Y*Y)^2-(X+Y-P)^2*(1-Y^2)'
              'D'#252'rersches Blatt'#9'(X^2+Y^2)*(2*(X^2+Y^2)-P^2)^2-P^4*X^2'
              'Edwards-Kurve'#9'X*X+Y*Y-1+P*X*X*Y*Y'
              'Edwards-Kurve, verdreht'#9'2*X*X+Y*Y-1+P*X*X*Y*Y'
              'Ellipse'#9'X^2/9+Y^2/4-1'
              'Ellipsen-Gleitkurve'#9'X*X*Y*Y-(P*P-Y*Y)*(Y*Y-4)'
              'Elliptische Kurve (2)'#9'X^3+P*X^2-Y^2'
              'Elliptische Kurve'#9'-X*X*X+Y*Y-P'
              'Gerade Y=X'#9'X-Y'
              'Gerade'#9'P*X+2*Y-3'
              'Geschossspitzen-Kurve'#9'1/X^2-1/Y^2-P'
              'Granvillesche Eikurve'#9'X^2*Y^2-(X-P)*(1-X)'
              'Herz-Kurve'#9'(X^2+Y^2-1)^3-X^2*Y^3'
              'Hyperbel (2)'#9'X+Y*X^2'
              'Hyperbel'#9'X^2/4-Y^2/4-1'
              'Kardioide'#9'(X*X+Y*Y)*(X*X+Y*Y-2*P*X)-P*P*Y*Y'
              'Kartesisches Blatt'#9'X^3+Y^3-3*P*X*Y'
              'Katzenaugen-Kurve'#9'Y^2-4*COS(X)-P*4'
              'Kreis'#9'X*X+Y*Y-4'
              'Kubische Parabel (2)'#9'X^3-Y'
              'Kubische Parabel'#9'X-Y^3'
              'K'#252'lps Quartik'#9'Y^2-1/(1+X^2)'
              'Kurve 1'#9'SIN(X+Y)-COS(X*Y)+1'
              'Kurve 2'#9'SIN(X+Y)+SIN(X-Y)'
              'Lam'#233'-Kurve'#9'ABS(X/2)^P+ABS(Y/2)^P-1'
              'Lam'#233'sche Kubik'#9'X^3+Y^3-P^3'
              'Montgomery-Kurve'#9'Y*Y-X^3-3*P*X^2-X'
              'Neilsche Parabel'#9'Y*Y-P*X^3'
              'Newtonscher Knoten'#9'X^3+X^2-Y^2'
              'Parabel'#9'X-Y^2'
              'Parabel-Gleitkurve'#9'P*P*X^4-Y^2*(Y^2+4*P^2)^2*(X*X+Y*Y+4*P^2)'
              'Parabolisches Blatt'#9'X^3-2*X*Y-P*(X^2-Y^2)'
              'Pellsche Gleichung'#9'X*X-P*Y*Y-1'
              'Pl'#252'cker-Quartik'#9'(X^2-1)^2+(Y^2-1)^2-P'
              'Quadratrix des Dinostratus'#9'X-Y*COT(Y/P)'
              'Quadrifolium'#9'(X^2+Y^2)^3-4*P*X^2*Y^2'
              
                'Quartik-Eikurve'#9'(Y^2*(1-2*P)-X^2+(P^2*4-1))^2-4*X^2*(1-(1-4)^2*Y' +
                '^2)'
              'Rhombus'#9'|X|/P+|Y|/2-1'
              'Salmonsche Quartik'#9'(X*X-1)^2+(Y*Y-1)^2-P'
              'Sechseck'#9'2*|Y|+|Y-X*SQRT(3)|+|Y+X*SQRT(3)|-6'
              'Serpentine'#9'X*X*Y+P*Y-P*P*X'
              'Sluzesche Kubik'#9'P*(X-P)*(X^2+Y^2)-X^2'
              'Spez.Lam'#233'-Kurve 1'#9'||X|-|Y||-1'
              'Spez.Lam'#233'-Kurve 2'#9'|Y*Y-X*X|-3'
              'Spez.Lam'#233'-Kurve 3'#9'|SQRT(|Y|)-SQRT(|X|)|-1'
              'Spez.Lam'#233'-Kurve 4'#9'|1/|Y|-1/|X||-0.2'
              'Strophoide'#9'(P-X)*Y*Y-(P+X)*X*X'
              'Superei'#9'|X|^3/P+|Y|^3/2-1'
              'Torpedo-Kurve'#9'(X*X+Y*Y)^2-P*X*(X*X-Y*Y)'
              'Tricuspoid'#9'(X*X+Y*Y+12*P*X+9*P*P)^2-4*P*(2*X+3*P)^3'
              'Tropfen-Kurve'#9'X^P*(1-X)-Y^2'
              'Verdopplungskurve'#9'X^3-P*(X^2+Y^2)'
              'Versiera der Agnesi'#9'(X*X+P*P)*Y-P^3'
              'Vierbl'#228'ttriges Kleeblatt'#9'(X*X+Y*Y)^3-P*P*X*X*Y*Y'
              'Visiera-Kurve'#9'X*(X*X+Y*Y)-P*(X*X+2*Y*Y)'
              'Wassenaar-Kurve'#9'(Y-X^2)^2-1+P*X^2'
              'Wendekurve der Agnesi'#9'P^2*(P-X)-X*Y^2'
              'Windm'#252'hlenkurve'#9'4*X^2*Y^2*(X^2+Y^2)-P*(X^2-Y^2)^2'
              'Zissoide des Diokles'#9'Y*Y*(P-X)-X^3')
            Sorted = True
            TabOrder = 0
            TabWidth = 200
            OnClick = Liste1Click
          end
          object Panel6: TPanel
            Left = 0
            Top = 0
            Width = 8
            Height = 420
            Align = alLeft
            BevelOuter = bvNone
            Color = 15790320
            TabOrder = 1
          end
          object Panel4: TPanel
            Left = 241
            Top = 0
            Width = 8
            Height = 420
            Align = alRight
            BevelOuter = bvNone
            Color = 15790320
            TabOrder = 2
          end
          object Panel1: TPanel
            Left = 0
            Top = 420
            Width = 249
            Height = 4
            Align = alBottom
            BevelOuter = bvNone
            Color = 15790320
            TabOrder = 3
          end
        end
      end
    end
  end
end
