Import-module ActiveDirectory
$users = Import-Csv "C:\temp\PSECompareData.csv"
foreach ($user in $users) {
    $props = @{
        identity    = $user.NETWORK_LOGIN
        title       = if($user.BUS_TITLE   ){$user.BUS_TITLE  }else{$null}
#        description = if($user.description){$user.description}else{$null}
#        state       = if($user.State      ){$user.State      }else{$null}
#        Office      = if($user.Office     ){$user.Office     }else{$null}
        department  = if($user.ORG_UNIT_NAME ){$user.ORG_UNIT_NAME }else{$null}
        city        = if($user.LOCATION       ){$user.LOCATION       }else{$null}
#        manager     = if($user.MANAGER_SALUTATION    ){$user.MANAGER_SALUTATION   }else{$null}    
#        manager    =  Get-ADUser -Filter "displayname -eq '$($user.MANAGER_SALUTATION)'"|select Samaccountname
#        company     = if($user.company    ){$user.company    }else{$null}
        # manager = $manager1
 #      manager = if ($user.MANAGER_SALUTATION -ne $null)
        manager = If (-not [string]::IsNullOrWhiteSpace($user.MANAGER_SALUTATION) )
       {
       #(Get-ADUser $user.MANAGER_SALUTATION).DistinguishedName
       #Get-ADUser -Filter "displayname -eq '$($user.MANAGER_SALUTATION)'"| select Distinguishedname 
       Get-ADUser ($user.MANAGER_SALUTATION) | select sAMAccountName 
       }
       
      else {$null} 
       }
    set-aduser @props

}

