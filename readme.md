# pwnedpass

           __          __ __    __      __ __
          |__)|  ||\ ||_ |  \  |__) /\ (_ (_
          |   |/\|| \||__|__/  |   /--\__)__)
                                v: 2.0.4 @foxoman

  A command line utility that lets you check if a passphrase has been
  pwned using the Pwned Passwords v3 API.

  All provided password data is k-anonymized before sending to the API,
  so plaintext passwords never leave your computer.

  ** See: https://haveibeenpwned.com/Passwords

see [this article](https://www.troyhunt.com/ive-just-launched-pwned-passwords-version-2/)
for more details.

## Installation

First get [Nimble](https://github.com/nim-lang/nimble). Then run:

```bash
nimble install pwnedpass
```
## API
```
pwnedCheck(passphrase)
```

*Example:*
```
import pwnedpass
let passphrase:string = stdin.readLine()
let occurance = pwnedCheck(passphrase)
echo "pwned: ", $occurance, " Times!"
```

## Usage as binary

```bash
$ pwnedpass
> Please enter a passphrase to check if has been pwned: => •••••••••••
> Oh no -- Pwned! Your passphrase was found to be used: => 2 times!
> [**WARN**] => This password has previously appeared in a data breach and should never be used. If you've ever used it anywhere before, change it!
```
