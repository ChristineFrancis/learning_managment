class AppUrl {
  static String ip='192.168.1.102';
  static  String baseUrl='http://$ip:8000/api/v1/students';
  static String signUpUrl = "$baseUrl/auth/register";
  static String loginUrl = "$baseUrl/auth/login";
  static String logOutUrl = "$baseUrl/auth/logout";
  static String checkEmailRegister = "$baseUrl/auth/check-code";
  static String checkEmailForget = "$baseUrl/auth/verify";
  static String resendCodeRegister = "$baseUrl/auth/resend-code";
  static String forgetPasswordUrl = "$baseUrl/auth/forget-password";
  static String resetPassword = "$baseUrl/auth/reset-password";
  static String quiz = "$baseUrl/courses/1";
}
