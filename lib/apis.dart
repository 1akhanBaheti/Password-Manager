class Apis {
  static const baseApi = "https://my-cred.herokuapp.com";
  static String login = "$baseApi/api/auth/login";
  static String register = "$baseApi/api/auth/register";
  static String getUserDetails = "$baseApi/api/auth/user";
  static String allPasswords = "$baseApi/api/passwords";
  static String passwordDetails = "$baseApi/api/passwords/id";
  static String deletePassword = "$baseApi/api/passwords/id";
  static String editPassword = "$baseApi/api/passwords/id";
  static String savePassword = "$baseApi/api/passwords";
}
