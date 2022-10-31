class Apis {
  static const baseApi = "";
  static String login = "$baseApi/api/auth/login";
  static String register = "$baseApi/api/auth/register";
  static String getUserDetails = "$baseApi/api/auth/user";
  static String allPasswords = "$baseApi/api/passwords";
  static String passwordDetails = "$baseApi/api/passwords/id";
  static String deletePassword = "$baseApi/api/passwords/id";
  static String editPassword = "$baseApi/api/passwords/id";
  static String addPassword = "$baseApi/api/passwords";
}
