import 'package:aspectumai/core/network/dio_client.dart';
import 'package:aspectumai/core/utils/shared_pref_utils.dart';
import 'package:aspectumai/features/auth/data/data_sources/auth_source.dart';
import 'package:aspectumai/features/auth/data/repositories/login_repository_impl.dart';
import 'package:aspectumai/features/auth/domain/repositories/login_repository.dart';
import 'package:aspectumai/features/auth/domain/usecases/login_usecase.dart';
import 'package:aspectumai/features/chat/data/data_sources/chat_source.dart';
import 'package:aspectumai/features/chat/data/repositories/chat_repository_impl.dart';
import 'package:aspectumai/features/chat/domain/repositories/chat_repository.dart';
import 'package:aspectumai/features/chat/domain/repositories/image_picker_repository.dart';
import 'package:aspectumai/features/chat/domain/usecases/send_chat.dart';
import 'package:aspectumai/features/chat/domain/usecases/send_chat_with_image.dart';
import 'package:aspectumai/features/chat/presentation/chat/bloc/chat/chat_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';

import 'features/auth/presentation/bloc/auth/auth_cubit.dart';
import 'features/auth/presentation/bloc/login/login_cubit.dart';
import 'features/chat/data/repositories/image_picker_repository_impl.dart';
import 'features/chat/domain/usecases/pick_image.dart';
import 'features/chat/presentation/chat/bloc/image_picker/image_picker_cubit.dart';

final sl = GetIt.instance;

Future<void> registerDependencies() async {
  final imagePicker = ImagePicker();

  sl.registerLazySingleton(() => imagePicker);

  sl.registerLazySingleton<DioClient>(() => DioClient());

  sl.registerFactory(() => SharePrefUtils());

  _dataSource();
  _repositories();
  _usecases();
  _bloc();
}

/* data sources */
void _dataSource() {
  sl.registerLazySingleton<ChatSource>(() => ChatSourceImpl(sl()));
  sl.registerLazySingleton<IAuthSource>(() => AuthSource(sl()));
}

/* repositories */
void _repositories() {
  sl.registerLazySingleton<ImagePickerRepository>(
    () => ImagePickerRepositoryImpl(imagePicker: sl()),
  );
  sl.registerLazySingleton<ChatRepository>(() => ChatRepositoryImpl(sl()));
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));
}

/* usecases */
void _usecases() {
  sl.registerLazySingleton(() => PickImageUseCase(sl()));
  sl.registerLazySingleton(() => SendChatUsecase(sl()));
  sl.registerLazySingleton(() => SendChatWithImageUsecase(sl()));

  /* auth */
  sl.registerLazySingleton(() => LoginUsecase(sl()));
}

/* blocs */
void _bloc() {
  sl.registerFactory(() => ImagePickerCubit(sl()));
  sl.registerFactory(() => ChatBloc(sl()));

  /* auth */
  sl.registerFactory(() => AuthCubit(sl()));
  sl.registerFactory(() => LoginCubit(sl(), sl()));
}
