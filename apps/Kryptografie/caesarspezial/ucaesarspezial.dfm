object Form1: TForm1
  Left = 304
  Top = 217
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Spezielle Cäsar-Kodierung'
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
      'Ein König hatte eine Tochter, die war über alle Maßen schön, '
      
        'aber dabei so stolz und übermütig, daß ihr kein Freier gut genug' +
        ' '
      'war. Sie wies einen nach dem andern ab, und trieb noch dazu '
      
        'Spott mit ihnen. Einmal ließ der König ein großes Fest anstellen' +
        ', '
      'und ladete dazu aus der Nähe und Ferne die heiratslustigen '
      'Männer ein. Sie wurden alle in eine Reihe nach Rang und Stand '
      'geordnet; erst kamen die Könige, dann die Herzöge, die Fürsten, '
      'Grafen und Freiherrn, zuletzt die Edelleute. Nun ward die '
      'Königstochter durch die Reihen geführt, aber an jedem hatte sie '
      'etwas auszusetzen. Der eine war ihr zu dick, das Weinfaß! '
      'sprach sie. Der andere zu lang, lang und schwank hat keinen '
      'Gang. Der dritte zu kurz, kurz und dick hat kein Geschick. Der '
      
        'vierte zu blaß, der bleiche Tod! der fünfte zu rot, der Zinshahn' +
        '! '
      'der sechste war nicht gerad genug, grünes Holz, hinterm Ofen '
      'getrocknet! Und sohatte sie an einem jeden etwas auszusetzen, '
      'besonders aber machte sie sich über einen guten König lustig, '
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
