object fachtdamen: Tfachtdamen
  Left = 345
  Top = 51
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Acht-Damen-Problem'
  ClientHeight = 729
  ClientWidth = 1008
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
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 14
  object Panel8: TPanel
    Left = 0
    Top = 0
    Width = 1008
    Height = 729
    Align = alClient
    BevelOuter = bvNone
    Color = clWhite
    TabOrder = 0
    object Panel3: TPanel
      Left = 0
      Top = 0
      Width = 1008
      Height = 729
      Align = alClient
      BevelOuter = bvNone
      Color = clWhite
      TabOrder = 0
      object Panel1: TPanel
        Left = 838
        Top = 0
        Width = 170
        Height = 729
        Align = alRight
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 0
        object Panel6: TPanel
          Left = 0
          Top = 0
          Width = 170
          Height = 26
          Align = alTop
          Alignment = taLeftJustify
          BevelOuter = bvNone
          Caption = '   Einstellungen'
          Color = clWhite
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -12
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
        end
        object Panel4: TPanel
          Left = 0
          Top = 32
          Width = 170
          Height = 211
          BevelOuter = bvNone
          Color = clWhite
          TabOrder = 1
          object L1: TLabel
            Left = 24
            Top = 16
            Width = 62
            Height = 14
            Caption = 'Feldgröße'
          end
          object L2: TLabel
            Left = 48
            Top = 93
            Width = 39
            Height = 14
            Caption = '0,00 s'
          end
          object L3: TLabel
            Left = 8
            Top = 188
            Width = 77
            Height = 14
            Caption = 'Belegungen'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -12
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object L4: TLabel
            Left = 96
            Top = 188
            Width = 4
            Height = 14
          end
          object Button1: TButton
            Left = 18
            Top = 62
            Width = 135
            Height = 25
            Caption = 'Simulation'
            TabOrder = 3
            OnClick = simulation
          end
          object C1: TCheckBox
            Left = 16
            Top = 112
            Width = 97
            Height = 17
            Caption = 'Spielmodus'
            TabOrder = 0
            OnClick = Spielmodus
          end
          object C2: TCheckBox
            Left = 16
            Top = 128
            Width = 97
            Height = 17
            Caption = 'Animation'
            Checked = True
            State = cbChecked
            TabOrder = 1
          end
          object C3: TCheckBox
            Left = 16
            Top = 144
            Width = 145
            Height = 17
            Caption = 'Belegungstabelle'
            Checked = True
            State = cbChecked
            TabOrder = 2
          end
          object C4: TCheckBox
            Left = 16
            Top = 162
            Width = 105
            Height = 17
            Caption = 'Superdamen'
            TabOrder = 4
          end
          object SpinEdit1: TSpinEdit
            Left = 96
            Top = 12
            Width = 49
            Height = 23
            MaxValue = 16
            MinValue = 4
            TabOrder = 5
            Value = 8
            OnChange = feldgroesse
          end
        end
        object acht: TPanel
          Left = 0
          Top = 241
          Width = 170
          Height = 432
          BevelOuter = bvNone
          Caption = 'acht'
          Color = clWhite
          TabOrder = 2
          object Panel5: TPanel
            Left = 0
            Top = 0
            Width = 8
            Height = 432
            Align = alLeft
            BevelOuter = bvNone
            Color = clWhite
            TabOrder = 0
          end
          object LB1: TListBox
            Left = 8
            Top = 0
            Width = 162
            Height = 432
            Align = alClient
            BorderStyle = bsNone
            Color = clWhite
            ItemHeight = 14
            TabOrder = 1
            OnClick = anzeige
          end
        end
      end
      object Panel7: TPanel
        Left = 0
        Top = 0
        Width = 838
        Height = 729
        Align = alClient
        BevelOuter = bvNone
        Color = clWhite
        TabOrder = 1
        object Panel2: TPanel
          Left = 0
          Top = 0
          Width = 838
          Height = 729
          Align = alClient
          BevelOuter = bvNone
          Color = clWhite
          TabOrder = 0
          object PB1: TPaintBox
            Left = 0
            Top = 0
            Width = 838
            Height = 729
            Align = alClient
            OnMouseDown = PB1D
            OnPaint = zeichnen
          end
          object im1: TImage
            Left = 168
            Top = 600
            Width = 25
            Height = 25
            AutoSize = True
            Picture.Data = {
              07544269746D617006020000424D060200000000000076000000280000001900
              0000190000000100040000000000900100000000000000000000100000000000
              000000000000000080000080000000808000800000008000800080800000C0C0
              C000808080000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFF
              FF00777777777000000077777777700000007777770000000000000777777000
              0000777770000000000000007777700000007777000000FFFFF0000007777000
              00007770000FFFFFFFFFFF00007770000000770000FFFF00000FFFF000077000
              000070000FFF000000000FFF0000700000007000FFF00000000000FFF0007000
              00007000FF0000FFFFF0000FF000700000000000FF000FFFFFFF000FFF000000
              0000000FF000FFF000FFF000FF0000000000000FF000FF00000FF000FF000000
              0000000FF000FF00000FF000FF0000000000000FF000FF00000FF000FF000000
              0000000FF000FFF000FFF000FF00000000000000FF000FFFFFFF000FFF000000
              00007000FF0000FFFFF0000FF000700000007000FFF00000000000FFF0007000
              000070000FFF000000000FFF000070000000770000FFFF00000FFFF000077000
              00007770000FFFFFFFFFFF00007770000000777700000FFFFFFF000007777000
              0000777770000000000000007777700000007777770000000000000777777000
              000077777777700000007777777770000000}
            Visible = False
          end
          object im2: TImage
            Left = 200
            Top = 608
            Width = 25
            Height = 25
            AutoSize = True
            Picture.Data = {
              07544269746D617006020000424D060200000000000076000000280000001900
              0000190000000100040000000000900100000000000000000000100000000000
              0000000000000000800000800000008080008000000080008000808000008080
              8000C0C0C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFF
              FF00FFFFFFFFF0000000FFFFFFFFF0000000FFFFFF0000000000000FFFFFF000
              0000FFFFF000000000000000FFFFF0000000FFFF000000FFFFF000000FFFF000
              0000FFF0000FFFFFFFFFFF0000FFF0000000FF0000FFFF00000FFFF0000FF000
              0000F0000FFF000000000FFF0000F0000000F000FFF00000000000FFF000F000
              0000F000FF0000FFFFF0000FF000F00000000000FF000FFFFFFF000FFF000000
              0000000FF000FFF000FFF000FF0000000000000FF000FF00000FF000FF000000
              0000000FF000FF00000FF000FF0000000000000FF000FF00000FF000FF000000
              0000000FF000FFF000FFF000FF00000000000000FF000FFFFFFF000FFF000000
              0000F000FF0000FFFFF0000FF000F0000000F000FFF00000000000FFF000F000
              0000F0000FFF000000000FFF0000F0000000FF0000FFFF00000FFFF0000FF000
              0000FFF0000FFFFFFFFFFF0000FFF0000000FFFF00000FFFFFFF00000FFFF000
              0000FFFFF000000000000000FFFFF0000000FFFFFF0000000000000FFFFFF000
              0000FFFFFFFFF0000000FFFFFFFFF0000000}
            Visible = False
          end
        end
      end
    end
  end
end
