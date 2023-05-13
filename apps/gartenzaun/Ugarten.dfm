object Form1: TForm1
  Left = 304
  Top = 217
  Width = 981
  Height = 505
  Caption = 'Gartenzaunkodierung'
  Color = clWhite
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Verdana'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 16
  object Label1: TLabel
    Left = 32
    Top = 16
    Width = 51
    Height = 16
    Caption = 'Klartext'
  end
  object Label2: TLabel
    Left = 504
    Top = 16
    Width = 74
    Height = 16
    Caption = 'Geheimtext'
  end
  object Label3: TLabel
    Left = 32
    Top = 424
    Width = 65
    Height = 16
    Caption = 'Zeilenzahl'
  end
  object Memo1: TMemo
    Left = 24
    Top = 40
    Width = 449
    Height = 360
    TabOrder = 0
  end
  object Memo2: TMemo
    Left = 496
    Top = 40
    Width = 449
    Height = 360
    Lines.Strings = (
      'EgeheeMhrs rdkigrinendnumnle '#223' elad nes'#228'nuln '
      'ntrrnnnedtfFnzd.r'#246'hcefbettz.nhcW s z dkigr ud sDtabT zdhrecd '
      'Hnecntnjwu rmi'#252'e ueoneiwucriuthKeonadeb eeii  icti br ac'#246'e  '
      'ozuem a eee ea.wee dmr n  oz  ie.a drgeoetaln adz '
      'eeurehiutMni.wrleieenagSaodese '#246'ianHr iseae rr,ttEee '
      'adKnctrhRie'#252'aejdteewsun ieirik e!s ira u,ln n enn.diukkr itkec '
      
        'erel'#223' l orf u esae t iha ,g oitfnokUdtea  etazs,bes ase bnnnKlsd' +
        'r '
      'baddmKn ermaha.re nhe a ii rsienbn dr erdmnslnnhenoedw'#252' '
      
        'e'#223'snbdi lnb'#252','#223'rirrtnw  snn  eautbcaSttn ml  iirssnl,dd usrhne  r' +
        'li '
      'ne  da e haR  nen tmdKgd  z,ernrnder e  ltNw  ioeu  hgh r ea  '
      'auseDe   d,si'#223'pheene gausahkea  tzu zdcaeGh.re b,reede'#252'e '
      ',rnhdsswntrggrslheO rn  a  emdessened rc  hei e'#246' t  zet    '
      'nnnkmwsw  fedc,rtnnwdDsenheus  tkeea sb. '#246'ateTr a ale '
      ',aaesod'#252'tg hnF uu Se iahadb rehdpt hEni'#223'Knng ese nee u '
      #228'dFdeasgne See i Ric uddge; ai e de'#246'e '#252',G niezldeluu degtrddee '
      
        'r, nmhsesaeze wrz  anarc.Ddrlnn cwa nGDrt r, nkhi ik iz  eih!dnt' +
        'rt '
      
        'in eha  eeu'#252'ez r gte!shseiee  utesnaehescregtngi,gnnsudds ii  ee' +
        ' '
      
        'E, i a e in i e  cl etZia nNDoatKt ,rln bt ii ggiecn,i oiie'#246' Ftu' +
        'taN '
      'iterinnehn tke,igF uhuienis inta i traudfa eaght eezu ncvudc '
      'foZ!crgnn,metoinnazobti uiga naeggnislde,elS,iem rr')
    TabOrder = 1
  end
  object Edit1: TEdit
    Left = 112
    Top = 420
    Width = 49
    Height = 24
    TabOrder = 2
    Text = '5'
  end
  object Button1: TButton
    Left = 336
    Top = 420
    Width = 129
    Height = 25
    Caption = 'Kodieren'
    TabOrder = 3
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 808
    Top = 420
    Width = 129
    Height = 25
    Caption = 'Dekodieren'
    TabOrder = 4
    OnClick = Button2Click
  end
  object CheckBox1: TCheckBox
    Left = 504
    Top = 424
    Width = 225
    Height = 17
    Caption = 'nur Ziffern und Buchstaben'
    TabOrder = 5
  end
end
