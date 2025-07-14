import 'package:get_it/get_it.dart';
import 'package:mission_up/data/datasources/auth/auth_datasource.dart';
import 'package:mission_up/data/datasources/auth/auth_datasource_impl.dart';
import 'package:mission_up/data/datasources/task_type/task_type_datasource.dart';
import 'package:mission_up/data/datasources/task_type/task_type_datasource_impl.dart';
import 'package:mission_up/data/repositories/auth_repositoryImpl.dart';
import 'package:mission_up/data/repositories/task_type_repositoryImpl.dart';
import 'package:mission_up/domain/repositories/auth_repository.dart';
import 'package:mission_up/domain/repositories/task_type_repository.dart';
import 'package:mission_up/domain/usecases/auth/get_current_user_usecase.dart';
import 'package:mission_up/domain/usecases/auth/login_with_code_usecase.dart';
import 'package:mission_up/domain/usecases/auth/login_with_email_usecase.dart';
import 'package:mission_up/domain/usecases/auth/login_with_social_usecase.dart';
import 'package:mission_up/domain/usecases/auth/logout_usecase.dart';
import 'package:mission_up/domain/usecases/auth/register_with_email_usecase.dart';
import 'package:mission_up/domain/usecases/task_types/create_tasks_types_usecase.dart';
import 'package:mission_up/domain/usecases/task_types/get_tasks_types_usecase.dart';
import 'package:mission_up/domain/usecases/task_types/update_task_types_usecase.dart';
import 'package:mission_up/ui/viewmodels/home/create_activities_viewmodel.dart';
import 'package:mission_up/ui/viewmodels/home/main_viewmodel.dart';
import 'package:mission_up/ui/viewmodels/home/activities_viewmodel.dart';
import 'package:mission_up/ui/viewmodels/home/profile_viewmodel.dart';
import 'package:mission_up/ui/viewmodels/presentation/login_tutor_viewmodel.dart';
import 'package:mission_up/ui/viewmodels/presentation/login_user_viewmodel.dart';
import 'package:mission_up/ui/viewmodels/presentation/presentation_viewmodel.dart';
import 'package:mission_up/ui/viewmodels/presentation/register_tutor_viewmodel.dart';

final di = GetIt.instance;

void initServiceLocator() {
  //DataSources
  di.registerLazySingleton<AuthDatasource>(() => AuthDatasourceImpl());
  di.registerLazySingleton<TaskTypeDatasource>(() => TaskTypeDatasourceImpl());

  //Repositorios
  di.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(di()));
  di.registerLazySingleton<TaskTypeRepository>(
    () => TaskTypeRepositoryImpl(di()),
  );

  //USE CASES - Auth
  di.registerLazySingleton(() => GetCurrentUserUseCase(di()));
  di.registerLazySingleton(() => LoginWithCodeUsecase(di()));
  di.registerLazySingleton(() => LoginWithEmailUseCase(di()));
  di.registerLazySingleton(() => LoginWithSocialUsecase(di()));
  di.registerLazySingleton(() => LogOutUseCase(di()));
  di.registerLazySingleton(() => RegisterWithEmailUseCase(di()));

  //USE CASES - TaskType
  di.registerLazySingleton(() => GetTasksTypesUsecase(di()));
  di.registerLazySingleton(() => CreateTasksTypesUsecase(di()));
  di.registerLazySingleton(() => UpdateTaskTypesUsecase(di()));

  //ViewModels
  di.registerFactory(() => PresentationViewmodel());
  di.registerFactory(() => LoginUserViewmodel(di<LoginWithCodeUsecase>()));
  di.registerFactory(
    () => RegisterTutorViewModel(di<RegisterWithEmailUseCase>()),
  );
  di.registerFactory(
    () => LoginTutorViewmodel(
      di<LoginWithEmailUseCase>(),
      di<LoginWithSocialUsecase>(),
    ),
  );
  di.registerFactory(() => MainViewmodel(di<GetCurrentUserUseCase>()));
  di.registerFactory(
    () => ActivitiesViewModel(
      di<GetTasksTypesUsecase>(),
      di<UpdateTaskTypesUsecase>(),
    ),
  );
  di.registerFactory(
    () => CreateActivitiesViewmodel(
      di<CreateTasksTypesUsecase>(),
      di<UpdateTaskTypesUsecase>(),
      di<GetCurrentUserUseCase>(),
    ),
  );
  di.registerFactory(() => ProfileViewModel(di<LogOutUseCase>()));
}
