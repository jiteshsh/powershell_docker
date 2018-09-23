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
    
    if ((check_installation) -eq $true) {write-host "Docker is already installed :) " -ForegroundColor Cyan}
    
    if ((check_installation) -eq $false) {
        Write-Host "Installing Docker !!!!" -ForegroundColor DarkCyan
        Install-Module DockerMsftProvider -Force -ErrorAction Stop  | Out-Null
        Install-Package Docker -ProviderName DockerMsftProvider -Force -ErrorAction Stop | Out-Null

        if((check_installation) -eq $true) {echo "Installation was success"}
    }
    
    function check_service {    
        $docker_status = (get-service Docker).Status 
                            
        if ($docker_status -eq 'Stopped') {               
            return $false 
        }
        elseif ($docker_status -eq 'Running') {             
            return $true 
        }
        else {echo "Somehting went wrong with docker service"
            break             
        }
    }      
    
    if ((check_service) -eq $false) {
        Write-Host "Currently Docker engine not running" -ForegroundColor Cyan        
        Start-Service docker -Verbose
        if ((check_service) -eq $true) {Write-Host "Docker engine is running now" -ForegroundColor cyan}
    }
}

docker_install
