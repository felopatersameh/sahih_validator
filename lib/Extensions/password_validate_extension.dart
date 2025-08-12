int calculateCharsetSize(String input) {
  bool hasLower = RegExp(r'[a-z]').hasMatch(input);
  bool hasUpper = RegExp(r'[A-Z]').hasMatch(input);
  bool hasDigits = RegExp(r'[0-9]').hasMatch(input);
  bool hasSpecial = RegExp(r'[^a-zA-Z0-9]').hasMatch(input);

  int size = 0;
  if (hasLower) size += 26;
  if (hasUpper) size += 26;
  if (hasDigits) size += 10;
  if (hasSpecial) size += 32; // Common special chars

  return size;
}

const weakPasswords = [
  '','password', '123456', '12345678', '123456789', '12345',
  'qwerty', 'abc123', 'password1', '1234567', '111111',
  '123123', 'admin', 'welcome', 'login', 'passw0rd',
  '123abc', 'letmein', 'monkey', 'sunshine', 'master',
  'hello', 'freedom', 'whatever', 'qazwsx', 'trustno1',
  'dragon', 'baseball', 'superman', 'iloveyou', 'starwars',
  'football', '123qwe', 'admin123', 'welcome123', 'password123',
  '1234', '12345', '123456', '1234567', '12345678',
  '123456789', '1234567890', 'qwerty', 'qwerty123', 'qwertyuiop',
  'password', 'password1', 'password123', 'admin', 'admin123',
  'welcome', 'welcome123', 'login', 'login123', 'passw0rd',
  'letmein', 'monkey', 'sunshine', 'master', 'hello',
  'freedom', 'whatever', 'qazwsx', 'trustno1', 'dragon',
  'baseball', 'superman', 'iloveyou', 'starwars', 'football',
  '123qwe', '1q2w3e4r', '1qaz2wsx', 'access', 'batman',
  'mustang', 'shadow', 'michael', 'jordan', 'harley',
  'hunter', 'buster', 'soccer', 'tigger', 'test',
  'test123', 'guest', 'killer', 'jennifer', 'george',
  'michelle', 'andrew', 'charlie', 'daniel', 'thomas',
  'matthew', 'joshua', 'ashley', 'nicole', 'justin',
  'basketball', 'pepper', 'hockey', 'banana', 'orange',
  'apple', 'computer', 'internet', 'silver', 'gold'
];