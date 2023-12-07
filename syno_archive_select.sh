#!/usr/bin/env bash
#------------------------------------------------------------------------------
# Forked from https://github.com/stopforumspam/download-synology-dsm
#------------------------------------------------------------------------------
# https://github.com/007revad/Download_Synology_Archive
#
# Checked with https://shellcheck.net/
#
# Script to select arguments for syno_archive_clone.php
#------------------------------------------------------------------------------

php_script="/volume1/scripts/syno_archive_clone.php"
php_log="/volume1/downloads/archive.synology.com/clone_$(date '+%Y%m%d-%H%M').log"


echo -e "Synology Archive Clone \n"

PS3="Choose download type: "
select srcdir in "Os" "Package" "Utility" "Mobile" "ChromeApp" "ToolChain" "Firmware"; do
    case "$srcdir" in
        Os)
            typelist=( "All" "BSM" "DSM" "DSMUC" "SRM" "VS600HD" "VSF" "VSM" )
            break ;;
        Package)
            typelist=( "All" "AcronisTrueImage" "ActiveBackup" "ActiveBackup-GSuite" )
            typelist+=( "ActiveBackup-Office365" "ActiveDirectoryServer" "ActiveInsight" )
            typelist+=( "AntiVirus" "Apache2.2" "Apache2.4" "ArchiwareP5" "ArchiwarePure" )
            typelist+=( "AudioStation" "BackupRestoreManager" "BitDefenderForMailPlus" )
            typelist+=( "C2IdentityLDAPAgent" "Calendar" "CardDAVServer" "Chat" "CloudStation" )
            typelist+=( "CloudStationClient" "CloudSync" "CMS" "CodecPack" "Contacts" )
            typelist+=( "ContainerManager" "DdbBackup" "DhcpServer" "DHCPServer" )
            typelist+=( "DiagnosisTool" "DiagnosisTool-Eng" "DirectoryServer" )
            typelist+=( "DirectoryServerForWindowsDomain" "DNSServer" "Docker" "Docker-GitLab" )
            typelist+=( "Docker-LXQt" "Docker-Redmine" "DocumentViewer" "DokuWiki" "domotz" )
            typelist+=( "DownloadStation" "DVBLinkServer" "elephantdrive" "EmbyServer" )
            typelist+=( "Exchange-Migrate" "exFAT-Free" "EynioServer" "FileStation" )
            typelist+=( "geoip-database-city" "geoip-database-country" "Git" "GlacierBackup" )
            typelist+=( "GLPI" "GoodSync" "GoodSync Server" "GWS-Migrate" "HAManager" )
            typelist+=( "HighAvailability" "HybridShare" "HyperBackup" "HyperBackup-ED" )
            typelist+=( "HyperBackupVault" "IDrive" "iTunesServer" "Java8" "jdboxPackage" )
            typelist+=( "Joomla" "KodExplorer" "LogCenter" "MailClient" "MailPlus-Server" )
            typelist+=( "MailServer" "MailStation" "MariaDB" "MariaDB10" "MediaServer" )
            typelist+=( "MediaWiki" "MEGAcmd" "MigrationAssistant" "MinimServer" "Moodle" )
            typelist+=( "NBR" "NBR-Transporter" "nConnect" "Node.js_v12" "Node.js_v14" )
            typelist+=( "Node.js_v16" "Node.js_v18" "Node.js_v8" "NoteStation" )
            typelist+=( "NVIDIARuntimeLibrary" "OAuthService" "OrangeHRM" "osTicket" "PACS" )
            typelist+=( "PDFViewer" "Perl" "PetaSpace" "Phddns" "PhotoStation" "PHP5.6" "PHP7.0" )
            typelist+=( "PHP7.2" "PHP7.3" "PHP7.4" "PHP8.0" "PHP8.1" "PHP8.2" "phpMyAdmin" )
            typelist+=( "Plex Media Server" "PlexMediaServer" "PrestoServer" "ProxyServer" "py3k" )
            typelist+=( "Python" "Python2" "Python3.9" "PythonModule" "QuickConnect" "QuikFynd" )
            typelist+=( "RadiusServer" "RagicBuilder" "ReplicationService" "resiliosync" )
            typelist+=( "SafeAccess" "ScsiTarget" "SecureSignIn" "SMBService" "SnapshotReplication" )
            typelist+=( "Sony_BraviaSignage" "Spreadsheet" "SSOServer" "StorageAnalyzer" )
            typelist+=( "StorageManager" "SupportService" "SurveillanceDevicePack" )
            typelist+=( "SurveillanceLocalDisplay" "SurveillanceStation" "SVN" "syncthing.net" )
            typelist+=( "SynoFinder" "SynologyApplicationService" "SynologyDrive" )
            typelist+=( "SynologyFileManager" "SynologyMoments" "SynologyPhotos" )
            typelist+=( "SynoOnlinePack_v2" "SynoSmisProvider" "SyslogServer" "Tailscale" )
            typelist+=( "TeamViewer" "TextEditor" "ThreatPrevention" "Tomcat7" "UniversalViewer" )
            typelist+=( "USBCopy" "VideoStation" "VirtualHere" "Virtualization" "VPNCenter" )
            typelist+=( "VPNPlusServer" "vtigerCRM" "WebDAVServer" "WebStation" "WordPress" )
            break ;;
        Utility)
            typelist=( "All" "ActiveBackupBusinessAgent" "ActiveBackupforRecoveryTool" )
            typelist+=( "ActiveBackupRecoveryMediaCreator" "Assistant" )
            typelist+=( "AxisBarcodeToSynologySurveillanceStation" "BeeDrive" )
            typelist+=( "BeeDriveOnlineInstaller" "C2BackupAgent" "C2BackupRecoveryTool" )
            typelist+=( "C2BackupRestoreMediaCreator" "C2IdentityADSyncTool" "C2IdentityAgent" )
            typelist+=( "C2IdentityDirectoryExportTool" "C2IdentityDockerMgmtTool" )
            typelist+=( "C2IdentityLDAPSyncTool" "C2IdentityWindowsADExportTool" "ChatClient" )
            typelist+=( "CloudStationBackup" "CloudStationDrive" "EvidenceIntegrityAuthenticator" )
            typelist+=( "HybridShareDownloadTool" "HyperBackupExplorer" "iSCSIVssPlugin" )
            typelist+=( "NFSVAAIPlugin" "NoteStationClient" "PhotoStationUploader" "Presto" )
            typelist+=( "StorageConsoleforVMware" "StorageConsoleforWindows" )
            typelist+=( "SurveillanceStationClient" "SurveillanceVideoConverterTool" )
            typelist+=( "SynologyCameraTool" "SynologyCloudSyncDecryptionTool" )
            typelist+=( "SynologyDriveClient" "SynologyFileManagerClient" )
            typelist+=( "TransactionsCompatibilityTool" "TransactionsDeviceSimulator" )
            typelist+=( "VMwarePlugin" "VMwareSRA" "VPNPlusClient" "WinVirtioDriver" )
            break ;;
        Mobile)
            typelist=( "All" "Android-ActiveInsight" "Android-BeeDrive" "Android-Drive" )
            typelist+=( "Android-DSaudio" "Android-DScam" "Android-DSchat" "Android-DScloud" )
            typelist+=( "Android-DSdownload" "Android-DSfile" "Android-DSfinder" "Android-DSmail" ) 
            typelist+=( "Android-DSnote" "Android-DSphoto" "Android-DSrouter" "Android-DSvideo" )
            typelist+=( "Android-LiveCam" "Android-Moments" "Android-Photos" "Android-SecureSignIn" )
            typelist+=( "AndroidTV-DSphoto" "AndroidTV-DSvideo" "AndroidTV-SynologyPhotos" )
            typelist+=( "Android-VPNPlus" )
            break ;;
        ChromeApp)
            typelist=( "All" "NoteStationClipper" "OfficeExtension" )
            break ;;
        ToolChain)
            typelist=( "All" "Synology NAS GPL Source" "toolchain" "toolkit" )
            break ;;
        Firmware)
            #typelist=( "All" "Camera" )
            typelist=( "Camera" )
            break ;;
        *)
            echo -e "Invalid choice" ;;
    esac
done
echo -e "You selected: $srcdir \n"


PS3="Choose $srcdir type: "
select subdir in "${typelist[@]}"; do
    type="$subdir"
    break
done
echo -e "You selected: $type \n"


if [[ -n $srcdir ]] && [[ -n $type ]]; then
    if [[ -n $php_log ]]; then
        php "$php_script" "$srcdir" "$type" 2>&1 | tee "$php_log"
    else
        php "$php_script" "$srcdir" "$type"
    fi
else
    echo "args empty!"  # debug
    exit 1              # debug
fi

