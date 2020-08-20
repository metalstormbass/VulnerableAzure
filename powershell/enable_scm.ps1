Param (
    [Parameter(Mandatory = $true)]
    [String]$webAppName,
    [string]$appResourceGroupName,
    [string]$repoUrl,
    [string]$scmBranch
)

#Script uses Azure CLI Login credentials to forward access_token to Powershell

$subscriptions = (az account list -o json 2> $null | ConvertFrom-Json)
$subscriptionId= $subscriptions | Where-Object isDefault -like true
$accountId = $subscriptionId.user.name
$tenantId = $subscriptionId.tenantId
$adTokenRegistry = (az account get-access-token | ConvertFrom-Json)
$accessToken = $adtokenregistry.accessToken

Login-AzureRmAccount -AccessToken $accessToken -tenantid $tenantId -accountid $accountId

Write-Host "Getting App information"
$webApp = get-AzureRmResource -ResourceName $webAppName -ResourceType "Microsoft.Web/sites" -ApiVersion 2015-08-01 -ResourceGroupName $appResourceGroupName
$location = $webApp.Location

$webAppConfig = Get-AzureRmResource -ResourceName "$($webAppName)/web" -ResourceType "Microsoft.Web/sites/config" -ApiVersion 2015-08-01 -ResourceGroupName $appResourceGroupName
$currentScmType = $webAppConfig.Properties.scmType

if($currentScmType -ne $null -and $currentScmType -ne "None")
{
    Write-Host "Already setup with scmType $currentScmType"
	# App is already configured with source control,  we cannot add again.
	return
}

$propertiesObject = @{
    repourl             = "$repoUrl"
    branch              = "$scmBranch"
    isManualIntegration = "true"
}

New-AzureRmResource -Properties $propertiesObject -ResourceName $webAppName/web -ResourceType Microsoft.Web/sites/SourceControls -ResourceGroupName $appResourceGroupName -ApiVersion 2015-08-01 -Force -ErrorAction SilentlyContinue
