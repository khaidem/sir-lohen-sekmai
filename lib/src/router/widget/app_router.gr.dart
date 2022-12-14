// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i4;
import 'package:flutter/material.dart' as _i12;

import '../../auth/auth.dart' as _i2;
import '../../camera/pages/camera.page.dart' as _i7;
import '../../core/flow/authentication_flow/authentication.flow.dart' as _i1;
import '../../customer/customer.dart' as _i13;
import '../../customer/pages/pages.dart' as _i8;
import '../../draft/pages/pages.dart' as _i10;
import '../../home/home.dart' as _i5;
import '../../main/pages/main.page.dart' as _i3;
import '../../payment/example.dart' as _i9;
import '../../profile/pages/pages.dart' as _i11;
import '../../qr_scanner/pages/pages.dart' as _i6;

class AppRouter extends _i4.RootStackRouter {
  AppRouter([_i12.GlobalKey<_i12.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i4.PageFactory> pagesMap = {
    AuthenticationRoute.name: (routeData) {
      return _i4.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.AuthenticationFlow());
    },
    LoginRoute.name: (routeData) {
      return _i4.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.LoginPage());
    },
    MainRoute.name: (routeData) {
      return _i4.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i3.MainPage());
    },
    HomeTabRouter.name: (routeData) {
      return _i4.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i4.EmptyRouterPage());
    },
    DraftTabRouter.name: (routeData) {
      return _i4.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i4.EmptyRouterPage());
    },
    ProfileTabRouter.name: (routeData) {
      return _i4.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i4.EmptyRouterPage());
    },
    HomeRoute.name: (routeData) {
      return _i4.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i5.HomePage());
    },
    QRCameraRoute.name: (routeData) {
      return _i4.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i6.QRCameraPage());
    },
    CameraRoute.name: (routeData) {
      return _i4.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i7.CameraPage());
    },
    ScannerResultRoute.name: (routeData) {
      return _i4.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i6.ScannerResultPage());
    },
    CustomersRoute.name: (routeData) {
      return _i4.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i8.CustomersPage());
    },
    CustomerDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<CustomerDetailsRouteArgs>();
      return _i4.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i8.CustomerDetailsPage(
              key: args.key, customerModel: args.customerModel));
    },
    PaymentRoute.name: (routeData) {
      return _i4.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i9.PaymentPage());
    },
    PaymentDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<PaymentDetailsRouteArgs>();
      return _i4.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i9.PaymentDetailPage(
              key: args.key,
              userName: args.userName,
              customerNo: args.customerNo));
    },
    DraftRoute.name: (routeData) {
      return _i4.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i10.DraftPage());
    },
    ProfileRoute.name: (routeData) {
      return _i4.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i11.ProfilePage());
    }
  };

  @override
  List<_i4.RouteConfig> get routes => [
        _i4.RouteConfig(AuthenticationRoute.name, path: '/', children: [
          _i4.RouteConfig(LoginRoute.name,
              path: 'login-page', parent: AuthenticationRoute.name),
          _i4.RouteConfig(MainRoute.name,
              path: 'main-page',
              parent: AuthenticationRoute.name,
              children: [
                _i4.RouteConfig(HomeTabRouter.name,
                    path: 'Home',
                    parent: MainRoute.name,
                    children: [
                      _i4.RouteConfig(HomeRoute.name,
                          path: '', parent: HomeTabRouter.name),
                      _i4.RouteConfig(QRCameraRoute.name,
                          path: 'q-rcamera-page', parent: HomeTabRouter.name),
                      _i4.RouteConfig(CameraRoute.name,
                          path: 'camera-page', parent: HomeTabRouter.name),
                      _i4.RouteConfig(ScannerResultRoute.name,
                          path: 'scanner-result-page',
                          parent: HomeTabRouter.name),
                      _i4.RouteConfig(CustomersRoute.name,
                          path: 'customers-page', parent: HomeTabRouter.name),
                      _i4.RouteConfig(CustomerDetailsRoute.name,
                          path: 'customer-details-page',
                          parent: HomeTabRouter.name),
                      _i4.RouteConfig(PaymentRoute.name,
                          path: 'payment-page', parent: HomeTabRouter.name),
                      _i4.RouteConfig(PaymentDetailsRoute.name,
                          path: 'payment-detail-page',
                          parent: HomeTabRouter.name),
                      _i4.RouteConfig('*#redirect',
                          path: '*',
                          parent: HomeTabRouter.name,
                          redirectTo: '',
                          fullMatch: true)
                    ]),
                _i4.RouteConfig(DraftTabRouter.name,
                    path: 'draft',
                    parent: MainRoute.name,
                    children: [
                      _i4.RouteConfig(DraftRoute.name,
                          path: '', parent: DraftTabRouter.name),
                      _i4.RouteConfig('*#redirect',
                          path: '*',
                          parent: DraftTabRouter.name,
                          redirectTo: '',
                          fullMatch: true)
                    ]),
                _i4.RouteConfig(ProfileTabRouter.name,
                    path: 'profileTab',
                    parent: MainRoute.name,
                    children: [
                      _i4.RouteConfig(ProfileRoute.name,
                          path: '', parent: ProfileTabRouter.name),
                      _i4.RouteConfig('*#redirect',
                          path: '*',
                          parent: ProfileTabRouter.name,
                          redirectTo: '',
                          fullMatch: true)
                    ])
              ])
        ])
      ];
}

/// generated route for [_i1.AuthenticationFlow]
class AuthenticationRoute extends _i4.PageRouteInfo<void> {
  const AuthenticationRoute({List<_i4.PageRouteInfo>? children})
      : super(name, path: '/', initialChildren: children);

  static const String name = 'AuthenticationRoute';
}

/// generated route for [_i2.LoginPage]
class LoginRoute extends _i4.PageRouteInfo<void> {
  const LoginRoute() : super(name, path: 'login-page');

  static const String name = 'LoginRoute';
}

/// generated route for [_i3.MainPage]
class MainRoute extends _i4.PageRouteInfo<void> {
  const MainRoute({List<_i4.PageRouteInfo>? children})
      : super(name, path: 'main-page', initialChildren: children);

  static const String name = 'MainRoute';
}

/// generated route for [_i4.EmptyRouterPage]
class HomeTabRouter extends _i4.PageRouteInfo<void> {
  const HomeTabRouter({List<_i4.PageRouteInfo>? children})
      : super(name, path: 'Home', initialChildren: children);

  static const String name = 'HomeTabRouter';
}

/// generated route for [_i4.EmptyRouterPage]
class DraftTabRouter extends _i4.PageRouteInfo<void> {
  const DraftTabRouter({List<_i4.PageRouteInfo>? children})
      : super(name, path: 'draft', initialChildren: children);

  static const String name = 'DraftTabRouter';
}

/// generated route for [_i4.EmptyRouterPage]
class ProfileTabRouter extends _i4.PageRouteInfo<void> {
  const ProfileTabRouter({List<_i4.PageRouteInfo>? children})
      : super(name, path: 'profileTab', initialChildren: children);

  static const String name = 'ProfileTabRouter';
}

/// generated route for [_i5.HomePage]
class HomeRoute extends _i4.PageRouteInfo<void> {
  const HomeRoute() : super(name, path: '');

  static const String name = 'HomeRoute';
}

/// generated route for [_i6.QRCameraPage]
class QRCameraRoute extends _i4.PageRouteInfo<void> {
  const QRCameraRoute() : super(name, path: 'q-rcamera-page');

  static const String name = 'QRCameraRoute';
}

/// generated route for [_i7.CameraPage]
class CameraRoute extends _i4.PageRouteInfo<void> {
  const CameraRoute() : super(name, path: 'camera-page');

  static const String name = 'CameraRoute';
}

/// generated route for [_i6.ScannerResultPage]
class ScannerResultRoute extends _i4.PageRouteInfo<void> {
  const ScannerResultRoute() : super(name, path: 'scanner-result-page');

  static const String name = 'ScannerResultRoute';
}

/// generated route for [_i8.CustomersPage]
class CustomersRoute extends _i4.PageRouteInfo<void> {
  const CustomersRoute() : super(name, path: 'customers-page');

  static const String name = 'CustomersRoute';
}

/// generated route for [_i8.CustomerDetailsPage]
class CustomerDetailsRoute extends _i4.PageRouteInfo<CustomerDetailsRouteArgs> {
  CustomerDetailsRoute(
      {_i12.Key? key, required _i13.CustomerModel customerModel})
      : super(name,
            path: 'customer-details-page',
            args: CustomerDetailsRouteArgs(
                key: key, customerModel: customerModel));

  static const String name = 'CustomerDetailsRoute';
}

class CustomerDetailsRouteArgs {
  const CustomerDetailsRouteArgs({this.key, required this.customerModel});

  final _i12.Key? key;

  final _i13.CustomerModel customerModel;
}

/// generated route for [_i9.PaymentPage]
class PaymentRoute extends _i4.PageRouteInfo<void> {
  const PaymentRoute() : super(name, path: 'payment-page');

  static const String name = 'PaymentRoute';
}

/// generated route for [_i9.PaymentDetailPage]
class PaymentDetailsRoute extends _i4.PageRouteInfo<PaymentDetailsRouteArgs> {
  PaymentDetailsRoute(
      {_i12.Key? key, required String userName, required String customerNo})
      : super(name,
            path: 'payment-detail-page',
            args: PaymentDetailsRouteArgs(
                key: key, userName: userName, customerNo: customerNo));

  static const String name = 'PaymentDetailsRoute';
}

class PaymentDetailsRouteArgs {
  const PaymentDetailsRouteArgs(
      {this.key, required this.userName, required this.customerNo});

  final _i12.Key? key;

  final String userName;

  final String customerNo;
}

/// generated route for [_i10.DraftPage]
class DraftRoute extends _i4.PageRouteInfo<void> {
  const DraftRoute() : super(name, path: '');

  static const String name = 'DraftRoute';
}

/// generated route for [_i11.ProfilePage]
class ProfileRoute extends _i4.PageRouteInfo<void> {
  const ProfileRoute() : super(name, path: '');

  static const String name = 'ProfileRoute';
}
