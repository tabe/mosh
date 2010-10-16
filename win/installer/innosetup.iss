; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

[Setup]
AppName=Mosh
AppVerName=mosh 0.2.6
AppPublisher=higepon
AppPublisherURL=http://code.google.com/p/mosh-scheme/
AppSupportURL=http://code.google.com/p/mosh-scheme/
AppUpdatesURL=http://code.google.com/p/mosh-scheme/
DefaultDirName={pf}\Mosh
DefaultGroupName=Mosh
AllowNoIcons=yes
LicenseFile=..\..\COPYING
OutputBaseFilename=setup_mosh_0.2.6
Compression=lzma
SolidCompression=yes
SetupIconFile="..\..\misc\logo\mosh.ico"
[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"
Name: "japanese"; MessagesFile: "compiler:Languages\Japanese.isl"

[Tasks]
Name: "quicklaunchicon"; Description: "{cm:CreateQuickLaunchIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Files]
Source: "dist\mosh.exe"; DestDir: "{app}"; DestName: "mosh.exe"; Flags: ignoreversion
;Source: "..\..\Release\nmosh.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\..\lib\*"; DestDir: "{app}\lib"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "..\..\misc\example\*"; DestDir: "{app}\misc\example"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "..\..\doc\html\*"; DestDir: "{app}\doc"; Flags: ignoreversion recursesubdirs createallsubdirs
; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[Icons]
Name: "{group}\mosh"; Filename: "{app}\mosh.exe"
Name: "{group}\manual.html"; Filename: "{app}\doc\index.html"
Name: "{group}\misc\example"; Filename: "{app}\misc\example"
Name: "{userappdata}\Microsoft\Internet Explorer\Quick Launch\mosh"; Filename: "{app}\mosh.exe"; Tasks: quicklaunchicon

[Run]
Filename: "{app}\mosh.exe"; Description: "{cm:LaunchProgram,mosh}"; Flags: nowait postinstall skipifsilent


