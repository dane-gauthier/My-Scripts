Function ConvertFrom-CharToPhonetic {
    param(
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [string]$String
    )
 
    BEGIN {}
 
    PROCESS {
 
        foreach ( $Char in $String.GetEnumerator() ) {
            $Translator = @{
                'a' = 'Alfa';
                'b' = 'Bravo';
                'c' = 'Charlie';
                'd' = 'Delta';
                'e' = 'Echo';
                'f' = 'Foxtrot';
                'g' = 'Golf';
                'h' = 'Hotel';
                'i' = 'India';
                'j' = 'Juliett';
                'k' = 'Kilo';
                'l' = 'Lima';
                'm' = 'Mike';
                'n' = 'November';
                'o' = 'Oscar';
                'p' = 'Papa';
                'q' = 'Quebec';
                'r' = 'Romeo';
                's' = 'Sierra';
                't' = 'Tango';
                'u' = 'Uniform';
                'v' = 'Victor';
                'w' = 'Whiskey';
                'x' = 'X-ray';
                'y' = 'Yankee';
                'z' = 'Zulu';
                '0' = 'zero';
                '1' = 'one';
                '2' = 'two';
                '3' = 'three';
                '4' = 'four';
                '5' = 'five';
                '6' = 'six';
                '7' = 'seven';
                '8' = 'eight';
                '9' = 'nine';
                '*' = 'asterisk';
                '+' = 'plus';
                ',' = 'comma';
                '-' = 'dash';
                '.' = 'period';
                '/' = 'forward slash';
            }
            [string]$Value = $Translator.GetEnumerator() | Where-Object { $_.Name -eq $Char } | Select-Object -ExpandProperty Value
            if ( $Char -match '[0-9]') {
                $msg = '{0} - {1}' -f $msg,$Value.toUpper()
            }
            elseif ( $Char -cmatch '[a-z]') {
                $msg = '{0} - {1}' -f $msg,$Value.tolower()
            }
            elseif ( $Char -cmatch '[A-Z]') {
                $msg = '{0} - {1}' -f $msg,$Value.toUpper()
            }
            elseif ( $Char -cmatch '[*+,-./]') {
                $msg = '{0} - {1}' -f $msg,$Value.toUpper()
            }           
 
            Remove-Variable Char
        }
    }
 
    END {
        $msg.Substring(3,$($msg.Length - 3))
    }
 
}

Function Get-RandomPassword {
    param(
        [Parameter(Mandatory=$true)]
        [int]$Length
    )
 
    $ReturnString = ''
    $AvailableChar = 42..57 + 65..90 + 97..122
 
    $AvailableChar | Get-Random -Count $Length | ForEach-Object {
        $ReturnString += [char][byte]$_
    }
 
    Write-Host "Phonetic Spelling -&amp;amp;amp;amp;amp;gt; $(ConvertFrom-CharToPhonetic -string $ReturnString)" -ForegroundColor Yellow
    Write-Output $ReturnString
 
}