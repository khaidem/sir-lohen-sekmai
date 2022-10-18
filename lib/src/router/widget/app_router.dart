import 'package:auto_route/auto_route.dart';
import 'package:snp_garbage_collection/src/auth/auth.dart';
import 'package:snp_garbage_collection/src/camera/pages/camera.page.dart';
import 'package:snp_garbage_collection/src/core/flow/authentication_flow/authentication.flow.dart';
import 'package:snp_garbage_collection/src/customer/pages/pages.dart';
import 'package:snp_garbage_collection/src/home/home.dart';
import 'package:snp_garbage_collection/src/main/pages/main.page.dart';
import 'package:snp_garbage_collection/src/draft/pages/pages.dart';
import 'package:snp_garbage_collection/src/profile/pages/pages.dart';
import 'package:snp_garbage_collection/src/qr_scanner/pages/pages.dart';

import '../../payment/example.dart';
import '../../payment/pages/customer_details_search.page.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(
      initial: true,
      page: AuthenticationFlow,
      name: 'AuthenticationRoute',
      children: [
        AutoRoute(
          page: LoginPage,
        ),

        // Main Screen With Bottom Nav Bar
        AutoRoute(
          page: MainPage,
          children: [
            AutoRoute(
              path: "Home",
              name: "HomeTabRouter",
              page: EmptyRouterPage,
              children: [
                AutoRoute(path: '', page: HomePage),
                AutoRoute(page: QRCameraPage, name: 'QRCameraRoute'),
                AutoRoute(page: CameraPage, name: 'CameraRoute'),
                AutoRoute(page: ScannerResultPage, name: 'ScannerResultRoute'),
                AutoRoute(page: CustomersPage, name: 'CustomersRoute'),
                AutoRoute(
                  page: CustomerDetailsPage,
                  name: 'CustomerDetailsRoute',
                ),
                AutoRoute(page: PaymentPage, name: 'PaymentRoute'),
                AutoRoute(
                  page: CustomerDetailsSearchPage,
                  name: 'CustomerDetailsSearchRoute',
                ),
                AutoRoute(page: PaymentDetailPage, name: 'PaymentDetailsRoute'),
                RedirectRoute(path: '*', redirectTo: ''),
              ],
            ),
            AutoRoute(
              path: "draft",
              name: "DraftTabRouter",
              page: EmptyRouterPage,
              children: [
                AutoRoute(path: '', page: DraftPage),
                RedirectRoute(path: '*', redirectTo: ''),
              ],
            ),
            AutoRoute(
              path: "profileTab",
              name: "ProfileTabRouter",
              page: EmptyRouterPage,
              children: [
                AutoRoute(path: '', page: ProfilePage),
                RedirectRoute(path: '*', redirectTo: ''),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
)
class $AppRouter {}
