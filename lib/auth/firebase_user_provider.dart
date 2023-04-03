import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class AdoteFirebaseUser {
  AdoteFirebaseUser(this.user);
  User? user;
  bool get loggedIn => user != null;
}

AdoteFirebaseUser? currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<AdoteFirebaseUser> adoteFirebaseUserStream() => FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<AdoteFirebaseUser>(
      (user) {
        currentUser = AdoteFirebaseUser(user);
        return currentUser!;
      },
    );
