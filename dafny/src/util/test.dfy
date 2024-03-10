/**
 *  Copyright 2022 ConsenSys Software Inc.
 */



module Tests {

    datatype TestStatus =
        Success() | Failure(msg: string)
    {
        function IsFailuer(): bool { Failure? }
        function PropagateFailure(): TestStatus { this }
    }


    /**
     *  C# strings for colour selection.
     */
    const RED := "001B[31m"
    const GREEN := "001B[32m"
    const YELLOW := "001B[33m"
    const BLUE := "001B[34m"
    const MAGENTA := "001B[35m"
    const RESET := "001B[0m"


    /**
     * Build test result
     */
    function makeTest(b: bool): TestStatus
    {
        if b then
            Success()
        else
            Failure("failed")
    }

    /**
     * Print colored test
     */

    method printTestResult(t: TestStatus, testId: string)
    {
         if (t.Success?) {
            print GREEN + "[Success] " + RESET + testId + "\n";
        } else {
            print RED + "[Fail] " + RESET + testId + " Msg:" + t.msg + "\n";
        }
    }

}
