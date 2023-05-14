object Form1: TForm1
  Left = 445
  Top = 53
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Arbeitstage zwischen 2 Daten'
  ClientHeight = 676
  ClientWidth = 629
  Color = clWhite
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Verdana'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 16
  object Label1: TLabel
    Left = 448
    Top = 36
    Width = 16
    Height = 16
    Caption = 'ab'
  end
  object Label2: TLabel
    Left = 448
    Top = 76
    Width = 18
    Height = 16
    Caption = 'bis'
  end
  object Label3: TLabel
    Left = 316
    Top = 176
    Width = 68
    Height = 16
    Caption = 'Feiertage:'
  end
  object Label5: TLabel
    Left = 316
    Top = 644
    Width = 212
    Height = 13
    Caption = 'Eintrag links mit der Maus auswählen'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
  end
  object DateTimePicker1: TDateTimePicker
    Left = 480
    Top = 32
    Width = 121
    Height = 24
    CalAlignment = dtaLeft
    Date = 41640.3681958449
    Time = 41640.3681958449
    DateFormat = dfShort
    DateMode = dmComboBox
    Kind = dtkDate
    ParseInput = False
    TabOrder = 0
    OnChange = Button1Click
  end
  object DateTimePicker2: TDateTimePicker
    Left = 480
    Top = 72
    Width = 121
    Height = 24
    CalAlignment = dtaLeft
    Date = 42004.3682897106
    Time = 42004.3682897106
    DateFormat = dfShort
    DateMode = dmComboBox
    Kind = dtkDate
    ParseInput = False
    TabOrder = 1
    OnChange = Button1Click
  end
  object Button1: TButton
    Left = 480
    Top = 112
    Width = 121
    Height = 25
    Caption = 'Berechnen'
    Default = True
    TabOrder = 2
    OnClick = Button1Click
  end
  object ListBox1: TListBox
    Left = 16
    Top = 24
    Width = 281
    Height = 633
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Verdana'
    Font.Style = []
    ItemHeight = 13
    ParentFont = False
    TabOrder = 3
    TabWidth = 110
    OnClick = auswahl
  end
  object ListBox2: TListBox
    Left = 200
    Top = 568
    Width = 121
    Height = 97
    ItemHeight = 16
    Items.Strings = (
      'Baden-Württemberg'
      'Bayern'
      'Berlin'
      'Brandenburg'
      'Bremen'
      'Hamburg'
      'Hessen'
      'Mecklenburg-Vorpommern'
      'Niedersachsen'
      'Nordrhein-Westfalen'
      'Rheinland-Pfalz'
      'Saarland'
      'Sachsen'
      'Sachsen-Anhalt'
      'Schleswig-Holstein'
      'Thüringen'
      'Österreich'
      'Kanton Zürich'
      'Kanton Bern'
      'Kanton Luzern'
      'Kanton Uri'
      'Kanton Schwyz'
      'Kanton Obwalden'
      'Kanton Nidwalden'
      'Kanton Glarus'
      'Kanton Zug'
      'Kanton Freiburg'
      'Kanton Solothurn'
      'Kanton Basel (Stadt, Land)'
      'Kanton Schaffhausen'
      'Kanton Appenzell A.Rh.'
      'Kanton Appenzell I.Rh.'
      'Kanton St.Gallen'
      'Kanton Graubünden'
      'Kanton Aargau'
      'Kanton Thurgau'
      'Cantone del Ticino'
      'Canton de Vaud'
      'Canton du Valais'
      'Canton du Neuchâtel'
      'Canton du Genève'
      'Canton du Jura'
      'Liechtenstein')
    TabOrder = 4
    Visible = False
  end
  object ListBox3: TListBox
    Left = 312
    Top = 204
    Width = 297
    Height = 433
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Verdana'
    Font.Style = []
    IntegralHeight = True
    ItemHeight = 13
    ParentFont = False
    Sorted = True
    TabOrder = 5
    TabWidth = 65
  end
  object ListBox4: TListBox
    Left = 64
    Top = 568
    Width = 121
    Height = 97
    ItemHeight = 16
    Items.Strings = (
      '01.01.Neujahrstag'
      'xx.xx.Ostersonntag'
      'xx.xx.Karfreitag'
      'xx.xx.Ostermontag'
      'xx.xx.Himmelfahrt'
      'xx.xx.Pfingstsonntag'
      'xx.xx.Pfingstmontag'
      '01.05.1.Mai'
      '25.12.Weihnachtstag'
      '26.12.2.Weihnachstag'
      '03.10.Tag der deutschen Einheit'
      '06.01.Heilige 3 Könige'
      'xx.xx.Fronleichnam'
      '15.08.Maria Himmelfahrt'
      '31.10.Reformationstag'
      '01.11.Aller Heiligen'
      'xx.xx.Buß- und Bettag'
      '26.10.Nationalfeiertag Österreich'
      '08.12.Maria Empfängnis'
      '08.09.Maria Geburt'
      '01.08.Nationalfeiertag Schweiz'
      '02.01.Berchtholdstag'
      '19.03.Josephstag'
      '25.09.Bruderklausenfest'
      '22.09.Mauritiustag'
      '01.03.Instauration de la République'
      '31.12.Restauration de la République'
      '23.06.Plébiscite jurassien'
      'xx.xx.Näfelserfahrt'
      'xx.xx.Schweizer Buß- und Bettag'
      'xx.xx.Genfer Buß- und Bettag'
      '29.06.San Pietro'
      '')
    TabOrder = 6
    Visible = False
  end
end
