object Fjosephus: TFjosephus
  Left = 275
  Top = 40
  HelpContext = 22001
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Josephus-Problem'
  ClientHeight = 722
  ClientWidth = 1103
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clBlack
  Font.Height = -12
  Font.Name = 'Verdana'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  OnShow = Formshow
  PixelsPerInch = 96
  TextHeight = 14
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 1103
    Height = 722
    Align = alClient
    BevelOuter = bvNone
    Color = clWhite
    TabOrder = 0
    object Panel3: TPanel
      Left = 0
      Top = 0
      Width = 1103
      Height = 722
      Align = alClient
      BevelOuter = bvNone
      Color = clWhite
      TabOrder = 0
      object josephus: TPanel
        Left = 0
        Top = 0
        Width = 1103
        Height = 722
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        object Panel4: TPanel
          Left = 0
          Top = 0
          Width = 350
          Height = 722
          Align = alLeft
          Color = clWhite
          TabOrder = 0
          object Panel7: TPanel
            Left = 1
            Top = 81
            Width = 12
            Height = 640
            Align = alLeft
            BevelOuter = bvNone
            Color = clWhite
            TabOrder = 0
          end
          object Liste: TListBox
            Left = 13
            Top = 81
            Width = 336
            Height = 640
            Align = alClient
            BorderStyle = bsNone
            ItemHeight = 14
            TabOrder = 1
            TabWidth = 50
          end
          object Panel1: TPanel
            Left = 1
            Top = 1
            Width = 348
            Height = 80
            Align = alTop
            BevelOuter = bvNone
            Color = 15790320
            TabOrder = 2
            object Label2: TLabel
              Left = 16
              Top = 20
              Width = 86
              Height = 14
              Caption = 'Personenzahl'
            end
            object Label3: TLabel
              Left = 16
              Top = 52
              Width = 77
              Height = 14
              Caption = 'Abz'#228'hlweite'
            end
            object Label1: TLabel
              Left = 214
              Top = 52
              Width = 25
              Height = 14
              Caption = '0 %'
            end
            object Button1: TButton
              Left = 184
              Top = 16
              Width = 97
              Height = 25
              Caption = 'Berechnung'
              TabOrder = 2
              OnClick = Button1Click
            end
            object Edit1: TEdit
              Left = 112
              Top = 16
              Width = 60
              Height = 22
              TabOrder = 0
              Text = '100'
            end
            object Edit2: TEdit
              Left = 112
              Top = 48
              Width = 60
              Height = 22
              TabOrder = 1
              Text = '3'
            end
          end
        end
        object Panel6: TPanel
          Left = 350
          Top = 0
          Width = 753
          Height = 722
          Align = alClient
          Color = clWhite
          TabOrder = 1
          object Paintbox: TPaintBox
            Left = 1
            Top = 81
            Width = 615
            Height = 640
            Align = alClient
            OnMouseDown = I12MD
            OnPaint = Rx1C
          end
          object Memo1: TMemo
            Left = 616
            Top = 81
            Width = 136
            Height = 640
            Align = alRight
            BorderStyle = bsNone
            Color = clWhite
            ScrollBars = ssVertical
            TabOrder = 0
          end
          object Panel5: TPanel
            Left = 1
            Top = 1
            Width = 751
            Height = 80
            Align = alTop
            BevelOuter = bvNone
            Color = 15790320
            TabOrder = 1
            object Label4: TLabel
              Left = 16
              Top = 20
              Width = 86
              Height = 14
              Caption = 'Personenzahl'
            end
            object Label5: TLabel
              Left = 16
              Top = 52
              Width = 77
              Height = 14
              Caption = 'Abz'#228'hlweite'
            end
            object Label6: TLabel
              Left = 184
              Top = 48
              Width = 360
              Height = 41
              AutoSize = False
              Caption = 'Zum Start des Auswahlprozesses eine Person anklicken'
              WordWrap = True
            end
            object pic1: TImage
              Left = 360
              Top = 16
              Width = 28
              Height = 29
              AutoSize = True
              Picture.Data = {
                07544269746D617062070000424D620700000000000036040000280000001C00
                00001D00000001000800000000002C030000130B0000130B0000000100000001
                000000000000000080000080000000808000800000008000800080800000C0C0
                C000C0DCC000F0CAA600C6AD9C008C8C8C00AD9C8C00B59C8C0000529400948C
                9400B5A59400BDA59400005A9C0000639C00C6AD9C00C6B59C000063A500527B
                A500CEBDA500D6BDA5000063AD00949CAD00D6BDAD00D6C6AD00DEC6AD001863
                B500086BB500216BB500296BB500087BB500DEC6B500DECEB500E7CEB500006B
                BD002973BD00007BBD00087BBD000084BD00EFD6BD00005AC6000084C600008C
                C600F7D6C600F7DEC600FFDEC6000873CE003984CE004284CE00398CCE006394
                CE00639CCE0084ADCE00C6C6CE00C6CECE00D6CECE00C6D6CE00D6D6CE00DEDE
                CE00EFDECE00F7DECE00F7E7CE00FFE7CE00007BD6001084D6001884D600089C
                D600399CD60008A5D60039A5D60063ADD6006BB5D60084B5D60084BDD60084C6
                D600C6CED600C6D6D600218CDE000094DE000894DE001894DE002194DE0031A5
                DE0039A5DE0039ADDE0042ADDE0063B5DE00009CE700189CE700299CE70000A5
                E70039A5E70000ADE70010ADE70000B5E70000B5EF0018B5EF0021B5EF0039B5
                EF0042B5EF0000BDEF0010BDEF004ABDEF0031C6EF0039C6EF004AC6EF0052C6
                EF0000BDF70008BDF70010BDF70021BDF70000C6F70008C6F70010C6F70018C6
                F70021C6F70029C6F70031C6F70000CEF70008CEF70010CEF70029CEF70031CE
                F70039CEF70042CEF7004ACEF70052CEF7005ACEF70063CEF70000D6F70010D6
                F7004AD6F70052D6F7005AD6F70063D6F7006BE7F70000D6FF0018D6FF0000DE
                FF0008DEFF0010DEFF0018DEFF0021DEFF0031DEFF0000E7FF0008E7FF0010E7
                FF0021E7FF0029E7FF0042E7FF0073E7FF007BE7FF0039EFFF0042EFFF0052EF
                FF005AEFFF0063EFFF0073EFFF007BEFFF0084EFFF0084F7FF008CF7FF009CF7
                FF00A5F7FF00ADF7FF00B5F7FF00B5FFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F0FBFF00A4A0
                A000808080000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFF
                FF00ACACACACACACACACACACACACACACACACACACACACACACACACACACACACACAC
                4331312C241E1C191818181818181818181C1D24262C313243ACACAC3231261D
                15110C0F1722212D2D2122170B0C100A18242C3143ACACAC43312C261C1B2833
                5E686B84846B685E33281B19242C313143ACACACACACAC413745678385858483
                838485858367453741ACACACACACACACACAC4035568183827A736A71716A737A
                828381563540ACACACACACACAC31345D6D81786A6A8184848483816A6A78816D
                553431ACACACACACAC37547A7A776A828560524646526085836A777A7A5437AC
                ACACACAC3A44777A727785561A120E13130E121A568577727A77443AACACACAC
                365F7876766F20132F6169696969612F13206F7776785F36ACACAC3C44757775
                6E162F697070707070707070692B166E757775443CACAC395C76757F23617474
                7474747474747474747461237E75765339ACAC36647674476374747474747474
                74747474747474614974766436ACAC45747D7463747474747474747474747474
                7474747463747D7445ACAC447B7D7B7B7B7B7B9B9B7B7B7B7B7B7B9B9B7B7B7B
                7B7B7D7B44ACAC447B7D7B7B7B7B7B29297B7B7B7B7B7B29297B7B7B7B7B7D7B
                44ACAC457B8E7B7B7B7B7B29297B7B7B7B7B7B29297B7B7B7B7B8E7B45ACAC48
                698E86868686862929868686868686292986868686868E6948ACAC4D61938786
                8686862E2E8686868686862E2E868686868793614DACAC3E538794868686862E
                2E8686868686862E2E868686869487533EACACAC48699A939086860E0E868686
                8686860E0E868690939A6948ACACACAC3B5F949F93908F8F8F8F8F8F8F8F8F8F
                8F8F90939F945C3BACACACACAC4B65A0A199908F8F8F8F8F8F8F8F8F8F9099A1
                A0654BACACACACACAC404A6CA2A39A92908F8F8F8F8F8F90929AA3A26C4A41AC
                ACACACACACAC405A6DA4A7A6A19A989797989AA1A6A7A46D5A40ACACACACACAC
                ACACAC424B668CA8AAAAA9A8A8A9AAAAA88C664C42ACACACACACACACACACACAC
                AC3B5862829CA4A8A8A49C8262583BACACACACACACACACACACACACACACACAC3F
                4E5A575353575A4E3FACACACACACACACACACACACACACACACACACACACACACACAC
                ACACACACACACACACACACACACACAC}
              Visible = False
            end
            object pic2: TImage
              Left = 400
              Top = 8
              Width = 28
              Height = 29
              AutoSize = True
              Picture.Data = {
                07544269746D617062070000424D620700000000000036040000280000001C00
                00001D00000001000800000000002C030000130B0000130B0000000100000001
                0000FFFFFF0042B5520042AD4A004ABD52004ABD5A0063C66B0052BD5A0084CE
                8C0042A54A00398C42007BCE8400D6EFD6009CDEA500BDE7C6005ABD630073CE
                7B006BC67300399C4200B5E7B500A5DEAD00317B39008CD69400399C4A002973
                310031843900DEF7DE00BDE7BD00CEEFCE0039944200ADDEB500A5DEA5000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                190B0B0D121D131E0C0C0C0C0C0C0C0C0C1313121A0D0B0B190000000B0B1A13
                15070F0501161109091116010E0F0A150C120D0B19000000190B0D1A130A0811
                06100F07070F100611080A1E120D0B0B190000000000000B1008050A0707070A
                0A0707070A0508100B0000000000000000000B06010F0A0A050E030303030E05
                0A0A0F01060B000000000000000B0406050F0E030202020202020202030E0F05
                06040B00000000000010080F0F06030202020202020202020203060A10081000
                00000000121106080F06020202020202020202020202060F0106111200000000
                04080E04090A1003020202020202020203050A09040E08040000000D11030603
                08140E07100401010101040507051408030603110D000007080403010108141C
                05070C07070C07051C170801010304160700000402040101010102181718091C
                1C09181714020101010104020400000801040101010101010809141414140908
                0101010101010401080000110104010101010101010101010101010101010101
                0101040111000011010401010101010C0C0101010101010C0C01010101010401
                11000008010E01010101011818010101010101181801010101010E0108000006
                020E01010101010909010101010101090901010101010E020600000708050401
                01010109090101010101010909010101010405080700000D1604100101010109
                090101010101010909010101011004160D00000006020A050401010909010101
                0101010909010104050A02060000000012081007050403171703030303030317
                170304050710081200000000000F040715050403030303030303030303040515
                07040F0000000000000B06050C0C0A0E04030303030303040E0A0C0C05060B00
                0000000000000B0505131A1D150A050606050A151D1A1305050B000000000000
                0000000B0F06150D1B1B0D0D0D0D1B1B0D15060A0B0000000000000000000000
                00120E010A0C130D0D130C0A010E12000000000000000000000000000000000D
                07050616160605070D0000000000000000000000000000000000000000000000
                0000000000000000000000000000}
              Visible = False
            end
            object pic3: TImage
              Left = 432
              Top = 24
              Width = 28
              Height = 29
              AutoSize = True
              Picture.Data = {
                07544269746D617062070000424D620700000000000036040000280000001C00
                00001D00000001000800000000002C030000130B0000130B0000000100000001
                0000FFFFFF0000F7FF0000E7FF0000DEFF0000CEFF00FFFFE700FFFFDE000084
                CE0010CEFF0031DEFF00E7CEB50018DEFF000084F70021FFFF0063E7FF0052E7
                FF00008CDE0008FFFF0000BDFF005AE7FF0010DEFF00B5FFFF0073FFFF0042FF
                FF0010E7FF0042E7FF0008DEFF00108CF70018F7FF0000529C00009CFF00FFF7
                CE004AE7FF0000C6FF008CFFFF0084FFFF00219CFF0039B5F700DEE7E700F7F7
                E70039A5F70021DEFF0039DEFF0010F7FF0031FFFF0042BDFF0063FFFF000063
                A5003994E700C6FFFF00639CE700FFDEC60000B5FF0063BDF700F7CEBD000094
                DE00F7DEBD00FFE7C6004ACEFF0021C6FF0018C6FF0039C6FF0042C6FF00005A
                DE0008CEFF0021CEFF005AFFFF0010FFFF00216BC6009C949C000063B500086B
                C600BDA5940052DEFF00BDFFFF00005AA50052FFFF004ADEFF002973CE0029FF
                FF00428CE700A5FFFF00188CF7000873E700398CE70094FFFF00F7E7E700DEDE
                E7008CBDE700F7CEB5000063BD009CA5BD008CC6F70039B5FF0031B5FF0029A5
                FF00296BC60010BDFF005284B5000884C6002194FF008CCEF7006BFFFF0000A5
                FF00089CFF00DEC6A50018A5FF00DEBDA500C6B59C00CEB59C0008A5F700008C
                CE0008B5F700189CFF006BC6F70029E7FF0031E7FF0000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0506061F333836590A0A0A0A0A0A0A0A0A363833391F06060500000006063938
                696D48456260443F3F44606245486C6B0A331F060500000005061F39365B4E53
                5F3E3A13133A3E5F534E5B59331F06060500000000000005321B3D0F0E0E130F
                0F130E0E0F3D1B3205000000000000000000055024190F200941084040084109
                200F192450050000000000000006546A2A19290808191313130F19080829192A
                715406000000000000326809090B08200E5D645252645D0E0F080B0909683200
                00000000570C0B09080B0E245A4B1D2F2F1D4B5A240E0B08090B0C5700000000
                303429141449472F37120404040412372F47490B14293430000000560C1A0B1A
                4D4637040404040404040404046F464D1A0B1A0C5600005867141A7463120303
                030303030303030303031263731A141E580000302114036E2103030303030303
                0303030303030312700314213000001B03180321030303030303030303030303
                03030303210318031B00000C0218020202020216160202020202021616020202
                020218020C00000C021802020202020707020202020202070702020202021802
                0C00001B021C02020202020707020202020202070702020202021C021B000028
                041C01010101010707010101010101070701010101011C042800005C120D2B01
                01010110100101010101011010010101012B0D125C0000271E2B2C0101010110
                100101010101011010010101012C2B1E270000002804170D1101011D1D010101
                0101011D1D0101110D1704280000000026342C4C0D1101010101010101010101
                0101110D4C2C67260000000000353C422E4F1101010101010101010101114F2E
                423C350000000000000525091623171C11010101010101111C17231609250500
                000000000000052D2A2251552E170D43430D172E5551222A2D05000000000000
                00000005353B661531314A15154A313115663B72050000000000000000000000
                0026256120232215152223206125260000000000000000000000000000000027
                652D5E1E1E5E2D65270000000000000000000000000000000000000000000000
                0000000000000000000000000000}
              Visible = False
            end
            object pic4: TImage
              Left = 480
              Top = 40
              Width = 28
              Height = 29
              AutoSize = True
              Picture.Data = {
                07544269746D617062070000424D620700000000000036040000280000001C00
                00001D00000001000800000000002C030000130B0000130B0000000100000001
                000000000000000080000080000000808000800000008000800080800000C0C0
                C000C0DCC000F0CAA6000063A5008C8C8C00AD9C8C00B59C8C00948C9400B5A5
                9400BDA59400005A9C00C6AD9C00C6B59C000063A500006BA500527BA500CEBD
                A500D6BDA5000073AD00949CAD00D6BDAD00D6C6AD00DEC6AD000063B5001863
                B500216BB500296BB5000873B500007BB500DEC6B500DECEB500E7CEB500006B
                BD002973BD00007BBD00EFD6BD00005AC6000873C600087BC6000084C600008C
                C600F7D6C600F7DEC600FFDEC6000873CE00087BCE003984CE004284CE00398C
                CE006394CE00189CCE00639CCE0084ADCE00C6C6CE00C6CECE00D6CECE00C6D6
                CE00D6D6CE00DEDECE00EFDECE00F7DECE00F7E7CE00FFE7CE00007BD6001084
                D600399CD60021A5D60039A5D60063ADD6006BB5D60084B5D60084BDD60084C6
                D600C6CED600C6D6D6000094DE000894DE001894DE0031A5DE0039A5DE0039AD
                DE0042ADDE0063B5DE00009CE700299CE70000A5E70029A5E70000ADE70010AD
                E70039ADE70000B5E70042B5E70000B5EF0018B5EF0021B5EF0039B5EF0042B5
                EF0000BDEF0010BDEF0042BDEF004ABDEF0031C6EF0039C6EF004AC6EF0052C6
                EF0000BDF70008BDF70010BDF70021BDF70000C6F70008C6F70010C6F70018C6
                F70021C6F70031C6F70000CEF70008CEF70010CEF70031CEF70039CEF70042CE
                F7004ACEF70052CEF7005ACEF70063CEF70000D6F70010D6F7004AD6F7005AD6
                F70063D6F7006BE7F70000D6FF0018D6FF0000DEFF0008DEFF0010DEFF0018DE
                FF0021DEFF0031DEFF0063DEFF0073DEFF0000E7FF0008E7FF0010E7FF0021E7
                FF0029E7FF0042E7FF0073E7FF007BE7FF0039EFFF0042EFFF0052EFFF005AEF
                FF0063EFFF0073EFFF007BEFFF0084EFFF0084F7FF008CF7FF009CF7FF00A5F7
                FF00ADF7FF00B5F7FF00B5FFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F0FBFF00A4A0
                A000808080000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFF
                FF00ABABABABABABABABABABABABABABABABABABABABABABABABABABABABABAB
                4531312A241D1B181717171717171717171B1C24262A313245ABABAB3231261C
                13100C0E1621202B2B2021160B0C0F1217242A3145ABABAB45312A261B1A2833
                5B676B82826B675B33281A18242A313145ABABABABABAB433847608183838281
                818283838160473843ABABABABABABABABAB4236547F81807973697171697379
                80817F543642ABABABABABABAB31355D6D7F7869636363636363636369787F6D
                5D3531ABABABABABAB38536B7F7771686868686868686868687177806A5338AB
                ABABABAB3C4677396E77686868686868686868686868776B4977463CABABABAB
                375C7876226F7E716868686868686868717D6F2276785C37ABABAB3E46757775
                610A57887E7670707070767D88600A5E757775463EABAB3B5A76757474610A2C
                60839388889383622D115E74747576523BABAB376376747474746823111E272D
                2D271E11196874747474766337ABAB47747C747474747474612F191515192F61
                7474747474747C7447ABAB467A7C7A7A7A7A7A7A7A7A7A7A7A7A7A7A7A7A7A7A
                7A7A7C7A46ABAB467A7C7A7A7A7A7A9A9A7A7A7A7A7A7A9A9A7A7A7A7A7A7C7A
                46ABAB477A8B7A7A7A7A7A23237A7A7A7A7A7A23237A7A7A7A7A8B7A47ABAB48
                688B84848484842929848484848484292984848484848B6848ABAB4D5E908584
                848484292984848484848429298484848485905E4DABAB40528591848484842E
                2E8484848484842E2E8484848491855240ABABAB486899908D84842E2E848484
                8484842E2E84848D90996848ABABABAB3D5C919E908D8C11118C8C8C8C8C8C11
                118C8D909E915A3DABABABABAB4B649FA0988D8C8C8C8C8C8C8C8C8C8C8D98A0
                9F644BABABABABABAB424A6CA1A2998F8D8C8C8C8C8C8C8D8F99A2A16C4A43AB
                ABABABABABAB42586DA3A6A5A0999796969799A0A5A6A36D5842ABABABABABAB
                ABABAB444B6589A7A9A9A8A7A7A8A9A9A789654C44ABABABABABABABABABABAB
                AB3D565F809BA3A7A7A39B805F563DABABABABABABABABABABABABABABABAB41
                4E5855525255584E41ABABABABABABABABABABABABABABABABABABABABABABAB
                ABABABABABABABABABABABABABAB}
              Visible = False
            end
            object Button2: TButton
              Left = 184
              Top = 16
              Width = 129
              Height = 25
              Caption = 'Zur'#252'cksetzen'
              TabOrder = 0
              OnClick = D8C
            end
            object SpinEdit1: TSpinEdit
              Left = 112
              Top = 16
              Width = 57
              Height = 23
              MaxValue = 50
              MinValue = 1
              TabOrder = 1
              Value = 41
            end
            object SpinEdit2: TSpinEdit
              Left = 112
              Top = 48
              Width = 57
              Height = 23
              MaxValue = 50
              MinValue = 2
              TabOrder = 2
              Value = 3
            end
          end
        end
      end
    end
  end
end
