import '../../models/member.dart';

class AuthState {
  Member? member;
  AuthState({
    this.member,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AuthState && other.member == member;
  }
  @override
  int get hashCode => member.hashCode;
}
class AuthLoggedIn extends AuthState {
  AuthLoggedIn(Member member) : super(member: member);
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AuthState && other.member == member;
  }

  @override
  int get hashCode => member.hashCode;
}

class AuthGuestLoggedIn extends AuthState {
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AuthState && other.member == member;
  }

  @override
  int get hashCode => member.hashCode;
}
