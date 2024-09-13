[CmdletBinding()]
param(
  [switch]$eXnXvGIj99,
  [switch]$sAotqZsQ99,
  [switch]$Excel
)
function viols {
  param(
    [string]$title
  )
  if (($title | Select-String -AllMatches -Pattern 'KB(\d{4,6})').Matches.Value) {
    return (($title | Select-String -AllMatches -Pattern 'KB(\d{4,6})').Matches.Value)
  }
  elseif (($title | Select-String -NotMatch -Pattern 'KB(\d{4,6})').Matches.Value) {
    return (($title | Select-String -NotMatch -Pattern 'KB(\d{4,6})').Matches.Value)
  }
}
Function thresholds {
  param(
    $evhWBoxI99, $jAoGwlGN99)
  if ($null -ne $evhWBoxI99) {
    try {
      $UIJiiHGW99 = Get-Acl $evhWBoxI99 -ErrorAction SilentlyContinue
    }
    catch { $null }
    
    if ($UIJiiHGW99) { 
      $PQLLYjAm99 = @()
      $PQLLYjAm99 += "$env:COMPUTERNAME\$env:USERNAME"
      if ($UIJiiHGW99.Owner -like $PQLLYjAm99 ) { Write-Host "$PQLLYjAm99 has ownership of $evhWBoxI99" -ForegroundColor Red }
      whoami.exe /groups /fo csv | ConvertFrom-Csv | Select-Object -ExpandProperty 'group name' | ForEach-Object { $PQLLYjAm99 += $_ }
      $xfMSQnLy99 = $false
      foreach ($i in $PQLLYjAm99) {
        $pWmguGNr99 = $UIJiiHGW99.Access | Where-Object { $_.IdentityReference -like $i }
        $JGhcLZIS99 = ""
        switch -WildCard ($pWmguGNr99.FileSystemRights) {
          "FullControl" { $JGhcLZIS99 = "FullControl"; $xfMSQnLy99 = $true }
          "Write*" { $JGhcLZIS99 = "Write"; $xfMSQnLy99 = $true }
          "Modify" { $JGhcLZIS99 = "Modify"; $xfMSQnLy99 = $true }
        }
        Switch ($pWmguGNr99.RegistryRights) {
          "FullControl" { $JGhcLZIS99 = "FullControl"; $xfMSQnLy99 = $true }
        }
        if ($JGhcLZIS99) {
          if ($jAoGwlGN99) { Write-Host "$jAoGwlGN99 found with permissions issue:" -ForegroundColor Red }
          Write-Host -ForegroundColor red  "Identity $($pWmguGNr99.IdentityReference) has '$JGhcLZIS99' perms for $evhWBoxI99"
        }
      }    
      if ($xfMSQnLy99 -eq $false) {
        if ($evhWBoxI99.Length -gt 3) {
          $evhWBoxI99 = Split-Path $evhWBoxI99
          thresholds $evhWBoxI99 -jAoGwlGN99 $jAoGwlGN99
        }
      }
    }
    else {
      $evhWBoxI99 = Split-Path $evhWBoxI99
      thresholds $evhWBoxI99 $jAoGwlGN99
    }
  }
}
Function ranches {
  Write-Host "Fetching the list of services, this may take a while...";
  $HQLFFRdy99 = Get-WmiObject -Class Win32_Service | Where-Object { $_.PathName -inotmatch "`"" -and $_.PathName -inotmatch ":\\Windows\\" -and ($_.StartMode -eq "Auto" -or $_.StartMode -eq "Manual") -and ($_.State -eq "Running" -or $_.State -eq "Stopped") };
  if ($($HQLFFRdy99 | Measure-Object).Count -lt 1) {
    Write-Host "No unquoted service paths were found";
  }
  else {
    $HQLFFRdy99 | ForEach-Object {
      Write-Host "Unquoted Service Path found!" -ForegroundColor red
      Write-Host Name: $_.Name
      Write-Host PathName: $_.PathName
      Write-Host StartName: $_.StartName 
      Write-Host StartMode: $_.StartMode
      Write-Host Running: $_.State
    } 
  }
}
function TimeElapsed { Write-Host "Time Running: $($PGoVzbDo99.Elapsed.Minutes):$($PGoVzbDo99.Elapsed.Seconds)" }
Function geezers {
  Add-Type -AssemblyName PresentationCore
  $text = [Windows.Clipboard]::GetText()
  if ($text) {
    Write-Host ""
    if ($eXnXvGIj99) { TimeElapsed }
    Write-Host -ForegroundColor Blue "=========|| ClipBoard text found:"
    Write-Host $text
    
  }
}
Function Morgan {
  [cmdletbinding()]
  Param (
      [parameter(Mandatory, ValueFromPipeline)]
      [ValidateScript({
          Try {
              If (Test-Path -Path $_) {$True}
              Else {Throw "$($_) is not a valid path!"}
          }
          Catch {
              Throw $_
          }
      })]
      [string]$jyBFQPPE99,
      [parameter(Mandatory)]
      [string]$gGVzLmjQ99
  )
  $Excel = New-Object -ComObject Excel.Application
  Try {
      $jyBFQPPE99 = Convert-Path $jyBFQPPE99
  }
  Catch {
      Write-Warning "Unable locate full path of $($jyBFQPPE99)"
      BREAK
  }
  $LRApzuDB99 = $Excel.Workbooks.Open($jyBFQPPE99)
  ForEach ($SYjrefPi99 in @($LRApzuDB99.Sheets)) {
      $Found = $SYjrefPi99.Cells.Find($gGVzLmjQ99)
      If ($Found) {
        try{  
          Write-Host "Pattern: '$gGVzLmjQ99' found in $jyBFQPPE99" -ForegroundColor Blue
          $DShtjVpP99 = $Found.Address(0,0,1,1)
          [pscustomobject]@{
              WorkSheet = $SYjrefPi99.Name
              Column = $Found.Column
              Row =$Found.Row
              TextMatch = $Found.Text
              Address = $DShtjVpP99
          }
          Do {
              $Found = $SYjrefPi99.Cells.FindNext($Found)
              $KGlTpHtA99 = $Found.Address(0,0,1,1)
              If ($KGlTpHtA99 -eq $DShtjVpP99) {
                Write-host "Address is same as Begin Address"
                  BREAK
              }
              [pscustomobject]@{
                  WorkSheet = $SYjrefPi99.Name
                  Column = $Found.Column
                  Row =$Found.Row
                  TextMatch = $Found.Text
                  Address = $KGlTpHtA99
              }                 
          } Until ($False)
        }
        catch {
        }
      }
  }
  try{
  $LRApzuDB99.close($False)
  [void][System.Runtime.InteropServices.Marshal]::ReleaseComObject([System.__ComObject]$excel)
  [gc]::Collect()
  [gc]::WaitForPendingFinalizers()
  }
  catch{
  }
  Remove-Variable excel -ErrorAction SilentlyContinue
}
function Write-Color([String[]]$Text, [ConsoleColor[]]$Color) {
  for ($i = 0; $i -lt $Text.Length; $i++) {
    Write-Host $Text[$i] -Foreground $Color[$i] -NoNewline
  }
  Write-Host
}
Write-Color ",/*,..*(((((((((((((((((((((((((((((((((," -Color Green
Write-Color ",*/((((((((((((((((((/,  .*//((//**, .*((((((*" -Color Green
Write-Color "((((((((((((((((", "* *****,,,", "\########## .(* ,((((((" -Color Green, Blue, Green
Write-Color "(((((((((((", "/*******************", "####### .(. ((((((" -Color Green, Blue, Green
Write-Color "(((((((", "/******************", "/@@@@@/", "***", "\#######\((((((" -Color Green, Blue, White, Blue, Green
Write-Color ",,..", "**********************", "/@@@@@@@@@/", "***", ",#####.\/(((((" -Color Green, Blue, White, Blue, Green
Write-Color ", ,", "**********************", "/@@@@@+@@@/", "*********", "##((/ /((((" -Color Green, Blue, White, Blue, Green
Write-Color "..(((##########", "*********", "/#@@@@@@@@@/", "*************", ",,..((((" -Color Green, Blue, White, Blue, Green
Write-Color ".(((################(/", "******", "/@@@@@/", "****************", ".. /((" -Color Green, Blue, White, Blue, Green
Write-Color ".((########################(/", "************************", "..*(" -Color Green, Blue, Green
Write-Color ".((#############################(/", "********************", ".,(" -Color Green, Blue, Green
Write-Color ".((##################################(/", "***************", "..(" -Color Green, Blue, Green
Write-Color ".((######################################(/", "***********", "..(" -Color Green, Blue, Green
Write-Color ".((######", "(,.***.,(", "###################", "(..***", "(/*********", "..(" -Color Green, Green, Green, Green, Blue, Green
Write-Color ".((######*", "(####((", "###################", "((######", "/(********", "..(" -Color Green, Green, Green, Green, Blue, Green
Write-Color ".((##################", "(/**********(", "################(**...(" -Color Green, Green, Green
Write-Color ".(((####################", "/*******(", "###################.((((" -Color Green, Green, Green
Write-Color ".(((((############################################/  /((" -Color Green
Write-Color "..(((((#########################################(..(((((." -Color Green
Write-Color "....(((((#####################################( .((((((." -Color Green
Write-Color "......(((((#################################( .(((((((." -Color Green
Write-Color "(((((((((. ,(############################(../(((((((((." -Color Green
Write-Color "  (((((((((/,  ,####################(/..((((((((((." -Color Green
Write-Color "        (((((((((/,.  ,*//////*,. ./(((((((((((." -Color Green
Write-Color "           (((((((((((((((((((((((((((/" -Color Green
Write-Color "          by PEASS-ng & RandolphConley" -Color Green
$CYoHAeBR99 = $true
$DffpUsSZ99 = $true
$SOwdckrV99 = $true
$DCCHnjuI99 = @{}
if ($CYoHAeBR99) {
  $DCCHnjuI99.add("Simple Passwords1", "pass.*[=:].+")
  $DCCHnjuI99.add("Simple Passwords2", "pwd.*[=:].+")
  $DCCHnjuI99.add("Apr1 MD5", '\$apr1\$[a-zA-Z0-9_/\.]{8}\$[a-zA-Z0-9_/\.]{22}')
  $DCCHnjuI99.add("Apache SHA", "\{SHA\}[0-9a-zA-Z/_=]{10,}")
  $DCCHnjuI99.add("Blowfish", '\$2[abxyz]?\$[0-9]{2}\$[a-zA-Z0-9_/\.]*')
  $DCCHnjuI99.add("Drupal", '\$S\$[a-zA-Z0-9_/\.]{52}')
  $DCCHnjuI99.add("Joomlavbulletin", "[0-9a-zA-Z]{32}:[a-zA-Z0-9_]{16,32}")
  $DCCHnjuI99.add("Linux MD5", '\$1\$[a-zA-Z0-9_/\.]{8}\$[a-zA-Z0-9_/\.]{22}')
  $DCCHnjuI99.add("phpbb3", '\$H\$[a-zA-Z0-9_/\.]{31}')
  $DCCHnjuI99.add("sha512crypt", '\$6\$[a-zA-Z0-9_/\.]{16}\$[a-zA-Z0-9_/\.]{86}')
  $DCCHnjuI99.add("Wordpress", '\$P\$[a-zA-Z0-9_/\.]{31}')
  $DCCHnjuI99.add("md5", "(^|[^a-zA-Z0-9])[a-fA-F0-9]{32}([^a-zA-Z0-9]|$)")
  $DCCHnjuI99.add("sha1", "(^|[^a-zA-Z0-9])[a-fA-F0-9]{40}([^a-zA-Z0-9]|$)")
  $DCCHnjuI99.add("sha256", "(^|[^a-zA-Z0-9])[a-fA-F0-9]{64}([^a-zA-Z0-9]|$)")
  $DCCHnjuI99.add("sha512", "(^|[^a-zA-Z0-9])[a-fA-F0-9]{128}([^a-zA-Z0-9]|$)")  
  $DCCHnjuI99.add("Base64", "(eyJ|YTo|Tzo|PD[89]|aHR0cHM6L|aHR0cDo|rO0)[a-zA-Z0-9+\/]+={0,2}")
}
if ($DffpUsSZ99) {
  $DCCHnjuI99.add("Usernames1", "username[=:].+")
  $DCCHnjuI99.add("Usernames2", "user[=:].+")
  $DCCHnjuI99.add("Usernames3", "login[=:].+")
  $DCCHnjuI99.add("Emails", "[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,6}")
  $DCCHnjuI99.add("Net user add", "net user .+ /add")
}
if ($sAotqZsQ99) {
  $DCCHnjuI99.add("Artifactory API Token", "AKC[a-zA-Z0-9]{10,}")
  $DCCHnjuI99.add("Artifactory Password", "AP[0-9ABCDEF][a-zA-Z0-9]{8,}")
  $DCCHnjuI99.add("Adafruit API Key", "([a-z0-9_-]{32})")
  $DCCHnjuI99.add("Adafruit API Key", "([a-z0-9_-]{32})")
  $DCCHnjuI99.add("Adobe Client Id (Oauth Web)", "(adobe[a-z0-9_ \.,\-]{0,25})(=|>|:=|\|\|:|<=|=>|:).{0,5}['""]([a-f0-9]{32})['""]")
  $DCCHnjuI99.add("Abode Client Secret", "(p8e-)[a-z0-9]{32}")
  $DCCHnjuI99.add("Age Secret Key", "AGE-SECRET-KEY-1[QPZRY9X8GF2TVDW0S3JN54KHCE6MUA7L]{58}")
  $DCCHnjuI99.add("Airtable API Key", "([a-z0-9]{17})")
  $DCCHnjuI99.add("Alchemi API Key", "(alchemi[a-z0-9_ \.,\-]{0,25})(=|>|:=|\|\|:|<=|=>|:).{0,5}['""]([a-zA-Z0-9-]{32})['""]")
  $DCCHnjuI99.add("Artifactory API Key & Password", "[""']AKC[a-zA-Z0-9]{10,}[""']|[""']AP[0-9ABCDEF][a-zA-Z0-9]{8,}[""']")
  $DCCHnjuI99.add("Atlassian API Key", "(atlassian[a-z0-9_ \.,\-]{0,25})(=|>|:=|\|\|:|<=|=>|:).{0,5}['""]([a-z0-9]{24})['""]")
  $DCCHnjuI99.add("Binance API Key", "(binance[a-z0-9_ \.,\-]{0,25})(=|>|:=|\|\|:|<=|=>|:).{0,5}['""]([a-zA-Z0-9]{64})['""]")
  $DCCHnjuI99.add("Bitbucket Client Id", "((bitbucket[a-z0-9_ \.,\-]{0,25})(=|>|:=|\|\|:|<=|=>|:).{0,5}['""]([a-z0-9]{32})['""])")
  $DCCHnjuI99.add("Bitbucket Client Secret", "((bitbucket[a-z0-9_ \.,\-]{0,25})(=|>|:=|\|\|:|<=|=>|:).{0,5}['""]([a-z0-9_\-]{64})['""])")
  $DCCHnjuI99.add("BitcoinAverage API Key", "(bitcoin.?average[a-z0-9_ \.,\-]{0,25})(=|>|:=|\|\|:|<=|=>|:).{0,5}['""]([a-zA-Z0-9]{43})['""]")
  $DCCHnjuI99.add("Bitquery API Key", "(bitquery[a-z0-9_ \.,\-]{0,25})(=|>|:=|\|\|:|<=|=>|:).{0,5}['""]([A-Za-z0-9]{32})['""]")
  $DCCHnjuI99.add("Bittrex Access Key and Access Key", "([a-z0-9]{32})")
  $DCCHnjuI99.add("Birise API Key", "(bitrise[a-z0-9_ \.,\-]{0,25})(=|>|:=|\|\|:|<=|=>|:).{0,5}['""]([a-zA-Z0-9_\-]{86})['""]")
  $DCCHnjuI99.add("Block API Key", "(block[a-z0-9_ \.,\-]{0,25})(=|>|:=|\|\|:|<=|=>|:).{0,5}['""]([a-z0-9]{4}-[a-z0-9]{4}-[a-z0-9]{4}-[a-z0-9]{4})['""]")
  $DCCHnjuI99.add("Blockchain API Key", "mainnet[a-zA-Z0-9]{32}|testnet[a-zA-Z0-9]{32}|ipfs[a-zA-Z0-9]{32}")
  $DCCHnjuI99.add("Blockfrost API Key", "(blockchain[a-z0-9_ \.,\-]{0,25})(=|>|:=|\|\|:|<=|=>|:).{0,5}['""]([a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[0-9a-f]{12})['""]")
  $DCCHnjuI99.add("Box API Key", "(box[a-z0-9_ \.,\-]{0,25})(=|>|:=|\|\|:|<=|=>|:).{0,5}['""]([a-zA-Z0-9]{32})['""]")
  $DCCHnjuI99.add("Bravenewcoin API Key", "(bravenewcoin[a-z0-9_ \.,\-]{0,25})(=|>|:=|\|\|:|<=|=>|:).{0,5}['""]([a-z0-9]{50})['""]")
  $DCCHnjuI99.add("Clearbit API Key", "sk_[a-z0-9]{32}")
  $DCCHnjuI99.add("Clojars API Key", "(CLOJARS_)[a-zA-Z0-9]{60}")
  $DCCHnjuI99.add("Coinbase Access Token", "([a-z0-9_-]{64})")
  $DCCHnjuI99.add("Coinlayer API Key", "(coinlayer[a-z0-9_ \.,\-]{0,25})(=|>|:=|\|\|:|<=|=>|:).{0,5}['""]([a-z0-9]{32})['""]")
  $DCCHnjuI99.add("Coinlib API Key", "(coinlib[a-z0-9_ \.,\-]{0,25})(=|>|:=|\|\|:|<=|=>|:).{0,5}['""]([a-z0-9]{16})['""]")
  $DCCHnjuI99.add("Confluent Access Token & Secret Key", "([a-z0-9]{16})")
  $DCCHnjuI99.add("Contentful delivery API Key", "(contentful[a-z0-9_ \.,\-]{0,25})(=|>|:=|\|\|:|<=|=>|:).{0,5}['""]([a-z0-9=_\-]{43})['""]")
  $DCCHnjuI99.add("Covalent API Key", "ckey_[a-z0-9]{27}")
  $DCCHnjuI99.add("Charity Search API Key", "(charity.?search[a-z0-9_ \.,\-]{0,25})(=|>|:=|\|\|:|<=|=>|:).{0,5}['""]([a-z0-9]{32})['""]")
  $DCCHnjuI99.add("Databricks API Key", "dapi[a-h0-9]{32}")
  $DCCHnjuI99.add("DDownload API Key", "(ddownload[a-z0-9_ \.,\-]{0,25})(=|>|:=|\|\|:|<=|=>|:).{0,5}['""]([a-z0-9]{22})['""]")
  $DCCHnjuI99.add("Defined Networking API token", "(dnkey-[a-z0-9=_\-]{26}-[a-z0-9=_\-]{52})")
  $DCCHnjuI99.add("Discord API Key, Client ID & Client Secret", "((discord[a-z0-9_ \.,\-]{0,25})(=|>|:=|\|\|:|<=|=>|:).{0,5}['""]([a-h0-9]{64}|[0-9]{18}|[a-z0-9=_\-]{32})['""])")
  $DCCHnjuI99.add("Droneci Access Token", "([a-z0-9]{32})")
  $DCCHnjuI99.add("Dropbox API Key", "sl.[a-zA-Z0-9_-]{136}")
  $DCCHnjuI99.add("Doppler API Key", "(dp\.pt\.)[a-zA-Z0-9]{43}")
  $DCCHnjuI99.add("Dropbox API secret/key, short & long lived API Key", "(dropbox[a-z0-9_ \.,\-]{0,25})(=|>|:=|\|\|:|<=|=>|:).{0,5}['""]([a-z0-9]{15}|sl\.[a-z0-9=_\-]{135}|[a-z0-9]{11}(AAAAAAAAAA)[a-z0-9_=\-]{43})['""]")
  $DCCHnjuI99.add("Duffel API Key", "duffel_(test|live)_[a-zA-Z0-9_-]{43}")
  $DCCHnjuI99.add("Dynatrace API Key", "dt0c01\.[a-zA-Z0-9]{24}\.[a-z0-9]{64}")
  $DCCHnjuI99.add("EasyPost API Key", "EZAK[a-zA-Z0-9]{54}")
  $DCCHnjuI99.add("EasyPost test API Key", "EZTK[a-zA-Z0-9]{54}")
  $DCCHnjuI99.add("Etherscan API Key", "(etherscan[a-z0-9_ \.,\-]{0,25})(=|>|:=|\|\|:|<=|=>|:).{0,5}['""]([A-Z0-9]{34})['""]")
  $DCCHnjuI99.add("Etsy Access Token", "([a-z0-9]{24})")
  $DCCHnjuI99.add("Facebook Access Token", "EAACEdEose0cBA[0-9A-Za-z]+")
  $DCCHnjuI99.add("Fastly API Key", "(fastly[a-z0-9_ \.,\-]{0,25})(=|>|:=|\|\|:|<=|=>|:).{0,5}['""]([a-z0-9=_\-]{32})['""]")
  $DCCHnjuI99.add("Finicity API Key & Client Secret", "(finicity[a-z0-9_ \.,\-]{0,25})(=|>|:=|\|\|:|<=|=>|:).{0,5}['""]([a-f0-9]{32}|[a-z0-9]{20})['""]")
  $DCCHnjuI99.add("Flickr Access Token", "([a-z0-9]{32})")
  $DCCHnjuI99.add("Flutterweave Keys", "FLWPUBK_TEST-[a-hA-H0-9]{32}-X|FLWSECK_TEST-[a-hA-H0-9]{32}-X|FLWSECK_TEST[a-hA-H0-9]{12}")
  $DCCHnjuI99.add("Frame.io API Key", "fio-u-[a-zA-Z0-9_=\-]{64}")
  $DCCHnjuI99.add("Freshbooks Access Token", "([a-z0-9]{64})")
  $DCCHnjuI99.add("Github", "github(.{0,20})?['""][0-9a-zA-Z]{35,40}")
  $DCCHnjuI99.add("Github App Token", "(ghu|ghs)_[0-9a-zA-Z]{36}")
  $DCCHnjuI99.add("Github OAuth Access Token", "gho_[0-9a-zA-Z]{36}")
  $DCCHnjuI99.add("Github Personal Access Token", "ghp_[0-9a-zA-Z]{36}")
  $DCCHnjuI99.add("Github Refresh Token", "ghr_[0-9a-zA-Z]{76}")
  $DCCHnjuI99.add("GitHub Fine-Grained Personal Access Token", "github_pat_[0-9a-zA-Z_]{82}")
  $DCCHnjuI99.add("Gitlab Personal Access Token", "glpat-[0-9a-zA-Z\-]{20}")
  $DCCHnjuI99.add("GitLab Pipeline Trigger Token", "glptt-[0-9a-f]{40}")
  $DCCHnjuI99.add("GitLab Runner Registration Token", "GR1348941[0-9a-zA-Z_\-]{20}")
  $DCCHnjuI99.add("Gitter Access Token", "([a-z0-9_-]{40})")
  $DCCHnjuI99.add("GoCardless API Key", "live_[a-zA-Z0-9_=\-]{40}")
  $DCCHnjuI99.add("GoFile API Key", "(gofile[a-z0-9_ \.,\-]{0,25})(=|>|:=|\|\|:|<=|=>|:).{0,5}['""]([a-zA-Z0-9]{32})['""]")
  $DCCHnjuI99.add("Google API Key", "AIza[0-9A-Za-z_\-]{35}")
  $DCCHnjuI99.add("Google Cloud Platform API Key", "(google|gcp|youtube|drive|yt)(.{0,20})?['""][AIza[0-9a-z_\-]{35}]['""]")
  $DCCHnjuI99.add("Google Drive Oauth", "[0-9]+-[0-9A-Za-z_]{32}\.apps\.googleusercontent\.com")
  $DCCHnjuI99.add("Google Oauth Access Token", "ya29\.[0-9A-Za-z_\-]+")
  $DCCHnjuI99.add("Google (GCP) Service-account", """type.+:.+""service_account")
  $DCCHnjuI99.add("Grafana API Key", "eyJrIjoi[a-z0-9_=\-]{72,92}")
  $DCCHnjuI99.add("Grafana cloud api token", "glc_[A-Za-z0-9\+/]{32,}={0,2}")
  $DCCHnjuI99.add("Grafana service account token", "(glsa_[A-Za-z0-9]{32}_[A-Fa-f0-9]{8})")
  $DCCHnjuI99.add("Hashicorp Terraform user/org API Key", "[a-z0-9]{14}\.atlasv1\.[a-z0-9_=\-]{60,70}")
  $DCCHnjuI99.add("Heroku API Key", "[hH][eE][rR][oO][kK][uU].{0,30}[0-9A-F]{8}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{4}-[0-9A-F]{12}")
  $DCCHnjuI99.add("Hubspot API Key", "['""][a-h0-9]{8}-[a-h0-9]{4}-[a-h0-9]{4}-[a-h0-9]{4}-[a-h0-9]{12}['""]")
  $DCCHnjuI99.add("Instatus API Key", "(instatus[a-z0-9_ \.,\-]{0,25})(=|>|:=|\|\|:|<=|=>|:).{0,5}['""]([a-z0-9]{32})['""]")
  $DCCHnjuI99.add("Intercom API Key & Client Secret/ID", "(intercom[a-z0-9_ \.,\-]{0,25})(=|>|:=|\|\|:|<=|=>|:).{0,5}['""]([a-z0-9=_]{60}|[a-h0-9]{8}-[a-h0-9]{4}-[a-h0-9]{4}-[a-h0-9]{4}-[a-h0-9]{12})['""]")
  $DCCHnjuI99.add("Ionic API Key", "(ionic[a-z0-9_ \.,\-]{0,25})(=|>|:=|\|\|:|<=|=>|:).{0,5}['""](ion_[a-z0-9]{42})['""]")
  $DCCHnjuI99.add("JSON Web Token", "(ey[0-9a-z]{30,34}\.ey[0-9a-z\/_\-]{30,}\.[0-9a-zA-Z\/_\-]{10,}={0,2})")
  $DCCHnjuI99.add("Kraken Access Token", "([a-z0-9\/=_\+\-]{80,90})")
  $DCCHnjuI99.add("Kucoin Access Token", "([a-f0-9]{24})")
  $DCCHnjuI99.add("Kucoin Secret Key", "([0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12})")
  $DCCHnjuI99.add("Launchdarkly Access Token", "([a-z0-9=_\-]{40})")
  $DCCHnjuI99.add("Linear API Key", "(lin_api_[a-zA-Z0-9]{40})")
  $DCCHnjuI99.add("Linear Client Secret/ID", "((linear[a-z0-9_ \.,\-]{0,25})(=|>|:=|\|\|:|<=|=>|:).{0,5}['""]([a-f0-9]{32})['""])")
  $DCCHnjuI99.add("LinkedIn Client ID", "linkedin(.{0,20})?['""][0-9a-z]{12}['""]")
  $DCCHnjuI99.add("LinkedIn Secret Key", "linkedin(.{0,20})?['""][0-9a-z]{16}['""]")
  $DCCHnjuI99.add("Lob API Key", "((lob[a-z0-9_ \.,\-]{0,25})(=|>|:=|\|\|:|<=|=>|:).{0,5}['""]((live|test)_[a-f0-9]{35})['""])|((lob[a-z0-9_ \.,\-]{0,25})(=|>|:=|\|\|:|<=|=>|:).{0,5}['""]((test|live)_pub_[a-f0-9]{31})['""])")
  $DCCHnjuI99.add("Lob Publishable API Key", "((test|live)_pub_[a-f0-9]{31})")
  $DCCHnjuI99.add("MailboxValidator", "(mailbox.?validator[a-z0-9_ \.,\-]{0,25})(=|>|:=|\|\|:|<=|=>|:).{0,5}['""]([A-Z0-9]{20})['""]")
  $DCCHnjuI99.add("Mailchimp API Key", "[0-9a-f]{32}-us[0-9]{1,2}")
  $DCCHnjuI99.add("Mailgun API Key", "key-[0-9a-zA-Z]{32}'")
  $DCCHnjuI99.add("Mailgun Public Validation Key", "pubkey-[a-f0-9]{32}")
  $DCCHnjuI99.add("Mailgun Webhook signing key", "[a-h0-9]{32}-[a-h0-9]{8}-[a-h0-9]{8}")
  $DCCHnjuI99.add("Mapbox API Key", "(pk\.[a-z0-9]{60}\.[a-z0-9]{22})")
  $DCCHnjuI99.add("Mattermost Access Token", "([a-z0-9]{26})")
  $DCCHnjuI99.add("MessageBird API Key & API client ID", "(messagebird[a-z0-9_ \.,\-]{0,25})(=|>|:=|\|\|:|<=|=>|:).{0,5}['""]([a-z0-9]{25}|[a-h0-9]{8}-[a-h0-9]{4}-[a-h0-9]{4}-[a-h0-9]{4}-[a-h0-9]{12})['""]")
  $DCCHnjuI99.add("Microsoft Teams Webhook", "https:\/\/[a-z0-9]+\.webhook\.office\.com\/webhookb2\/[a-z0-9]{8}-([a-z0-9]{4}-){3}[a-z0-9]{12}@[a-z0-9]{8}-([a-z0-9]{4}-){3}[a-z0-9]{12}\/IncomingWebhook\/[a-z0-9]{32}\/[a-z0-9]{8}-([a-z0-9]{4}-){3}[a-z0-9]{12}")
  $DCCHnjuI99.add("MojoAuth API Key", "[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}")
  $DCCHnjuI99.add("Netlify Access Token", "([a-z0-9=_\-]{40,46})")
  $DCCHnjuI99.add("New Relic User API Key, User API ID & Ingest Browser API Key", "(NRAK-[A-Z0-9]{27})|((newrelic[a-z0-9_ \.,\-]{0,25})(=|>|:=|\|\|:|<=|=>|:).{0,5}['""]([A-Z0-9]{64})['""])|(NRJS-[a-f0-9]{19})")
  $DCCHnjuI99.add("Nownodes", "(nownodes[a-z0-9_ \.,\-]{0,25})(=|>|:=|\|\|:|<=|=>|:).{0,5}['""]([A-Za-z0-9]{32})['""]")
  $DCCHnjuI99.add("Npm Access Token", "(npm_[a-zA-Z0-9]{36})")
  $DCCHnjuI99.add("Nytimes Access Token", "([a-z0-9=_\-]{32})")
  $DCCHnjuI99.add("Okta Access Token", "([a-z0-9=_\-]{42})")
  $DCCHnjuI99.add("OpenAI API Token", "sk-[A-Za-z0-9]{48}")
  $DCCHnjuI99.add("ORB Intelligence Access Key", "['""][a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}['""]")
  $DCCHnjuI99.add("Pastebin API Key", "(pastebin[a-z0-9_ \.,\-]{0,25})(=|>|:=|\|\|:|<=|=>|:).{0,5}['""]([a-z0-9]{32})['""]")
  $DCCHnjuI99.add("PayPal Braintree Access Token", 'access_token\$ZhKkidPN99\$[0-9a-z]{16}\$[0-9a-f]{32}')
  $DCCHnjuI99.add("Picatic API Key", "sk_live_[0-9a-z]{32}")
  $DCCHnjuI99.add("Pinata API Key", "(pinata[a-z0-9_ \.,\-]{0,25})(=|>|:=|\|\|:|<=|=>|:).{0,5}['""]([a-z0-9]{64})['""]")
  $DCCHnjuI99.add("Planetscale API Key", "pscale_tkn_[a-zA-Z0-9_\.\-]{43}")
  $DCCHnjuI99.add("PlanetScale OAuth token", "(pscale_oauth_[a-zA-Z0-9_\.\-]{32,64})")
  $DCCHnjuI99.add("Planetscale Password", "pscale_pw_[a-zA-Z0-9_\.\-]{43}")
  $DCCHnjuI99.add("Plaid API Token", "(access-(?:sandbox|development|production)-[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12})")
  $DCCHnjuI99.add("Plaid Client ID", "([a-z0-9]{24})")
  $DCCHnjuI99.add("Plaid Secret key", "([a-z0-9]{30})")
  $DCCHnjuI99.add("Prefect API token", "(pnu_[a-z0-9]{36})")
  $DCCHnjuI99.add("Postman API Key", "PMAK-[a-fA-F0-9]{24}-[a-fA-F0-9]{34}")
  $DCCHnjuI99.add("Private Keys", "\-\-\-\-\-BEGIN PRIVATE KEY\-\-\-\-\-|\-\-\-\-\-BEGIN RSA PRIVATE KEY\-\-\-\-\-|\-\-\-\-\-BEGIN OPENSSH PRIVATE KEY\-\-\-\-\-|\-\-\-\-\-BEGIN PGP PRIVATE KEY BLOCK\-\-\-\-\-|\-\-\-\-\-BEGIN DSA PRIVATE KEY\-\-\-\-\-|\-\-\-\-\-BEGIN EC PRIVATE KEY\-\-\-\-\-")
  $DCCHnjuI99.add("Pulumi API Key", "pul-[a-f0-9]{40}")
  $DCCHnjuI99.add("PyPI upload token", "pypi-AgEIcHlwaS5vcmc[A-Za-z0-9_\-]{50,}")
  $DCCHnjuI99.add("Quip API Key", "(quip[a-z0-9_ \.,\-]{0,25})(=|>|:=|\|\|:|<=|=>|:).{0,5}['""]([a-zA-Z0-9]{15}=\|[0-9]{10}\|[a-zA-Z0-9\/+]{43}=)['""]")
  $DCCHnjuI99.add("RapidAPI Access Token", "([a-z0-9_-]{50})")
  $DCCHnjuI99.add("Rubygem API Key", "rubygems_[a-f0-9]{48}")
  $DCCHnjuI99.add("Readme API token", "rdme_[a-z0-9]{70}")
  $DCCHnjuI99.add("Sendbird Access ID", "([0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12})")
  $DCCHnjuI99.add("Sendbird Access Token", "([a-f0-9]{40})")
  $DCCHnjuI99.add("Sendgrid API Key", "SG\.[a-zA-Z0-9_\.\-]{66}")
  $DCCHnjuI99.add("Sendinblue API Key", "xkeysib-[a-f0-9]{64}-[a-zA-Z0-9]{16}")
  $DCCHnjuI99.add("Sentry Access Token", "([a-f0-9]{64})")
  $DCCHnjuI99.add("Shippo API Key, Access Token, Custom Access Token, Private App Access Token & Shared Secret", "shippo_(live|test)_[a-f0-9]{40}|shpat_[a-fA-F0-9]{32}|shpca_[a-fA-F0-9]{32}|shppa_[a-fA-F0-9]{32}|shpss_[a-fA-F0-9]{32}")
  $DCCHnjuI99.add("Sidekiq Secret", "([a-f0-9]{8}:[a-f0-9]{8})")
  $DCCHnjuI99.add("Sidekiq Sensitive URL", "([a-f0-9]{8}:[a-f0-9]{8})@(?:gems.contribsys.com|enterprise.contribsys.com)")
  $DCCHnjuI99.add("Slack Token", "xox[baprs]-([0-9a-zA-Z]{10,48})?")
  $DCCHnjuI99.add("Slack Webhook", "https://hooks.slack.com/services/T[a-zA-Z0-9_]{10}/B[a-zA-Z0-9_]{10}/[a-zA-Z0-9_]{24}")
  $DCCHnjuI99.add("Smarksheel API Key", "(smartsheet[a-z0-9_ \.,\-]{0,25})(=|>|:=|\|\|:|<=|=>|:).{0,5}['""]([a-z0-9]{26})['""]")
  $DCCHnjuI99.add("Square Access Token", "sqOatp-[0-9A-Za-z_\-]{22}")
  $DCCHnjuI99.add("Square API Key", "EAAAE[a-zA-Z0-9_-]{59}")
  $DCCHnjuI99.add("Square Oauth Secret", "sq0csp-[ 0-9A-Za-z_\-]{43}")
  $DCCHnjuI99.add("Stytch API Key", "secret-.*-[a-zA-Z0-9_=\-]{36}")
  $DCCHnjuI99.add("Stripe Access Token & API Key", "(sk|pk)_(test|live)_[0-9a-z]{10,32}|k_live_[0-9a-zA-Z]{24}")
  $DCCHnjuI99.add("SumoLogic Access ID", "([a-z0-9]{14})")
  $DCCHnjuI99.add("SumoLogic Access Token", "([a-z0-9]{64})")
  $DCCHnjuI99.add("Telegram Bot API Token", "[0-9]+:AA[0-9A-Za-z\\-_]{33}")
  $DCCHnjuI99.add("Travis CI Access Token", "([a-z0-9]{22})")
  $DCCHnjuI99.add("Trello API Key", "(trello[a-z0-9_ \.,\-]{0,25})(=|>|:=|\|\|:|<=|=>|:).{0,5}['""]([0-9a-z]{32})['""]")
  $DCCHnjuI99.add("Twilio API Key", "SK[0-9a-fA-F]{32}")
  $DCCHnjuI99.add("Twitch API Key", "(twitch[a-z0-9_ \.,\-]{0,25})(=|>|:=|\|\|:|<=|=>|:).{0,5}['""]([a-z0-9]{30})['""]")
  $DCCHnjuI99.add("Twitter Client ID", "[tT][wW][iI][tT][tT][eE][rR](.{0,20})?['""][0-9a-z]{18,25}")
  $DCCHnjuI99.add("Twitter Bearer Token", "(A{22}[a-zA-Z0-9%]{80,100})")
  $DCCHnjuI99.add("Twitter Oauth", "[tT][wW][iI][tT][tT][eE][rR].{0,30}['""\\s][0-9a-zA-Z]{35,44}['""\\s]")
  $DCCHnjuI99.add("Twitter Secret Key", "[tT][wW][iI][tT][tT][eE][rR](.{0,20})?['""][0-9a-z]{35,44}")
  $DCCHnjuI99.add("Typeform API Key", "tfp_[a-z0-9_\.=\-]{59}")
  $DCCHnjuI99.add("URLScan API Key", "['""][a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}['""]")
  $DCCHnjuI99.add("Vault Token", "[sb]\.[a-zA-Z0-9]{24}")
  $DCCHnjuI99.add("Yandex Access Token", "(t1\.[A-Z0-9a-z_-]+[=]{0,2}\.[A-Z0-9a-z_-]{86}[=]{0,2})")
  $DCCHnjuI99.add("Yandex API Key", "(AQVN[A-Za-z0-9_\-]{35,38})")
  $DCCHnjuI99.add("Yandex AWS Access Token", "(YC[a-zA-Z0-9_\-]{38})")
  $DCCHnjuI99.add("Web3 API Key", "(web3[a-z0-9_ \.,\-]{0,25})(=|>|:=|\|\|:|<=|=>|:).{0,5}['""]([A-Za-z0-9_=\-]+\.[A-Za-z0-9_=\-]+\.?[A-Za-z0-9_.+/=\-]*)['""]")
  $DCCHnjuI99.add("Zendesk Secret Key", "([a-z0-9]{40})")
  $DCCHnjuI99.add("Generic API Key", "((key|api|token|secret|password)[a-z0-9_ \.,\-]{0,25})(=|>|:=|\|\|:|<=|=>|:).{0,5}['""]([0-9a-zA-Z_=\-]{8,64})['""]")
}
if ($SOwdckrV99) {
  $DCCHnjuI99.add("Authorization Basic", "basic [a-zA-Z0-9_:\.=\-]+")
  $DCCHnjuI99.add("Authorization Bearer", "bearer [a-zA-Z0-9_\.=\-]+")
  $DCCHnjuI99.add("Alibaba Access Key ID", "(LTAI)[a-z0-9]{20}")
  $DCCHnjuI99.add("Alibaba Secret Key", "(alibaba[a-z0-9_ \.,\-]{0,25})(=|>|:=|\|\|:|<=|=>|:).{0,5}['""]([a-z0-9]{30})['""]")
  $DCCHnjuI99.add("Asana Client ID", "((asana[a-z0-9_ \.,\-]{0,25})(=|>|:=|\|\|:|<=|=>|:).{0,5}['""]([0-9]{16})['""])|((asana[a-z0-9_ \.,\-]{0,25})(=|>|:=|\|\|:|<=|=>|:).{0,5}['""]([a-z0-9]{32})['""])")
  $DCCHnjuI99.add("AWS Client ID", "(A3T[A-Z0-9]|AKIA|AGPA|AIDA|AROA|AIPA|ANPA|ANVA|ASIA)[A-Z0-9]{16}")
  $DCCHnjuI99.add("AWS MWS Key", "amzn\.mws\.[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}")
  $DCCHnjuI99.add("AWS Secret Key", "aws(.{0,20})?['""][0-9a-zA-Z\/+]{40}['""]")
  $DCCHnjuI99.add("AWS AppSync GraphQL Key", "da2-[a-z0-9]{26}")
  $DCCHnjuI99.add("Basic Auth Credentials", "://[a-zA-Z0-9]+:[a-zA-Z0-9]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
  $DCCHnjuI99.add("Beamer Client Secret", "(beamer[a-z0-9_ \.,\-]{0,25})(=|>|:=|\|\|:|<=|=>|:).{0,5}['""](b_[a-z0-9=_\-]{44})['""]")
  $DCCHnjuI99.add("Cloudinary Basic Auth", "cloudinary://[0-9]{15}:[0-9A-Za-z]+@[a-z]+")
  $DCCHnjuI99.add("Facebook Client ID", "([fF][aA][cC][eE][bB][oO][oO][kK]|[fF][bB])(.{0,20})?['""][0-9]{13,17}")
  $DCCHnjuI99.add("Facebook Oauth", "[fF][aA][cC][eE][bB][oO][oO][kK].*['|""][0-9a-f]{32}['|""]")
  $DCCHnjuI99.add("Facebook Secret Key", "([fF][aA][cC][eE][bB][oO][oO][kK]|[fF][bB])(.{0,20})?['""][0-9a-f]{32}")
  $DCCHnjuI99.add("Jenkins Creds", "<[a-zA-Z]*>{[a-zA-Z0-9=+/]*}<")
  $DCCHnjuI99.add("Generic Secret", "[sS][eE][cC][rR][eE][tT].*['""][0-9a-zA-Z]{32,45}['""]")
  $DCCHnjuI99.add("Basic Auth", "//(.+):(.+)@")
  $DCCHnjuI99.add("PHP Passwords", "(pwd|passwd|password|PASSWD|PASSWORD|dbuser|dbpass|pass').*[=:].+|define ?\('(\w*pass|\w*pwd|\w*user|\w*datab)")
  $DCCHnjuI99.add("Config Secrets (Passwd / Credentials)", "passwd.*|creden.*|^kind:[^a-zA-Z0-9_]?Secret|[^a-zA-Z0-9_]env:|secret:|secretName:|^kind:[^a-zA-Z0-9_]?EncryptionConfiguration|\-\-encryption\-provider\-config")
  $DCCHnjuI99.add("Generiac API tokens search", "(access_key|access_token|admin_pass|admin_user|algolia_admin_key|algolia_api_key|alias_pass|alicloud_access_key| amazon_secret_access_key|amazonaws|ansible_vault_password|aos_key|api_key|api_key_secret|api_key_sid|api_secret| api.googlemaps AIza|apidocs|apikey|apiSecret|app_debug|app_id|app_key|app_log_level|app_secret|appkey|appkeysecret| application_key|appsecret|appspot|auth_token|authorizationToken|authsecret|aws_access|aws_access_key_id|aws_bucket| aws_key|aws_secret|aws_secret_key|aws_token|AWSSecretKey|b2_app_key|bashrc password| bintray_apikey|bintray_gpg_password|bintray_key|bintraykey|bluemix_api_key|bluemix_pass|browserstack_access_key| bucket_password|bucketeer_aws_access_key_id|bucketeer_aws_secret_access_key|built_branch_deploy_key|bx_password|cache_driver| cache_s3_secret_key|cattle_access_key|cattle_secret_key|certificate_password|ci_deploy_password|client_secret| client_zpk_secret_key|clojars_password|cloud_api_key|cloud_watch_aws_access_key|cloudant_password| cloudflare_api_key|cloudflare_auth_key|cloudinary_api_secret|cloudinary_name|codecov_token|conn.login| connectionstring|consumer_key|consumer_secret|credentials|cypress_record_key|database_password|database_schema_test| datadog_api_key|datadog_app_key|db_password|db_server|db_username|dbpasswd|dbpassword|dbuser|deploy_password| digitalocean_ssh_key_body|digitalocean_ssh_key_ids|docker_hub_password|docker_key|docker_pass|docker_passwd| docker_password|dockerhub_password|dockerhubpassword|dot-files|dotfiles|droplet_travis_password|dynamoaccesskeyid| dynamosecretaccesskey|elastica_host|elastica_port|elasticsearch_password|encryption_key|encryption_password| env.heroku_api_key|env.sonatype_password|eureka.awssecretkey)[a-z0-9_ .,<\-]{0,25}(=|>|:=|\|\|:|<=|=>|:).{0,5}['""]([0-9a-zA-Z_=\-]{8,64})['""]")
}
if($sAotqZsQ99){$Excel = $true}
$DCCHnjuI99.add("IPs", "(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)")
$SxSHAzdh99 = Get-PSDrive | Where-Object { $_.Root -like "*:\" }
$sAVVouJf99 = @("*.xml", "*.txt", "*.conf", "*.config", "*.cfg", "*.ini", ".y*ml", "*.log", "*.bak", "*.xls", "*.xlsx", "*.xlsm")
$PGoVzbDo99 = [system.diagnostics.stopwatch]::StartNew()
if ($sAotqZsQ99) {
  Write-Host "**Full Check Enabled. This will significantly increase false positives in registry / folder check for Usernames / Passwords.**"
}
Write-Host -BackgroundColor Red -ForegroundColor White  "ADVISORY: WinPEAS - Windows local Privilege Escalation Awesome Script"
Write-Host -BackgroundColor Red -ForegroundColor White "WinPEAS should be used for authorized penetration testing and/or educational purposes only"
Write-Host -BackgroundColor Red -ForegroundColor White "Any misuse of this software will not be the responsibility of the author or of any other collaborator"
Write-Host -BackgroundColor Red -ForegroundColor White "Use it at your own networks and/or with the network owner's explicit permission"
Write-Host -ForegroundColor red  "Indicates special privilege over an object or misconfiguration"
Write-Host -ForegroundColor green  "Indicates protection is enabled or something is well configured"
Write-Host -ForegroundColor cyan  "Indicates active users"
Write-Host -ForegroundColor Gray  "Indicates disabled users"
Write-Host -ForegroundColor yellow  "Indicates links"
Write-Host -ForegroundColor Blue "Indicates title"
Write-Host "You can find a Windows local PE Checklist here: https://book.hacktricks.xyz/windows-hardening/checklist-windows-privilege-escalation" -ForegroundColor Yellow
Write-Host ""
if ($eXnXvGIj99) { TimeElapsed }
Write-Host "====================================||SYSTEM INFORMATION ||===================================="
"The following information is curated. To get a full list of system information, run the cmdlet get-computerinfo"
systeminfo.exe
Write-Host ""
if ($eXnXvGIj99) { TimeElapsed }
Write-Host -ForegroundColor Blue "=========|| WINDOWS HOTFIXES"
Write-Host "=| Check if windows is vulnerable with Watson https://github.com/rasta-mouse/Watson" -ForegroundColor Yellow
Write-Host "Possible exploits (https://github.com/codingo/OSCP-2/blob/master/Windows/WinPrivCheck.bat)" -ForegroundColor Yellow
$NdloWrXo99 = Get-HotFix | Sort-Object -Descending -Property InstalledOn -ErrorAction SilentlyContinue | Select-Object HotfixID, Description, InstalledBy, InstalledOn
$NdloWrXo99 | Format-Table -AutoSize
Write-Host ""
if ($eXnXvGIj99) { TimeElapsed }
Write-Host -ForegroundColor Blue "=========|| ALL UPDATES INSTALLED"
$AjKmfAqu99 = (New-Object -ComObject 'Microsoft.Update.Session')
$aZztRSZs99 = $AjKmfAqu99.QueryHistory("", 0, 1000) | Select-Object ResultCode, Date, Title
$yTVRIhAh99 = @()
$sQGaoshY99 = @()
for ($i = 0; $i -lt $aZztRSZs99.Count; $i++) {
  $check = viols -title $aZztRSZs99[$i].Title
  if ($yTVRIhAh99 -like $check) {
  }
  else {
    $yTVRIhAh99 += $check
    $sQGaoshY99 += $i
  }
}
$icXmfahM99 = @()
$sQGaoshY99 | ForEach-Object {
  $DSggvviP99 = $aZztRSZs99[$_]
  $nEWXPtuc99 = $DSggvviP99.ResultCode
  switch ($nEWXPtuc99) {
    1 {
      $nEWXPtuc99 = "Missing/Superseded"
    }
    2 {
      $nEWXPtuc99 = "Succeeded"
    }
    3 {
      $nEWXPtuc99 = "Succeeded With Errors"
    }
    4 {
      $nEWXPtuc99 = "Failed"
    }
    5 {
      $nEWXPtuc99 = "Canceled"
    }
  }
  $icXmfahM99 += [PSCustomObject]@{
    Result = $nEWXPtuc99
    Date   = $DSggvviP99.Date
    Title  = $DSggvviP99.Title
  }    
}
$icXmfahM99 | Format-Table -AutoSize
Write-Host ""
if ($eXnXvGIj99) { TimeElapsed }
Write-Host -ForegroundColor Blue "=========|| Drive Info"
Add-Type -AssemblyName System.Management
$bQLdJnBG99 = New-Object System.Management.ManagementObjectSearcher("SELECT * FROM Win32_LogicalDisk WHERE DriveType = 3")
$VHvDzojP99 = $bQLdJnBG99.Get()
foreach ($drive in $VHvDzojP99) {
  $VSIitPcF99 = $drive.DeviceID
  $vGhkUtih99 = $drive.VolumeName
  $LVqOtZTV99 = [math]::Round($drive.Size / 1GB, 2)
  $efGCGZHP99 = [math]::Round($drive.FreeSpace / 1GB, 2)
  Write-Output "Drive: $VSIitPcF99"
  Write-Output "Label: $vGhkUtih99"
  Write-Output "Size: $LVqOtZTV99 GB"
  Write-Output "Free Space: $efGCGZHP99 GB"
  Write-Output ""
}
Write-Host ""
if ($eXnXvGIj99) { TimeElapsed }
Write-Host -ForegroundColor Blue "=========|| Antivirus Detection (attemping to read exclusions as well)"
WMIC /Node:localhost /Namespace:\\root\SecurityCenter2 Path AntiVirusProduct Get displayName
Get-ChildItem 'registry::HKLM\SOFTWARE\Microsoft\Windows Defender\Exclusions' -ErrorAction SilentlyContinue
Write-Host ""
if ($eXnXvGIj99) { TimeElapsed }
Write-Host -ForegroundColor Blue "=========|| NET ACCOUNTS Info"
net accounts
Write-Host ""
if ($eXnXvGIj99) { TimeElapsed }
Write-Host -ForegroundColor Blue "=========|| REGISTRY SETTINGS CHECK"
 
Write-Host ""
if ($eXnXvGIj99) { TimeElapsed }
Write-Host -ForegroundColor Blue "=========|| Audit Log Settings"
if ((Test-Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\Audit\).Property) {
  Get-Item -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\Audit\
}
else {
  Write-Host "No Audit Log settings, no registry entry found."
}
 
Write-Host ""
if ($eXnXvGIj99) { TimeElapsed }
Write-Host -ForegroundColor Blue "=========|| Windows Event Forward (WEF) registry"
if (Test-Path HKLM:\SOFTWARE\Policies\Microsoft\Windows\EventLog\EventForwarding\SubscriptionManager) {
  Get-Item HKLM:\SOFTWARE\Policies\Microsoft\Windows\EventLog\EventForwarding\SubscriptionManager
}
else {
  Write-Host "Logs are not being fowarded, no registry entry found."
}
 
Write-Host ""
if ($eXnXvGIj99) { TimeElapsed }
Write-Host -ForegroundColor Blue "=========|| LAPS Check"
if (Test-Path 'C:\Program Files\LAPS\CSE\Admpwd.dll') { Write-Host "LAPS dll found on this machine at C:\Program Files\LAPS\CSE\" -ForegroundColor Green }
elseif (Test-Path 'C:\Program Files (x86)\LAPS\CSE\Admpwd.dll' ) { Write-Host "LAPS dll found on this machine at C:\Program Files (x86)\LAPS\CSE\" -ForegroundColor Green }
else { Write-Host "LAPS dlls not found on this machine" }
if ((Get-ItemProperty HKLM:\Software\Policies\Microsoft Services\AdmPwd -ErrorAction SilentlyContinue).AdmPwdEnabled -eq 1) { Write-Host "LAPS registry key found on this machine" -ForegroundColor Green }
Write-Host ""
if ($eXnXvGIj99) { TimeElapsed }
Write-Host -ForegroundColor Blue "=========|| WDigest Check"
$EQxkUyEE99 = (Get-ItemProperty HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\WDigest).UseLogonCredential
switch ($EQxkUyEE99) {
  0 { Write-Host "Value 0 found. Plain-text Passwords are not stored in LSASS" }
  1 { Write-Host "Value 1 found. Plain-text Passwords may be stored in LSASS" -ForegroundColor red }
  Default { Write-Host "The system was unable to find the specified registry value: UesLogonCredential" }
}
 
Write-Host ""
if ($eXnXvGIj99) { TimeElapsed }
Write-Host -ForegroundColor Blue "=========|| LSA Protection Check"
$PjUKWMRp99 = (Get-ItemProperty HKLM:\SYSTEM\CurrentControlSet\Control\LSA).RunAsPPL
$hNPKFKPG99 = (Get-ItemProperty HKLM:\SYSTEM\CurrentControlSet\Control\LSA).RunAsPPLBoot
switch ($PjUKWMRp99) {
  2 { Write-Host "RunAsPPL: 2. Enabled without UEFI Lock" }
  1 { Write-Host "RunAsPPL: 1. Enabled with UEFI Lock" }
  0 { Write-Host "RunAsPPL: 0. LSA Protection Disabled. Try mimikatz." -ForegroundColor red }
  Default { "The system was unable to find the specified registry value: RunAsPPL / RunAsPPLBoot" }
}
if ($hNPKFKPG99) { Write-Host "RunAsPPLBoot: $hNPKFKPG99" }
 
Write-Host ""
if ($eXnXvGIj99) { TimeElapsed }
Write-Host -ForegroundColor Blue "=========|| Credential Guard Check"
$UhhdCQHy99 = (Get-ItemProperty HKLM:\SYSTEM\CurrentControlSet\Control\LSA).LsaCfgFlags
switch ($UhhdCQHy99) {
  2 { Write-Host "LsaCfgFlags 2. Enabled without UEFI Lock" }
  1 { Write-Host "LsaCfgFlags 1. Enabled with UEFI Lock" }
  0 { Write-Host "LsaCfgFlags 0. LsaCfgFlags Disabled." -ForegroundColor red }
  Default { "The system was unable to find the specified registry value: LsaCfgFlags" }
}
 
Write-Host ""
if ($eXnXvGIj99) { TimeElapsed }
Write-Host -ForegroundColor Blue "=========|| Cached WinLogon Credentials Check"
if (Test-Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon") {
  (Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" -Name "CACHEDLOGONSCOUNT").CACHEDLOGONSCOUNT
  Write-Host "However, only the SYSTEM user can view the credentials here: HKEY_LOCAL_MACHINE\SECURITY\Cache"
  Write-Host "Or, using mimikatz lsadump::cache"
}
Write-Host ""
if ($eXnXvGIj99) { TimeElapsed }
Write-Host -ForegroundColor Blue "=========|| Additonal Winlogon Credentials Check"
(Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon").DefaultDomainName
(Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon").DefaultUserName
(Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon").DefaultPassword
(Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon").AltDefaultDomainName
(Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon").AltDefaultUserName
(Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon").AltDefaultPassword
Write-Host ""
if ($eXnXvGIj99) { TimeElapsed }
Write-Host -ForegroundColor Blue "=========|| RDCMan Settings Check"
if (Test-Path "$env:USERPROFILE\appdata\Local\Microsoft\Remote Desktop Connection Manager\RDCMan.settings") {
  Write-Host "RDCMan Settings Found at: $($env:USERPROFILE)\appdata\Local\Microsoft\Remote Desktop Connection Manager\RDCMan.settings" -ForegroundColor Red
}
else { Write-Host "No RCDMan.Settings found." }
Write-Host ""
if ($eXnXvGIj99) { TimeElapsed }
Write-Host -ForegroundColor Blue "=========|| RDP Saved Connections Check"
Write-Host "HK_Users"
New-PSDrive -PSProvider Registry -Name HKU -Root HKEY_USERS
Get-ChildItem HKU:\ -ErrorAction SilentlyContinue | ForEach-Object {
  $whPxNJXL99 = $_.Name.Replace('HKEY_USERS\', "")
  if (Test-Path "registry::HKEY_USERS\$whPxNJXL99\Software\Microsoft\Terminal Server Client\Default") {
    Write-Host "Server Found: $((Get-ItemProperty "registry::HKEY_USERS\$whPxNJXL99\Software\Microsoft\Terminal Server Client\Default" -Name MRU0).MRU0)"
  }
  else { Write-Host "Not found for $($_.Name)" }
}
Write-Host "HKCU"
if (Test-Path "registry::HKEY_CURRENT_USER\Software\Microsoft\Terminal Server Client\Default") {
  Write-Host "Server Found: $((Get-ItemProperty "registry::HKEY_CURRENT_USER\Software\Microsoft\Terminal Server Client\Default" -Name MRU0).MRU0)"
}
else { Write-Host "Terminal Server Client not found in HCKU" }
Write-Host ""
if ($eXnXvGIj99) { TimeElapsed }
Write-Host -ForegroundColor Blue "=========|| Putty Stored Credentials Check"
if (Test-Path HKCU:\SOFTWARE\SimonTatham\PuTTY\Sessions) {
  Get-ChildItem HKCU:\SOFTWARE\SimonTatham\PuTTY\Sessions | ForEach-Object {
    $DjcZxjSp99 = Split-Path $_.Name -Leaf
    Write-Host "Key: $DjcZxjSp99"
    @("HostName", "PortNumber", "UserName", "PublicKeyFile", "PortForwardings", "ConnectionSharing", "ProxyUsername", "ProxyPassword") | ForEach-Object {
      Write-Host "$_ :"
      Write-Host "$((Get-ItemProperty  HKCU:\SOFTWARE\SimonTatham\PuTTY\Sessions\$DjcZxjSp99).$_)"
    }
  }
}
else { Write-Host "No putty credentials found in HKCU:\SOFTWARE\SimonTatham\PuTTY\Sessions" }
Write-Host ""
if ($eXnXvGIj99) { TimeElapsed }
Write-Host -ForegroundColor Blue "=========|| SSH Key Checks"
Write-Host ""
if ($eXnXvGIj99) { TimeElapsed }
Write-Host -ForegroundColor Blue "=========|| If found:"
Write-Host "https://blog.ropnop.com/extracting-ssh-private-keys-from-windows-10-ssh-agent/" -ForegroundColor Yellow
Write-Host ""
if ($eXnXvGIj99) { TimeElapsed }
Write-Host -ForegroundColor Blue "=========|| Checking Putty SSH KNOWN HOSTS"
if (Test-Path HKCU:\Software\SimonTatham\PuTTY\SshHostKeys) { 
  Write-Host "$((Get-Item -Path HKCU:\Software\SimonTatham\PuTTY\SshHostKeys).Property)"
}
else { Write-Host "No putty ssh keys found" }
Write-Host ""
if ($eXnXvGIj99) { TimeElapsed }
Write-Host -ForegroundColor Blue "=========|| Checking for OpenSSH Keys"
if (Test-Path HKCU:\Software\OpenSSH\Agent\Keys) { Write-Host "OpenSSH keys found. Try this for decryption: https://github.com/ropnop/windows_sshagent_extract" -ForegroundColor Yellow }
else { Write-Host "No OpenSSH Keys found." }
Write-Host ""
if ($eXnXvGIj99) { TimeElapsed }
Write-Host -ForegroundColor Blue "=========|| Checking for WinVNC Passwords"
if ( Test-Path "HKCU:\Software\ORL\WinVNC3\Password") { Write-Host " WinVNC found at HKCU:\Software\ORL\WinVNC3\Password" }else { Write-Host "No WinVNC found." }
Write-Host ""
if ($eXnXvGIj99) { TimeElapsed }
Write-Host -ForegroundColor Blue "=========|| Checking for SNMP Passwords"
if ( Test-Path "HKLM:\SYSTEM\CurrentControlSet\Services\SNMP" ) { Write-Host "SNMP Key found at HKLM:\SYSTEM\CurrentControlSet\Services\SNMP" }else { Write-Host "No SNMP found." }
Write-Host ""
if ($eXnXvGIj99) { TimeElapsed }
Write-Host -ForegroundColor Blue "=========|| Checking for TightVNC Passwords"
if ( Test-Path "HKCU:\Software\TightVNC\Server") { Write-Host "TightVNC key found at HKCU:\Software\TightVNC\Server" }else { Write-Host "No TightVNC found." }
Write-Host ""
if ($eXnXvGIj99) { TimeElapsed }
Write-Host -ForegroundColor Blue "=========|| UAC Settings"
if ((Get-ItemProperty HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System).EnableLUA -eq 1) {
  Write-Host "EnableLUA is equal to 1. Part or all of the UAC components are on."
  Write-Host "https://book.hacktricks.xyz/windows-hardening/windows-local-privilege-escalation#basic-uac-bypass-full-file-system-access" -ForegroundColor Yellow
}
else { Write-Host "EnableLUA value not equal to 1" }
Write-Host ""
if ($eXnXvGIj99) { TimeElapsed }
Write-Host -ForegroundColor Blue "=========|| Recently Run Commands (WIN+R)"
Get-ChildItem HKU:\ -ErrorAction SilentlyContinue | ForEach-Object {
  $whPxNJXL99 = $_.Name.Replace('HKEY_USERS\', "")
  $XDKvTpIo99 = (Get-Item "HKU:\$_\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\RunMRU" -ErrorAction SilentlyContinue).Property
  $whPxNJXL99 | ForEach-Object {
    if (Test-Path "HKU:\$_\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\RunMRU") {
      Write-Host -ForegroundColor Blue "=========||HKU Recently Run Commands"
      foreach ($p in $XDKvTpIo99) {
        Write-Host "$((Get-Item "HKU:\$_\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\RunMRU"-ErrorAction SilentlyContinue).getValue($p))" 
      }
    }
  }
}
Write-Host ""
if ($eXnXvGIj99) { TimeElapsed }
Write-Host -ForegroundColor Blue "=========||HKCU Recently Run Commands"
$XDKvTpIo99 = (Get-Item "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\RunMRU" -ErrorAction SilentlyContinue).Property
foreach ($p in $XDKvTpIo99) {
  Write-Host "$((Get-Item "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\RunMRU"-ErrorAction SilentlyContinue).getValue($p))"
}
Write-Host ""
if ($eXnXvGIj99) { TimeElapsed }
Write-Host -ForegroundColor Blue "=========|| Always Install Elevated Check"
 
Write-Host "Checking Windows Installer Registry (will populate if the key exists)"
if ((Get-ItemProperty HKLM:\SOFTWARE\Policies\Microsoft\Windows\Installer -ErrorAction SilentlyContinue).AlwaysInstallElevated -eq 1) {
  Write-Host "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Installer).AlwaysInstallElevated = 1" -ForegroundColor red
  Write-Host "Try msfvenom msi package to escalate" -ForegroundColor red
  Write-Host "https://book.hacktricks.xyz/windows-hardening/windows-local-privilege-escalation#metasploit-payloads" -ForegroundColor Yellow
}
 
if ((Get-ItemProperty HKCU:\SOFTWARE\Policies\Microsoft\Windows\Installer -ErrorAction SilentlyContinue).AlwaysInstallElevated -eq 1) { 
  Write-Host "HKCU:\SOFTWARE\Policies\Microsoft\Windows\Installer).AlwaysInstallElevated = 1" -ForegroundColor red
  Write-Host "Try msfvenom msi package to escalate" -ForegroundColor red
  Write-Host "https://book.hacktricks.xyz/windows-hardening/windows-local-privilege-escalation#metasploit-payloads" -ForegroundColor Yellow
}
Write-Host ""
if ($eXnXvGIj99) { TimeElapsed }
Write-Host -ForegroundColor Blue "=========|| PowerShell Info"
(Get-ItemProperty registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PowerShell\1\PowerShellEngine).PowerShellVersion | ForEach-Object {
  Write-Host "PowerShell $_ available"
}
(Get-ItemProperty registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PowerShell\3\PowerShellEngine).PowerShellVersion | ForEach-Object {
  Write-Host  "PowerShell $_ available"
}
Write-Host ""
if ($eXnXvGIj99) { TimeElapsed }
Write-Host -ForegroundColor Blue "=========|| PowerShell Registry Transcript Check"
if (Test-Path HKCU:\Software\Policies\Microsoft\Windows\PowerShell\Transcription) {
  Get-Item HKCU:\Software\Policies\Microsoft\Windows\PowerShell\Transcription
}
if (Test-Path HKLM:\Software\Policies\Microsoft\Windows\PowerShell\Transcription) {
  Get-Item HKLM:\Software\Policies\Microsoft\Windows\PowerShell\Transcription
}
if (Test-Path HKCU:\Wow6432Node\Software\Policies\Microsoft\Windows\PowerShell\Transcription) {
  Get-Item HKCU:\Wow6432Node\Software\Policies\Microsoft\Windows\PowerShell\Transcription
}
if (Test-Path HKLM:\Wow6432Node\Software\Policies\Microsoft\Windows\PowerShell\Transcription) {
  Get-Item HKLM:\Wow6432Node\Software\Policies\Microsoft\Windows\PowerShell\Transcription
}
 
Write-Host ""
if ($eXnXvGIj99) { TimeElapsed }
Write-Host -ForegroundColor Blue "=========|| PowerShell Module Log Check"
if (Test-Path HKCU:\Software\Policies\Microsoft\Windows\PowerShell\ModuleLogging) {
  Get-Item HKCU:\Software\Policies\Microsoft\Windows\PowerShell\ModuleLogging
}
if (Test-Path HKLM:\Software\Policies\Microsoft\Windows\PowerShell\ModuleLogging) {
  Get-Item HKLM:\Software\Policies\Microsoft\Windows\PowerShell\ModuleLogging
}
if (Test-Path HKCU:\Wow6432Node\Software\Policies\Microsoft\Windows\PowerShell\ModuleLogging) {
  Get-Item HKCU:\Wow6432Node\Software\Policies\Microsoft\Windows\PowerShell\ModuleLogging
}
if (Test-Path HKLM:\Wow6432Node\Software\Policies\Microsoft\Windows\PowerShell\ModuleLogging) {
  Get-Item HKLM:\Wow6432Node\Software\Policies\Microsoft\Windows\PowerShell\ModuleLogging
}
 
Write-Host ""
if ($eXnXvGIj99) { TimeElapsed }
Write-Host -ForegroundColor Blue "=========|| PowerShell Script Block Log Check"
 
if ( Test-Path HKCU:\Software\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging) {
  Get-Item HKCU:\Software\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging
}
if ( Test-Path HKLM:\Software\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging) {
  Get-Item HKLM:\Software\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging
}
if ( Test-Path HKCU:\Wow6432Node\Software\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging) {
  Get-Item HKCU:\Wow6432Node\Software\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging
}
if ( Test-Path HKLM:\Wow6432Node\Software\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging) {
  Get-Item HKLM:\Wow6432Node\Software\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging
}
Write-Host ""
if ($eXnXvGIj99) { TimeElapsed }
Write-Host -ForegroundColor Blue "=========|| WSUS check for http and UseWAServer = 1, if true, might be vulnerable to exploit"
Write-Host "https://book.hacktricks.xyz/windows-hardening/windows-local-privilege-escalation#wsus" -ForegroundColor Yellow
if (Test-Path HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate) {
  Get-Item HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate
}
if ((Get-ItemProperty HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU -Name "USEWUServer" -ErrorAction SilentlyContinue).UseWUServer) {
  (Get-ItemProperty HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU -Name "USEWUServer").UseWUServer
}
Write-Host ""
if ($eXnXvGIj99) { TimeElapsed }
Write-Host -ForegroundColor Blue "=========|| Internet Settings HKCU / HKLM"
$XDKvTpIo99 = (Get-Item "HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings" -ErrorAction SilentlyContinue).Property
foreach ($p in $XDKvTpIo99) {
  Write-Host "$p - $((Get-Item "HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings"-ErrorAction SilentlyContinue).getValue($p))"
}
 
$XDKvTpIo99 = (Get-Item "HKLM:\Software\Microsoft\Windows\CurrentVersion\Internet Settings" -ErrorAction SilentlyContinue).Property
foreach ($p in $XDKvTpIo99) {
  Write-Host "$p - $((Get-Item "HKLM:\Software\Microsoft\Windows\CurrentVersion\Internet Settings"-ErrorAction SilentlyContinue).getValue($p))"
}
Write-Host ""
if ($eXnXvGIj99) { TimeElapsed }
Write-Host -ForegroundColor Blue "=========|| RUNNING PROCESSES"
Write-Host ""
if ($eXnXvGIj99) { TimeElapsed }
Write-Host -ForegroundColor Blue "=========|| Checking user permissions on running processes"
Get-Process | Select-Object Path -Unique | ForEach-Object { thresholds -evhWBoxI99 $_.path }
Write-Host ""
if ($eXnXvGIj99) { TimeElapsed }
Write-Host -ForegroundColor Blue "=========|| System processes"
Start-Process tasklist -ArgumentList '/v /fi "username eq system"' -Wait -NoNewWindow
Write-Host ""
if ($eXnXvGIj99) { TimeElapsed }
Write-Host -ForegroundColor Blue "=========|| SERVICE path vulnerable check"
Write-Host "Checking for vulnerable service .exe"
$yIEGHkJp99 = @{}
Get-WmiObject Win32_Service | Where-Object { $_.PathName -like '*.exe*' } | ForEach-Object {
  $Path = ($_.PathName -split '(?<=\.exe\b)')[0].Trim('"')
  $yIEGHkJp99[$Path] = $_.Name
}
foreach ( $h in ($yIEGHkJp99 | Select-Object -Unique).GetEnumerator()) {
  thresholds -evhWBoxI99 $h.Name -jAoGwlGN99 $h.Value
}
Write-Host ""
if ($eXnXvGIj99) { TimeElapsed }
Write-Host -ForegroundColor Blue "=========|| Checking for Unquoted Service Paths"
ranches
Write-Host ""
if ($eXnXvGIj99) { TimeElapsed }
Write-Host -ForegroundColor Blue "=========|| Checking Service Registry Permissions"
Write-Host "This will take some time."
Get-ChildItem 'HKLM:\System\CurrentControlSet\services\' | ForEach-Object {
  $evhWBoxI99 = $_.Name.Replace("HKEY_LOCAL_MACHINE", "hklm:")
  Start-aclcheck -evhWBoxI99 $evhWBoxI99
}
Write-Host ""
if ($eXnXvGIj99) { TimeElapsed }
Write-Host -ForegroundColor Blue "=========|| SCHEDULED TASKS vulnerable check"
Write-Host ""
if ($eXnXvGIj99) { TimeElapsed }
Write-Host -ForegroundColor Blue "=========|| Testing access to c:\windows\system32\tasks"
if (Get-ChildItem "c:\windows\system32\tasks" -ErrorAction SilentlyContinue) {
  Write-Host "Access confirmed, may need futher investigation"
  Get-ChildItem "c:\windows\system32\tasks"
}
else {
  Write-Host "No admin access to scheduled tasks folder."
  Get-ScheduledTask | Where-Object { $_.TaskPath -notlike "\Microsoft*" } | ForEach-Object {
    $faKnWCKD99 = $_.Actions.Execute
    if ($faKnWCKD99 -ne $null) {
      foreach ($a in $faKnWCKD99) {
        if ($a -like "%windir%*") { $a = $a.replace("%windir%", $Env:windir) }
        elseif ($a -like "%SystemRoot%*") { $a = $a.replace("%SystemRoot%", $Env:windir) }
        elseif ($a -like "%localappdata%*") { $a = $a.replace("%localappdata%", "$env:UserProfile\appdata\local") }
        elseif ($a -like "%appdata%*") { $a = $a.replace("%localappdata%", $env:Appdata) }
        $a = $a.Replace('"', '')
        thresholds -evhWBoxI99 $a
        Write-Host "`n"
        Write-Host "TaskName: $($_.TaskName)"
        Write-Host "-------------"
        [pscustomobject]@{
          LastResult = $(($_ | Get-ScheduledTaskInfo).LastTaskResult)
          NextRun    = $(($_ | Get-ScheduledTaskInfo).NextRunTime)
          Status     = $_.State
          Command    = $_.Actions.execute
          Arguments  = $_.Actions.Arguments 
        } | Write-Host
      } 
    }
  }
}
Write-Host ""
if ($eXnXvGIj99) { TimeElapsed }
Write-Host -ForegroundColor Blue "=========|| STARTUP APPLICATIONS Vulnerable Check"
"Check if you can modify any binary that is going to be executed by admin or if you can impersonate a not found binary"
Write-Host "https://book.hacktricks.xyz/windows-hardening/windows-local-privilege-escalation#run-at-startup" -ForegroundColor Yellow
@("C:\Documents and Settings\All Users\Start Menu\Programs\Startup",
  "C:\Documents and Settings\$env:Username\Start Menu\Programs\Startup", 
  "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Startup", 
  "$env:Appdata\Microsoft\Windows\Start Menu\Programs\Startup") | ForEach-Object {
  if (Test-Path $_) {
    thresholds $_
    Get-ChildItem -Recurse -Force -Path $_ | ForEach-Object {
      $KKJEhVfH99 = $_.FullName
      if (Test-Path $KKJEhVfH99) { 
        thresholds -evhWBoxI99 $KKJEhVfH99
      }
    }
  }
}
Write-Host ""
if ($eXnXvGIj99) { TimeElapsed }
Write-Host -ForegroundColor Blue "=========|| STARTUP APPS Registry Check"
@("registry::HKLM\Software\Microsoft\Windows\CurrentVersion\Run",
  "registry::HKLM\Software\Microsoft\Windows\CurrentVersion\RunOnce",
  "registry::HKCU\Software\Microsoft\Windows\CurrentVersion\Run",
  "registry::HKCU\Software\Microsoft\Windows\CurrentVersion\RunOnce") | ForEach-Object {
  $fYTgLJIt99 = $_
  (Get-Item $_) | ForEach-Object {
    $MpmAkggX99 = $_.property
    $MpmAkggX99 | ForEach-Object {
      thresholds ((Get-ItemProperty -Path $fYTgLJIt99).$_ -split '(?<=\.exe\b)')[0].Trim('"')
    }
  }
}
Write-Host ""
if ($eXnXvGIj99) { TimeElapsed }
Write-Host -ForegroundColor Blue "=========|| INSTALLED APPLICATIONS"
Write-Host "Generating list of installed applications"
Get-CimInstance -class win32_Product | Select-Object Name, Version | 
ForEach-Object {
  Write-Host $("{0} : {1}" -f $_.Name, $_.Version)  
}
Write-Host ""
if ($eXnXvGIj99) { TimeElapsed }
Write-Host -ForegroundColor Blue "=========|| LOOKING FOR BASH.EXE"
Get-ChildItem C:\Windows\WinSxS\ -Filter "amd64_microsoft-windows-lxss-bash*" | ForEach-Object {
  Write-Host $((Get-ChildItem $_.FullName -Recurse -Filter "*bash.exe*").FullName)
}
@("bash.exe", "wsl.exe") | ForEach-Object { Write-Host $((Get-ChildItem C:\Windows\System32\ -Filter $_).FullName) }
Write-Host ""
if ($eXnXvGIj99) { TimeElapsed }
Write-Host -ForegroundColor Blue "=========|| LOOKING FOR SCCM CLIENT"
$nEWXPtuc99 = Get-WmiObject -Namespace "root\ccm\clientSDK" -Class CCM_Application -Property * -ErrorAction SilentlyContinue | Select-Object Name, SoftwareVersion
if ($nEWXPtuc99) { $nEWXPtuc99 }
elseif (Test-Path 'C:\Windows\CCM\SCClient.exe') { Write-Host "SCCM Client found at C:\Windows\CCM\SCClient.exe" -ForegroundColor Cyan }
else { Write-Host "Not Installed." }
Write-Host ""
if ($eXnXvGIj99) { TimeElapsed }
Write-Host -ForegroundColor Blue "=========|| NETWORK INFORMATION"
Write-Host ""
if ($eXnXvGIj99) { TimeElapsed }
Write-Host -ForegroundColor Blue "=========|| HOSTS FILE"
Write-Host "Get content of etc\hosts file"
Get-Content "c:\windows\system32\drivers\etc\hosts"
Write-Host ""
if ($eXnXvGIj99) { TimeElapsed }
Write-Host -ForegroundColor Blue "=========|| IP INFORMATION"
Write-Host ""
if ($eXnXvGIj99) { TimeElapsed }
Write-Host -ForegroundColor Blue "=========|| Ipconfig ALL"
Start-Process ipconfig.exe -ArgumentList "/all" -Wait -NoNewWindow
Write-Host ""
if ($eXnXvGIj99) { TimeElapsed }
Write-Host -ForegroundColor Blue "=========|| DNS Cache"
ipconfig /displaydns | Select-String "Record" | ForEach-Object { Write-Host $('{0}' -f $_) }
 
Write-Host ""
if ($eXnXvGIj99) { TimeElapsed }
Write-Host -ForegroundColor Blue "=========|| LISTENING PORTS"
Start-Process NETSTAT.EXE -ArgumentList "-ano" -Wait -NoNewWindow
Write-Host ""
if ($eXnXvGIj99) { TimeElapsed }
Write-Host -ForegroundColor Blue "=========|| ARP Table"
Start-Process arp -ArgumentList "-A" -Wait -NoNewWindow
Write-Host ""
if ($eXnXvGIj99) { TimeElapsed }
Write-Host -ForegroundColor Blue "=========|| Routes"
Start-Process route -ArgumentList "print" -Wait -NoNewWindow
Write-Host ""
if ($eXnXvGIj99) { TimeElapsed }
Write-Host -ForegroundColor Blue "=========|| Network Adapter info"
Get-NetAdapter | ForEach-Object { 
  Write-Host "----------"
  Write-Host $_.Name
  Write-Host $_.InterfaceDescription
  Write-Host $_.ifIndex
  Write-Host $_.Status
  Write-Host $_.MacAddress
  Write-Host "----------"
} 
Write-Host ""
if ($eXnXvGIj99) { TimeElapsed }
Write-Host -ForegroundColor Blue "=========|| Checking for WiFi passwords"
((netsh.exe wlan show profiles) -match '\s{2,}:\s').replace("    All User Profile     : ", "") | ForEach-Object {
  netsh wlan show profile name="$_" key=clear 
}
Write-Host ""
if ($eXnXvGIj99) { TimeElapsed }
Write-Host -ForegroundColor Blue "=========|| Enabled firewall rules - displaying command only - it can overwrite the display buffer"
Write-Host -ForegroundColor Blue "=========|| show all rules with: netsh advfirewall firewall show rule dir=in name=all"
Write-Host ""
if ($eXnXvGIj99) { TimeElapsed }
Write-Host -ForegroundColor Blue "=========|| SMB SHARES"
Write-Host "Will enumerate SMB Shares and Access if any are available" 
Get-SmbShare | Get-SmbShareAccess | ForEach-Object {
  $udXeZrgJ99 = $_
  whoami.exe /groups /fo csv | ConvertFrom-Csv | Select-Object -ExpandProperty 'group name' | ForEach-Object {
    if ($udXeZrgJ99.AccountName -like $_ -and ($udXeZrgJ99.AccessRight -like "Full" -or "Change") -and $udXeZrgJ99.AccessControlType -like "Allow" ) {
      Write-Host -ForegroundColor red "$($udXeZrgJ99.AccountName) has $($udXeZrgJ99.AccessRight) to $($udXeZrgJ99.Name)"
    }
  }
}
Write-Host ""
if ($eXnXvGIj99) { TimeElapsed }
Write-Host -ForegroundColor Blue "=========|| USER INFO"
Write-Host "== || Generating List of all Administrators, Users and Backup Operators (if any exist)"
@("ADMINISTRATORS", "USERS") | ForEach-Object {
  Write-Host $_
  Write-Host "-------"
  Start-Process net -ArgumentList "localgroup $_" -Wait -NoNewWindow
}
Write-Host "BACKUP OPERATORS"
Write-Host "-------"
Start-Process net -ArgumentList 'localgroup "Backup Operators"' -Wait -NoNewWindow
Write-Host ""
if ($eXnXvGIj99) { TimeElapsed }
Write-Host -ForegroundColor Blue "=========|| USER DIRECTORY ACCESS CHECK"
Get-ChildItem C:\Users\* | ForEach-Object {
  if (Get-ChildItem $_.FullName -ErrorAction SilentlyContinue) {
    Write-Host -ForegroundColor red "Read Access to $($_.FullName)"
  }
}
Write-Host ""
if ($eXnXvGIj99) { TimeElapsed }
Write-Host -ForegroundColor Blue "=========|| WHOAMI INFO"
Write-Host ""
if ($eXnXvGIj99) { TimeElapsed }
Write-Host -ForegroundColor Blue "=========|| Check Token access here: https://book.hacktricks.xyz/windows-hardening/windows-local-privilege-escalation/privilege-escalation-abusing-tokens" -ForegroundColor yellow
Write-Host -ForegroundColor Blue "=========|| Check if you are inside the Administrators group or if you have enabled any token that can be use to escalate privileges like SeImpersonatePrivilege, SeAssignPrimaryPrivilege, SeTcbPrivilege, SeBackupPrivilege, SeRestorePrivilege, SeCreateTokenPrivilege, SeLoadDriverPrivilege, SeTakeOwnershipPrivilege, SeDebbugPrivilege"
Write-Host "https://book.hacktricks.xyz/windows-hardening/windows-local-privilege-escalation#users-and-groups" -ForegroundColor Yellow
Start-Process whoami.exe -ArgumentList "/all" -Wait -NoNewWindow
Write-Host ""
if ($eXnXvGIj99) { TimeElapsed }
Write-Host -ForegroundColor Blue "=========|| Cloud Credentials Check"
$Users = (Get-ChildItem C:\Users).Name
$BcpzayJu99 = @(".aws\credentials",
  "AppData\Roaming\gcloud\credentials.db",
  "AppData\Roaming\gcloud\legacy_credentials",
  "AppData\Roaming\gcloud\access_tokens.db",
  ".azure\accessTokens.json",
  ".azure\azureProfile.json") 
foreach ($u in $users) {
  $BcpzayJu99 | ForEach-Object {
    if (Test-Path "c:\$u\$_") { Write-Host "$_ found!" -ForegroundColor Red }
  }
}
Write-Host ""
if ($eXnXvGIj99) { TimeElapsed }
Write-Host -ForegroundColor Blue "=========|| APPcmd Check"
if (Test-Path ("$Env:SystemRoot\System32\inetsrv\appcmd.exe")) {
  Write-Host "https://book.hacktricks.xyz/windows-hardening/windows-local-privilege-escalation#appcmd.exe" -ForegroundColor Yellow
  Write-Host "$Env:SystemRoot\System32\inetsrv\appcmd.exe exists!" -ForegroundColor Red
}
Write-Host ""
if ($eXnXvGIj99) { TimeElapsed }
Write-Host -ForegroundColor Blue "=========|| OpenVPN Credentials Check"
$keys = Get-ChildItem "HKCU:\Software\OpenVPN-GUI\configs" -ErrorAction SilentlyContinue
if ($Keys) {
  Add-Type -AssemblyName System.Security
  $items = $keys | ForEach-Object { Get-ItemProperty $_.PsPath }
  foreach ($item in $items) {
    $TlbMYVEO99 = $item.'auth-data'
    $ziyttpTq99 = $item.'entropy'
    $ziyttpTq99 = $ziyttpTq99[0..(($ziyttpTq99.Length) - 2)]
    $NtpmaJJf99 = [System.Security.Cryptography.ProtectedData]::Unprotect(
      $TlbMYVEO99, 
      $ziyttpTq99, 
      [System.Security.Cryptography.DataProtectionScope]::CurrentUser)
 
    Write-Host ([System.Text.Encoding]::Unicode.GetString($NtpmaJJf99))
  }
}
Write-Host ""
if ($eXnXvGIj99) { TimeElapsed }
Write-Host -ForegroundColor Blue "=========|| PowerShell History (Password Search Only)"
Write-Host "=|| PowerShell Console History"
Write-Host "=|| To see all history, run this command: Get-Content (Get-PSReadlineOption).HistorySavePath"
Write-Host $(Get-Content (Get-PSReadLineOption).HistorySavePath | Select-String pa)
Write-Host "=|| AppData PSReadline Console History "
Write-Host "=|| To see all history, run this command: Get-Content $env:USERPROFILE\AppData\Roaming\Microsoft\Windows\PowerShell\PSReadline\ConsoleHost_history.txt"
Write-Host $(Get-Content "$env:USERPROFILE\AppData\Roaming\Microsoft\Windows\PowerShell\PSReadline\ConsoleHost_history.txt" | Select-String pa)
Write-Host "=|| PowesRhell default transrcipt history check "
if (Test-Path $env:SystemDrive\transcripts\) { "Default transcripts found at $($env:SystemDrive)\transcripts\" }
Write-Host ""
if ($eXnXvGIj99) { TimeElapsed }
Write-Host -ForegroundColor Blue "=========|| ENVIRONMENT VARIABLES "
Write-Host "Maybe you can take advantage of modifying/creating a binary in some of the following locations"
Write-Host "PATH variable entries permissions - place binary or DLL to execute instead of legitimate"
Write-Host "https://book.hacktricks.xyz/windows-hardening/windows-local-privilege-escalation#dll-hijacking" -ForegroundColor Yellow
Get-ChildItem env: | Format-Table -Wrap
Write-Host ""
if ($eXnXvGIj99) { TimeElapsed }
Write-Host -ForegroundColor Blue "=========|| Sticky Notes Check"
if (Test-Path "C:\Users\$env:USERNAME\AppData\Local\Packages\Microsoft.MicrosoftStickyNotes*\LocalState\plum.sqlite") {
  Write-Host "Sticky Notes database found. Could have credentials in plain text: "
  Write-Host "C:\Users\$env:USERNAME\AppData\Local\Packages\Microsoft.MicrosoftStickyNotes*\LocalState\plum.sqlite"
}
Write-Host ""
if ($eXnXvGIj99) { TimeElapsed }
Write-Host -ForegroundColor Blue "=========|| Cached Credentials Check"
Write-Host "https://book.hacktricks.xyz/windows-hardening/windows-local-privilege-escalation#windows-vault" -ForegroundColor Yellow 
cmdkey.exe /list
Write-Host ""
if ($eXnXvGIj99) { TimeElapsed }
Write-Host -ForegroundColor Blue "=========|| Checking for DPAPI RPC Master Keys"
Write-Host "Use the Mimikatz 'dpapi::masterkey' module with appropriate arguments (/rpc) to decrypt"
Write-Host "https://book.hacktricks.xyz/windows-hardening/windows-local-privilege-escalation#dpapi" -ForegroundColor Yellow
$otPuFree99 = "C:\Users\$env:USERNAME\AppData\Roaming\Microsoft\"
$HFaUzFFJ99 = "C:\Users\$env:USERNAME\AppData\Local\Microsoft\"
if ( Test-Path "$otPuFree99\Protect\") {
  Write-Host "found: $otPuFree99\Protect\"
  Get-ChildItem -Path "$otPuFree99\Protect\" -Force | ForEach-Object {
    Write-Host $_.FullName
  }
}
if ( Test-Path "$HFaUzFFJ99\Protect\") {
  Write-Host "found: $HFaUzFFJ99\Protect\"
  Get-ChildItem -Path "$HFaUzFFJ99\Protect\" -Force | ForEach-Object {
    Write-Host $_.FullName
  }
}
Write-Host ""
if ($eXnXvGIj99) { TimeElapsed }
Write-Host -ForegroundColor Blue "=========|| Checking for DPAPI Cred Master Keys"
Write-Host "Use the Mimikatz 'dpapi::cred' module with appropriate /masterkey to decrypt" 
Write-Host "You can also extract many DPAPI masterkeys from memory with the Mimikatz 'sekurlsa::dpapi' module" 
Write-Host "https://book.hacktricks.xyz/windows-hardening/windows-local-privilege-escalation#dpapi" -ForegroundColor Yellow
if ( Test-Path "$otPuFree99\Credentials\") {
  Get-ChildItem -Path "$otPuFree99\Credentials\" -Force
}
if ( Test-Path "$HFaUzFFJ99\Credentials\") {
  Get-ChildItem -Path "$HFaUzFFJ99\Credentials\" -Force
}
Write-Host ""
if ($eXnXvGIj99) { TimeElapsed }
Write-Host -ForegroundColor Blue "=========|| Current Logged on Users"
try { quser }catch { Write-Host "'quser' command not not present on system" } 
Write-Host ""
if ($eXnXvGIj99) { TimeElapsed }
Write-Host -ForegroundColor Blue "=========|| Remote Sessions"
try { qwinsta } catch { Write-Host "'qwinsta' command not present on system" }
Write-Host ""
if ($eXnXvGIj99) { TimeElapsed }
Write-Host -ForegroundColor Blue "=========|| Kerberos tickets (does require admin to interact)"
try { klist } catch { Write-Host "No active sessions" }
Write-Host ""
if ($eXnXvGIj99) { TimeElapsed }
Write-Host -ForegroundColor Blue "=========|| Printing ClipBoard (if any)"
geezers
Write-Host ""
if ($eXnXvGIj99) { TimeElapsed }
Write-Host -ForegroundColor Blue "=========|| Unattended Files Check"
@("C:\Windows\sysprep\sysprep.xml",
  "C:\Windows\sysprep\sysprep.inf",
  "C:\Windows\sysprep.inf",
  "C:\Windows\Panther\Unattended.xml",
  "C:\Windows\Panther\Unattend.xml",
  "C:\Windows\Panther\Unattend\Unattend.xml",
  "C:\Windows\Panther\Unattend\Unattended.xml",
  "C:\Windows\System32\Sysprep\unattend.xml",
  "C:\Windows\System32\Sysprep\unattended.xml",
  "C:\unattend.txt",
  "C:\unattend.inf") | ForEach-Object {
  if (Test-Path $_) {
    Write-Host "$_ found."
  }
}
Write-Host ""
if ($eXnXvGIj99) { TimeElapsed }
Write-Host -ForegroundColor Blue "=========|| SAM / SYSTEM Backup Checks"
@(
  "$Env:windir\repair\SAM",
  "$Env:windir\System32\config\RegBack\SAM",
  "$Env:windir\System32\config\SAM",
  "$Env:windir\repair\system",
  "$Env:windir\System32\config\SYSTEM",
  "$Env:windir\System32\config\RegBack\system") | ForEach-Object {
  if (Test-Path $_ -ErrorAction SilentlyContinue) {
    Write-Host "$_ Found!" -ForegroundColor red
  }
}
Write-Host ""
if ($eXnXvGIj99) { TimeElapsed }
Write-Host -ForegroundColor Blue "=========|| Group Policy Password Check"
$SCnstztS99 = @("Groups.xml", "Services.xml", "Scheduledtasks.xml", "DataSources.xml", "Printers.xml", "Drives.xml")
if (Test-Path "$env:SystemDrive\Microsoft\Group Policy\history") {
  Get-ChildItem -Recurse -Force "$env:SystemDrive\Microsoft\Group Policy\history" -Include @GroupPolicy
}
if (Test-Path "$env:SystemDrive\Documents and Settings\All Users\Application Data\Microsoft\Group Policy\history" ) {
  Get-ChildItem -Recurse -Force "$env:SystemDrive\Documents and Settings\All Users\Application Data\Microsoft\Group Policy\history"
}
Write-Host ""
if ($eXnXvGIj99) { TimeElapsed }
Write-Host -ForegroundColor Blue "=========|| Recycle Bin TIP:"
Write-Host "if credentials are found in the recycle bin, tool from nirsoft may assist: http://www.nirsoft.net/password_recovery_tools.html" -ForegroundColor Yellow
Write-Host ""
if ($eXnXvGIj99) { TimeElapsed }
Write-Host -ForegroundColor Blue "=========||  Password Check in Files/Folders"
if ($eXnXvGIj99) { TimeElapsed }
Write-Host -ForegroundColor Blue "=========|| Password Check. Starting at root of each drive. This will take some time. Like, grab a coffee or tea kinda time."
Write-Host -ForegroundColor Blue "=========|| Looking through each drive, searching for $sAVVouJf99"
try { New-Object -ComObject Excel.Application | Out-Null; $StZbPGMw99 = $true }catch {$StZbPGMw99 = $false; if($Excel){
  Write-Host -ForegroundColor Yellow "Host does not have Excel COM object, will still point out excel files when found."
}}
$SxSHAzdh99.Root | ForEach-Object {
  $Drive = $_
  Get-ChildItem $Drive -Recurse -Include $sAVVouJf99 -ErrorAction SilentlyContinue -Force | ForEach-Object {
    $path = $_
    if ($Path.FullName | select-string "(?i).*lang.*") {
    }
    if($Path.FullName | Select-String "(?i).:\\.*\\.*Pass.*"){
      write-host -ForegroundColor Blue "$($path.FullName) contains the word 'pass'"
    }
    if($Path.FullName | Select-String ".:\\.*\\.*user.*" ){
      Write-Host -ForegroundColor Blue "$($path.FullName) contains the word 'user' -excluding the 'users' directory"
    }
    elseif ($Path.FullName | Select-String ".*\.xls",".*\.xlsm",".*\.xlsx") {
      if ($StZbPGMw99 -and $Excel) {
        Morgan -jyBFQPPE99 $Path.FullName -gGVzLmjQ99 "user"
        Morgan -jyBFQPPE99 $Path.FullName -gGVzLmjQ99 "pass"
      }
    }
    else {
      if ($path.Length -gt 0) {
      }
      if ($path.FullName | Select-String "(?i).*SiteList\.xml") {
        Write-Host "Possible MCaffee Site List Found: $($_.FullName)"
        Write-Host "Just going to leave this here: https://github.com/funoverip/mcafee-sitelist-pwd-decryption" -ForegroundColor Yellow
      }
      $DCCHnjuI99.keys | ForEach-Object {
        $qBwfXIqJ99 = Get-Content $path.FullName -ErrorAction SilentlyContinue -Force | Select-String $DCCHnjuI99[$_] -Context 1, 1
        if ($qBwfXIqJ99) {
          Write-Host "Possible Password found: $_" -ForegroundColor Yellow
          Write-Host $Path.FullName
          Write-Host -ForegroundColor Blue "$_ triggered"
          Write-Host $qBwfXIqJ99 -ForegroundColor Red
        }
      }
    }  
  }
}
Write-Host -ForegroundColor Blue "=========|| Registry Password Check"
Write-Host "This will take some time. Won't you have a pepsi?"
$ymYLTOyi99 = @("registry::\HKEY_CURRENT_USER\", "registry::\HKEY_LOCAL_MACHINE\")
foreach ($r in $ymYLTOyi99) {
(Get-ChildItem -Path $r -Recurse -Force -ErrorAction SilentlyContinue) | ForEach-Object {
    $XDKvTpIo99 = $_.property
    $Name = $_.Name
    $XDKvTpIo99 | ForEach-Object {
      $Prop = $_
      $DCCHnjuI99.keys | ForEach-Object {
        $value = $DCCHnjuI99[$_]
        if ($Prop | Where-Object { $_ -like $value }) {
          Write-Host "Possible Password Found: $Name\$Prop"
          Write-Host "Key: $_" -ForegroundColor Red
        }
        $Prop | ForEach-Object {   
          $UPCTfFfq99 = (Get-ItemProperty "registry::$Name").$_
          if ($UPCTfFfq99 | Where-Object { $_ -like $Value }) {
            Write-Host "Possible Password Found: $name\$_ $UPCTfFfq99"
          }
        }
      }
    }
  }
  if ($eXnXvGIj99) { TimeElapsed }
  Write-Host "Finished $r"
}
