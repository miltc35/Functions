# Powershell function that takes an arbitrarily long string parameter $foo (e.g. 'abcdedcba') and returns the first recurring character in that Input string.
# In 'abcdedcba', 'd' would be the first recurring character, so the cmdlet/function should return 'd' for that sample input.

function Find-FirstCharacterRecurrence ($testString) {
    $testList = @()
    $indexList = @()
    $testStringChars = $testString.toCharArray()

    # Determine Char with recurrence and create list of Char to test - only test char recurrence
    Foreach($char in $testStringChars){
        $charCount = $testString.toCharArray() | Where-Object {$_ -eq $char}
        if($charCount.length -gt 1){
            if($testList -notcontains $char){
                $testList = $testList + $char
            }
        }    
    }

    if($testList.Count -lt 1){Return $null} # Return null if no recurrance of characters in string

    # Determine index of second recurrence of char in the string
    Foreach ($char in $testList){
        $firstrecurrence = $testString.IndexOf($char)
        $remainingString = $testString.substring($firstrecurrence +1)
        $nextrecurrence = $remainingString.indexof($char) + 1
        $indexOfNextrecurrence = $firstrecurrence + $nextrecurrence
        $indexList = $indexList + $indexOfNextrecurrence
    }
    # Determine first recurrence by checking list for the minimum value
    $firstRerecurrence = $indexList | measure -Minimum
    Return $testStringChars[$firstRerecurrence.Minimum]
    
}


$foo = 'abcdedcba'

$firstrecurrence = Find-FirstCharacterRecurrence $foo

