import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:snp_garbage_collection/src/core/constant/constant.dart';

class LocationPermissionView extends StatefulWidget {
  const LocationPermissionView({Key? key, required this.child})
      : super(key: key);

  final Widget child;

  @override
  _LocationPermissionViewState createState() => _LocationPermissionViewState();
}

class _LocationPermissionViewState extends State<LocationPermissionView>
    with AfterLayoutMixin<LocationPermissionView> {
  PermissionStatus permissionStatus = PermissionStatus.denied;

  @override
  Widget build(BuildContext context) {
    switch (permissionStatus) {
      case PermissionStatus.denied:
        return _AskPermission(
          onPressed: initPermission,
        );
      case PermissionStatus.granted:
        return widget.child;
      case PermissionStatus.permanentlyDenied:
        return _PermissionIsBlocked(
          onPressed: initPermission,
        );
      default:
        return Container();
    }
  }

  @override
  void afterFirstLayout(BuildContext context) {
    initPermission();
  }

  Future<void> initPermission() async {
    final s = await Permission.location.status;
    setState(() {
      permissionStatus = s;
    });

    if (permissionStatus.isDenied) {
      final status = await Permission.location.request();
      setState(() {
        permissionStatus = status;
      });
    }
  }
}

class _AskPermission extends StatelessWidget {
  const _AskPermission({Key? key, required this.onPressed}) : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.subtitle1;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            KImage.location,
            width: 100,
            height: 100,
          ),
          const SizedBox(height: 21),
          Text(
            'Please give access to your location',
            style: style,
          ),
          const SizedBox(height: 21),
          ElevatedButton(
            onPressed: onPressed,
            child: const Text('Grant'),
          ),
        ],
      ),
    );
  }
}

class _PermissionIsBlocked extends StatelessWidget {
  const _PermissionIsBlocked({Key? key, required this.onPressed})
      : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.subtitle1;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            KImage.location,
            width: 100,
            height: 100,
          ),
          const SizedBox(height: 21),
          Text(
            'You Have completely Deny location Permission',
            style: style,
          ),
          const SizedBox(height: 21),
          ElevatedButton(
            onPressed: () async {
              if (await openAppSettings()) {
                onPressed();
              }
            },
            child: const Text('Open App Setting'),
          ),
        ],
      ),
    );
  }
}
