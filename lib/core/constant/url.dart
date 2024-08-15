
class AppUrl {
  static String ip = '192.168.1.5';
  static String baseUrl = 'http://$ip:8000/api/v1/students';
  static String signUpUrl = "$baseUrl/auth/register";
  static String loginUrl = "$baseUrl/auth/login";
  static String logOutUrl = "$baseUrl/auth/logout";
  static String checkEmailRegister = "$baseUrl/auth/check-code";
  static String checkEmailForget = "$baseUrl/auth/verify";
  static String resendCodeRegister = "$baseUrl/auth/resend-code";
  static String forgetPasswordUrl = "$baseUrl/auth/forget-password";
  static String resetPassword = "$baseUrl/auth/reset-password";
  static String quiz = "$baseUrl/courses";
  static String recommended = "$baseUrl/home";
  static String latest = "$baseUrl/home";
  static String categories = "$baseUrl/home";
  static String sendQuiz = "$baseUrl/quizzes";
  static String contactUs = "$baseUrl/issues";
  static String favorite = "$baseUrl/courses/favorites";
  static String profile = "$baseUrl/profile";
  static String updateprofile = "$baseUrl/profile";
}
