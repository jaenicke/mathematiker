unit glex;

interface
uses Windows, dialogs, sysutils, forms, graphics, gl, glu;

type Tvec3f=array[0..2] of GLfloat;
     pTvec3f=^Tvec3f;
     Tvec4f=array[0..3] of GLfloat;
     pTvec4f=^Tvec4f;

     TColorRGB = packed record
               r, g, b	: BYTE;
               end;
     PColorRGB = ^TColorRGB;

     TRGBList = packed array[0..0] of TColorRGB;
     PRGBList = ^TRGBList;

const use_frustum = true;
      fovX = 90.0;

var   dc: HDC;
      HRC: HGLRC;
      texID: integer;

procedure ResizeViewport(width,height:longint);
Procedure InitRC(hnd:tHandle);
Procedure ReleaseRC(hnd:thandle);
Procedure InitGL(width,height:longint);

implementation

function tan(x:extended):extended;
begin
result:=sin(x)/cos(x);
end;

Procedure SetDCPixelFormat;
var
  nPixelFormat: Integer;
  pfd: TPixelFormatDescriptor;
begin
  FillChar(pfd, SizeOf(pfd),0);
  with pfd do begin
    nSize     := sizeof(pfd);                               // Size of this structure
    nVersion  := 1;                                         // Version number
    dwFlags   := PFD_DRAW_TO_window or
                 PFD_SUPPORT_OPENGL or
                 PFD_DOUBLEBUFFER;                          // Flags
    iPixelType:= PFD_TYPE_RGBA;                             // RGBA pixel values
    cColorBits:= 32;                                        // 24-bit color
    cDepthBits:= 32;                                        // 32-bit depth buffer
    iLayerType:= PFD_MAIN_PLANE;                            // Layer type
  end;
  nPixelFormat := ChoosePixelFormat(DC, @pfd);
  SetPixelFormat(DC, nPixelFormat, @pfd);
  DescribePixelFormat(DC, nPixelFormat, sizeof(TPixelFormatDescriptor), pfd);
end;

procedure ResizeViewport(width,height:longint);
var znear, zfar, aspect: double;
    left, right, bottom, top: double;

begin
znear := 0.1;
zfar  := 150.0;//150.0;
glViewport(0, 0, width, height);
aspect := width/height;

glMatrixMode(GL_PROJECTION);
glLoadIdentity();

if USE_FRUSTUM then
 begin
 right := znear * tan(fovX/3.0 * PI/180.0);
 top := right / aspect;
 bottom := -top;
 left := -right;
 glFrustum(left, right, bottom, top, znear, zfar);
 end
else
 gluPerspective(fovX/aspect, aspect, znear, zfar);
glMatrixMode(GL_MODELVIEW);
end;

Procedure InitRC(hnd:tHandle);
begin
DC := GetDC(hnd);
SetDCPixelFormat;
HRC := wglCreateContext(DC);
wglMakeCurrent(DC, HRC);
end;

Procedure ReleaseRC(hnd:thandle);
begin
wglMakeCurrent(0, 0);
wglDeleteContext(HRC);
ReleaseDC(hnd, DC);
end;

Procedure InitGL(width,height:longint);
begin
glClearColor(0.0, 0.0, 0.0, 0.0);
glClearDepth(1.0);
glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);
glShadeModel(GL_smooth);
glFrontFace(GL_CCW);
glPixelStorei(GL_UNPACK_ALIGNMENT, 1);
gldisable(GL_BLEND);
glEnable(GL_DEPTH_TEST);
glDepthFunc(GL_LESS);

glHint(GL_PERSPECTIVE_CORRECTION_HINT, GL_NICEST);
ResizeViewport(width, height);
end;

end.
