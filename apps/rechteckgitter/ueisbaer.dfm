object Form1: TForm1
  Left = 361
  Top = 78
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Wege in einem Rechteckgitter'
  ClientHeight = 600
  ClientWidth = 784
  Color = clWhite
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Verdana'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  object PaintBox1: TPaintBox
    Left = 184
    Top = 0
    Width = 600
    Height = 600
    Align = alClient
    OnMouseDown = PaintBox1MouseDown
    OnPaint = PaintBox1Paint
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 184
    Height = 600
    Align = alLeft
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 152
      Width = 15
      Height = 16
      Caption = '...'
    end
    object Label2: TLabel
      Left = 24
      Top = 28
      Width = 66
      Height = 16
      Caption = 'Gr'#246#223'e X ='
    end
    object Label3: TLabel
      Left = 24
      Top = 60
      Width = 66
      Height = 16
      Caption = 'Gr'#246#223'e Y ='
    end
    object Label7: TLabel
      Left = 24
      Top = 200
      Width = 139
      Height = 64
      Caption = 
        'Setzen und L'#246'schen '#13#10'von gesperrten '#13#10'Wegkreuzungen'#13#10'mit linkem ' +
        'Mausklick'
    end
    object Button1: TButton
      Left = 24
      Top = 104
      Width = 137
      Height = 25
      Caption = 'Berechnen'
      TabOrder = 0
      OnClick = Button1Click
    end
    object SpinEdit1: TSpinEdit
      Left = 104
      Top = 24
      Width = 57
      Height = 26
      MaxValue = 10
      MinValue = 1
      TabOrder = 1
      Value = 4
      OnChange = SpinEdit1Change
    end
    object SpinEdit2: TSpinEdit
      Left = 104
      Top = 56
      Width = 57
      Height = 26
      MaxValue = 10
      MinValue = 1
      TabOrder = 2
      Value = 4
      OnChange = SpinEdit1Change
    end
    object Button2: TButton
      Left = 24
      Top = 280
      Width = 137
      Height = 25
      Caption = 'Zur'#252'cksetzen'
      TabOrder = 3
      OnClick = Button2Click
    end
    object RadioButton1: TRadioButton
      Left = 24
      Top = 320
      Width = 129
      Height = 17
      Caption = 'Dellannoy-Wege'
      Checked = True
      TabOrder = 4
      TabStop = True
      OnClick = PaintBox1Paint
    end
    object RadioButton2: TRadioButton
      Left = 24
      Top = 344
      Width = 137
      Height = 17
      Caption = 'Schr'#246'der-Wege'
      TabOrder = 5
      OnClick = PaintBox1Paint
    end
  end
end
