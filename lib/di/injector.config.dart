// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:get_it/get_it.dart' as _i174;
import 'package:google_sign_in/google_sign_in.dart' as _i116;
import 'package:injectable/injectable.dart' as _i526;

import '../features/auth/data/datasources/auth_remote_data_source.dart'
    as _i719;
import '../features/auth/data/repositories/auth_repository.dart' as _i243;
import '../features/auth/data/repositories/auth_repository_impl.dart' as _i570;
import '../features/domain/usercase/sign_in_with_google_usecase.dart' as _i219;
import '../features/domain/usercase/sign_out_usecase.dart' as _i85;
import '../features/presentation/blocs/auth_bloc.dart' as _i691;
import 'firebae_module.dart' as _i836;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final firebaseModule = _$FirebaseModule();
    gh.lazySingleton<_i59.FirebaseAuth>(() => firebaseModule.firebaseAuth);
    gh.lazySingleton<_i116.GoogleSignIn>(() => firebaseModule.googleSignIn);
    gh.lazySingleton<_i719.AuthRemoteDataSource>(
      () => _i719.AuthRemoteDataSourceImpl(
        firebaseAuth: gh<_i59.FirebaseAuth>(),
        googleSignIn: gh<_i116.GoogleSignIn>(),
      ),
    );
    gh.lazySingleton<_i243.AuthRepository>(
      () => _i570.AuthRepositoryImpl(
        remoteDataSource: gh<_i719.AuthRemoteDataSource>(),
      ),
    );
    gh.factory<_i219.SignInWithGoogleUseCase>(
      () => _i219.SignInWithGoogleUseCase(gh<_i243.AuthRepository>()),
    );
    gh.factory<_i85.SignOutUseCase>(
      () => _i85.SignOutUseCase(gh<_i243.AuthRepository>()),
    );
    gh.factory<_i691.AuthBloc>(
      () => _i691.AuthBloc(
        signInWithGoogleUseCase: gh<_i219.SignInWithGoogleUseCase>(),
        signOutUseCase: gh<_i85.SignOutUseCase>(),
      ),
    );
    return this;
  }
}

class _$FirebaseModule extends _i836.FirebaseModule {}
