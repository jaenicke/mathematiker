object Form1: TForm1
  Left = 282
  Top = 34
  Width = 987
  Height = 704
  HelpContext = 108
  Caption = 'Mondrian-Bilder'
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
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 971
    Height = 665
    Align = alClient
    BevelOuter = bvNone
    Color = clWhite
    TabOrder = 0
    object Panel1: TPanel
      Left = 0
      Top = 0
      Width = 971
      Height = 665
      Align = alClient
      BevelOuter = bvNone
      Color = clWhite
      TabOrder = 0
      object mondrian: TPanel
        Left = 0
        Top = 0
        Width = 971
        Height = 665
        Align = alClient
        BevelOuter = bvNone
        Color = clWhite
        TabOrder = 0
        object Paintbox1: TPaintBox
          Left = 161
          Top = 0
          Width = 810
          Height = 665
          Align = alClient
          OnPaint = Button1Click
        end
        object Panel3: TPanel
          Left = 0
          Top = 0
          Width = 161
          Height = 665
          Align = alLeft
          BevelOuter = bvNone
          Color = 15790320
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Verdana'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          object Label4: TLabel
            Left = 16
            Top = 48
            Width = 43
            Height = 16
            Caption = 'Anzahl'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Verdana'
            Font.Style = []
            ParentFont = False
          end
          object Label5: TLabel
            Left = 19
            Top = 80
            Width = 52
            Height = 16
            Caption = 'x-Gr'#246#223'e'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Verdana'
            Font.Style = []
            ParentFont = False
            WordWrap = True
          end
          object Image1: TImage
            Left = -219
            Top = 405
            Width = 500
            Height = 500
            Visible = False
          end
          object Label6: TLabel
            Left = 16
            Top = 16
            Width = 77
            Height = 16
            Caption = 'Parameter'
            Font.Charset = ANSI_CHARSET
            Font.Color = clNavy
            Font.Height = -13
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label2: TLabel
            Left = 19
            Top = 112
            Width = 53
            Height = 16
            Caption = 'y-Gr'#246#223'e'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Verdana'
            Font.Style = []
            ParentFont = False
            WordWrap = True
          end
          object Label1: TLabel
            Left = 16
            Top = 312
            Width = 115
            Height = 42
            Caption = 'Konstruktion von '#13#10'Bildern im Stil von '#13#10'Piet Mondrian'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Verdana'
            Font.Style = []
            ParentFont = False
          end
          object Label3: TLabel
            Left = 16
            Top = 144
            Width = 51
            Height = 16
            Caption = 'Wei'#223'-%'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Verdana'
            Font.Style = []
            ParentFont = False
          end
          object Button1: TButton
            Left = 16
            Top = 176
            Width = 124
            Height = 25
            Caption = 'Zeichnen'
            Default = True
            TabOrder = 1
            OnClick = Button1Click
          end
          object Radiogroup1: TRadioGroup
            Left = 16
            Top = 216
            Width = 121
            Height = 81
            Caption = 'Farbmuster'
            Columns = 3
            ItemIndex = 0
            Items.Strings = (
              '1'
              '2'
              '3'
              '4'
              '5'
              '6'
              '7'
              '8'
              '9')
            TabOrder = 0
            OnClick = Button1Click
          end
          object Spin1: TSpinEdit
            Left = 80
            Top = 44
            Width = 57
            Height = 26
            MaxValue = 100
            MinValue = 5
            TabOrder = 2
            Value = 40
          end
          object Spin2: TSpinEdit
            Left = 80
            Top = 76
            Width = 57
            Height = 26
            MaxValue = 1000
            MinValue = 100
            TabOrder = 3
            Value = 750
          end
          object Spin3: TSpinEdit
            Left = 80
            Top = 108
            Width = 57
            Height = 26
            MaxValue = 1000
            MinValue = 100
            TabOrder = 4
            Value = 600
          end
          object Spin4: TSpinEdit
            Left = 80
            Top = 140
            Width = 57
            Height = 26
            MaxValue = 100
            MinValue = 0
            TabOrder = 5
            Value = 0
          end
        end
      end
    end
  end
end
