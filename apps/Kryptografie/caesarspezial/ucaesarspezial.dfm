object Form1: TForm1
  Left = 304
  Top = 217
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Spezielle C�sar-Kodierung'
  ClientHeight = 466
  ClientWidth = 965
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
  object Memo1: TMemo
    Left = 24
    Top = 40
    Width = 449
    Height = 360
    Lines.Strings = (
      'Ein K�nig hatte eine Tochter, die war �ber alle Ma�en sch�n, '
      
        'aber dabei so stolz und �berm�tig, da� ihr kein Freier gut genug' +
        ' '
      'war. Sie wies einen nach dem andern ab, und trieb noch dazu '
      
        'Spott mit ihnen. Einmal lie� der K�nig ein gro�es Fest anstellen' +
        ', '
      'und ladete dazu aus der N�he und Ferne die heiratslustigen '
      'M�nner ein. Sie wurden alle in eine Reihe nach Rang und Stand '
      'geordnet; erst kamen die K�nige, dann die Herz�ge, die F�rsten, '
      'Grafen und Freiherrn, zuletzt die Edelleute. Nun ward die '
      'K�nigstochter durch die Reihen gef�hrt, aber an jedem hatte sie '
      'etwas auszusetzen. Der eine war ihr zu dick, das Weinfa�! '
      'sprach sie. Der andere zu lang, lang und schwank hat keinen '
      'Gang. Der dritte zu kurz, kurz und dick hat kein Geschick. Der '
      
        'vierte zu bla�, der bleiche Tod! der f�nfte zu rot, der Zinshahn' +
        '! '
      'der sechste war nicht gerad genug, gr�nes Holz, hinterm Ofen '
      'getrocknet! Und sohatte sie an einem jeden etwas auszusetzen, '
      'besonders aber machte sie sich �ber einen guten K�nig lustig, '
      'der ganz oben stand und dem das Kinn ein wenig krumm '
      
        'gewachsen war. Ei, rief sie und lachte, der hat ein Kinn, wie di' +
        'e '
      'Drossel einen Schnabel, und seit der Zeit bekam er den Namen '
      'Drosselbart.')
    TabOrder = 0
  end
  object Memo2: TMemo
    Left = 496
    Top = 40
    Width = 449
    Height = 360
    TabOrder = 1
  end
  object Button1: TButton
    Left = 336
    Top = 420
    Width = 129
    Height = 25
    Caption = 'Kodieren'
    TabOrder = 2
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 808
    Top = 420
    Width = 129
    Height = 25
    Caption = 'Dekodieren'
    TabOrder = 3
    OnClick = Button2Click
  end
end
