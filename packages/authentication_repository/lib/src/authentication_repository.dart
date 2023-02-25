import 'dart:async';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {
  //deklarasikan controller yang mengelola AuthenticationStatus secara stream
  final _controller = StreamController<AuthenticationStatus>();

  //bagian ini yg selalu 'mengalir' menotifikasi aplikasi apakah user in or out
  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));

    //defaultnya buat AuthenticationStatus bernilai 'unauthenticated'
    //bisa juga disini ambil nilai nya apakah authenticated or unauthenticated by sharedpreferences
    yield AuthenticationStatus.unauthenticated;

    //masukkan Authentication sebagai variabel yg di 'Stream' atau dialirkan agar status/state nya bisa dimonitor
    yield* _controller.stream;
  }

  Future<void> logIn({
    required String username,
    required String password,
  }) async {
    //misal disini bisa operasi API untuk ambil token
    //jika berhasil maka return berupa status AuthenticationStatus=authenticated
    await Future.delayed(
      const Duration(milliseconds: 300),
      () => _controller.add(AuthenticationStatus.authenticated),
    );
  }

  void logOut() {
    //misal proses hapus token di sharepreferences agar tidak login lagi
    //dan masukkan dalam stream authenticationstatus dengan state unauthenticated
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => _controller.close();
}
