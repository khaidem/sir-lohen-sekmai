import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:snp_garbage_collection/src/core/core.dart';
import 'package:snp_garbage_collection/src/core/extension/theme.extension.dart';
import 'package:snp_garbage_collection/src/core/helper/get_position.dart';
import 'package:snp_garbage_collection/src/core/helper/logger.dart';
import 'package:snp_garbage_collection/src/core/object_box/garbages_collection.box.dart';
import 'package:snp_garbage_collection/src/core/widgets/widgets.dart';
import 'package:snp_garbage_collection/src/customer/customer.dart';
import 'package:snp_garbage_collection/src/customer/logic/customer_photo/customer_photo_cubit.dart';
import 'package:snp_garbage_collection/src/draft/logic/draft/draft_cubit.dart';
import 'package:snp_garbage_collection/src/router/router.dart';
import 'package:uuid/uuid.dart';

class CustomerDetailsPage extends StatelessWidget {
  const CustomerDetailsPage({
    Key? key,
    required this.customerModel,
  }) : super(key: key);

  final CustomerModel customerModel;

  @override
  Widget build(BuildContext context) {
    return CustomerDetailsBlocListener(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Customer Details"),
        ),
        body: ListView(
          // crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            _CustomerInfoCard(customerModel: customerModel),
            const SizedBox(height: 8),
            CameraPermissionView(
              child: LocationPermissionView(
                child: CustomerPlaceImage(customerModel: customerModel),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 110),
              child: ElevatedButton(
                onPressed: () {
                  context.router.push(PaymentDetailsRoute(
                      userName: customerModel.name,
                      customerNo: customerModel.customerNo));
                },
                child: const Text('Payments'),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _CustomerInfoCard extends StatelessWidget {
  const _CustomerInfoCard({
    Key? key,
    required this.customerModel,
  }) : super(key: key);

  final CustomerModel customerModel;

  @override
  Widget build(BuildContext context) {
    final name = customerModel.name;
    final type = customerModel.customerType;
    final number = customerModel.customerNo;

    final nameStyle = context.theme.textTheme.headline6;
    final typeStyle = context.theme.textTheme.subtitle1;
    final numberStyle = context.theme.textTheme.subtitle2?.copyWith(
      color: Colors.black54,
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(number, style: numberStyle),
        const SizedBox(height: 4),
        Text(name, style: nameStyle, textAlign: TextAlign.center),
        const SizedBox(height: 8),
        Text(type, style: typeStyle),
      ],
    );
  }
}

class CustomerPlaceImage extends StatelessWidget {
  const CustomerPlaceImage({Key? key, required this.customerModel})
      : super(key: key);

  final CustomerModel customerModel;

  @override
  Widget build(BuildContext context) {
    // final item = customerModel;

    // final description = "Tap here to take a picture of customer's " +
    //     item.customerType.toLowerCase();
    const description = "Take a picture of customer's garbage being collected";

    final customerPhotoState = context.watch<CustomerPhotoCubit>().state;
    final imagePath = customerPhotoState.imagePath;
    final position = customerPhotoState.position;

    if (imagePath != null) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "lat: ${position?.latitude}, long: ${position?.longitude}",
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            AspectRatio(
              aspectRatio: 1,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                child: Container(
                  color: Colors.red,
                  child: Image(
                    image: FileImage(File(imagePath)),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _onPressedDelete(context),
                    icon: const Icon(Icons.delete),
                    label: const Text('Delete Photo'),
                    style: ElevatedButton.styleFrom(primary: Colors.red),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _onPressedSubmit(context),
                    icon: const Icon(Icons.upload),
                    label: const Text('Upload Photo'),
                    style: ElevatedButton.styleFrom(primary: Colors.green),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextButton.icon(
              onPressed: () => _onPressedSavePhotoSubmit(context),
              icon: const Icon(Icons.save_outlined),
              label: const Text('Save Photo to Draft'),
              // style: ElevatedButton.styleFrom(primary: Colors.black),
            ),
          ],
        ),
      );
    }

    return Center(
      child: DottedBorder(
        borderType: BorderType.RRect,
        radius: const Radius.circular(12),
        dashPattern: const [8, 4],
        color: Colors.grey.shade600,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          child: Container(
            padding: const EdgeInsets.all(16),
            color: Colors.grey.shade200,
            child: Column(
              children: [
                FaIcon(
                  FontAwesomeIcons.camera,
                  size: 75,
                  color: Colors.blueGrey.shade200,
                ),
                const SizedBox(height: 8),
                Text(description),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  icon: const FaIcon(FontAwesomeIcons.camera, size: 17),
                  label: const Text(
                    'Take a picture',
                    // style: context.theme.textTheme.button,
                  ),
                  onPressed: () => _onPressTakeCamera(context),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onPressTakeCamera(BuildContext context) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? photo = await _picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 720,
    );
    if (photo == null) return;

    logger.i(photo.path);

    final takenOn = getDateNow();
    final customerNo = customerModel.customerNo;
    final customerType = customerModel.customerType;
    final uuid = const Uuid().v4();

    // Getting the Image File extension like .jpg etc
    final imageType = p.extension(photo.path);

    // Creating image file name 67a40bd7-c41c-40a5-955a-d9e68843da3c_15-11-2021_SMC00002_RESIDENTIAL.jpg
    final savedImageName =
        '${uuid}_${takenOn}_${customerNo}_$customerType$imageType';

    // getting a directory path for saving
    final String path = (await getApplicationDocumentsDirectory()).path;
    final pathToSave = '$path/$savedImageName';

// copy the file to a new path
    await photo.saveTo(pathToSave);

    logger.i(pathToSave);

    context
        .read<CustomerPhotoCubit>()
        .photoSelected(pathToSave, savedImageName);
  }

  _onPressedDelete(BuildContext context) {
    context.read<CustomerPhotoCubit>().deletePhotoFromDisk();
  }

  _onPressedSubmit(BuildContext context) async {
    final customerPhotoState = context.read<CustomerPhotoCubit>().state;
    final imagePath = customerPhotoState.imagePath!;
    final position = customerPhotoState.position!;

    final box = GarbagesCollectionBox(
      collectionDate: getDateNow(),
      customerNo: customerModel.customerNo,
      imagePath: imagePath,
      latitude: position.latitude.toString(),
      longitude: position.longitude.toString(),
      name: customerModel.name,
      customerType: customerModel.customerType,
      isPhoto: true,
    );

    context.read<CustomerPhotoCubit>().uploadPhoto(box);
  }

  _onPressedSavePhotoSubmit(BuildContext context) async {
    final customerPhotoState = context.read<CustomerPhotoCubit>().state;
    final imagePath = customerPhotoState.imagePath!;
    final position = customerPhotoState.position!;

    final box = GarbagesCollectionBox(
      collectionDate: getDateNow(),
      customerNo: customerModel.customerNo,
      imagePath: imagePath,
      latitude: position.latitude.toString(),
      longitude: position.longitude.toString(),
      name: customerModel.name,
      customerType: customerModel.customerType,
      isPhoto: true,
    );

    context.read<DraftCubit>().addToDraft(box: box);
    AutoRouter.of(context).pop();
  }
}
