# pwnedpass

           __          __ __    __      __ __
          |__)|  ||\ ||_ |  \  |__) /\ (_ (_
          |   |/\|| \||__|__/  |   /--\__)__)
                                v: 1.0 @foxoman

  A command line utility that lets you check if a passphrase has been
  pwned using the Pwned Passwords v2 API.

  All provided password data is k-anonymized before sending to the API,
  so plaintext passwords never leave your computer.

  ** See: https://haveibeenpwned.com/Passwords

see[this article](https://www.troyhunt.com/ive-just-launched-pwned-passwords-version-2/)
for more details.

## Installation

First get [Nimble](https://github.com/nim-lang/nimble). Then run:

```bash
nimble install https://github.com/foxoman/pwnedpass
```

## Usage

```bash
$ pwnedpass
> Please enter a passphrase to check if has been pwned: => •••••••••••
> Oh no -- Pwned! Your passphrase was found to be used: => 2 times!
> [**WARN**] => This password has previously appeared in a data breach and should never be used. If you've ever used it anywhere before, change it!
```
