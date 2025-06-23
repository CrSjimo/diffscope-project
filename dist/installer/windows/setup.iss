﻿; Windows Application Installer Script
;
; Required Environment Variables:
;   SETUP_APP_NAME
;   SETUP_APP_VERSION
;   SETUP_APP_PUBLISHER
;   SETUP_APP_URL
;   SETUP_APP_COPYRIGHT
;   SETUP_APP_INSTALLED_DIR
;   SETUP_APP_BRIDGE_ARTIFACTS_DIR
;   SETUP_MESSAGE_FILES_DIR
;   SETUP_OUTPUT_DIR
;   SETUP_OUTPUT_FILE_BASE
;   SETUP_INFO_PATH
;
; Command:
;   ISCC.exe setup.iss

#define MyAppName GetEnv("SETUP_APP_NAME")
#define MyAppVersion GetEnv("SETUP_APP_VERSION")
#define MyAppPublisher GetEnv("SETUP_APP_PUBLISHER")
#define MyAppURL GetEnv("SETUP_APP_URL")
#define MyAppCopyright GetEnv("SETUP_APP_COPYRIGHT")

#define MyAppExeName "bin\" + MyAppName + ".exe"

#define MyAppProjectAssocName MyAppName + " Project File"
#define MyAppProjectAssocExt ".dspx"
#define MyAppProjectAssocKey StringChange(MyAppProjectAssocName, " ", "") + MyAppProjectAssocExt

#define MyAppSoundBankAssocName MyAppName + " Sound Bank"
#define MyAppSoundBankAssocExt ".aaa"
#define MyAppSoundBankAssocKey StringChange(MyAppProjectAssocName, " ", "") + MyAppProjectAssocExt

#define MyAppInstalledDir GetEnv("SETUP_APP_INSTALLED_DIR")

#define MyAppBridgeArtefactsDir GetEnv("SETUP_APP_BRIDGE_ARTIFACTS_DIR")

[Setup]
AppId={{E777B852-937C-42A1-930F-C1CD1FF5C07E}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
AppCopyright={#MyAppCopyright}
DefaultDirName={autopf}\OpenVPI\{#MyAppName}
ChangesAssociations=yes
DisableProgramGroupPage=yes
; Uncomment the following line to run in non administrative install mode (install for current user only.)
;PrivilegesRequired=lowest
PrivilegesRequiredOverridesAllowed=dialog
LicenseFile={#MyAppInstalledDir}\share\doc\DiffScope\LICENSE
InfoBeforeFile={#GetEnv("SETUP_INFO_PATH")}
OutputDir={#GetEnv("SETUP_OUTPUT_DIR")}
OutputBaseFilename={#GetEnv("SETUP_OUTPUT_FILE_BASE")}
Compression=lzma
SolidCompression=yes
WizardStyle=modern
ArchitecturesInstallIn64BitMode=x64
VersionInfoDescription={#MyAppName} Installer

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"
Name: "chinesesimplified"; MessagesFile: "{#GetEnv('SETUP_MESSAGE_FILES_DIR')}\ChineseSimplified.isl"
Name: "chinesetraditional"; MessagesFile: "{#GetEnv('SETUP_MESSAGE_FILES_DIR')}\ChineseTraditional.isl"
Name: "japanese"; MessagesFile: "compiler:Languages\Japanese.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Code]
function FullInstallationMessage(Param: String): String;
begin
    Result := SetupMessage(msgFullInstallation);
end;

function CompactInstallationMessage(Param: String): String;
begin
    Result := SetupMessage(msgCompactInstallation);
end;

function CustomInstallationMessage(Param: String): String;
begin
    Result := SetupMessage(msgCustomInstallation);
end;

#include "uninstall.iss"

[Types]
Name: "full"; Description: "{code:FullInstallationMessage}"
Name: "compact"; Description: "{code:CompactInstallationMessage}"
Name: "custom"; Description: "{code:CustomInstallationMessage}"; Flags: iscustom

[Components]
Name: "program"; Description: "{#MyAppName}"; Types: full compact custom; Flags: fixed
Name: "vst"; Description: "{#MyAppName} Bridge (VST3)"; Types: full
Name: "lv2"; Description: "{#MyAppName} Bridge (LV2)"; Types: full

[Files]
Source: "{#MyAppInstalledDir}\*"; DestDir: "{app}"; Components: program; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "{#MyAppBridgeArtefactsDir}\VST3\*.vst3"; DestDir: "{autocf}\VST3"; Components: vst; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "{#MyAppBridgeArtefactsDir}\LV2\*.lv2"; DestDir: "{autocf}\LV2"; Components: lv2; Flags: ignoreversion recursesubdirs createallsubdirs

; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[Registry]
Root: HKA; Subkey: "Software\Classes\{#MyAppProjectAssocExt}\OpenWithProgids"; ValueType: string; ValueName: "{#MyAppProjectAssocKey}"; ValueData: ""; Flags: uninsdeletevalue
Root: HKA; Subkey: "Software\Classes\{#MyAppProjectAssocKey}"; ValueType: string; ValueName: ""; ValueData: "{#MyAppProjectAssocName}"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\{#MyAppProjectAssocKey}\DefaultIcon"; ValueType: string; ValueName: ""; ValueData: "{app}\{#MyAppExeName},1"
Root: HKA; Subkey: "Software\Classes\{#MyAppProjectAssocKey}\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """{app}\{#MyAppExeName}"" ""%1"""
Root: HKA; Subkey: "Software\Classes\Applications\{#MyAppExeName}\SupportedTypes"; ValueType: string; ValueName: "{#MyAppProjectAssocExt}"; ValueData: ""

Root: HKA; Subkey: "Software\Classes\{#MyAppSoundBankAssocExt}\OpenWithProgids"; ValueType: string; ValueName: "{#MyAppSoundBankAssocKey}"; ValueData: ""; Flags: uninsdeletevalue
Root: HKA; Subkey: "Software\Classes\{#MyAppSoundBankAssocKey}"; ValueType: string; ValueName: ""; ValueData: "{#MyAppSoundBankAssocName}"; Flags: uninsdeletekey
Root: HKA; Subkey: "Software\Classes\{#MyAppSoundBankAssocKey}\DefaultIcon"; ValueType: string; ValueName: ""; ValueData: "{app}\{#MyAppExeName},2"
Root: HKA; Subkey: "Software\Classes\{#MyAppSoundBankAssocKey}\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """{app}\{#MyAppExeName}"" ""%1"""
Root: HKA; Subkey: "Software\Classes\Applications\{#MyAppExeName}\SupportedTypes"; ValueType: string; ValueName: "{#MyAppSoundBankAssocExt}"; ValueData: ""

[Icons]
Name: "{autoprograms}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{autodesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon

[Run]
Filename: "{app}\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent

