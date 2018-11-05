#Sharepoint setup script
#Add references to SharePoint client assemblies and authenticate to Office 365 site
Add-Type -Path "C:\Program Files\Common Files\Microsoft Shared\Web Server Extensions\16\ISAPI\Microsoft.SharePoint.Client.dll"
Add-Type -Path "C:\Program Files\Common Files\Microsoft Shared\Web Server Extensions\16\ISAPI\Microsoft.SharePoint.Client.Runtime.dll"
$Username = "anthony.hawke@msc.com"
$Site = "https://teamsite.msc.com/sites/ITAgencyAudit/"
$ListTitle = "AgencyAuditTool-Prototype"
$Password = Read-Host -Prompt "Please enter your password" -AsSecureString

#Set up log file(s) and working directory
$workingdirectory = "sharepointscriptworking"
$filestocreate = @("sharepointscript-diagnostics.txt")
if (Test-Path -path .\$workingdirectory){
    Write-Output "$workingdirectory exists - cleaning up files"
    foreach ($file in $filestocreate){
        if(Test-Path -path .\$workingdirectory\$file){
            rm ".\$workingdirectory\$file" -force
            Write-Output "existing $file removed"
            }
            else{
            Write-Output "No file: $file to clean up"
            #continue
            }
    New-Item ".\$workingdirectory\$file" -type file | Out-Null
    Write-Output "$file created"
        }
    }
    else{
        Write-Output "$workingdirectory doesn't exist - creating"
        mkdir ".\$workingdirectory" | Out-Null
        foreach ($file in $filestocreate){
            New-Item $workingdirectory\$file -type file | Out-Null
            Write-Output "$file created"
        }
}

#Bind to site collection
$Context = New-Object Microsoft.SharePoint.Client.ClientContext($Site)
$Creds = New-Object Microsoft.SharePoint.Client.SharePointOnlineCredentials($Username,$Password)
$Context.Credentials = $Creds
$Web = $Context.Web

#Create List
$ListInfo = New-Object Microsoft.SharePoint.Client.ListCreationInformation
$ListInfo.Title = $ListTitle
$ListInfo.TemplateType = "100"
$List = $Context.Web.Lists.Add($ListInfo)
$List.Description = $ListTitle
$List.Update()
$Context.ExecuteQuery()

#getlistGUID
#$web = get-spweb -identity “Web url”
#$listGUID = $web.lists[[GUID](“ID of the list”)]

#specify the name of the csv file to be used for import
#unless a full path is specified, the script will try to open the source file is in the same folder/location where the script is executed
$inputcsvfile = "auditquestions-cleaned-100rows.csv"

#initial data load and variable setup
$dataset = import-csv ".\$inputcsvfile"
$currentrow = 0

#Rename first column from Title to Agency
Function Rename-ListColumn()
{
   Try {
        $ExistingColumnName = "Title"
        $NewColumnName = "Agency"

        #Get the List
        $GetList = $Context.Web.Lists.GetByTitle($ListTitle)
        $Context.Load($GetList)
        $Context.ExecuteQuery()
 
        #Get the column to rename
        $Field = $GetList.Fields.GetByInternalNameOrTitle($ExistingColumnName)
        $Field.Title = $NewColumnName
        $Field.Update()
        $Context.ExecuteQuery()
             
        Write-Host "Column Name Changed successfully!"
 
    }
    Catch {
        write-host -f Red "Error Renaming Column!" $_.Exception.Message
    }
}
#Call the function to rename column
Rename-ListColumn -SiteURL $Site -ListName $ListName -ColumnName $ExistingColumnName -NewName $NewColumnName
 
#create column for audit date
Function Add-DateTimeColumnToList()
{
    param
    (
        [Parameter(Mandatory=$true)] [string] $SiteURL,
        [Parameter(Mandatory=$true)] [string] $ListName,
        [Parameter(Mandatory=$true)] [string] $Name,
        [Parameter(Mandatory=$true)] [string] $DisplayName,
        [Parameter(Mandatory=$true)] [string] $Description,
        [Parameter(Mandatory=$true)] [string] $Format,
        [Parameter(Mandatory=$true)] [string] $IsRequired,
        [Parameter(Mandatory=$true)] [string] $FriendlyDisplayFormat,
        [Parameter(Mandatory=$true)] [string] $EnforceUniqueValues
    )
 
    #Generate new GUID for Field ID - not sure you need this, apparently it's always better to let Sharepoint assign the GUID
    #$FieldID = New-Guid
 
    Try {
        #$Cred= Get-Credential
        $Credentials = $Creds
 
        #Setup the context
        $Ctx = New-Object Microsoft.SharePoint.Client.ClientContext($SiteURL)
        $Ctx.Credentials = $Credentials
         
        #Get the List
        $List = $Ctx.Web.Lists.GetByTitle($ListName)
        $Ctx.Load($List)
        $Ctx.ExecuteQuery()
 
        #Check if the column exists in list already
        $Fields = $List.Fields
        $Ctx.Load($Fields)
        $Ctx.executeQuery() | Add-Content -path ".\$workingdirectory\$logfile" -value "$_"
        $NewField = $Fields | where { ($_.Internalname -eq $Name) -or ($_.Title -eq $DisplayName) }
        if($NewField -ne $NULL) 
        {
            Write-host "Column $Name already exists in the List!" -f Yellow
        }
        else
        {
            #Define XML for Field Schema
            $FieldSchema = "<Field Type='DateTime' Name='$Name' StaticName='$Name' DisplayName='$DisplayName' Format='$Format' Required='$IsRequired'  Description='$Description' EnforceUniqueValues='$EnforceUniqueValues' FriendlyDisplayFormat='$FriendlyDisplayFormat' />"
            $NewField = $List.Fields.AddFieldAsXml($FieldSchema,$True,[Microsoft.SharePoint.Client.AddFieldOptions]::AddFieldInternalNameHint)
            $Ctx.ExecuteQuery()
 
            Write-host "New Column Added to the List Successfully!" -ForegroundColor Green 
        }
    }
    Catch {
        write-host -f Red "Error Adding Column to List!" $_.Exception.Message
    }
}
 
#Set parameter values
$SiteURL="$Site"
$ListName="$ListTitle"
$Name="AuditDate" #Column Name
$DisplayName="Audit Date"
$Description="Enter the Audit End Date"
$Format="DateOnly" #DateTime
$IsRequired = "FALSE"
$EnforceUniqueValues="FALSE"
$FriendlyDisplayFormat="Disabled" #Relative
 
#Call the function to add column to list
Add-DateTimeColumnToList -SiteURL $SiteURL -ListName $ListName -Name $Name -DisplayName $DisplayName -IsRequired $IsRequired -Format $Format -EnforceUniqueValues $EnforceUniqueValues -FriendlyDisplayFormat $FriendlyDisplayFormat -Description $Description


#Question creation - generated from CSV questions template
#=========================================================================================================================
switch($dataset."Qtype")
{
    'YesNo'
    {
    #Question Type - Choice Yes/No - choice box
    $currentQID = $dataset[$currentrow].("QID")
    $currentITEM = $dataset[$currentrow].("ITEM")
    $displayname = $currentQID+'Response'
    Write-Output "Working on question: $currentQID"
    $a = $List.Fields.AddFieldAsXml("<Field Type='Choice' DisplayName='$displayname' Description='$currentITEM'>
                            <Default>Yes</Default>
                            <CHOICES>
                                <CHOICE>Yes</CHOICE>
                                <CHOICE>No</CHOICE>
                            </CHOICES></Field>",$true,[Microsoft.SharePoint.Client.AddFieldOptions]::AddFieldToDefaultView)
    $List.Update()
    $Context.ExecuteQuery()
    
    #Question Type - Choice Yes/No - details text box
    $currentQID = $dataset[$currentrow].("QID")
    $currentDetail = $dataset[$currentrow].("Detail")
    $displayname = $currentQID+'Detail'
    $List.Fields.AddFieldAsXml("<Field Type='Note' NumLines='1' DisplayName='$displayname' Description='$currentDetail'/>",$true,[Microsoft.SharePoint.Client.AddFieldOptions]::AddFieldToDefaultView)
    $List.Update()
    $Context.ExecuteQuery()
    
    Write-Output "YesNo row completed"
    $currentrow++
    continue
    }

    'AllMostSomeNone'
    {
    #Question Type - Choice AllMostSomeNone - choice box
    $currentQID = $dataset[$currentrow].("QID")
    $currentITEM = $dataset[$currentrow].("ITEM")
    $displayname = $currentQID+'Response'
    Write-Output "Working on question: $currentQID"
    $List.Fields.AddFieldAsXml("<Field Type='Choice' DisplayName='$displayname' Description='$currentITEM'>
                            <Default>All</Default>
                            <CHOICES>
                                <CHOICE>All</CHOICE>
                                <CHOICE>Most</CHOICE>
                                <CHOICE>Some</CHOICE>
                                <CHOICE>None</CHOICE>
                            </CHOICES></Field>",$true,[Microsoft.SharePoint.Client.AddFieldOptions]::AddFieldToDefaultView)
    $List.Update()
    $Context.ExecuteQuery()
        
    #Question Type - Choice AllMostSomeNone - details text box
    $currentQID = $dataset[$currentrow].("QID")
    $currentDetail = $dataset[$currentrow].("Detail")
    $displayname = $currentQID+'Detail'
    $List.Fields.AddFieldAsXml("<Field Type='Note' NumLines='1' DisplayName='$displayname' Description='$currentDetail'/>",$true,[Microsoft.SharePoint.Client.AddFieldOptions]::AddFieldToDefaultView)
    $List.Update()
    $Context.ExecuteQuery()
    $currentrow++
    Write-Output "AllMostSomeNone row completed"
    continue
    }

    'TextField'
    {
    #Question Type - Choice TextField - choice box 1 to 10
    Write-Output "Working on question: $currentQID"
    $currentQID = $dataset[$currentrow].("QID")
    $currentITEM = "Score"
    $displayname = $currentQID+'Response'
    
    $List.Fields.AddFieldAsXml("<Field Type='Choice' DisplayName='$displayname' Description='$currentITEM'>
                            <Default>6</Default>
                            <CHOICES>
                                <CHOICE>1</CHOICE>
                                <CHOICE>2</CHOICE>
                                <CHOICE>3</CHOICE>
                                <CHOICE>4</CHOICE>
                                <CHOICE>5</CHOICE>
                                <CHOICE>6</CHOICE>
                                <CHOICE>7</CHOICE>
                                <CHOICE>8</CHOICE>
                                <CHOICE>9</CHOICE>
                                <CHOICE>10</CHOICE>
                            </CHOICES></Field>",$true,[Microsoft.SharePoint.Client.AddFieldOptions]::AddFieldToDefaultView)
    $List.Update()
    $Context.ExecuteQuery()
    
    #Question Type - Choice TextField - details text box
    $currentQID = $dataset[$currentrow].("QID")
    $currentDetail = $dataset[$currentrow].("Detail")
    $displayname = $currentQID+'Detail'
    $List.Fields.AddFieldAsXml("<Field Type='Note' NumLines='1' DisplayName='$displayname' Description='$currentITEM'/>",$true,[Microsoft.SharePoint.Client.AddFieldOptions]::AddFieldToDefaultView)
    $List.Update()
    $Context.ExecuteQuery()
    Write-Output "Textfield case row completed"
    $currentrow++
    continue
    }
}

#Format="DateOnly | DateTime | TimeOnly | EventList | ISO8601 | MonthDayOnly | MonthYearOnly | ISO8601Basic | ISO8601Gregorian | ISO8601BasicDateOnly | DropDown | RadioButtons | HyperLink | Image | TRUE | FALSE"