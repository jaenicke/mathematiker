unit ShellFolders;

interface

uses
  Windows;

const
  {$EXTERNALSYM CSIDL_DESKTOP}
  CSIDL_DESKTOP                       = $0000;
  {$EXTERNALSYM CSIDL_INTERNET}
  CSIDL_INTERNET                      = $0001;
  {$EXTERNALSYM CSIDL_PROGRAMS}
  CSIDL_PROGRAMS                      = $0002;
  {$EXTERNALSYM CSIDL_CONTROLS}
  CSIDL_CONTROLS                      = $0003;
  {$EXTERNALSYM CSIDL_PRINTERS}
  CSIDL_PRINTERS                      = $0004;
  {$EXTERNALSYM CSIDL_PERSONAL}
  CSIDL_PERSONAL                      = $0005;
  {$EXTERNALSYM CSIDL_FAVORITES}
  CSIDL_FAVORITES                     = $0006;
  {$EXTERNALSYM CSIDL_STARTUP}
  CSIDL_STARTUP                       = $0007;
  {$EXTERNALSYM CSIDL_RECENT}
  CSIDL_RECENT                        = $0008;
  {$EXTERNALSYM CSIDL_SENDTO}
  CSIDL_SENDTO                        = $0009;
  {$EXTERNALSYM CSIDL_BITBUCKET}
  CSIDL_BITBUCKET                     = $000a;
  {$EXTERNALSYM CSIDL_STARTMENU}
  CSIDL_STARTMENU                     = $000b;
  {$EXTERNALSYM CSIDL_DESKTOPDIRECTORY}
  CSIDL_DESKTOPDIRECTORY              = $0010;
  {$EXTERNALSYM CSIDL_DRIVES}
  CSIDL_DRIVES                        = $0011;
  {$EXTERNALSYM CSIDL_NETWORK}
  CSIDL_NETWORK                       = $0012;
  {$EXTERNALSYM CSIDL_NETHOOD}
  CSIDL_NETHOOD                       = $0013;
  {$EXTERNALSYM CSIDL_FONTS}
  CSIDL_FONTS                         = $0014;
  {$EXTERNALSYM CSIDL_TEMPLATES}
  CSIDL_TEMPLATES                     = $0015;
  {$EXTERNALSYM CSIDL_COMMON_STARTMENU}
  CSIDL_COMMON_STARTMENU              = $0016;
  {$EXTERNALSYM CSIDL_COMMON_PROGRAMS}
  CSIDL_COMMON_PROGRAMS               = $0017;
  {$EXTERNALSYM CSIDL_COMMON_STARTUP}
  CSIDL_COMMON_STARTUP                = $0018;
  {$EXTERNALSYM CSIDL_COMMON_DESKTOPDIRECTORY}
  CSIDL_COMMON_DESKTOPDIRECTORY       = $0019;
  {$EXTERNALSYM CSIDL_APPDATA}
  CSIDL_APPDATA                       = $001a;
  {$EXTERNALSYM CSIDL_PRINTHOOD}
  CSIDL_PRINTHOOD                     = $001b;
  {$EXTERNALSYM CSIDL_ALTSTARTUP}
  CSIDL_ALTSTARTUP                    = $001d;
  {$EXTERNALSYM CSIDL_COMMON_ALTSTARTUP}
  CSIDL_COMMON_ALTSTARTUP             = $001e;
  {$EXTERNALSYM CSIDL_COMMON_FAVORITES}
  CSIDL_COMMON_FAVORITES              = $001f;
  {$EXTERNALSYM CSIDL_INTERNET_CACHE}
  CSIDL_INTERNET_CACHE                = $0020;
  {$EXTERNALSYM CSIDL_COOKIES}
  CSIDL_COOKIES                       = $0021;
  {$EXTERNALSYM CSIDL_HISTORY}
  CSIDL_HISTORY                       = $0022;

function SHGetFolderPath(hwndOwner: HWND; nFolder: Integer; hToken: THandle; dwFlags: DWORD; pszPath: PChar): HRESULT; stdcall;
{$EXTERNALSYM SHGetFolderPath}
function SHGetFolderPathA(hwndOwner: HWND; nFolder: Integer; hToken: THandle; dwFlags: DWORD; pszPath: PAnsiChar):HRESULT; stdcall;
{$EXTERNALSYM SHGetFolderPathA}
function SHGetFolderPathW(hwndOwner: HWND; nFolder: Integer; hToken: THandle; dwFlags: DWORD; pszPath: PWideChar):HRESULT; stdcall;
{$EXTERNALSYM SHGetFolderPathW}

function GetShellFolder(FolderID: Integer): String;

implementation

uses
  SysUtils, Forms;

function SHGetFolderPath;  external 'shell32.dll' name 'SHGetFolderPathA'
function SHGetFolderPathA; external 'shell32.dll' name 'SHGetFolderPathA'
function SHGetFolderPathW; external 'shell32.dll' name 'SHGetFolderPathW'

function GetShellFolder(FolderID: Integer): String;
begin
  SetLength(Result, MAX_PATH);
  SHGetFolderPath(Application.Handle, FolderID, 0, 0, PChar(Result));
  SetLength(Result, StrLen(PChar(Result)));
end;

end.
