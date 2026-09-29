function Header{
	Write-Host "----------------------------------------------------------------------------"
	Write-Host "|                                Auditing!                                 |"
	Write-Host "----------------------------------------------------------------------------"


}


function Output{
	Header
	foreach($value in $results){
		$square = $value -split ":"
		$info = $square[1..($square.Count-1)]
		$square = $square[0]
		if($square -eq "🟨"){
			$color = "Yellow"
		}
		elseif($square -eq "🟪"){
			$color = "Magenta"
		}
		elseif($square -eq "🟩"){
			$color = "Green"
		}
		elseif($square -eq "🟥"){
			$color = "Red"
		}
		Write-Host -Foreground $color -Background $color "  " -NoNewLine 
		Write-Host -Foreground "White" $info
	}

}

function ExecutionPolicy(){
	$ExecPol = Get-ExecutionPolicy
	$result = @() 
	if($ExecPol -eq "RemoteSigned"){
		$result += "🟨:Execution Policy Remote Signed"
	}
	elseif($ExecPol -eq "Restricted"){
		$result += "🟩:Execution Policy Restricted"
	}
	elseif($ExecPol -eq "AllSigned"){
		$result += "🟨:Execution Policy All Signed"
	}
	elseif($ExecPol -eq "Unrestricted"){
		$result += "🟥:Execution Policy Unrestricted"
	}
	elseif($ExecPol -eq "Bypass"){
		$result += "🟥:Execution Policy Bypass"
	}
	elseif($ExecPol -eq "Undefined"){
		$result += "🟥:Execution Policy Undefined"
	}
	else{
		$result += "🟧:Execution Policy Default"
	}

	return $result
}

function UserAccountControl{
	$result = @()
	$temp = Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" | Select-Object EnableLUA, ConsentPromptBehaviorAdmin, PromptOnSecureDesktop
	$lua = ((($temp -split "=")[1]) -split ";")[0]
	$behavior = ((($temp -split "=")[2]) -split ";")[0]
	$secure = ((((($temp -split "=")[3]) -split ";")[0])-split "}")[0]
	if($lua-eq1-and$behavior-ne5-and$behavior-ne0-and$secure-eq1){
		$result+="🟩:UAC Secure"
	}
	elseif($lua-eq1-and$behavior-eq5-and$secure-eq1){
		$result+="🟨:UAC Windows Default"
	}
	else{
		$result+="🟥:UAC Insecure"
	}


	return $result
}

function LocalSecurityPolicy{
	$result = @()


	return $result
}

function GroupPolicy{
	$result = @()


	return $result

}

function LegacyProtocolsFeatures{
	$result = @()
	$smb1 = Get-WindowsOptionalFeature -Online -FeatureName "SMB1Protocol" | Select-Object FeatureName, State
	$ntlm2 = Get-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa" -Name "LmCompatibilityLevel" -ErrorAction SilentlyContinue | Select-Object LmCompatibilityLevel
	$guest = Get-CimInstance Win32_UserAccount -Filter "LocalAccount = True AND SID LIKE '%-501'" | Select-Object Name, Disabled
	$autorun = Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "NoDriveTypeAutoRun" -ErrorAction SilentlyContinue | Select-Object NoDriveTypeAutoRun
	

	$llmnr = (Get-ItemProperty -Path "HKLM:\Software\Policies\Microsoft\Windows NT\DNSClient" -Name "EnableMulticast" -ErrorAction SilentlyContinue).EnableMulticast
	$netbios = Get-CimInstance Win32_NetworkAdapterConfiguration | Where-Object {$_.IPEnabled} | Select-Object Description, TcpipNetbiosOptions
	$powershell2 = Get-WindowsOptionalFeature -Online -FeatureName "MicrosoftWindowsPowerShellV2"
	$wdigest = (Get-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\WDigest" -Name "UseLogonCredential" -ErrorAction SilentlyContinue).UseLogonCredential
	$remoteregistry = (Get-Service -Name "RemoteRegistry" -ErrorAction SilentlyContinue).StartType
	
	$Protocols = @("SSL 2.0", "SSL 3.0", "TLS 1.0", "TLS 1.1")

	

	$SchannelStatus = foreach ($Proto in $Protocols) {
		$Path = "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\$Proto\Server"
    
		$Enabled = Get-ItemProperty -Path $Path -Name "Enabled" -ErrorAction SilentlyContinue
    
    		[PSCustomObject]@{
        		Protocol        = $Proto
        		ConfiguredState = if ($Enabled) { if ($Enabled.Enabled -eq 0) { "Explicitly Disabled" } else { "Explicitly Enabled" } } else { "Default (Not set in registry)" }
    		}
}


#$SchannelStatus

#$
#$llmnr
$powershell2
#$wdigest
#$remoteregistry
#$autorun
#$protocols

	foreach ($item in $netbios){
		$system = ((($item -split "=")[1]) -split ";")[0]
		$value = ((($item -split "=")[2]) -split "}")[0]
		if($value-eq2){
			$result += ("🟩:NetBIOS - "+$system+" - Disabled")
		}
		elseif($value-eq1){
			$result += ("🟥:NetBIOS - "+$system+" - Enabled")
		}
		else{
			$result += ("🟨:NetBIOS - "+$system+" - Unconfigured")
		}

	}
$smb1 = (($smb1 -split "State=")[1] -split "}")[0]


	if($smb1-eq"Disabled"){
		$result += "🟩:SMBv1 Disabled"
	}
	elseif($smb1-eq"Enabled"){
		$result += "🟥:SMBv1 Enabled"
	}

$ntlm2 = ((($ntlm2 -split "Enabled=")[1]) -split "}")[0]
	
	if($ntlm2-eq5){
		$result += "🟩:NTLM 5, Good Hashing"
	}
	else{
		$result += "🟥:NTLM not 5, Weak Hashing or No Hashing... NTLMv1 Allowed"
	}

$guest = (($guest -split "Disabled=")[1] -split "}")[0]
	
	if($guest-eq"True"){
		$result += "🟩:Guest Account Disabled"
	}
	else{
		$result += "🟥:Guest Account Enabled"
	}



	return $result

}


function WindowsOptionalFeatures{
	$result = @()


	return $result
}

function Groups{
	$result = @()
	$all = net localgroup
	foreach($item in $all){
		if($item -match "\*"){
			$item = ($item -split "\*")[1]
			$members = net localgroup $item
			$sub = $item.Substring(0, $item.Length-1)
			
			if($members -match $sub){

				$temp = ($members -split "-------------------------------------------------------------------------------") | Select-Object -Skip 7
				$temp = $temp -split "`n"
				
				foreach($tempitem in $temp){	
					if(!($tempitem -match "successful")){
						#$item
						#$temp
						#$tempitem
						if ($tempitem -match '[a-z]') {
							$result += ("🟪:"+ ($item + " - " + $tempitem))
						}
					}
				}
				
			}
			
		}
	}
	
	return $result

}

function Users{
	$result = @()
	$allowed = "JW, Guest, Administrator, DefaultAccount, WDAGUtilityAccount"
	$allowed = $allowed -split ", "
	$current = (net user)[4 .. ((net user).Length - 2)] -split '\s+' | Where-Object { $_ -ne '' }
	$current = $current -split "`n"
	$current = $current[0..($current.Length -5)]

	foreach($value in $current){
		if($value -match '[A-z]'){
			if($value -In $allowed){
				$result += ("🟩: User - " +$value)
			}	
			else{
				$result += ("🟥: Invalid User - "+$value)
			}
		}
	}	

	return $result

}

function Firewall{
	$result = @()


	return $result

}

function Scheduler{
	$result = @()


	return $result

}

function Audits{
	$result = @()


	return $result

}

function Registry{
	$result = @()


	return $result

}

function Processes{
	$result = @()


	return $result
}

function Services{
	$result = @()


	return $result
}

function NetworkShares{
	$result = @()


	return $result
}

function StartUp{
	$result = @()


	return $result
}

function Updates{
	$result = @()


	return $result
}

function Programs{
	$result = @()


	return $result
}

function Remote{
	$result = @()


	return $result
}

function EventLogs{
	$result = @()


	return $result
}

function Ports{
	$result = @()


	return $result
}

function DNS{
	$result = @()


	return $result
}

function SessionAndCredentialProtection{
	$result = @()


	return $result
}

function WinDefender{
	$result = @()


	return $result
}

function HostsFileIntegrity{
	$result = @()


	return $result
}



function Main{
	$results=@()
	$results += ExecutionPolicy #Done
	$results += UserAccountControl #Done
	$results += LocalSecurityPolicy 
	$results += GroupPolicy
	$results += LegacyProtocolsFeatures #Work in Progress
	$results += Groups
	$results += Users
	$results += Scheduler
	$results += Audits
	$results += Registry
	$results += Processes
	$results += Services
	$results += NetworkShares
	$results += StartUp
	$results += Updates
	$results += Programs
	$results += Remote
	$results += EventLogs
	$results += Ports
	$results += DNS
	$results += SessionAndCredentialProtection
	$results += WinDefender
	$results += HostsFileIntegrity
	$results += Firewall
	$results += WindowsOptionalFeatures


	Output	
}

Main
