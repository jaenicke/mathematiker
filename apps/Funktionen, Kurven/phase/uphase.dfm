�
 TFORM1 0�
  TPF0TForm1Form1Left�Top� BorderIconsbiSystemMenu
biMinimize BorderStylebsSingleCaption  Phase plot of complex functionsClientHeight�ClientWidth Color	clBtnFaceFont.CharsetANSI_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameVerdana
Font.Style OldCreateOrder	Position	poDefaultScaledOnCreate
FormCreate	OnDestroyFormDestroyOnShowFormShowPixelsPerInch`
TextHeight 	TPaintBox	PaintBox1Left Top Width Height AlignalClient	PopupMenu
PopupMenu1OnMouseMovePaintBox1MouseMoveOnPaintPaintBox1Paint  TPanelPanel1Left Top Width Height� AlignalBottom
BevelInnerbvRaised
BevelOuter	bvLoweredColor��� TabOrder  TLabelLabel1LeftTopWidth&HeightCaptionf(z) =  TLabelL64LeftTop0Width� HeightCaptionRange for z = x + iyFont.CharsetANSI_CHARSET
Font.ColorclNavyFont.Height�	Font.NameVerdana
Font.StylefsBold 
ParentFont  TLabelL95Left� Top0Width)HeightCaptionx from  TLabelL94Left(Top0WidthHeightCaptionto  TLabelL96Left� TopHWidth*HeightCaptiony from  TLabelL93Left(TopHWidthHeightCaptionto  TLabelLabel2LeftTopIWidth� HeightAutoSize  TButtonBT_PlotLeft�Top-Width`Height CaptionPlotDefault	TabOrder OnClickBT_PlotClick  TEditedit1Left� Top,WidthAHeightCharCaseecUpperCaseTabOrderText-3  TEditEdit2LeftHTop,WidthAHeightCharCaseecUpperCaseTabOrderText3  TEditEdit3Left� TopDWidthAHeightCharCaseecUpperCaseTabOrderText-3  TEditEdit4LeftHTopDWidthAHeightCharCaseecUpperCaseTabOrderText3  	TCheckBoxCB_FastLeftTopbWidthEHeightCaptionFastTabOrder  TButtonBt_HelpLeft�TopTWidth`Height CaptionHelpTabOrderOnClickBt_HelpClick  	TComboBox	FuncComboLeft<TopWidth�HeightDropDownCount
ItemHeightTabOrderText(z-1)/(z^2+z+1)Items.Strings(z-1)/(z^2+z+1)100/(z^3+1)!(z^2-1) * (z-2-i)^2 / (z^2+2+2*i)
lngamma(z)	sech(z^2)5*sin(z*Pi/2)*erf(z)psi(0.2*z^4)*erfc(-i*z)cn(z^2,0.5)abs(psi(z))   TPanelRBPanelLeftDTopdWidthDHeight
BevelInner	bvLowered
BevelOuterbvNoneColor��� TabOrder TRadioButtonRB_StandardLeft	TopWidth<HeightCaptionBasicTabOrder   TRadioButton	RB_WegertLeft� TopWidth\HeightCaption	Wegert 20TabOrder  TRadioButtonRB_RocchiniLeftLTopWidthPHeightCaptionRocchiniChecked	TabOrderTabStop	  TRadioButtonRB_W10LeftTopWidth<HeightCaptionW 10TabOrder    
TPopupMenu
PopupMenu1Left� Top  	TMenuItemcopytoclipboardCaptioncopy to clipboardOnClickcopytoclipboardClick    