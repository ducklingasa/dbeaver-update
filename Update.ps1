Function Get-RedirectedUrl {

    Param (
        [Parameter(Mandatory=$true)]
        [String]$URL
    )

    $request = [System.Net.WebRequest]::Create($url)
    $request.AllowAutoRedirect=$false
    $response=$request.GetResponse()

    If ($response.StatusCode -eq "Found")
    {
        $response.GetResponseHeader("Location")
    }
}

$source = 'https://dbeaver.io/files/dbeaver-ce-latest-win32.win32.x86_64.zip';
$destination = '.\.update\dbeaver-ce-latest-win32.win32.x86_64.zip';

If ([System.IO.File]::Exists(".\.eclipseproduct")) 
{
    $status = [IO.File]::ReadAllText(".\.eclipseproduct") -match '(?<=(version=))[0-9.]+'
}
Else
{
    $status = $false
}
$current_ver = ''
If ($status)
{
    $current_ver = $Matches.Item(0)
}

$status = (Get-RedirectedUrl $source) -match '(?<=(ce-))[0-9.]+(?=(-))'
$new_ver = ''
If ($status)
{
    $new_ver = $Matches.Item(0)
}

If ($new_ver -ne $current_ver)
{
    $client = New-Object System.Net.WebClient;
    $client.UseDefaultCredentials = $true;
    $client.DownloadFile($source, $destination);
    Write-Output "Download completed!"
    'version=' + $Matches.Item(0) | Out-File -FilePath .\new_version.txt -NoNewline -Encoding ASCII
}
Else
{
    Write-Output "Download skipped!"
}
