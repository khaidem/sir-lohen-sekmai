import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snp_garbage_collection/src/auth/auth.dart';
import 'package:snp_garbage_collection/src/auth/data/repo/disk.repo.dart';
import 'package:snp_garbage_collection/src/core/object_box/objectbox.dart';
import 'package:snp_garbage_collection/src/core/repo/repo.dart';
import 'package:snp_garbage_collection/src/customer/data/repo/customer.repo.dart';
import 'package:snp_garbage_collection/src/profile/data/repo/profile.repo.dart';
import 'package:snp_garbage_collection/src/qr_scanner/data/repo/garbages.repo.dart';
import 'package:snp_garbage_collection/src/services/chopper_services/auth/auth.service.dart';
import 'package:snp_garbage_collection/src/services/chopper_services/customer/customers.service.dart';
import 'package:snp_garbage_collection/src/services/chopper_services/garbages/garbages.service.dart';
import 'package:snp_garbage_collection/src/services/chopper_services/profile/profile.service.dart';
import 'package:snp_garbage_collection/src/services/services.dart';

class MultiRepositoryProviderWrapper extends StatelessWidget {
  const MultiRepositoryProviderWrapper({
    Key? key,
    required this.child,
    required this.sharedPreferences,
    required this.objectbox,
  }) : super(key: key);

  final Widget child;
  final SharedPreferences sharedPreferences;
  final ObjectBox objectbox;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<DiskRepo>(
          create: (context) => DiskRepo(sharedPreferences: sharedPreferences),
        ),
        RepositoryProvider<ObjectBoxRepo>(
          create: (context) => ObjectBoxRepo(objectBox: objectbox),
        ),
        RepositoryProvider<AuthRepo>(
          create: (context) => AuthRepo(chopper.getService<AuthService>()),
        ),
        RepositoryProvider<GarbageRepo>(
          create: (context) => GarbageRepo(
            chopper.getService<GarbagesService>(),
          ),
        ),
        RepositoryProvider<CustomerRepo>(
          create: (context) => CustomerRepo(
            customersService: chopper.getService<CustomersService>(),
          ),
        ),
        RepositoryProvider<ProfileRepo>(
          create: (context) => ProfileRepo(
            service: chopper.getService<ProfileService>(),
          ),
        ),
      ],
      child: child,
    );
  }
}
