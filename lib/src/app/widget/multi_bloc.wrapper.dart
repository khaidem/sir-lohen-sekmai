import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snp_garbage_collection/src/auth/auth.dart';
import 'package:snp_garbage_collection/src/auth/data/repo/disk.repo.dart';
import 'package:snp_garbage_collection/src/auth/logic/login/login_cubit.dart';
import 'package:snp_garbage_collection/src/core/logic/logic.dart';
import 'package:snp_garbage_collection/src/core/repo/repo.dart';
import 'package:snp_garbage_collection/src/customer/data/repo/customer.repo.dart';
import 'package:snp_garbage_collection/src/customer/logic/customer_list/customer_list_cubit.dart';
import 'package:snp_garbage_collection/src/customer/logic/customer_photo/customer_photo_cubit.dart';
import 'package:snp_garbage_collection/src/customer_search/logic/customer_search/customer_search_bloc.dart';
import 'package:snp_garbage_collection/src/draft/logic/draft/draft_cubit.dart';
import 'package:snp_garbage_collection/src/profile/data/repo/profile.repo.dart';
import 'package:snp_garbage_collection/src/profile/logic/profile/profile_cubit.dart';
import 'package:snp_garbage_collection/src/qr_scanner/data/repo/garbages.repo.dart';
import 'package:snp_garbage_collection/src/qr_scanner/logic/garbages_collection_qrcode/garbages_collection_qrcode_cubit.dart';
import 'package:snp_garbage_collection/src/qr_scanner/logic/qr_scanner/qr_scanner_cubit.dart';

Future<String?> getToken() async {
  final p = await SharedPreferences.getInstance();
  final token = p.getString('token');
  return token;
}

class MultiBlocWrapper extends StatelessWidget {
  const MultiBlocWrapper({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    var authenticationState = const AuthenticationState(
      status: AuthenticationStatus.unauthorized,
    );

    final diskRepo = context.read<DiskRepo>();
    final authRepo = context.read<AuthRepo>();
    final garbageRepo = context.read<GarbageRepo>();
    final customerRepo = context.read<CustomerRepo>();
    final objectBoxRepo = context.read<ObjectBoxRepo>();
    final profileRepo = context.read<ProfileRepo>();
    final token = diskRepo.token;

    if (token != null) {
      authenticationState = AuthenticationState(
        status: AuthenticationStatus.authorized,
        token: token,
      );
    }

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthenticationCubit(
            state: authenticationState,
            diskRepo: diskRepo,
          ),
        ),
        BlocProvider(
          create: (context) => LoginCubit(
            authRepo: authRepo,
          ),
        ),
        BlocProvider(create: (context) => QrScannerCubit()),
        BlocProvider(
          create: (context) => DraftCubit(
            objectBoxRepo: objectBoxRepo,
            garbageRepo: garbageRepo,
          ),
        ),
        BlocProvider(
          create: (context) => GarbagesCollectionQrcodeCubit(
            garbageRepo: garbageRepo,
            draftCubit: context.read<DraftCubit>(),
          ),
        ),
        BlocProvider(
          create: (context) => CustomerListCubit(customerRepo: customerRepo),
        ),
        BlocProvider(
          create: (context) => CustomerSearchBloc(customerRepo: customerRepo),
        ),
        BlocProvider(
          create: (context) => CustomerPhotoCubit(
            repo: garbageRepo,
            draftCubit: context.read<DraftCubit>(),
          ),
        ),
        BlocProvider(
          create: (context) => ProfileCubit(profileRepo: profileRepo),
        ),
      ],
      child: child,
    );
  }
}
