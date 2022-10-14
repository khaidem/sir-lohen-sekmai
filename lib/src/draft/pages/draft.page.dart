import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:snp_garbage_collection/src/core/core.dart';
import 'package:snp_garbage_collection/src/core/extension/theme.extension.dart';
import 'package:snp_garbage_collection/src/core/object_box/garbages_collection.box.dart';
import 'package:snp_garbage_collection/src/draft/draft.dart';
import 'package:snp_garbage_collection/src/draft/logic/draft/draft_cubit.dart';

class DraftPage extends StatelessWidget {
  const DraftPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final shouldShowFAB = context.watch<DraftCubit>().state.totalCount > 0;

    return DraftListener(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Drafts and Pending'),
        ),
        body: const _DraftList(),
        floatingActionButton: shouldShowFAB
            ? FloatingActionButton.extended(
                onPressed: () {
                  context.read<DraftCubit>().uploadAll();
                },
                label: Text('Upload all'.toUpperCase()),
              )
            : null,
      ),
    );
  }
}

class _DraftList extends StatelessWidget {
  const _DraftList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final draftCubit = context.watch<DraftCubit>();
    final list = draftCubit.state.draftList;

    if (list.isEmpty) {
      return Center(
        child: Text(
          'No drafts or pending',
          style: context.textTheme.headline6?.copyWith(color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        final item = list[index];

        IconData icon = FontAwesomeIcons.store;
        Color backgroundColor = Colors.amber;
        Color color = Colors.black87;

        if (item.customerType == "RESIDENTIAL") {
          icon = FontAwesomeIcons.home;
          backgroundColor = Colors.green;
          color = Colors.white;
        }

        return ListTile(
          leading: CircleAvatar(
            backgroundColor: backgroundColor,
            child: FaIcon(
              icon,
              size: 21,
              color: color,
            ),
          ),
          title: Text(item.name),
          subtitle: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                item.customerNo,
                style: context.theme.textTheme.subtitle2?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                item.collectionDate,
                style: context.theme.textTheme.subtitle2?.copyWith(
                  fontWeight: FontWeight.normal,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
          trailing: _getPreview(item),
          onTap: () {
            // draftCubit.deleteFromDraft(item.id);
            confirmDialog(context, item);
          },
        );
      },
    );
  }

  _getPreview(GarbagesCollectionBox item) {
    final qrString = item.qrString;
    final imagePath = item.imagePath;

    if (qrString != null && !item.isPhoto) {
      return QrImage(
        data: qrString,
        version: QrVersions.auto,
        size: 55.0,
      );
    }

    if (imagePath != null && item.isPhoto) {
      return Image(
        image: FileImage(File(imagePath)),
        fit: BoxFit.cover,
        height: 50,
        width: 50,
      );
    }
  }

  confirmDialog(BuildContext context, GarbagesCollectionBox item) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm'),
          content: const Text('Are you sure you want to delete this item?'),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(primary: Colors.red),
              label: const Text('Delete'),
              onPressed: () {
                Navigator.of(context).pop();
                context.read<DraftCubit>().deleteFromDraft(item.id);
              },
              icon: const Icon(Icons.delete),
            ),
          ],
        );
      },
    );
  }
}
