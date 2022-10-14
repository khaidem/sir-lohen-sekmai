import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:snp_garbage_collection/src/core/core.dart';
import 'package:snp_garbage_collection/src/core/extension/theme.extension.dart';
import 'package:snp_garbage_collection/src/router/router.dart';

class CustomerCardView extends StatelessWidget {
  const CustomerCardView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey.shade100,
      elevation: 0.5,
      child: InkWell(
        onTap: () {
          context.router.push(const CustomersRoute());
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // const FaIcon(
              //   FontAwesomeIcons.users,
              //   size: 115,
              //   color: Colors.amber,
              // ),

              Image.asset(
                KImage.man,
                height: 115,
              ),
              const SizedBox(height: 16),
              Text(
                "Customer List",
                style: context.theme.textTheme.subtitle2?.copyWith(
                  color: Colors.black54,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
