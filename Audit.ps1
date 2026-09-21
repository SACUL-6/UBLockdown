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
		elseif($square -eq "🟧"){
			$color = "Orange"
		}
		elseif($square -eq "🟩"){
			$color = "Green"
		}
		elseif($square -eq "🟥"){
			$color = "Red"
		}
		Write-Host -Foreground $color -Background $color "  " -NoNewLine 
		Write-Host -Foreground "White" $info -NoNewLine
		Write-Host -Foreground $color -Background $color "  " -NoNewLine 
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


	return $result

}

function Groups{
	$result = @()


	return $result

}

function Users{
	$result = @()


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
	$results += ExecutionPolicy
	$results += UserAccountControl
	$results += LocalSecurityPolicy
	$results += GroupPolicy
	$results += LegacyProtocolsFeatures
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


	Output	
}

Main
