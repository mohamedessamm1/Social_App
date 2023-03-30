
abstract class SignStates {}

class SignInitialState extends SignStates {}
class SiginRegisterLoadingState extends SignStates {}
class SignRegistrerrorState extends SignStates {}
class SignRegisterSuccessState extends SignStates {}

class SignPassState extends SignStates {}
class ChangeRememberMeState extends SignStates {}



class UserCreateLoadingState extends SignStates {}
class UserCreateSuccessState extends SignStates {}
class UserCreateerrorState extends SignStates {}
