function docker_install {

    function check_installation
        {        
            $installed_package = Get-Package  
            if ($installed_package.name -match 'docker' -and $installed_package.name -match 'DockerMsftProvider') {
                return $true
    
            } else {Write-Host "Docker Module is not installed"
                return $false
            } 
        }

    if ((check_installation) -eq $true) {write-host "Docker is already installed" -ForegroundColor Cyan}
    
    if ((check_installation) -eq $false) {
        Write-Host "Installing Docker !!!!" -ForegroundColor DarkCyan
        Install-Module DockerMsftProvider -Force -ErrorAction Stop  | Out-Null
        Install-Package Docker -ProviderName DockerMsftProvider -Force -ErrorAction Stop | Out-Null

        if((check_installation) -eq $true) {echo "Installation Completed :) "}
    }
}

docker_install
