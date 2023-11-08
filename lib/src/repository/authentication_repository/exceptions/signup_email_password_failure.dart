
class SignUpWithEmailAndPasswordFailure{
  final String message;

  const SignUpWithEmailAndPasswordFailure([this.message = " Ocorreu um erro desconhecido"]);

  factory SignUpWithEmailAndPasswordFailure.code(String code){
    switch(code){
      case 'weak-password':
        return const SignUpWithEmailAndPasswordFailure('por favor insira uma senha mais forte');
      case 'invalid-email':
        return const SignUpWithEmailAndPasswordFailure('o e-mail não é válido ou está mal formatado');
        case 'email-already-in-use':
        return const SignUpWithEmailAndPasswordFailure('já existe uma conta para esse e-mail');
        case 'operation-not-allowed':
        return const SignUpWithEmailAndPasswordFailure('operação não é permitida. entre em contato com o suporte');
        case 'user-disabled':
        return const SignUpWithEmailAndPasswordFailure('este usuário foi desativado. entre em contato com o suporte para obter ajuda');
        default:
        return const SignUpWithEmailAndPasswordFailure();
    }
  }

}