object fbaum: Tfbaum
  Left = 201
  Top = 68
  Width = 1000
  Height = 592
  HelpContext = 114
  Caption = 'Demonstration AVL-Baum'
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Verdana'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  Scaled = False
  OnActivate = FormActivate
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 14
  object P4: TPanel
    Left = 0
    Top = 0
    Width = 984
    Height = 556
    Align = alClient
    BevelOuter = bvNone
    Color = clWhite
    TabOrder = 0
    object avl: TPanel
      Left = 0
      Top = 0
      Width = 984
      Height = 556
      Align = alClient
      BevelOuter = bvNone
      Color = clWhite
      TabOrder = 0
      object pb1: TPaintBox
        Left = 185
        Top = 0
        Width = 799
        Height = 556
        Align = alClient
        OnPaint = pb1Paint
      end
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 185
        Height = 556
        Align = alLeft
        BevelOuter = bvNone
        Color = 15790320
        TabOrder = 0
        object Label1: TLabel
          Left = 8
          Top = 16
          Width = 91
          Height = 14
          Caption = 'Neuer Eintrag'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -12
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label3: TLabel
          Left = 8
          Top = 184
          Width = 53
          Height = 14
          Caption = 'Element'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -12
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Edit1: TEdit
          Left = 16
          Top = 40
          Width = 145
          Height = 22
          TabOrder = 0
          Text = '14'
        end
        object Edit2: TEdit
          Left = 16
          Top = 208
          Width = 145
          Height = 22
          TabOrder = 1
        end
        object CB1: TCheckBox
          Left = 24
          Top = 144
          Width = 113
          Height = 17
          Caption = 'automatisch'
          TabOrder = 2
        end
        object Memo1: TMemo
          Left = 8
          Top = 312
          Width = 161
          Height = 121
          BorderStyle = bsNone
          Color = 15790320
          TabOrder = 3
        end
        object Button1: TButton
          Left = 16
          Top = 80
          Width = 145
          Height = 25
          Caption = 'Übernehmen'
          TabOrder = 4
          OnClick = d1Click
        end
        object Button2: TButton
          Left = 16
          Top = 112
          Width = 145
          Height = 25
          Caption = 'Baum ausgleichen'
          TabOrder = 5
          OnClick = D8Click
        end
        object Button4: TButton
          Left = 16
          Top = 248
          Width = 145
          Height = 25
          Caption = 'Element suchen'
          TabOrder = 6
          OnClick = D2Click
        end
        object Button5: TButton
          Left = 16
          Top = 280
          Width = 145
          Height = 25
          Caption = 'Element löschen'
          TabOrder = 7
          OnClick = D3Click
        end
      end
    end
  end
end
