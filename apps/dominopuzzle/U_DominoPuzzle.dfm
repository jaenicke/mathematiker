object domi: Tdomi
  Left = 192
  Top = 49
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Domino Puzzle'
  ClientHeight = 598
  ClientWidth = 900
  Color = clWindow
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 278
    Top = 48
    Width = 613
    Height = 529
    OnMouseDown = Image1MouseDown
    OnMouseMove = Image1MouseMove
    OnMouseUp = Image1MouseUp
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 265
    Height = 598
    Align = alLeft
    BevelOuter = bvNone
    Color = 15790320
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 168
      Width = 97
      Height = 33
      AutoSize = False
      Caption = 'Verfügbare'#13#10'Domino-Steine'
      WordWrap = True
    end
    object Label3: TLabel
      Left = 136
      Top = 168
      Width = 113
      Height = 41
      AutoSize = False
      Caption = 'Verwendete '#13#10'Domino-Steine'#13#10'(Mausklick löscht)'
      WordWrap = True
    end
    object CreateBtn: TBitBtn
      Left = 16
      Top = 96
      Width = 113
      Height = 25
      Caption = 'Neues Puzzle'
      TabOrder = 0
      OnClick = CreateBtnClick
    end
    object SolutionBtn: TButton
      Left = 16
      Top = 128
      Width = 113
      Height = 25
      Caption = 'Lösung'
      TabOrder = 1
      OnClick = SolutionBtnClick
    end
    object SizeGrp: TRadioGroup
      Left = 16
      Top = 16
      Width = 233
      Height = 65
      Caption = 'Spielfeldgröße'
      Columns = 3
      ItemIndex = 1
      Items.Strings = (
        '5 x 4'
        '6 x 5'
        '7 x 6'
        '8 x 7'
        '9 x 8'
        '10 x 9')
      TabOrder = 2
      OnClick = SizeGrpClick
    end
    object RestartBtn: TButton
      Left = 136
      Top = 96
      Width = 113
      Height = 25
      Caption = 'Zurücksetzen'
      TabOrder = 3
      OnClick = RestartBtnClick
    end
    object AvailListBox: TListBox
      Left = 16
      Top = 216
      Width = 100
      Height = 364
      BorderStyle = bsNone
      Color = 15790320
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      IntegralHeight = True
      ItemHeight = 13
      ParentFont = False
      TabOrder = 4
    end
    object AddedListBox: TListBox
      Left = 136
      Top = 216
      Width = 100
      Height = 369
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = []
      ItemHeight = 13
      ParentFont = False
      Sorted = True
      TabOrder = 5
      OnClick = AddedListBoxClick
    end
  end
end
