<#
Source: https://justagrad.wordpress.com/2010/01/20/part-ii-phonetic-string-generator-for-passwords-in-powershell/
#>

function generate-phonetics
{
    param([string]$Password)
     
    #Nato Alphabet
    $trans = @{
    "a" = "Alpha";
    "b" = "Bravo";
    "c" = "Charlie";
    "d" = "Delta";
    "e" = "Echo";
    "f" = "Foxtrot";
    "g" = "Golf";
    "h" = "Hotel";
    "i" = "India";
    "j" = "Juliet";
    "k" = "Kilo";
    "l" = "Lima";
    "m" = "Mike";
    "n" = "November";
    "o" = "Oscar";
    "p" = "Papa";
    "q" = "Quebec";
    "r" = "Romeo";
    "s" = "Sierra";
    "t" = "Tango";
    "u" = "Uniform";
    "v" = "Victor";
    "w" = "Whiskey";
    "x" = "X-Ray";
    "y" = "Yankee";
    "z" = "Zulu";
    "0" = "Zero";
    "1" = "One";
    "2" = "Two";
    "3" = "Three";
    "4" = "Four";
    "5" = "Five";
    "6" = "Six";
    "7" = "Seven";
    "8" = "Eight";
    "9" = "Nine";
    "@" = "At";
    "?" = "Question";
    "_" = "Underscore";
    "#" = "Hash";
    "&" = "Ampersand";
    "!" = "Exclamation";
    "-" = "Dash";
    "*" = "Asterisk";
    "+" = "Plus";
    "=" = "Equals";
    '"' = "DoubleQuote";
    "%" = "Percent";
    "'" = "SingleQuote";
    "(" = "LeftParens";
    ")" = "RightParens";
    "," = "Comma";
    "." = "Period";
    "/" = "ForeSlash";
    "\" = "BackSlash";
    ":" = "Colon";
    ";" = "SemiColon";
    "<" = "LessThan";
    ">" = "GreaterThan";
    "[" = "LeftBracket";
    "]" = "RightBracket";
    "{" = "LeftBrace";
    "}" = "RightBrace";
    "^" = "Caret";
    '`' = "Backtick";
    "|" = "Pipe";
    "~" = "Tilde";
    }
     
    $output = "("
    $charArray = $Password.ToCharArray()
    foreach ($char in $charArray) {
        if ([char]::IsDigit($char)) {
            $output = $output + $trans[$char.ToString().ToLower()] + " - "
             
        }elseif ([char]::IsUpper($char)){
            $output = $output + $trans[$char.ToString().ToLower()].ToUpper() + " - "
             
        }elseif ([char]::IsLower($char)) {
            $output = $output + $trans[$char.ToString().ToLower()].ToLower() + " - "
         
        }else {
            if ($trans.ContainsKey($char)) {
                $output = $output + $trans[$char.ToString().ToLower()] + " - "
                 
            }else {
                $output = $output + $char + " - "
             
            }
             
        }
    }
    return $output.SubString(0,$output.Length-3) + ")"
}

if ($Password -eq $null) {
    $Password = read-host 'What do you want to convert'
    generate-phonetics $Password
}