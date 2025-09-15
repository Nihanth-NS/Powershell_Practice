###################################################################DAY-9 AWS Module installation,EC2 interact##########################################################################################################
Install-Module -Name AWS.Tools.Common -Scope CurrentUser -Force
Install-Module -Name AWS.Tools.EC2 -Scope CurrentUser -Force
Import-Module AWS.Tools.Common
Import-Module AWS.Tools.EC2
Set-AWSCredential -AccessKey -SecretKey -StoreAs default
Get-EC2Instance -Region ap-southeast-2
Get-EC2Instance -Region ap-southeast-2 | Select-Object -ExpandProperty Instances |
    Select-Object InstanceId, State, InstanceType, PrivateIpAddress, PublicIpAddress
Stop-EC2Instance -Region ap-southeast-2 -InstanceId i-010b59e51988e0dd4
(Get-EC2Instance -Region ap-southeast-2 -InstanceId i-010b59e51988e0dd4).Instances.state
