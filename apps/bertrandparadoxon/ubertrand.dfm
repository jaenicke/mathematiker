object Form1: TForm1
  Left = 285
  Top = 90
  Width = 1067
  Height = 699
  HelpContext = 108
  Caption = 'Bertrand-Experiment'
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Verdana'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 14
  object panel5: TPanel
    Left = 0
    Top = 0
    Width = 1051
    Height = 660
    Align = alClient
    BevelOuter = bvNone
    Color = clWhite
    TabOrder = 0
    object panel4: TPanel
      Left = 0
      Top = 0
      Width = 1051
      Height = 660
      Align = alClient
      BevelOuter = bvNone
      Color = clWhite
      TabOrder = 0
      object bertrand: TPanel
        Left = 0
        Top = 0
        Width = 1051
        Height = 660
        Align = alClient
        BevelOuter = bvNone
        Color = clWhite
        TabOrder = 0
        OnResize = bertrandResize
        object Paintbox1: TPaintBox
          Left = 0
          Top = 0
          Width = 1051
          Height = 530
          Align = alClient
          OnPaint = Paintbox1Paint
        end
        object panel6: TPanel
          Left = 0
          Top = 530
          Width = 1051
          Height = 130
          Align = alBottom
          BevelOuter = bvNone
          Color = 15790320
          TabOrder = 0
          object panel2: TPanel
            Left = 257
            Top = 0
            Width = 522
            Height = 130
            Align = alClient
            BevelOuter = bvNone
            Color = 15790320
            TabOrder = 0
            object Label4: TLabel
              Left = 144
              Top = 40
              Width = 8
              Height = 14
              Caption = '0'
            end
            object Label5: TLabel
              Left = 144
              Top = 60
              Width = 5
              Height = 14
              Caption = '-'
            end
            object Label7: TLabel
              Left = 16
              Top = 40
              Width = 40
              Height = 14
              Caption = 'Treffer'
            end
            object Label8: TLabel
              Left = 16
              Top = 60
              Width = 116
              Height = 14
              Caption = 'Wahrscheinlichkeit'
            end
            object Label6: TLabel
              Left = 16
              Top = 16
              Width = 106
              Height = 14
              Caption = 'Radius-Methode'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -12
              Font.Name = 'Verdana'
              Font.Style = [fsBold]
              ParentFont = False
            end
          end
          object Panel3: TPanel
            Left = 779
            Top = 0
            Width = 272
            Height = 130
            Align = alRight
            BevelOuter = bvNone
            Color = 15790320
            TabOrder = 1
            object Label13: TLabel
              Left = 144
              Top = 40
              Width = 8
              Height = 14
              Caption = '0'
            end
            object Label14: TLabel
              Left = 144
              Top = 60
              Width = 5
              Height = 14
              Caption = '-'
            end
            object Label16: TLabel
              Left = 16
              Top = 40
              Width = 40
              Height = 14
              Caption = 'Treffer'
            end
            object Label17: TLabel
              Left = 16
              Top = 60
              Width = 116
              Height = 14
              Caption = 'Wahrscheinlichkeit'
            end
            object Label12: TLabel
              Left = 16
              Top = 16
              Width = 136
              Height = 14
              Caption = 'Mittelpunkt-Methode'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -12
              Font.Name = 'Verdana'
              Font.Style = [fsBold]
              ParentFont = False
            end
          end
          object panel1: TPanel
            Left = 0
            Top = 0
            Width = 257
            Height = 130
            Align = alLeft
            BevelOuter = bvNone
            Color = 15790320
            TabOrder = 2
            object Label15: TLabel
              Left = 208
              Top = 92
              Width = 8
              Height = 14
              Caption = '0'
            end
            object Label1: TLabel
              Left = 144
              Top = 40
              Width = 8
              Height = 14
              Caption = '0'
            end
            object Label2: TLabel
              Left = 144
              Top = 60
              Width = 5
              Height = 14
              Caption = '-'
            end
            object Label9: TLabel
              Left = 144
              Top = 92
              Width = 57
              Height = 14
              Caption = 'Versuche'
            end
            object Label10: TLabel
              Left = 16
              Top = 40
              Width = 40
              Height = 14
              Caption = 'Treffer'
            end
            object Label11: TLabel
              Left = 16
              Top = 60
              Width = 116
              Height = 14
              Caption = 'Wahrscheinlichkeit'
            end
            object Label3: TLabel
              Left = 16
              Top = 16
              Width = 131
              Height = 14
              Caption = 'Endpunkte-Methode'
              Font.Charset = ANSI_CHARSET
              Font.Color = clNavy
              Font.Height = -12
              Font.Name = 'Verdana'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object Button1: TButton
              Left = 16
              Top = 88
              Width = 113
              Height = 25
              Caption = 'Simulation'
              TabOrder = 0
              OnClick = Button1Click
            end
          end
        end
      end
    end
  end
end
