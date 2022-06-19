import std/[sha1,strscans], strutils, puppy, termui

const apiUrl = "https://api.pwnedpasswords.com/range/"

proc rangeCheck(hash: SecureHash): int =
  ## Takes a SHA1 hash and returns the corresponding password's occurrences
  ## in the Pwned Passwords database.
  result = 0

  let prefix = ($hash)[0..<5]
  let suffix = ($hash)[5..^1]

  let response = Request(url: parseUrl(apiUrl & prefix), verb: "get").fetch()

  var sufx: string
  var occ: int

  if response.code == 200:
    for line in response.body.splitLines():
      discard scanf(line, "$+:$i", sufx, occ)
      if suffix == sufx:
        return occ
  elif response.code == 429:
    stderr.writeLine "[*] Too many requests — the rate limit has been exceeded."
  else:
    stderr.writeLine "[*] Unknown Error."

when isMainModule:
  echo """
           __          __ __    __      __ __
          |__)|  ||\ ||_ |  \  |__) /\ (_ (_
          |   |/\|| \||__|__/  |   /--\__)__)
                                v: 1.0 @foxoman

  A command line utility that lets you check if a passphrase has been
  pwned using the Pwned Passwords v2 API.

  All provided password data is k-anonymized before sending to the API,
  so plaintext passwords never leave your computer.

  ** See: https://haveibeenpwned.com/Passwords
  """
  var password = termuiAskPassword("Please enter a passphrase to check if has been pwned:")
  if password.len == 0:
    stderr.writeLine "[*] No passphrase entered."
  else:
    let hash = secureHash(password)
    let occurrences = rangeCheck(hash)
    if occurrences == 0:
      termuiLabel("Wow, Your passphrase look secure,", "NOT Pwned!")
    else:
      termuiLabel("Oh no -- Pwned! Your passphrase was found to be used:", "$1 times!" % [$occurrences])
      termuiLabel("[**WARN**]", "This password has previously appeared in a data breach and should never be used. If you've ever used it anywhere before, change it!")
