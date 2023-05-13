object form10k: Tform10k
  Left = 225
  Top = 51
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Kryptogramm'
  ClientHeight = 496
  ClientWidth = 887
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clBlack
  Font.Height = -12
  Font.Name = 'Verdana'
  Font.Style = []
  Menu = MM1
  OldCreateOrder = False
  Position = poDesktopCenter
  Scaled = False
  OnActivate = FormActivate
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 14
  object P8: TPanel
    Left = 1
    Top = 0
    Width = 886
    Height = 496
    Align = alClient
    BevelOuter = bvNone
    Color = clWhite
    TabOrder = 0
    object krypto: TPanel
      Left = 0
      Top = 486
      Width = 886
      Height = 10
      Align = alBottom
      BevelOuter = bvNone
      Caption = 'krypto'
      Color = clWhite
      TabOrder = 0
      Visible = False
      object P17: TPanel
        Left = 0
        Top = 0
        Width = 886
        Height = 366
        Align = alTop
        BevelOuter = bvNone
        Color = clWhite
        TabOrder = 0
        object P24: TPanel
          Left = 0
          Top = 0
          Width = 886
          Height = 366
          Align = alClient
          BevelOuter = bvNone
          Color = clWhite
          TabOrder = 0
          object L13: TLabel
            Left = 824
            Top = 26
            Width = 11
            Height = 16
            Caption = '='
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object L14: TLabel
            Left = 824
            Top = 90
            Width = 11
            Height = 16
            Caption = '='
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object L15: TLabel
            Left = 824
            Top = 146
            Width = 11
            Height = 16
            Caption = '='
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object L18: TLabel
            Left = 360
            Top = 96
            Width = 5
            Height = 16
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Verdana'
            Font.Style = []
            ParentFont = False
          end
          object L35: TLabel
            Left = 452
            Top = 64
            Width = 7
            Height = 16
            Caption = '-'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Verdana'
            Font.Style = []
            ParentFont = False
          end
          object Label3: TLabel
            Left = 16
            Top = 80
            Width = 47
            Height = 14
            Caption = 'Lösung'
            Font.Charset = ANSI_CHARSET
            Font.Color = clRed
            Font.Height = -12
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object E4: TEdit
            Left = 568
            Top = 24
            Width = 90
            Height = 24
            CharCase = ecUpperCase
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
            OnChange = uebertragen
          end
          object E5: TEdit
            Left = 672
            Top = 24
            Width = 36
            Height = 24
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 1
            OnChange = uebertragen
          end
          object E6: TEdit
            Left = 720
            Top = 24
            Width = 90
            Height = 24
            CharCase = ecUpperCase
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 2
            OnChange = uebertragen
          end
          object E7: TEdit
            Left = 848
            Top = 24
            Width = 90
            Height = 24
            CharCase = ecUpperCase
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 3
            OnChange = uebertragen
          end
          object E8: TEdit
            Left = 592
            Top = 56
            Width = 36
            Height = 24
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 4
            OnChange = uebertragen
          end
          object E9: TEdit
            Left = 744
            Top = 56
            Width = 36
            Height = 24
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 5
            OnChange = uebertragen
          end
          object E10: TEdit
            Left = 872
            Top = 56
            Width = 36
            Height = 24
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 6
            OnChange = uebertragen
          end
          object E11: TEdit
            Left = 568
            Top = 88
            Width = 90
            Height = 24
            CharCase = ecUpperCase
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 7
            OnChange = uebertragen
          end
          object E12: TEdit
            Left = 672
            Top = 88
            Width = 36
            Height = 24
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 8
            OnChange = uebertragen
          end
          object E13: TEdit
            Left = 720
            Top = 88
            Width = 90
            Height = 24
            CharCase = ecUpperCase
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 9
            OnChange = uebertragen
          end
          object E14: TEdit
            Left = 848
            Top = 88
            Width = 90
            Height = 24
            CharCase = ecUpperCase
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 10
            OnChange = uebertragen
          end
          object E15: TEdit
            Left = 568
            Top = 144
            Width = 90
            Height = 24
            CharCase = ecUpperCase
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 11
            OnChange = uebertragen
          end
          object E16: TEdit
            Left = 672
            Top = 144
            Width = 36
            Height = 24
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 12
            OnChange = uebertragen
          end
          object E17: TEdit
            Left = 720
            Top = 144
            Width = 90
            Height = 24
            CharCase = ecUpperCase
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 13
            OnChange = uebertragen
          end
          object E18: TEdit
            Left = 848
            Top = 144
            Width = 90
            Height = 24
            CharCase = ecUpperCase
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 14
            OnChange = uebertragen
          end
          object P18: TPanel
            Left = 554
            Top = 126
            Width = 396
            Height = 2
            BevelOuter = bvNone
            Caption = 'P18'
            Color = clBlack
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Verdana'
            Font.Style = []
            ParentFont = False
            TabOrder = 15
          end
          object LB5: TListBox
            Left = 1176
            Top = -40
            Width = 121
            Height = 97
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Verdana'
            Font.Style = []
            ItemHeight = 16
            Items.Strings = (
              '[1'
              'AB'
              '*'
              'BC'
              'DEF'
              '+'
              '+'
              ':'
              'GCC'
              ':'
              'BC'
              'E'
              'GDE'
              '-'
              'CF'
              'GBF'
              '3247681:::'
              '[2'
              'AB'
              '+'
              'CB'
              'DB'
              '*'
              '*'
              '*'
              'CB'
              '-'
              'E'
              'E'
              'ABB'
              '-'
              'EB'
              'CEB'
              '20135:::::'
              '[3'
              'FD'
              '*'
              'DA'
              'AHG'
              '+'
              '+'
              '+'
              'BGF'
              '-'
              'BCA'
              'BE'
              'BHE'
              '+'
              'BBG'
              'HBC'
              '84125369::'
              '[4'
              'A'
              '+'
              'B'
              'C'
              '+'
              '+'
              '+'
              'D'
              '+'
              'E'
              'F'
              'E'
              '+'
              'G'
              'AB'
              '1234597:::'
              '[5'
              'AB'
              ':'
              'C'
              'D'
              '-'
              '+'
              '+'
              'E'
              '-'
              'A'
              'F'
              'G'
              '*'
              'H'
              'AG'
              '14279853::'
              '[6'
              'AB'
              ':'
              'C'
              'D'
              '-'
              '*'
              '+'
              'B'
              '+'
              'A'
              'D'
              'AE'
              '-'
              'C'
              'F'
              '124306::::'
              '[7'
              'A'
              '*'
              'A'
              'B'
              '+'
              '*'
              '-'
              'C'
              '*'
              'D'
              'E'
              'F'
              '-'
              'G'
              'H'
              '39428761::'
              '[8'
              'ABC'
              '-'
              'DB'
              'EC'
              ':'
              '+'
              '+'
              'EA'
              '*'
              'F'
              'GF'
              'C'
              '+'
              'DF'
              'DD'
              '1058236:::'
              '[9'
              'ABC'
              '+'
              'BDE'
              'FGH'
              '+'
              '-'
              '+'
              'ADB'
              '-'
              'ECB'
              'IJ'
              'GCE'
              '+'
              'EAC'
              'HJH'
              '3571286940'
              '[10'
              'ABCD'
              '+'
              'EBFB'
              'FGEH'
              '-'
              ':'
              '+'
              'GIEA'
              '+'
              'HJB'
              'AAEF'
              'CAC'
              '*'
              'GB'
              'IHIJ'
              '2568471390'
              '[11'
              'ABCD'
              ':'
              'BE'
              'CFG'
              '-'
              '*'
              '+'
              'EHFD'
              '-'
              'BED'
              'EICF'
              'JCCF'
              '-'
              'BCAH'
              'EACG'
              '9178306425'
              '[12'
              'ABCD'
              '-'
              'EFCE'
              'GEAF'
              ':'
              '-'
              '-'
              'HD'
              '*'
              'IE'
              'BHID'
              'CGF'
              '+'
              'EIJD'
              'CBEF'
              '9140375268'
              '[13'
              'AABB'
              ':'
              'ACB'
              'DD'
              '-'
              '+'
              '*'
              'DEFA'
              '-'
              'DCDC'
              'EAA'
              'GHEH'
              '-'
              'DADB'
              'EBCA'
              '58012643::'
              '[14'
              'ABCD'
              ':'
              'EE'
              'FFD'
              '-'
              '*'
              '+'
              'DGHI'
              '-'
              'GID'
              'DIBA'
              'JEBD'
              '-'
              'GGDD'
              'DADI'
              '8492173506'
              '[15'
              'ABBC'
              ':'
              'DC'
              'ED'
              '-'
              '*'
              '+'
              'FFFF'
              '+'
              'GE'
              'FFAH'
              'GCCF'
              '-'
              'CHID'
              'FCGA'
              '532681497:'
              '[16'
              'AABC'
              ':'
              'DE'
              'CDC'
              '+'
              '+'
              '*'
              'DCFG'
              '-'
              'DCHI'
              'CG'
              'JEFI'
              '+'
              'DCEE'
              'HBAE'
              '3921678504'
              '[17'
              'ABC'
              '-'
              'DE'
              'FEG'
              ':'
              '-'
              '-'
              'HG'
              '*'
              'CH'
              'DIG'
              'CA'
              '+'
              'JC'
              'FB'
              '7035469182'
              '[18'
              'A'
              ':'
              'B'
              'B'
              '-'
              '+'
              '+'
              'C'
              '*'
              'D'
              'EF'
              'D'
              '+'
              'EG'
              'ED'
              '9327140:::'
              '[19'
              'ABC'
              '-'
              'ADH'
              'HE'
              '+'
              '-'
              '*'
              'HFC'
              ':'
              'GD'
              'AI'
              'FDC'
              '+'
              'AHJ'
              'JJJ'
              '2905761348'
              '[20'
              'ABB'
              '+'
              'CDE'
              'FDE'
              ':'
              '+'
              '-'
              'GB'
              '+'
              'GFH'
              'GDH'
              'IB'
              '+'
              'JFI'
              'HBI'
              '6019872534'
              '[21'
              'ABB'
              '-'
              'CCC'
              'DEE'
              '-'
              '+'
              '*'
              'FGF'
              '-'
              'CHB'
              'CAA'
              'GHA'
              '*'
              'GEI'
              'EFIFA'
              '581473269:'
              '[22'
              'ABC'
              '-'
              'DB'
              'EFC'
              '+'
              '+'
              '*'
              'AFB'
              '+'
              'AG'
              'ADG'
              'FFC'
              '*'
              'HG'
              'IHGEC'
              '205614783:'
              '[23'
              'ABB'
              '-'
              'CD'
              'EED'
              '-'
              '-'
              '*'
              'FD'
              '+'
              'EF'
              'CE'
              'EGD'
              '*'
              'FH'
              'HGED'
              '20851639::'
              '[24'
              'ABC'
              '-'
              'DEF'
              'CDC'
              '+'
              '-'
              '*'
              'DGG'
              '-'
              'DDH'
              'IH'
              'BEH'
              '*'
              'CC'
              'JCAH'
              '3612408957'
              '[25'
              'ABCC'
              '-'
              'ADEE'
              'FCF'
              '-'
              '-'
              '*'
              'EBA'
              '+'
              'ACF'
              'AAGB'
              'BHI'
              '*'
              'EIJ'
              'BJEJAG'
              '1750962843'
              '[26'
              'AB'
              '*'
              'BC'
              'DAD'
              '*'
              ':'
              '*'
              'EC'
              ':'
              'F'
              'F'
              'BCD'
              '*'
              'G'
              'BBEA'
              '2368149:::'
              '[27'
              'ABA'
              ':'
              'CD'
              'CE'
              '+'
              '+'
              '+'
              'CDA'
              '+'
              'CCF'
              'AGA'
              'EHE'
              '-'
              'CAD'
              'HFI'
              '251840936:'
              '[28'
              'ABC'
              '-'
              'DBB'
              'EFG'
              '+'
              '+'
              '+'
              'ABB'
              '-'
              'ECC'
              'BBB'
              'DBEB'
              '-'
              'HBB'
              'IBC'
              '620149857:'
              '[29'
              'ABC'
              '+'
              'DDE'
              'FCF'
              '+'
              '+'
              '+'
              'CB'
              '+'
              'BGE'
              'BCA'
              'AEE'
              '+'
              'CBG'
              'DGAE'
              '7231580:::'
              '[30'
              'ABCD'
              '+'
              'EEFG'
              'HGDD'
              '-'
              ':'
              '+'
              'ACDD'
              '+'
              'CCI'
              'AHAC'
              'IIG'
              '*'
              'AH'
              'FFGG'
              '172836054:'
              '[31'
              'ABCD'
              ':'
              'CEC'
              'CF'
              '-'
              '+'
              '*'
              'GBAH'
              '-'
              'GAID'
              'GJA'
              'HFAH'
              '-'
              'GDFJ'
              'EJBH'
              '6728391450'
              '[32'
              'ABCD'
              '+'
              'EFAC'
              'GHFC'
              ':'
              '-'
              '+'
              'IEF'
              '+'
              'JCD'
              'EDHF'
              'EG'
              '*'
              'ABC'
              'JDFD'
              '4680125937'
              '[#'
              '32')
            ParentFont = False
            TabOrder = 16
            Visible = False
          end
          object LB3: TListBox
            Left = 20
            Top = 104
            Width = 485
            Height = 81
            BorderStyle = bsNone
            Color = clWhite
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Verdana'
            Font.Style = []
            ItemHeight = 16
            ParentFont = False
            TabOrder = 17
            TabWidth = 16
          end
        end
      end
    end
    object Panel1: TPanel
      Left = 0
      Top = 0
      Width = 886
      Height = 486
      Align = alClient
      BevelOuter = bvNone
      Color = clWhite
      TabOrder = 1
      object Panel3: TPanel
        Left = 0
        Top = 32
        Width = 886
        Height = 326
        Align = alClient
        BevelOuter = bvNone
        Color = clWhite
        TabOrder = 0
        object PB1: TPaintBox
          Left = 0
          Top = 0
          Width = 886
          Height = 326
          Align = alClient
          OnPaint = PB1Paint
        end
      end
      object Panel4: TPanel
        Left = 0
        Top = 358
        Width = 886
        Height = 128
        Align = alBottom
        BevelOuter = bvNone
        Color = 15790320
        TabOrder = 1
        object Label2: TLabel
          Left = 24
          Top = 86
          Width = 48
          Height = 16
          Caption = 'Beispiel'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Verdana'
          Font.Style = []
          ParentFont = False
        end
        object I0: TImage
          Left = 192
          Top = 20
          Width = 35
          Height = 35
          AutoSize = True
          Transparent = True
        end
        object I1: TImage
          Left = 192
          Top = 62
          Width = 35
          Height = 35
          AutoSize = True
          Transparent = True
        end
        object I2: TImage
          Left = 328
          Top = 20
          Width = 35
          Height = 35
          AutoSize = True
          Transparent = True
        end
        object I3: TImage
          Left = 328
          Top = 62
          Width = 35
          Height = 35
          AutoSize = True
          Transparent = True
        end
        object I4: TImage
          Left = 464
          Top = 20
          Width = 35
          Height = 35
          AutoSize = True
          Transparent = True
        end
        object I5: TImage
          Left = 464
          Top = 62
          Width = 35
          Height = 35
          AutoSize = True
          Transparent = True
        end
        object I6: TImage
          Left = 600
          Top = 20
          Width = 35
          Height = 35
          AutoSize = True
          Transparent = True
        end
        object I7: TImage
          Left = 600
          Top = 62
          Width = 35
          Height = 35
          AutoSize = True
          Transparent = True
        end
        object I8: TImage
          Left = 736
          Top = 20
          Width = 35
          Height = 35
          AutoSize = True
          Transparent = True
        end
        object I9: TImage
          Left = 736
          Top = 62
          Width = 35
          Height = 35
          AutoSize = True
          Transparent = True
        end
        object I10: TImage
          Left = -56
          Top = -10
          Width = 105
          Height = 105
          AutoSize = True
          Visible = False
        end
        object I11: TImage
          Left = -64
          Top = -26
          Width = 105
          Height = 105
          AutoSize = True
          Visible = False
        end
        object I12: TImage
          Left = -64
          Top = -18
          Width = 105
          Height = 105
          AutoSize = True
          Visible = False
        end
        object I13: TImage
          Left = -48
          Top = -10
          Width = 105
          Height = 105
          AutoSize = True
          Visible = False
        end
        object I14: TImage
          Left = -40
          Top = -2
          Width = 105
          Height = 105
          AutoSize = True
          Visible = False
        end
        object Lx1: TRxSpinEdit
          Left = 240
          Top = 26
          Width = 48
          Height = 28
          EditorEnabled = False
          MaxValue = 10
          ValueType = vtHex
          Value = 10
          BorderStyle = bsNone
          Color = 15790320
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -19
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          OnChange = Lx1Change
        end
        object Lx2: TRxSpinEdit
          Left = 240
          Top = 66
          Width = 48
          Height = 28
          EditorEnabled = False
          MaxValue = 10
          ValueType = vtHex
          Value = 10
          BorderStyle = bsNone
          Color = 15790320
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -19
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          OnChange = Lx1Change
        end
        object Lx3: TRxSpinEdit
          Left = 376
          Top = 26
          Width = 48
          Height = 28
          EditorEnabled = False
          MaxValue = 10
          ValueType = vtHex
          Value = 10
          BorderStyle = bsNone
          Color = 15790320
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -19
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 2
          OnChange = Lx1Change
        end
        object Lx4: TRxSpinEdit
          Left = 376
          Top = 66
          Width = 48
          Height = 28
          EditorEnabled = False
          MaxValue = 10
          ValueType = vtHex
          Value = 10
          BorderStyle = bsNone
          Color = 15790320
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -19
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 3
          OnChange = Lx1Change
        end
        object Lx5: TRxSpinEdit
          Left = 512
          Top = 26
          Width = 48
          Height = 28
          EditorEnabled = False
          MaxValue = 10
          ValueType = vtHex
          Value = 10
          BorderStyle = bsNone
          Color = 15790320
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -19
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 4
          OnChange = Lx1Change
        end
        object Lx6: TRxSpinEdit
          Left = 512
          Top = 66
          Width = 48
          Height = 28
          EditorEnabled = False
          MaxValue = 10
          ValueType = vtHex
          Value = 10
          BorderStyle = bsNone
          Color = 15790320
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -19
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 5
          OnChange = Lx1Change
        end
        object Lx7: TRxSpinEdit
          Left = 648
          Top = 26
          Width = 48
          Height = 28
          EditorEnabled = False
          MaxValue = 10
          ValueType = vtHex
          Value = 10
          BorderStyle = bsNone
          Color = 15790320
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -19
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 6
          OnChange = Lx1Change
        end
        object Lx8: TRxSpinEdit
          Left = 648
          Top = 66
          Width = 48
          Height = 28
          EditorEnabled = False
          MaxValue = 10
          ValueType = vtHex
          Value = 10
          BorderStyle = bsNone
          Color = 15790320
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -19
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 7
          OnChange = Lx1Change
        end
        object Lx9: TRxSpinEdit
          Left = 784
          Top = 26
          Width = 48
          Height = 28
          EditorEnabled = False
          MaxValue = 10
          ValueType = vtHex
          Value = 10
          BorderStyle = bsNone
          Color = 15790320
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -19
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 8
          OnChange = Lx1Change
        end
        object Lx10: TRxSpinEdit
          Left = 784
          Top = 66
          Width = 48
          Height = 28
          EditorEnabled = False
          MaxValue = 10
          ValueType = vtHex
          Value = 10
          BorderStyle = bsNone
          Color = 15790320
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -19
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 9
          OnChange = Lx1Change
        end
        object rx2: TRxSpinEdit
          Left = 88
          Top = 84
          Width = 49
          Height = 22
          MaxValue = 10
          MinValue = 1
          Value = 1
          TabOrder = 10
          OnChange = Rx2Change
        end
        object Button1: TButton
          Left = 24
          Top = 16
          Width = 113
          Height = 25
          Caption = 'Neue Aufgabe'
          TabOrder = 11
          OnClick = D1Click
        end
        object Button2: TButton
          Left = 24
          Top = 48
          Width = 113
          Height = 25
          Caption = 'Hilfe geben'
          TabOrder = 12
          OnClick = D2Click
        end
      end
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 886
        Height = 32
        Align = alTop
        BevelOuter = bvNone
        Color = clWhite
        TabOrder = 2
        object Label1: TLabel
          Left = 368
          Top = 8
          Width = 167
          Height = 16
          Caption = 'Kryptogramm-Aufgabe'
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -13
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object CB1: TCheckBox
          Left = 8
          Top = 8
          Width = 121
          Height = 17
          Caption = 'Ziffern zeigen'
          Checked = True
          State = cbChecked
          TabOrder = 0
          OnClick = PB1Paint
        end
        object Panel7: TPanel
          Left = 772
          Top = 0
          Width = 114
          Height = 32
          Align = alRight
          BevelOuter = bvNone
          Color = clWhite
          TabOrder = 1
          object Label7: TLabel
            Left = 16
            Top = 8
            Width = 24
            Height = 14
            Caption = 'Zeit'
          end
          object Label6: TLabel
            Left = 56
            Top = 8
            Width = 41
            Height = 14
            Caption = '00:00'
            Font.Charset = ANSI_CHARSET
            Font.Color = clRed
            Font.Height = -12
            Font.Name = 'Verdana'
            Font.Style = [fsBold]
            ParentFont = False
          end
        end
      end
    end
  end
  object Panel8: TPanel
    Left = 0
    Top = 0
    Width = 1
    Height = 496
    Align = alLeft
    BevelOuter = bvNone
    Color = clWhite
    TabOrder = 1
    object panel9: TPanel
      Left = 0
      Top = 296
      Width = 1
      Height = 200
      Align = alBottom
      BevelOuter = bvNone
      Color = clWhite
      TabOrder = 0
    end
    object Panel10: TPanel
      Left = 0
      Top = 0
      Width = 1
      Height = 296
      Align = alClient
      BevelOuter = bvNone
      Color = clWhite
      TabOrder = 1
      object Panel11: TPanel
        Left = 0
        Top = 175
        Width = 1
        Height = 121
        Align = alBottom
        BevelOuter = bvNone
        Color = 15790320
        TabOrder = 0
      end
    end
  end
  object MM1: TMainMenu
    Left = 216
    Top = 92
    object M2: TMenuItem
      Caption = 'Datei'
      Visible = False
      object M3: TMenuItem
        Caption = 'Teilprogramm beenden'
        ShortCut = 27
        OnClick = S13Click
      end
      object M4: TMenuItem
        Caption = 'M'
        ShortCut = 13
        Visible = False
        OnClick = D4C
      end
    end
  end
  object Timer1: TTimer
    Interval = 50
    OnTimer = Timer1Timer
    Left = 224
    Top = 8
  end
end
