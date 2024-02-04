# FreeAgent Coding Challenge

Thank you for your interest in the FreeAgent Coding Challenge.  This template is a barebones guide to get you started.  Please add any gems, folders, files, tests, etc. you see fit in order to produce a solution you're proud of.

## Coding Challenge Instructions

Please see the INSTRUCTIONS.md file for more information.

## Your Solution Setup and Run Instructions

Please include instructions on how to setup and run your solution here.

    No additional steps required further to the ones stated in INSTRUCTIONS.md

## Your Design Decisions

We'd love to hear your thoughts around any design decisions you made while coding your solution.

    Taking into account the fact that this program may need to be extended in the future to allow for calculation
    of exchange rates from varying file types, I decided to use a common interface to develop my solution. By
    having a general ExchangeRate class, I can then implement different subclasses for each file type. The child
    method fetch_exchange_rate overrides the parent method, allowing for different logic to be used for
    calculating from the different file type. 
    
    The instructions also state that new sources may not be based in EUR however no further implementation is
    required for this in my solution, since the exchange rates are simply calculated from the ratio of one to the
    other - not taking into account the base currency. I decided to add a few more tests relevant to the base
    currency because the base currency is not found within the file so there are a few exceptions to as of what
    should be calculated when this currency is used.

    Finally, I have read through the style-guide on github and have tried my best to use these practises in my code.