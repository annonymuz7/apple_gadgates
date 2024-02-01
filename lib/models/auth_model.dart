/// result : true
/// token : "1b248e428dc8b9d89761ebe8ecf673de65a75e1b8bbf34a5fd229d2bb3e3eb49"

class AuthModel {
  late bool result;
  late String token;

  static AuthModel? fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    AuthModel authModelBean = AuthModel();
    authModelBean.result = map['result'];
    authModelBean.token = map['token'];
    return authModelBean;
  }

  Map toJson() => {
    "result": result,
    "token": token,
  };
}