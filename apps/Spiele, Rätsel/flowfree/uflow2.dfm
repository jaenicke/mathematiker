object fflow: Tfflow
  Left = 419
  Top = 98
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Flowfree'
  ClientHeight = 625
  ClientWidth = 808
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Verdana'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  Scaled = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 14
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 808
    Height = 625
    Align = alClient
    BevelOuter = bvNone
    Color = clWhite
    TabOrder = 0
    object Panel1: TPanel
      Left = 0
      Top = 0
      Width = 808
      Height = 625
      Align = alClient
      BevelOuter = bvNone
      Color = clWhite
      TabOrder = 0
      object PBox1: TPaintBox
        Left = 193
        Top = 0
        Width = 615
        Height = 625
        Align = alClient
        OnMouseDown = PBox1MouseDown
        OnMouseMove = PBox1MouseMove
        OnMouseUp = PBox1MouseUp
        OnPaint = PBox1Paint
      end
      object Panel3: TPanel
        Left = 0
        Top = 0
        Width = 193
        Height = 625
        Align = alLeft
        BevelOuter = bvNone
        Color = 15790320
        TabOrder = 0
        object Label1: TLabel
          Left = 16
          Top = 28
          Width = 81
          Height = 14
          Caption = 'Spielnummer'
        end
        object Button1: TButton
          Left = 40
          Top = 68
          Width = 113
          Height = 25
          Caption = 'Neues Spiel'
          TabOrder = 1
          OnClick = Button1Click
        end
        object Memo1: TMemo
          Left = 8
          Top = 112
          Width = 177
          Height = 273
          TabStop = False
          BorderStyle = bsNone
          Color = 15790320
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Verdana'
          Font.Style = []
          Lines.Strings = (
            'Die farbigen Punkte sind '
            'mit gleichfarbigen R'#246'hren '
            'zu verbinden.'
            'R'#246'hren d'#252'rfen sich dabei '
            'nicht '#252'berschneiden oder '
            'einen andersfarbigen '
            'Punkt beinhalten.'
            ''
            'Ein R'#246'hre wird gezogen:'
            'Linker Mausklick auf den '
            'Ausgangspunkt, '
            'Bewegung der Maus l'#228'ngs '
            'der Felder, Freigeben des '
            'Mausklicks am Zielpunkt.'
            ''
            'Eine fehlerhafte R'#246'hre '
            'wird mit einem rechten '
            'Mausklick gel'#246'scht.')
          ParentFont = False
          TabOrder = 0
        end
        object ListBox1: TListBox
          Left = 32
          Top = 584
          Width = 121
          Height = 97
          ItemHeight = 14
          Items.Strings = (
            '[1'
            '5'
            '5'
            'A22BC'
            '124D3'
            '12D33'
            '1BC3E'
            '1AE55'
            '[2'
            '5'
            '5'
            'A2BCD'
            '12334'
            '123D4'
            '1B33C'
            '1111A'
            '[3'
            '6'
            '6'
            '111111'
            'ABE4D1'
            '225411'
            '2C541E'
            '235DA5'
            'BC5555'
            '[4'
            '8'
            '7'
            '111111D4'
            '1222B114'
            '12333C14'
            'A2CA1114'
            'B25ED444'
            '55566666'
            '5F66G77F'
            '55555E7G'
            '[5'
            '9'
            '9'
            'AB2C33333'
            '1122D45E3'
            'H112245F3'
            '881G24563'
            'I817BD563'
            '9817775F3'
            '98111G553'
            '988811AE3'
            '99I88HC33'
            '[6'
            '9'
            '7'
            '111333333'
            '1B13D444C'
            '12133334D'
            '12111133C'
            '1222B1111'
            '11A555551'
            '5555F6F51'
            '5G7GE5551'
            'EA1111111'
            '[7'
            '10'
            '11'
            '11AH88A111'
            '1BCI98G7G1'
            '123C9888H1'
            '12229:::J1'
            '14DBI:;;K1'
            '1DJ:::;EF1'
            '1EK;;;;561'
            '1555555561'
            '1F66666661'
            '1111111111'
            '[')
          TabOrder = 2
          Visible = False
        end
        object SpinEdit1: TSpinEdit
          Left = 112
          Top = 24
          Width = 65
          Height = 23
          EditorEnabled = False
          MaxValue = 7
          MinValue = 1
          TabOrder = 3
          Value = 1
          OnChange = Button1Click
        end
      end
    end
  end
end
