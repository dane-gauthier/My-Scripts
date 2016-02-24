 $computers='computer','computer'
$message='Message Goes Here'
 
ForEach($computer in $computers) {
    msg.exe * /SERVER:$computer /TIME:15 $message
}  
