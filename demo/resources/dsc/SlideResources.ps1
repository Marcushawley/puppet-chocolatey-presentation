Configuration SoftwareManagement
{
  Import-DscResource -Module cChoco
  Node "localhost"
  {
  LocalConfigurationManager
  {
    DebugMode = 'ForceModuleImport'
  }

  cChocoInstaller chocoInstall
  {
    # default installation location - allows
    # Chocolatey to apply default security
    # settings
    InstallDir = "$env:ProgramData\chocolatey"
    ChocoInstallScriptUrl = 'file:///C:\InstallChoco.ps1'
  }

  cChocoSource defaultChocoSource {
    Ensure    = 'Absent'
    Name      = 'chocolatey'
    Source    = 'https://chocolatey.org/api/v2/'
  }

  cChocoSource internalChocoSource {
    Ensure    = 'Present'
    Name      = 'internal_server'
    Source    = 'http://localhost/chocolatey'
    #Credentials = add credentials
    Priority  = 1
  }

  cChocoPackageInstaller ChromePackage {
    Ensure      = 'Present|Absent'
    Name        = 'packageId'
    Params      = 'package parameters'
    chocoParams = 'Params for choco.exe'
    Version     = 'package version'
    Source      = 'location'
    AutoUpgrade = $False
  }

  # cChocoPackageInstaller installChrome
  # {
  #   Name        = "googlechrome"
  #   DependsOn   = "[cChocoInstaller]ensureChocoInstall"
  #   #This will automatically try to upgrade if
  #   # available, only if a version is not
  #   # explicitly specified.
  #   AutoUpgrade = $True
  # }

  #   cChocoPackageInstaller installAtomSpecificVersion
  #   {
  #     Name      = "atom"
  #     Version   = "0.155.0"
  #     DependsOn = "[cChocoInstaller]ensureChocoInstall"
  #   }

  #   cChocoPackageInstaller installGit
  #   {
  #       Ensure = 'Present'
  #       Name = "git"
  #       Params = "/Someparam "
  #       DependsOn = "[cChocoInstaller]ensureChocoInstall"
  #   }
  #   cChocoPackageInstaller noFlashAllowed
  #   {
  #       Ensure = 'Absent'
  #       Name = "flashplayerplugin"
  #       DependsOn = "[cChocoInstaller]ensureChocoInstall"
  #   }
  #   cChocoPackageInstallerSet installSomeStuff
  #   {
  #       Ensure = 'Present'
  #       Name = @(
  #   "git"
  #   "skype"
  #   "7zip"
  # )
  #       DependsOn = "[cChocoInstaller]ensureChocoInstall"
  #   }
  #   cChocoPackageInstallerSet stuffToBeRemoved
  #   {
  #       Ensure = 'Absent'
  #       Name = @(
  #   "vlc"
  #   "ruby"
  #   "adobeair"
  # )
  #     DependsOn = "[cChocoInstaller]ensureChocoInstall"
  #   }

}
}

SoftwareManagement

Start-DscConfiguration .\SoftwareManagement -Wait -Verbose -Force
