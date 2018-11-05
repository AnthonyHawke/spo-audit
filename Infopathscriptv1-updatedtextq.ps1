#files to generate Infopath template
#Choices Data Connection.xsd
#manifest.xsf
#sampledata.xml
#schema.xsd
#schema1.xsd
#schema2.xsd
#schema3.xsd
#schema4.xsd
#template.xml
#upgrade.xsl
#view1.xsl
$templatefiles = Get-Childitem -Path .\$templatedirectory\ -File -Filter *basetemplate* | %{$_.Name}

Function Create_Output_Directory
{
if (Test-Path -path .\$outputdirectory){
    Write-Output "Info: $outputdirectory exists - cleaning up files (deleting everything in directory)"
    Get-Childitem -Path .\$outputdirectory\ -File | Foreach-Object {
        Remove-Item $_.Fullname -Force
        Write-Output "Info: $_.Fullname removed"
        }
    }
    else{
        Write-Output "Info: $outputdirectory doesn't exist - creating"
        New-Item -Name $outputdirectory -ItemType directory
        Write-Output "Success: directory (folder) $outputdirectory created"
    }
}

#Function to create initial files from base templates
Function Copy_Initial_Template_Files
{
Get-ChildItem -Path .\$templatedirectory\ -File -Filter *basetemplate* | Foreach-Object {
    $string = $_.Tostring()
    $filesplits = $string.split("_")
    $filename = $filesplits[0]
    $fileextension= $filesplits[1]
    Write-Output "Copying template file: $string as $filename.$fileextension"
    Copy-Item ".\$templatedirectory\$string" ".\$outputdirectory\$filename.$fileextension" -Force
    }
$workingfileset = Get-ChildItem -Path .\$outputdirectory\ -File | %{$_.Name}
Write-Output "Working File set is: $workingfileset"
}


#Function block - updates of each question type for each file type
#Choices Data Connection_xsd
Function Update_Choices_Data_Connection_Xsd_YesNoQ
{
    # Function for updating file Choices Data Connection5.xsd
    # Processes lines of text from file and assign result to $NewContent variable
    $NewContent = Get-Content -Path ".\$outputdirectory\Choices Data Connection5.xsd" |
        ForEach-Object {
            # If line matches regex
            if($_ -match '<!-- choicesdataconnection_xsd_QID_response_insertpoint1 -->')
            {
				#get template of new xml section to be added
                $rowstotransform = Get-Content -Path ".\$templatedirectory\Choices Data Connection5_xsd_yesnoQ_template_insertpoint1.txt"
                #transform new rows to be added
				$transformedrows = %{ $rowstotransform -replace 'QIDReplace',$dataset[$currentrow].("QID")}
                #Inject new info into row
                $transformedrows
                #Don't replace update flag because of second 'if', uncomment if only a single 'if'
                #$_
            }
            if($_ -match '<!-- choicesdataconnection_xsd_QID_response_insertpoint2 -->')
            {
				#get template of new xml section to be added
                $rowstotransform = Get-Content -Path ".\$templatedirectory\Choices Data Connection5_xsd_yesnoQ_template_insertpoint2.txt"
                #transform new rows to be added
				$transformedrows = %{ $rowstotransform -replace 'QIDReplace',$dataset[$currentrow].("QID")}
                #Inject new info into row
                $transformedrows
                #Replace update flag
                $_
            }
            else # If line doesn't matches regex
            {
                # Output current line to pipeline - leave it as it is
                $_
            }
        }

    # Write content of $NewContent varibale back to file
    $NewContent | Out-File -FilePath ".\$outputdirectory\Choices Data Connection5.xsd" -Encoding Default -Force
}

Function Update_Choices_Data_Connection_Xsd_AllMostSomeNoneQ
{
    # Function for updating file Choices Data Connection.xsd
    # Processes lines of text from file and assign result to $NewContent variable
    $NewContent = Get-Content -Path ".\$outputdirectory\Choices Data Connection5.xsd" |
        ForEach-Object {
            # If line matches regex
            if($_ -match '<!-- choicesdataconnection_xsd_QID_response_insertpoint1 -->')
            {
				#get template of new xml section to be added
                $rowstotransform = Get-Content -Path ".\$templatedirectory\Choices Data Connection5_xsd_allmostsomenoneQ_template_insertpoint1.txt"
                #transform new rows to be added
				$transformedrows = %{ $rowstotransform -replace 'QIDReplace',$dataset[$currentrow].("QID")}
                #Inject new info into row
                $transformedrows
                #Don't replace update flag because of second 'if', uncomment if only a single 'if'
                #$_
            }
            if($_ -match '<!-- choicesdataconnection_xsd_QID_response_insertpoint2 -->')
            {
				#get template of new xml section to be added
                $rowstotransform = Get-Content -Path ".\$templatedirectory\Choices Data Connection5_xsd_allmostsomenoneQ_template_insertpoint2.txt"
                #transform new rows to be added
				$transformedrows = %{ $rowstotransform -replace 'QIDReplace',$dataset[$currentrow].("QID")}
                #Inject new info into row
                $transformedrows
                #Replace update flag
                $_
            }
            else # If line doesn't matches regex
            {
                # Output current line to pipeline - leave it as it is
                $_
            }
        }

    # Write content of $NewContent varibale back to file
    $NewContent | Out-File -FilePath ".\$outputdirectory\Choices Data Connection5.xsd" -Encoding Default -Force
}

Function Update_Choices_Data_Connection_Xsd_TextFieldQ
{
    # Function for updating file Choices Data Connection.xsd
    # Processes lines of text from file and assign result to $NewContent variable
    $NewContent = Get-Content -Path ".\$outputdirectory\Choices Data Connection5.xsd" |
        ForEach-Object {
            # If line matches regex
            if($_ -match '<!-- choicesdataconnection_xsd_QID_response_insertpoint1 -->')
            {
				#get template of new xml section to be added
                $rowstotransform = Get-Content -Path ".\$templatedirectory\Choices Data Connection5_xsd_textfieldQ_template_insertpoint1.txt"
                #transform new rows to be added
				$transformedrows = %{ $rowstotransform -replace 'QIDReplace',$dataset[$currentrow].("QID")}
                #Inject new info into row
                $transformedrows
                #Don't replace update flag because of second 'if', uncomment if only a single 'if'
                #$_
            }
            if($_ -match '<!-- choicesdataconnection_xsd_QID_response_insertpoint2 -->')
            {
				#get template of new xml section to be added
                $rowstotransform = Get-Content -Path ".\$templatedirectory\Choices Data Connection5_xsd_textfieldQ_template_insertpoint2.txt"
                #transform new rows to be added
				$transformedrows = %{ $rowstotransform -replace 'QIDReplace',$dataset[$currentrow].("QID")}
                #Inject new info into row
                $transformedrows
                #Replace update flag
                $_
            }
            else # If line doesn't matches regex
            {
                # Output current line to pipeline - leave it as it is
                $_
            }
        }

    # Write content of $NewContent varibale back to file
    $NewContent | Out-File -FilePath ".\$outputdirectory\Choices Data Connection5.xsd" -Encoding Default -Force
}

#Choices_Xml
Function Update_Choices_Xml_YesNoQ
{
    # Function for updating file Choices Data Connection.xsd
    # Processes lines of text from file and assign result to $NewContent variable
    $NewContent = Get-Content -Path ".\$outputdirectory\choices.xml" |
        ForEach-Object {
            # If line matches regex
            if($_ -match '<!-- choices_xml_QID_response_insertpoint1 -->')
            {
				#get template of new xml section to be added
                $rowstotransform = Get-Content -Path ".\$templatedirectory\choices_xml_yesnoQ_template_insertpoint1.txt"
                #transform new rows to be added
				$transformedrows = %{ $rowstotransform -replace 'QIDReplace',$dataset[$currentrow].("QID")}
                #Inject new info into row
                $transformedrows
                #Don't replace update flag because of second 'if', uncomment if only a single 'if'
                $_
            }
            else # If line doesn't matches regex
            {
                # Output current line to pipeline - leave it as it is
                $_
            }
        }

    # Write content of $NewContent varibale back to file
    $NewContent | Out-File -FilePath ".\$outputdirectory\choices.xml" -Encoding Default -Force
}

Function Update_Choices_Xml_AllMostSomeNoneQ
{
    # Function for updating file Choices Data Connection.xsd
    # Processes lines of text from file and assign result to $NewContent variable
    $NewContent = Get-Content -Path ".\$outputdirectory\choices.xml" |
        ForEach-Object {
            # If line matches regex
            if($_ -match '<!-- choices_xml_QID_response_insertpoint1 -->')
            {
				#get template of new xml section to be added
                $rowstotransform = Get-Content -Path ".\$templatedirectory\choices_xml_AllMostSomeNoneQ_template_insertpoint1.txt"
                #transform new rows to be added
				$transformedrows = %{ $rowstotransform -replace 'QIDReplace',$dataset[$currentrow].("QID")}
                #Inject new info into row
                $transformedrows
                #Don't replace update flag because of second 'if', uncomment if only a single 'if'
                $_
            }
            else # If line doesn't matches regex
            {
                # Output current line to pipeline - leave it as it is
                $_
            }
        }

    # Write content of $NewContent varibale back to file
    $NewContent | Out-File -FilePath ".\$outputdirectory\choices.xml" -Encoding Default -Force
}

Function Update_Choices_Xml_TextFieldQ
{
    # Function for updating file Choices Data Connection.xsd
    # Processes lines of text from file and assign result to $NewContent variable
    $NewContent = Get-Content -Path ".\$outputdirectory\choices.xml" |
        ForEach-Object {
            # If line matches regex
            if($_ -match '<!-- choices_xml_QID_response_insertpoint1 -->')
            {
				#get template of new xml section to be added
                $rowstotransform = Get-Content -Path ".\$templatedirectory\choices_xml_TextfieldQ_template_insertpoint1.txt"
                #transform new rows to be added
				$transformedrows = %{ $rowstotransform -replace 'QIDReplace',$dataset[$currentrow].("QID")}
                #Inject new info into row
                $transformedrows
                #Don't replace update flag because of second 'if', uncomment if only a single 'if'
                $_
            }
            else # If line doesn't matches regex
            {
                # Output current line to pipeline - leave it as it is
                $_
            }
        }

    # Write content of $NewContent varibale back to file
    $NewContent | Out-File -FilePath ".\$outputdirectory\choices.xml" -Encoding Default -Force
}

#manifest.xsf
Function Update_Manifest_Xsf_YesNoQ
{
    # Function for updating file manifest.xsf
    # Processes lines of text from file and assign result to $NewContent variable
    $NewContent = Get-Content -Path .\$outputdirectory\manifest.xsf |
        ForEach-Object {
            # If line matches regex
            if($_ -match '<!-- manifest_xsf_QID_detail_insertpoint1 -->')
            {
				#get template of new xml section to be added
                $rowstotransform = Get-Content -Path ".\$templatedirectory\manifest_xsf_yesnoQ_template_insertpoint1.txt"
                #transform new rows to be added
				$transformedrows = %{ $rowstotransform -replace 'QIDReplace',$dataset[$currentrow].("QID")}
                #Inject new info into row
                $transformedrows
                #Don't replace update flag because of second 'if', uncomment if only a single 'if'
                #$_
            }
            if($_ -match '<!-- manifest_xsf_QID_both_insertpoint2 -->')
            {
				#get template of new xml section to be added
                $rowstotransform = Get-Content -Path ".\$templatedirectory\manifest_xsf_yesnoQ_template_insertpoint2.txt"
                #transform new rows to be added
				$transformedrows = %{ $rowstotransform -replace 'QIDReplace',$dataset[$currentrow].("QID")}
                #Inject new info into row
                $transformedrows
                #Replace update flag
                $_
            }
            else # If line doesn't matches regex
            {
                # Output current line to pipeline - leave it as it is
                $_
            }
        }

    # Write content of $NewContent varibale back to file
    $NewContent | Out-File -FilePath .\$outputdirectory\manifest.xsf -Encoding Default -Force
}

Function Update_Manifest_Xsf_AllMostSomeNoneQ
{
    # Function for updating file manifest.xsf
    # Processes lines of text from file and assign result to $NewContent variable
    $NewContent = Get-Content -Path .\$outputdirectory\manifest.xsf |
        ForEach-Object {
            # If line matches regex
            if($_ -match '<!-- manifest_xsf_QID_detail_insertpoint1 -->')
            {
				#get template of new xml section to be added
                $rowstotransform = Get-Content -Path ".\$templatedirectory\manifest_xsf_allmostsomenoneQ_template_insertpoint1.txt"
                #transform new rows to be added
				$transformedrows = %{ $rowstotransform -replace 'QIDReplace',$dataset[$currentrow].("QID")}
                #Inject new info into row
                $transformedrows
                #Don't replace update flag because of second 'if', uncomment if only a single 'if'
                #$_
            }
            if($_ -match '<!-- manifest_xsf_QID_both_insertpoint2 -->')
            {
				#get template of new xml section to be added
                $rowstotransform = Get-Content -Path ".\$templatedirectory\manifest_xsf_allmostsomenoneQ_template_insertpoint2.txt"
                #transform new rows to be added
				$transformedrows = %{ $rowstotransform -replace 'QIDReplace',$dataset[$currentrow].("QID")}
                #Inject new info into row
                $transformedrows
                #Replace update flag
                $_
            }
            else # If line doesn't matches regex
            {
                # Output current line to pipeline - leave it as it is
                $_
            }
        }

    # Write content of $NewContent varibale back to file
    $NewContent | Out-File -FilePath .\$outputdirectory\manifest.xsf -Encoding Default -Force
}

Function Update_Manifest_Xsf_TextFieldQ
{
    # Function for updating file manifest.xsf
    # Processes lines of text from file and assign result to $NewContent variable
    $NewContent = Get-Content -Path .\$outputdirectory\manifest.xsf |
        ForEach-Object {
            # If line matches regex
            if($_ -match '<!-- manifest_xsf_QID_detail_insertpoint1 -->')
            {
				#get template of new xml section to be added
                $rowstotransform = Get-Content -Path ".\$templatedirectory\manifest_xsf_textfieldQ_template_insertpoint1.txt"
                #transform new rows to be added
				$transformedrows = %{ $rowstotransform -replace 'QIDReplace',$dataset[$currentrow].("QID")}
                #Inject new info into row
                $transformedrows
                #Don't replace update flag because of second 'if', uncomment if only a single 'if'
                #$_
            }
            if($_ -match '<!-- manifest_xsf_QID_both_insertpoint2 -->')
            {
				#get template of new xml section to be added
                $rowstotransform = Get-Content -Path ".\$templatedirectory\manifest_xsf_textfieldQ_template_insertpoint2.txt"
                #transform new rows to be added
				$transformedrows = %{ $rowstotransform -replace 'QIDReplace',$dataset[$currentrow].("QID")}
                #Inject new info into row
                $transformedrows
                #Replace update flag
                $_
            }
            else # If line doesn't matches regex
            {
                # Output current line to pipeline - leave it as it is
                $_
            }
        }

    # Write content of $NewContent varibale back to file
    $NewContent | Out-File -FilePath .\$outputdirectory\manifest.xsf -Encoding Default -Force
}

#sampledata.xml
Function Update_Sampledata_Xml_YesNoQ
{
    # Function for updating file sampledata.xml
    # Processes lines of text from file and assign result to $NewContent variable
    $NewContent = Get-Content -Path .\$outputdirectory\sampledata.xml |
        ForEach-Object {
            # If line matches regex
            if($_ -match '<!-- sampledata_xml_QID_response_insertpoint1 -->')
            {
				#get template of new xml section to be added
                $rowstotransform = Get-Content -Path ".\$templatedirectory\sampledata_xml_YesNoQ_template_insertpoint1.txt"
                #transform new rows to be added
				$transformedrows = %{ $rowstotransform -replace 'QIDReplace',$dataset[$currentrow].("QID")}
                #Inject new info into row
                $transformedrows
                #Don't replace update flag because of second 'if', uncomment if only a single 'if'
                #$_
            }
            if($_ -match '<!-- sampledata_xml_QID_both_insertpoint2 -->')
            {
				#get template of new xml section to be added
                $rowstotransform = Get-Content -Path ".\$templatedirectory\sampledata_xml_YesNoQ_template_insertpoint2.txt"
                #transform new rows to be added
				$transformedrows = %{ $rowstotransform -replace 'QIDReplace',$dataset[$currentrow].("QID")}
                #Inject new info into row
                $transformedrows
                #Replace update flag
                #$_
            }
            if($_ -match '<!-- sampledata_xml_QID_response_insertpoint3 -->')
            {
				#get template of new xml section to be added
                $rowstotransform = Get-Content -Path ".\$templatedirectory\sampledata_xml_YesNoQ_template_insertpoint3.txt"
                #transform new rows to be added
				$transformedrows = %{ $rowstotransform -replace 'QIDReplace',$dataset[$currentrow].("QID")}
                #Inject new info into row
                $transformedrows
                #Replace update flag
                $_
            }
            else # If line doesn't matches regex
            {
                # Output current line to pipeline - leave it as it is
                $_
            }
        }

    # Write content of $NewContent varibale back to file
    $NewContent | Out-File -FilePath .\$outputdirectory\sampledata.xml -Encoding Default -Force
}

Function Update_Sampledata_Xml_AllMostSomeNoneQ
{
    # Function for updating file sampledata.xml
    # Processes lines of text from file and assign result to $NewContent variable
    $NewContent = Get-Content -Path .\$outputdirectory\sampledata.xml |
        ForEach-Object {
            # If line matches regex
            if($_ -match '<!-- sampledata_xml_QID_response_insertpoint1 -->')
            {
				#get template of new xml section to be added
                $rowstotransform = Get-Content -Path ".\$templatedirectory\sampledata_xml_AllMostSomeNoneQ_template_insertpoint1.txt"
                #transform new rows to be added
				$transformedrows = %{ $rowstotransform -replace 'QIDReplace',$dataset[$currentrow].("QID")}
                #Inject new info into row
                $transformedrows
                #Don't replace update flag because of second 'if', uncomment if only a single 'if'
                #$_
            }
            if($_ -match '<!-- sampledata_xml_QID_both_insertpoint2 -->')
            {
				#get template of new xml section to be added
                $rowstotransform = Get-Content -Path ".\$templatedirectory\sampledata_xml_AllMostSomeNoneQ_template_insertpoint2.txt"
                #transform new rows to be added
				$transformedrows = %{ $rowstotransform -replace 'QIDReplace',$dataset[$currentrow].("QID")}
                #Inject new info into row
                $transformedrows
                #Replace update flag
                #$_
            }
            if($_ -match '<!-- sampledata_xml_QID_response_insertpoint3 -->')
            {
				#get template of new xml section to be added
                $rowstotransform = Get-Content -Path ".\$templatedirectory\sampledata_xml_AllMostSomeNoneQ_template_insertpoint3.txt"
                #transform new rows to be added
				$transformedrows = %{ $rowstotransform -replace 'QIDReplace',$dataset[$currentrow].("QID")}
                #Inject new info into row
                $transformedrows
                #Replace update flag
                $_
            }
            else # If line doesn't matches regex
            {
                # Output current line to pipeline - leave it as it is
                $_
            }
        }

    # Write content of $NewContent varibale back to file
    $NewContent | Out-File -FilePath .\$outputdirectory\sampledata.xml -Encoding Default -Force
}

Function Update_Sampledata_Xml_TextFieldQ
{
    # Function for updating file sampledata.xml
    # Processes lines of text from file and assign result to $NewContent variable
    $NewContent = Get-Content -Path .\$outputdirectory\sampledata.xml |
        ForEach-Object {
            # If line matches regex
            if($_ -match '<!-- sampledata_xml_QID_response_insertpoint1 -->')
            {
				#get template of new xml section to be added
                $rowstotransform = Get-Content -Path ".\$templatedirectory\sampledata_xml_textfieldQ_template_insertpoint1.txt"
                #transform new rows to be added
				$transformedrows = %{ $rowstotransform -replace 'QIDReplace',$dataset[$currentrow].("QID")}
                #Inject new info into row
                $transformedrows
                #Don't replace update flag because of second 'if', uncomment if only a single 'if'
                #$_
            }
            if($_ -match '<!-- sampledata_xml_QID_both_insertpoint2 -->')
            {
				#get template of new xml section to be added
                $rowstotransform = Get-Content -Path ".\$templatedirectory\sampledata_xml_textfieldQ_template_insertpoint2.txt"
                #transform new rows to be added
				$transformedrows = %{ $rowstotransform -replace 'QIDReplace',$dataset[$currentrow].("QID")}
                #Inject new info into row
                $transformedrows
                #Replace update flag
                #$_
            }
            if($_ -match '<!-- sampledata_xml_QID_response_insertpoint3 -->')
            {
				#get template of new xml section to be added
                $rowstotransform = Get-Content -Path ".\$templatedirectory\sampledata_xml_textfieldQ_template_insertpoint3.txt"
                #transform new rows to be added
				$transformedrows = %{ $rowstotransform -replace 'QIDReplace',$dataset[$currentrow].("QID")}
                #Inject new info into row
                $transformedrows
                #Replace update flag
                $_
            }
            else # If line doesn't matches regex
            {
                # Output current line to pipeline - leave it as it is
                $_
            }
        }

    # Write content of $NewContent varibale back to file
    $NewContent | Out-File -FilePath .\$outputdirectory\sampledata.xml -Encoding Default -Force
}

#Schema1_xsd
Function Update_Schema1_Xsd_YesNoQ
{
    # Function for updating file schema1.xsd
    # Processes lines of text from file and assign result to $NewContent variable
    $NewContent = Get-Content -Path .\$outputdirectory\schema1.xsd |
        ForEach-Object {
            # If line matches regex
            if($_ -match '<!-- schema1_xsd_QID_both_insertpoint1 -->')
            {
				#get template of new xml section to be added
                $rowstotransform = Get-Content -Path ".\$templatedirectory\schema1_xsd_yesnoQ_template_insertpoint1.txt"
                #transform new rows to be added
				$transformedrows = %{ $rowstotransform -replace 'QIDReplace',$dataset[$currentrow].("QID")}
                #Inject new info into row
                $transformedrows
                #Don't replace update flag because of second 'if', uncomment if only a single 'if'
                #$_
            }
            if($_ -match '<!-- schema1_xsd_QID_both_insertpoint2 -->')
            {
				#get template of new xml section to be added
                $rowstotransform = Get-Content -Path ".\$templatedirectory\schema1_xsd_yesnoQ_template_insertpoint2.txt"
                #transform new rows to be added
				$transformedrows = %{ $rowstotransform -replace 'QIDReplace',$dataset[$currentrow].("QID")}
                #Inject new info into row
                $transformedrows
                #Replace update flag
                $_
            }
            else # If line doesn't matches regex
            {
                # Output current line to pipeline - leave it as it is
                $_
            }
        }

    # Write content of $NewContent varibale back to file
    $NewContent | Out-File -FilePath .\$outputdirectory\schema1.xsd -Encoding Default -Force
}

Function Update_Schema1_Xsd_AllMostSomeNoneQ
{
    # Function for updating file schema1.xsd
    # Processes lines of text from file and assign result to $NewContent variable
    $NewContent = Get-Content -Path .\$outputdirectory\schema1.xsd |
        ForEach-Object {
            # If line matches regex
            if($_ -match '<!-- schema1_xsd_QID_both_insertpoint1 -->')
            {
				#get template of new xml section to be added
                $rowstotransform = Get-Content -Path ".\$templatedirectory\schema1_xsd_allmostsomenoneQ_template_insertpoint1.txt"
                #transform new rows to be added
				$transformedrows = %{ $rowstotransform -replace 'QIDReplace',$dataset[$currentrow].("QID")}
                #Inject new info into row
                $transformedrows
                #Don't replace update flag because of second 'if', uncomment if only a single 'if'
                #$_
            }
            if($_ -match '<!-- schema1_xsd_QID_both_insertpoint2 -->')
            {
				#get template of new xml section to be added
                $rowstotransform = Get-Content -Path ".\$templatedirectory\schema1_xsd_allmostsomenoneQ_template_insertpoint2.txt"
                #transform new rows to be added
				$transformedrows = %{ $rowstotransform -replace 'QIDReplace',$dataset[$currentrow].("QID")}
                #Inject new info into row
                $transformedrows
                #Replace update flag
                $_
            }
            else # If line doesn't matches regex
            {
                # Output current line to pipeline - leave it as it is
                $_
            }
        }

    # Write content of $NewContent varibale back to file
    $NewContent | Out-File -FilePath .\$outputdirectory\schema1.xsd -Encoding Default -Force
}

Function Update_Schema1_Xsd_TextFieldQ
{
    # Function for updating file schema1.xsd
    # Processes lines of text from file and assign result to $NewContent variable
    $NewContent = Get-Content -Path .\$outputdirectory\schema1.xsd |
        ForEach-Object {
            # If line matches regex
            if($_ -match '<!-- schema1_xsd_QID_both_insertpoint1 -->')
            {
				#get template of new xml section to be added
                $rowstotransform = Get-Content -Path ".\$templatedirectory\schema1_xsd_textfieldQ_template_insertpoint1.txt"
                #transform new rows to be added
				$transformedrows = %{ $rowstotransform -replace 'QIDReplace',$dataset[$currentrow].("QID")}
                #Inject new info into row
                $transformedrows
                #Don't replace update flag because of second 'if', uncomment if only a single 'if'
                #$_
            }
            if($_ -match '<!-- schema1_xsd_QID_both_insertpoint2 -->')
            {
				#get template of new xml section to be added
                $rowstotransform = Get-Content -Path ".\$templatedirectory\schema1_xsd_textfieldQ_template_insertpoint2.txt"
                #transform new rows to be added
				$transformedrows = %{ $rowstotransform -replace 'QIDReplace',$dataset[$currentrow].("QID")}
                #Inject new info into row
                $transformedrows
                #Replace update flag
                $_
            }
            else # If line doesn't matches regex
            {
                # Output current line to pipeline - leave it as it is
                $_
            }
        }

    # Write content of $NewContent varibale back to file
    $NewContent | Out-File -FilePath .\$outputdirectory\schema1.xsd -Encoding Default -Force
}

#Schema4_xsd
Function Update_schema4_Xsd_YesNoQ
{
    # Function for updating file schema4.xsd
    # Processes lines of text from file and assign result to $NewContent variable
    $NewContent = Get-Content -Path .\$outputdirectory\schema4.xsd |
        ForEach-Object {
            # If line matches regex
            if($_ -match '<!-- schema4_xsd_QID_response_insertpoint1 -->')
            {
				#get template of new xml section to be added
                $rowstotransform = Get-Content -Path ".\$templatedirectory\schema4_xsd_yesnoQ_template_insertpoint1.txt"
                #transform new rows to be added
				$transformedrows = %{ $rowstotransform -replace 'QIDReplace',$dataset[$currentrow].("QID")}
                #Inject new info into row
                $transformedrows
                #Don't replace update flag because of second 'if', uncomment if only a single 'if'
                #$_
            }
            if($_ -match '<!-- schema4_xsd_QID_response_insertpoint2 -->')
            {
				#get template of new xml section to be added
                $rowstotransform = Get-Content -Path ".\$templatedirectory\schema4_xsd_yesnoQ_template_insertpoint2.txt"
                #transform new rows to be added
				$transformedrows = %{ $rowstotransform -replace 'QIDReplace',$dataset[$currentrow].("QID")}
                #Inject new info into row
                $transformedrows
                #Replace update flag
                $_
            }
            else # If line doesn't matches regex
            {
                # Output current line to pipeline - leave it as it is
                $_
            }
        }

    # Write content of $NewContent varibale back to file
    $NewContent | Out-File -FilePath .\$outputdirectory\schema4.xsd -Encoding Default -Force
}

Function Update_schema4_Xsd_AllMostSomeNoneQ
{
    # Function for updating file schema4.xsd
    # Processes lines of text from file and assign result to $NewContent variable
    $NewContent = Get-Content -Path .\$outputdirectory\schema4.xsd |
        ForEach-Object {
            # If line matches regex
            if($_ -match '<!-- schema4_xsd_QID_response_insertpoint1 -->')
            {
				#get template of new xml section to be added
                $rowstotransform = Get-Content -Path ".\$templatedirectory\schema4_xsd_allmostsomenoneQ_template_insertpoint1.txt"
                #transform new rows to be added
				$transformedrows = %{ $rowstotransform -replace 'QIDReplace',$dataset[$currentrow].("QID")}
                #Inject new info into row
                $transformedrows
                #Don't replace update flag because of second 'if', uncomment if only a single 'if'
                #$_
            }
            if($_ -match '<!-- schema4_xsd_QID_response_insertpoint2 -->')
            {
				#get template of new xml section to be added
                $rowstotransform = Get-Content -Path ".\$templatedirectory\schema4_xsd_allmostsomenoneQ_template_insertpoint2.txt"
                #transform new rows to be added
				$transformedrows = %{ $rowstotransform -replace 'QIDReplace',$dataset[$currentrow].("QID")}
                #Inject new info into row
                $transformedrows
                #Replace update flag
                $_
            }
            else # If line doesn't matches regex
            {
                # Output current line to pipeline - leave it as it is
                $_
            }
        }

    # Write content of $NewContent varibale back to file
    $NewContent | Out-File -FilePath .\$outputdirectory\schema4.xsd -Encoding Default -Force
}

Function Update_schema4_Xsd_TextFieldQ
{
    # Function for updating file schema4.xsd
    # Processes lines of text from file and assign result to $NewContent variable
    $NewContent = Get-Content -Path .\$outputdirectory\schema4.xsd |
        ForEach-Object {
            # If line matches regex
            if($_ -match '<!-- schema4_xsd_QID_response_insertpoint1 -->')
            {
				#get template of new xml section to be added
                $rowstotransform = Get-Content -Path ".\$templatedirectory\schema4_xsd_allmostsomenoneQ_template_insertpoint1.txt"
                #transform new rows to be added
				$transformedrows = %{ $rowstotransform -replace 'QIDReplace',$dataset[$currentrow].("QID")}
                #Inject new info into row
                $transformedrows
                #Don't replace update flag because of second 'if', uncomment if only a single 'if'
                #$_
            }
            if($_ -match '<!-- schema4_xsd_QID_response_insertpoint2 -->')
            {
				#get template of new xml section to be added
                $rowstotransform = Get-Content -Path ".\$templatedirectory\schema4_xsd_allmostsomenoneQ_template_insertpoint2.txt"
                #transform new rows to be added
				$transformedrows = %{ $rowstotransform -replace 'QIDReplace',$dataset[$currentrow].("QID")}
                #Inject new info into row
                $transformedrows
                #Replace update flag
                $_
            }
            else # If line doesn't matches regex
            {
                # Output current line to pipeline - leave it as it is
                $_
            }
        }

    # Write content of $NewContent varibale back to file
    $NewContent | Out-File -FilePath .\$outputdirectory\schema4.xsd -Encoding Default -Force
}

#Template_xml
Function Update_Template_Xml_YesNoQ
{
    # Function for updating file template.xml
    # Processes lines of text from file and assign result to $NewContent variable
    $NewContent = Get-Content -Path .\$outputdirectory\template.xml |
        ForEach-Object {
            # If line matches regex
            if($_ -match '<!-- template_xml_QID_response_insertpoint1 -->')
            {
				#get template of new xml section to be added
                $rowstotransform = Get-Content -Path ".\$templatedirectory\template_xml_yesnoQ_template_insertpoint1.txt"
                #transform new rows to be added
				$transformedrows = %{ $rowstotransform -replace 'QIDReplace',$dataset[$currentrow].("QID")}
                #Inject new info into row
                $transformedrows
                #Don't replace update flag because of second 'if', uncomment if only a single 'if'
                #$_
            }
            if($_ -match '<!-- template_xml_QID_both_insertpoint2 -->')
            {
				#get template of new xml section to be added
                $rowstotransform = Get-Content -Path ".\$templatedirectory\template_xml_yesnoQ_template_insertpoint2.txt"
                #transform new rows to be added
				$transformedrows = %{ $rowstotransform -replace 'QIDReplace',$dataset[$currentrow].("QID")}
                #Inject new info into row
                $transformedrows
                #Replace update flag
                $_
            }
            else # If line doesn't matches regex
            {
                # Output current line to pipeline - leave it as it is
                $_
            }
        }

    # Write content of $NewContent varibale back to file
    $NewContent | Out-File -FilePath .\$outputdirectory\template.xml -Encoding Default -Force
}

Function Update_Template_Xml_AllMostSomeNoneQ
{
    # Function for updating file template.xml
    # Processes lines of text from file and assign result to $NewContent variable
    $NewContent = Get-Content -Path .\$outputdirectory\template.xml |
        ForEach-Object {
            # If line matches regex
            if($_ -match '<!-- template_xml_QID_response_insertpoint1 -->')
            {
				#get template of new xml section to be added
                $rowstotransform = Get-Content -Path ".\$templatedirectory\template_xml_allmostsomenoneQ_template_insertpoint1.txt"
                #transform new rows to be added
				$transformedrows = %{ $rowstotransform -replace 'QIDReplace',$dataset[$currentrow].("QID")}
                #Inject new info into row
                $transformedrows
                #Don't replace update flag because of second 'if', uncomment if only a single 'if'
                #$_
            }
            if($_ -match '<!-- template_xml_QID_both_insertpoint2 -->')
            {
				#get template of new xml section to be added
                $rowstotransform = Get-Content -Path ".\$templatedirectory\template_xml_allmostsomenoneQ_template_insertpoint2.txt"
                #transform new rows to be added
				$transformedrows = %{ $rowstotransform -replace 'QIDReplace',$dataset[$currentrow].("QID")}
                #Inject new info into row
                $transformedrows
                #Replace update flag
                $_
            }
            else # If line doesn't matches regex
            {
                # Output current line to pipeline - leave it as it is
                $_
            }
        }

    # Write content of $NewContent varibale back to file
    $NewContent | Out-File -FilePath .\$outputdirectory\template.xml -Encoding Default -Force
}

Function Update_Template_Xml_TextFieldQ
{
    # Function for updating file template.xml
    # Processes lines of text from file and assign result to $NewContent variable
    $NewContent = Get-Content -Path .\$outputdirectory\template.xml |
        ForEach-Object {
            # If line matches regex
            if($_ -match '<!-- template_xml_QID_response_insertpoint1 -->')
            {
				#get template of new xml section to be added
                $rowstotransform = Get-Content -Path ".\$templatedirectory\template_xml_textfieldQ_template_insertpoint1.txt"
                #transform new rows to be added
				$transformedrows = %{ $rowstotransform -replace 'QIDReplace',$dataset[$currentrow].("QID")}
                #Inject new info into row
                $transformedrows
                #Don't replace update flag because of second 'if', uncomment if only a single 'if'
                #$_
            }
            if($_ -match '<!-- template_xml_QID_both_insertpoint2 -->')
            {
				#get template of new xml section to be added
                $rowstotransform = Get-Content -Path ".\$templatedirectory\template_xml_textfieldQ_template_insertpoint2.txt"
                #transform new rows to be added
				$transformedrows = %{ $rowstotransform -replace 'QIDReplace',$dataset[$currentrow].("QID")}
                #Inject new info into row
                $transformedrows
                #Replace update flag
                $_
            }
            else # If line doesn't matches regex
            {
                # Output current line to pipeline - leave it as it is
                $_
            }
        }

    # Write content of $NewContent varibale back to file
    $NewContent | Out-File -FilePath .\$outputdirectory\template.xml -Encoding Default -Force
}

#Upgrade_xsl
Function Update_Upgrade_Xsl_YesNoQ
{
    # Function for updating file template.xml
    # Processes lines of text from file and assign result to $NewContent variable
    $NewContent = Get-Content -Path .\$outputdirectory\upgrade.xsl |
        ForEach-Object {
            # If line matches regex
            if($_ -match '<!-- upgrade_xsl_QID_response_insertpoint1 -->')
            {
				#get template of new xml section to be added
                $rowstotransform = Get-Content -Path ".\$templatedirectory\upgrade_xsl_yesnoQ_template_insertpoint1.txt"
                #transform new rows to be added
				$transformedrows = %{ $rowstotransform -replace 'QIDReplace',$dataset[$currentrow].("QID")}
                #Inject new info into row
                $transformedrows
                #Don't replace update flag because of second 'if', uncomment if only a single 'if'
                #$_
            }
            if($_ -match '<!-- upgrade_xsl_QID_both_insertpoint2 -->')
            {
				#get template of new xml section to be added
                $rowstotransform = Get-Content -Path ".\$templatedirectory\upgrade_xsl_yesnoQ_template_insertpoint2.txt"
                #transform new rows to be added
				$transformedrows = %{ $rowstotransform -replace 'QIDReplace',$dataset[$currentrow].("QID")}
                #Inject new info into row
                $transformedrows
                #Replace update flag
                $_
            }
            else # If line doesn't matches regex
            {
                # Output current line to pipeline - leave it as it is
                $_
            }
        }

    # Write content of $NewContent varibale back to file
    $NewContent | Out-File -FilePath .\$outputdirectory\upgrade.xsl -Encoding Default -Force
}

Function Update_Upgrade_Xsl_AllMostSomeNoneQ
{
    # Function for updating file template.xml
    # Processes lines of text from file and assign result to $NewContent variable
    $NewContent = Get-Content -Path .\$outputdirectory\upgrade.xsl |
        ForEach-Object {
            # If line matches regex
            if($_ -match '<!-- upgrade_xsl_QID_response_insertpoint1 -->')
            {
				#get template of new xml section to be added
                $rowstotransform = Get-Content -Path ".\$templatedirectory\upgrade_xsl_AllMostSomeNoneQ_template_insertpoint1.txt"
                #transform new rows to be added
				$transformedrows = %{ $rowstotransform -replace 'QIDReplace',$dataset[$currentrow].("QID")}
                #Inject new info into row
                $transformedrows
                #Don't replace update flag because of second 'if', uncomment if only a single 'if'
                #$_
            }
            if($_ -match '<!-- upgrade_xsl_QID_both_insertpoint2 -->')
            {
				#get template of new xml section to be added
                $rowstotransform = Get-Content -Path ".\$templatedirectory\upgrade_xsl_AllMostSomeNoneQ_template_insertpoint2.txt"
                #transform new rows to be added
				$transformedrows = %{ $rowstotransform -replace 'QIDReplace',$dataset[$currentrow].("QID")}
                #Inject new info into row
                $transformedrows
                #Replace update flag
                $_
            }
            else # If line doesn't matches regex
            {
                # Output current line to pipeline - leave it as it is
                $_
            }
        }

    # Write content of $NewContent varibale back to file
    $NewContent | Out-File -FilePath .\$outputdirectory\upgrade.xsl -Encoding Default -Force
}

Function Update_Upgrade_Xsl_TextFieldQ
{
    # Function for updating file template.xml
    # Processes lines of text from file and assign result to $NewContent variable
    $NewContent = Get-Content -Path .\$outputdirectory\upgrade.xsl |
        ForEach-Object {
            # If line matches regex
            if($_ -match '<!-- upgrade_xsl_QID_response_insertpoint1 -->')
            {
				#get template of new xml section to be added
                $rowstotransform = Get-Content -Path ".\$templatedirectory\upgrade_xsl_textfieldQ_template_insertpoint1.txt"
                #transform new rows to be added
				$transformedrows = %{ $rowstotransform -replace 'QIDReplace',$dataset[$currentrow].("QID")}
                #Inject new info into row
                $transformedrows
                #Don't replace update flag because of second 'if', uncomment if only a single 'if'
                #$_
            }
            if($_ -match '<!-- upgrade_xsl_QID_both_insertpoint2 -->')
            {
				#get template of new xml section to be added
                $rowstotransform = Get-Content -Path ".\$templatedirectory\upgrade_xsl_textfieldQ_template_insertpoint2.txt"
                #transform new rows to be added
				$transformedrows = %{ $rowstotransform -replace 'QIDReplace',$dataset[$currentrow].("QID")}
                #Inject new info into row
                $transformedrows
                #Replace update flag
                $_
            }
            else # If line doesn't matches regex
            {
                # Output current line to pipeline - leave it as it is
                $_
            }
        }

    # Write content of $NewContent varibale back to file
    $NewContent | Out-File -FilePath .\$outputdirectory\upgrade.xsl -Encoding Default -Force
}

#View1_xsl
Function Update_View1_Xsl_YesNoQ
{
    # Function for updating file template.xml
    # Processes lines of text from file and assign result to $NewContent variable
    $NewContent = Get-Content -Path .\$outputdirectory\view1.xsl |
        ForEach-Object {
            # If line matches regex
            if($_ -match '<!-- view1_xsl_QID_all_insertpoint1 -->')
            {
				#get template of new xml section to be added
                $rowstotransform = Get-Content -Path ".\$templatedirectory\view1_xsl_yesnoQ_template_insertpoint1.txt"
                #transform new rows to be added
				$transformedrows = %{ $rowstotransform -replace 'QIDReplace',$dataset[$currentrow].("QID") -replace 'ITEMReplace',$dataset[$currentrow].("ITEM") -replace 'DetailReplace',$dataset[$currentrow].("Detail")}
                #Inject new info into row
                $transformedrows
                #Don't replace update flag because of second 'if', uncomment if only a single 'if'
                $_
            }
            else # If line doesn't matches regex
            {
                # Output current line to pipeline - leave it as it is
                $_
            }
        }

    # Write content of $NewContent varibale back to file
    $NewContent | Out-File -FilePath .\$outputdirectory\view1.xsl -Encoding Default -Force
}

Function Update_View1_Xsl_AllMostSomeNoneQ
{
    # Function for updating file template.xml
    # Processes lines of text from file and assign result to $NewContent variable
    $NewContent = Get-Content -Path .\$outputdirectory\view1.xsl |
        ForEach-Object {
            # If line matches regex
            if($_ -match '<!-- view1_xsl_QID_all_insertpoint1 -->')
            {
				#get template of new xml section to be added
                $rowstotransform = Get-Content -Path ".\$templatedirectory\view1_xsl_AllMostSomeNoneQ_template_insertpoint1.txt"
                #transform new rows to be added
				$transformedrows = %{ $rowstotransform -replace 'QIDReplace',$dataset[$currentrow].("QID") -replace 'ITEMReplace',$dataset[$currentrow].("ITEM") -replace 'DetailReplace',$dataset[$currentrow].("Detail")}
                #Inject new info into row
                $transformedrows
                #Don't replace update flag because of second 'if', uncomment if only a single 'if'
                $_
            }
            else # If line doesn't matches regex
            {
                # Output current line to pipeline - leave it as it is
                $_
            }
        }

    # Write content of $NewContent varibale back to file
    $NewContent | Out-File -FilePath .\$outputdirectory\view1.xsl -Encoding Default -Force
}

Function Update_View1_Xsl_TextFieldQ
{
    # Function for updating file template.xml
    # Processes lines of text from file and assign result to $NewContent variable
    $NewContent = Get-Content -Path .\$outputdirectory\view1.xsl |
        ForEach-Object {
            # If line matches regex
            if($_ -match '<!-- view1_xsl_QID_all_insertpoint1 -->')
            {
				#get template of new xml section to be added
                $rowstotransform = Get-Content -Path ".\$templatedirectory\view1_xsl_TextFieldQ_template_insertpoint1.txt"
                #transform new rows to be added
				$transformedrows = %{ $rowstotransform -replace 'QIDReplace',$dataset[$currentrow].("QID") -replace 'ITEMReplace',$dataset[$currentrow].("ITEM") -replace 'DetailReplace',$dataset[$currentrow].("Detail")}
                #Inject new info into row
                $transformedrows
                #Don't replace update flag because of second 'if', uncomment if only a single 'if'
                $_
            }
            else # If line doesn't matches regex
            {
                # Output current line to pipeline - leave it as it is
                $_
            }
        }

    # Write content of $NewContent varibale back to file
    $NewContent | Out-File -FilePath .\$outputdirectory\view1.xsl -Encoding Default -Force
}


#=================================================================================
#Start of real script
#=================================================================================
#set global variables
$inputcsvfile = "auditquestions-cleaned-10rows.csv"
$currentrow = 0
$templatedirectory = 'TemplateFiles'
$outputdirectory = 'scriptoutput-10rows'

#setup stuff on Infopath files side
Create_Output_Directory
Copy_Initial_Template_Files

#setup sharepoint


#data load
$dataset = import-csv "$inputcsvfile"

#recursively go through questions list, taking actions to update appropriate files depending on question type
#Notes:
#Schema.xsd - don't seem to need any fields updated - raw template copy is sufficient
#Schema2.xsd - don't seem to need any fields updated - raw template copy is sufficient
#Schema3.xsd - don't seem to need any fields updated - raw template copy is sufficient


switch($dataset."Qtype")
{
    'YesNo'
    {
    #Update all Infopath files for YesNo questions
    Update_Choices_Data_Connection_Xsd_YesNoQ
    Update_Choices_Xml_YesNoQ
    Update_Manifest_Xsf_YesNoQ
    Update_Sampledata_Xml_YesNoQ
    Update_Schema1_Xsd_YesNoQ
    Update_Schema4_Xsd_YesNoQ
    Update_Template_Xml_YesNoQ
    Update_Upgrade_Xsl_YesNoQ
    Update_View1_Xsl_YesNoQ
    Write-Output "YesNo row completed"
    $currentrow++
    continue
    }

    'AllMostSomeNone'
    {
    #Update all Infopath files for AllMostSomeNone questions
    Update_Choices_Data_Connection_Xsd_AllMostSomeNoneQ
    Update_Choices_Xml_AllMostSomeNoneQ
    Update_Manifest_Xsf_AllMostSomeNoneQ
    Update_Sampledata_Xml_AllMostSomeNoneQ
    Update_Schema1_Xsd_AllMostSomeNoneQ
    Update_Schema4_Xsd_AllMostSomeNoneQ
    Update_Template_Xml_AllMostSomeNoneQ
    Update_Upgrade_Xsl_AllMostSomeNoneQ
    Update_View1_Xsl_AllMostSomeNoneQ
    Write-Output "AllMostSomeNone row completed"
    $currentrow++
    continue
    }

    'TextField'
    {
    #Update all Infopath files for TextField questions
    Update_Choices_Data_Connection_Xsd_TextFieldQ
    Update_Choices_Xml_TextFieldQ
    Update_Manifest_Xsf_TextFieldQ
    Update_Sampledata_Xml_TextFieldQ
    Update_Schema1_Xsd_TextFieldQ
    Update_Schema4_Xsd_TextFieldQ
    Update_Template_Xml_TextFieldQ
    Update_Upgrade_Xsl_TextFieldQ
    Update_View1_Xsl_TextFieldQ
    Write-Output "Textfield case row completed"
    $currentrow++
    continue
    }
}
