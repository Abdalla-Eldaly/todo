bool InvalidEmail (String email)
{
  return  RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);
}

bool InvalidPassword(String password)
{
  return RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
      .hasMatch(password);
}
bool Invalidfullname(String fullname)
{
  return RegExp(r'^[a-z A-Z,.\-]+$')
      .hasMatch(fullname);
}

