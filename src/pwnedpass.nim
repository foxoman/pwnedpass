#[
             __          __ __    __      __ __
          |__)|  ||\ ||_ |  \  |__) /\ (_ (_
          |   |/\|| \||__|__/  |   /--\__)__)
                                v: 2.0.2 @foxoman

  A command line utility that lets you check if a passphrase has been
  pwned using the Pwned Passwords v3 API.

  All provided password data is k-anonymized before sending to the API,
  so plaintext passwords never leave your computer.

  ** See: https://haveibeenpwned.com/Passwords
]#
import std/[sha1, strscans], strutils, puppy

const
  apiUrl = "https://api.pwnedpasswords.com/range/"

proc rangeCheck(hash: SecureHash): int =
  result = 0

  let prefix = ($hash)[0..<5]
  let suffix = ($hash)[5..^1]

  let response = Request(url: parseUrl(apiUrl & prefix), verb: "get").fetch()

  if response.code == 200:
    for line in response.body.splitLines():
      let (ok, scannedSuffix, occurance) = scanTuple(line, "$+:$i")
      if ok:
        if suffix == scannedSuffix:
          return occurance
  elif response.code == 429:
    stderr.writeLine "[*] Too many requests — the rate limit has been exceeded."
  else:
    stderr.writeLine "[*] Unknown Error."

proc pwnedCheck*(password: string): int =
  ## Get the password hash and return the corresponding password's occurrences
  ## in the Pwned Passwords database using the rangecheck method
  ##
  ## * See Here ** https://www.troyhunt.com/ive-just-launched-pwned-passwords-version-2/
  let hash = secureHash(password)
  return rangeCheck(hash)

when isMainModule:
  import termui
  # https://github.com/molnarmark/colorize
  const ansiResetStyle* = "\e[0m"
  # foreground colors
  const ansiForegroundRed* = "\e[31m"
  const ansiForegroundGreen* = "\e[32m"
  const ansiForegroundYellow* = "\e[33m"
  const ansiForegroundDarkGray* = "\e[90m"
  const ansiForegroundLightGreen* = "\e[92m"
  const ansiForegroundLightBlue* = "\e[94m"
  # # formatting functions
  const ansiBold* = "\e[1m"
  const ansiUnderline* = "\e[2m"

  echo """
           __          __ __    __      __ __
          |__)|  ||\ ||_ |  \  |__) /\ (_ (_
          |   |/\|| \||__|__/  |   /--\__)__)
                                v: 2.0.2 @foxoman

  A command line utility that lets you check if a passphrase has been
  pwned using the Pwned Passwords v3 API.

  All provided password data is k-anonymized before sending to the API,
  so plaintext passwords never leave your computer.

  ** See: https://haveibeenpwned.com/Passwords

  """

  stdout.writeLine "*".repeat(70) & "\n"

  var password = termuiAskPassword("Please enter a passphrase to check if has been pwned:")
  if password.len == 0:
    stderr.writeLine "[*] No passphrase entered."
  else:
    let occurrences = pwnedCheck(password)
    if occurrences == 0:
      termuiLabel(ansiForegroundGreen & "Wow, Your passphrase look secure." &
          ansiResetStyle, "NOT Pwned!")
    else:
      termuiLabel(ansiForegroundRed & "Oh no -- Pwned!" & ansiResetStyle &
          " Your passphrase was found to be used:",

"$1 times!" % [$occurrences])
  termuiLabel(ansiForegroundRed & "[**WARN**]" & ansiResetStyle, "This password has previously appeared in a data breach\n\t\tand should never be used.\n\t\tIf you've ever used it anywhere before, change it!")

stdout.writeLine "\n" & "*".repeat(70)
  stdout.write "\n\n\t\t** PRESS" & ansiBold & ansiUnderline & " ENTER " &
      ansiResetStyle & "KEY TO EXIT **"
  discard stdin.readChar()
