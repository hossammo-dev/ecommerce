abstract class AuthStates{}

class AuthInitState extends AuthStates{}

class AuthChangePassVisibilityState extends AuthStates{}
class AuthChangePageState extends AuthStates{}
class AuthLoadingState extends AuthStates{}

//login states
class AuthLoginSuccessState extends AuthStates{}
class AuthLoginErrorState extends AuthStates{}


//register states
class AuthRegisterSuccessState extends AuthStates{}
class AuthRegisterErrorState extends AuthStates{}

//logOut states
class AuthLogOutSuccessState extends AuthStates{}
class AuthLogOutErrorState extends AuthStates{}
