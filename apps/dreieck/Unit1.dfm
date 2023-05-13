object Form1: TForm1
  Left = 194
  Top = 29
  BorderStyle = bsSingle
  Caption = 'Rechtwinkliges Dreieck'
  ClientHeight = 684
  ClientWidth = 984
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  Scaled = False
  OnActivate = FormActivate
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object PaintBox1: TPaintBox
    Left = 193
    Top = 36
    Width = 791
    Height = 612
    Align = alClient
    OnPaint = Button1Click
  end
  object Panel1: TPanel
    Left = 0
    Top = 36
    Width = 193
    Height = 612
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
      Top = 20
      Width = 44
      Height = 14
      Caption = 'Seite a'
    end
    object Label2: TLabel
      Left = 16
      Top = 44
      Width = 44
      Height = 14
      Caption = 'Seite b'
    end
    object Label3: TLabel
      Left = 16
      Top = 112
      Width = 76
      Height = 14
      Caption = 'Hypotenuse'
    end
    object Label4: TLabel
      Left = 16
      Top = 136
      Width = 83
      Height = 14
      Caption = 'Fl�cheninhalt'
    end
    object Label5: TLabel
      Left = 16
      Top = 160
      Width = 35
      Height = 14
      Caption = 'Alpha'
    end
    object Label6: TLabel
      Left = 16
      Top = 184
      Width = 29
      Height = 14
      Caption = 'Beta'
    end
    object Label7: TLabel
      Left = 16
      Top = 208
      Width = 67
      Height = 14
      Caption = 'H�he auf c'
    end
    object Label8: TLabel
      Left = 16
      Top = 232
      Width = 70
      Height = 14
      Caption = 'Abschnitt p'
    end
    object Label9: TLabel
      Left = 16
      Top = 256
      Width = 70
      Height = 14
      Caption = 'Abschnitt q'
    end
    object Label10: TLabel
      Left = 128
      Top = 112
      Width = 12
      Height = 14
      Caption = '...'
    end
    object Label11: TLabel
      Left = 128
      Top = 136
      Width = 12
      Height = 14
      Caption = '...'
    end
    object Label12: TLabel
      Left = 128
      Top = 160
      Width = 12
      Height = 14
      Caption = '...'
    end
    object Label13: TLabel
      Left = 128
      Top = 184
      Width = 12
      Height = 14
      Caption = '...'
    end
    object Label14: TLabel
      Left = 128
      Top = 208
      Width = 12
      Height = 14
      Caption = '...'
    end
    object Label15: TLabel
      Left = 128
      Top = 232
      Width = 12
      Height = 14
      Caption = '...'
    end
    object Label16: TLabel
      Left = 128
      Top = 256
      Width = 12
      Height = 14
      Caption = '...'
    end
    object Label0: TLabel
      Left = 16
      Top = 288
      Width = 74
      Height = 14
      Caption = 'Ma�stab 1: '
    end
    object Edit1: TEdit
      Left = 88
      Top = 16
      Width = 81
      Height = 22
      TabOrder = 0
      Text = '3'
    end
    object Edit2: TEdit
      Left = 88
      Top = 40
      Width = 81
      Height = 22
      TabOrder = 1
      Text = '4'
    end
    object Button1: TButton
      Left = 16
      Top = 72
      Width = 153
      Height = 25
      Caption = 'Berechnung'
      TabOrder = 2
      OnClick = Button1Click
    end
    object RadioGroup1: TRadioGroup
      Left = 16
      Top = 392
      Width = 153
      Height = 146
      Caption = 'Sprache'
      ItemIndex = 0
      Items.Strings = (
        'Deutsch'
        'Franz�sisch'
        'Englisch'
        'Latein'
        'Russisch'
        'Niederl�ndisch'
        'Spanisch')
      TabOrder = 3
      OnClick = RadioGroup1Click
    end
    object Button2: TButton
      Left = 16
      Top = 320
      Width = 153
      Height = 25
      Caption = 'Animation'
      TabOrder = 4
      OnClick = Button2Click
    end
    object CheckBox1: TCheckBox
      Left = 24
      Top = 360
      Width = 153
      Height = 17
      Caption = 'Kathetensatz'
      TabOrder = 5
      OnClick = Button1Click
    end
    object ListBox1: TListBox
      Left = 16
      Top = 592
      Width = 121
      Height = 97
      ItemHeight = 14
      Items.Strings = (
        '[Deutsch'
        'Rechtwinkliges Dreieck'
        
          'Satz des Pythagoras: In einem rechtwinkligen Dreieck gilt, dass ' +
          'die Summe der Quadrate �ber den Katheten gleich dem Quadrat �ber' +
          ' der Hypotenuse ist.'
        'Seite a'
        'Seite b'
        'Hypotenuse'
        'Fl�cheninhalt'
        'Alpha'
        'Beta'
        'H�he auf c'
        'Abschnitt p'
        'Abschnitt q'
        'Ma�stab'
        'Sprache'
        'Deutsch'
        'Franz�sisch'
        'Englisch'
        'Latein'
        'Russisch'
        'Niederl�ndisch'
        'Spanisch'
        'Kathetensatz'
        'Berechnung'
        'Animation'
        '[Franz�sich'
        'Triangle rectangle'
        
          'Le carr� de la longueur de l�hypot�nuse dans un triangle rectang' +
          'le est �gal � la somme des carr�s des longueurs des deux autres ' +
          'c�t�s.'
        'Cath�te a'
        'Cath�te b'
        'Hypot�nuse'
        'Aire'
        'Alpha'
        'Beta'
        'Hauteur'
        'Fragment p'
        'Fragment q'
        '�chelle'
        'Langage'
        'Allemand'
        'Fran�ais'
        'Anglais'
        'Latin'
        'Russe'
        'N�erlandais'
        'Espagnol'
        'Th�or�me d'#39'Euclide'
        'Calcul'
        'Animation'
        '[Englisch'
        'Right triangle'
        
          'In any right triangle, the area of the square whose side is the ' +
          'hypotenuse is equal to the sum of the areas of the squares whose' +
          ' sides are the two legs.'
        'Leg a'
        'Leg b'
        'Hypotenuse'
        'Area'
        'Alpha'
        'Beta'
        'Height'
        'Segment p'
        'Segment q'
        'Scale'
        'Language'
        'German'
        'French'
        'English'
        'Latin'
        'Russian'
        'Dutch'
        'Spanish'
        'Euclidian theorem'
        'Calculation'
        'Animation'
        '[Latein'
        'Triangulum rectum'
        
          'Enuntiatum theoremae est: in triangulum ABC rectum in C quod hyp' +
          'othenusa est AB, habemus AC� + BC� = AB�.'
        'Catheta a'
        'Catheta b'
        'Hypotenusa'
        'Area'
        'Alpha'
        'Beta'
        'Altitudo'
        'Segmentum p'
        'Segmentum q'
        'Modulus'
        'Lingua'
        'Germani lingua'
        'Gallico lingua'
        'Anglico lingua'
        'Latina'
        'Orientalum lingua'
        'Lingua sephela'
        'Lingua hispania'
        'Sententia kathetae'
        'Computatio'
        'Alacritas'
        '[Russisch'
        'Pr�mougol�n�j treugol�nik'
        
          'W pr�mougol�nom treugol�nike plo�ad� kwadrata, poctroennogo na g' +
          'ipotenuse, rawna cumme plo�adej kwadratow, poctroenn�x na kateta' +
          'x.'
        'Katet a'
        'Katet b'
        'Gipotenusa'
        'Plo�ad�'
        'Alfa'
        'Beta'
        'B�cota'
        'Otresok p'
        'Otresok q'
        'Macvtab'
        '�s�k'
        'Nemezkij'
        'Franzusckij'
        'Anglijckij'
        'Latinckij'
        'Rucckij'
        'Gollandckij'
        'Icpanckij'
        'Teorema Ewklida'
        'W�yiclenie'
        'Modelirowanie'
        '[Niederl�ndsch'
        'Rechthoekige driehoek'
        
          'In een rechthoekige driehoek is de som van de kwadraten van de l' +
          'engtes van de rechthoekszijden gelijk aan het kwadraat van de le' +
          'ngte van de schuine zijde.'
        'Zijd a'
        'Zijd b'
        'Hypotenusa'
        'Oppervlakte'
        'Alfa'
        'B�ta'
        'Hoogte op c'
        'Segment p'
        'Segment q'
        'Maatstaf'
        'Taal'
        'Duits'
        'Frans'
        'Engels'
        'Latijn'
        'Russisch'
        'Nederlands'
        'Spaans'
        'Stelling van Euclides'
        'Berekening'
        'Simulatie'
        '[Spanisch'
        'Tri�ngulo rect�ngulo'
        
          'Teorema de Pit�goras: En todo tri�ngulo rect�ngulo el cuadrado d' +
          'e la hipotenusa es igual a la suma de los cuadrados de los catet' +
          'os.'
        'Cateto a'
        'Cateto b'
        'Hipotenusa'
        '�rea'
        'Alfa'
        'Beta'
        'Altura sobre c'
        'Secci�n p'
        'Secci�n q'
        'Escala'
        'Idioma'
        'Alem�n'
        'Franc�s'
        'Ingl�s'
        'Latino'
        'Ruso'
        'Holand�s'
        'Espa�ol'
        'Teorema del cateto'
        'C�lculo'
        'Animaci�n'
        '[')
      TabOrder = 6
      Visible = False
    end
    object Edit3: TEdit
      Left = 96
      Top = 284
      Width = 49
      Height = 22
      AutoSize = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      TabOrder = 7
      Text = '40'
      OnChange = Button1Click
    end
    object UpDown1: TUpDown
      Left = 145
      Top = 284
      Width = 16
      Height = 22
      Associate = Edit3
      Min = 5
      Position = 40
      TabOrder = 8
      Wrap = False
    end
    object Button3: TButton
      Left = 16
      Top = 552
      Width = 153
      Height = 25
      Caption = '"All about Pythagoras"'
      TabOrder = 9
      OnClick = Button3Click
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 984
    Height = 36
    Align = alTop
    Caption = 'Rechtwinkliges Dreieck'
    Color = 15790320
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -19
    Font.Name = 'Verdana'
    Font.Style = [fsBold, fsItalic]
    ParentFont = False
    TabOrder = 1
  end
  object Panel3: TPanel
    Left = 0
    Top = 648
    Width = 984
    Height = 36
    Align = alBottom
    BevelOuter = bvNone
    Caption = 
      'Satz des Pythagoras: In einem rechtwinkligen Dreieck gilt, dass ' +
      'die Summe der Quadrate �ber den Katheten gleich dem Quadrat �ber' +
      ' der Hypotenuse ist.'
    Color = 15790320
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 25
    OnTimer = Timer1Timer
    Left = 824
    Top = 8
  end
end
