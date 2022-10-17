import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snp_garbage_collection/src/core/core.dart';
import 'package:snp_garbage_collection/src/payment/example.dart';
import 'package:http/http.dart' as http;

class PaymentDetailPage extends StatefulWidget {
  const PaymentDetailPage({
    Key? key,
    required this.nameUser,
    required this.smcUser,
  }) : super(key: key);
  final String nameUser;
  final String smcUser;

  @override
  State<PaymentDetailPage> createState() => _PaymentDetailPageState();
}

class _PaymentDetailPageState extends State<PaymentDetailPage> {
  List<PaymentModel> f = [];
  late final Future<List<PaymentModel>> myFuture;
  @override
  void initState() {
    super.initState();
    myFuture = getPayment();
  }

  Future<List<PaymentModel>> getPayment() async {
    String baseUrl =
        'https://staging.sekmaimunicipalcouncild2d.com/api/payments/${widget.smcUser}';
    final pref = await SharedPreferences.getInstance();
    String? extractUser = pref.getString('token');
    // logger.i('extraUsere$extractUser');
    // logger.e('payment$extractUser');
    List<PaymentModel> l = [];
    final url = Uri.parse(baseUrl);
    try {
      final reponse = await http.get(url, headers: {
        "Token": extractUser!,
      });
      var d = jsonDecode(reponse.body) as List;
      var r = d.length;
      logger.i({'Length of payment $r'});
      var e = d.map((e) => PaymentModel.fromJson(e)).toList();
      if (mounted) {
        setState(() {
          f = e;
        });
      }
    } catch (error) {
      rethrow;
    }
    return l;
  }

  String body = json.encode({
    'customer_id': '127',
    'month': '1',
    'year': '2022',
    'geo_location': "24.747031,93.948389"
  });
  void payDone() async {
    String baseUrl =
        'https://staging.sekmaimunicipalcouncild2d.com/api/payments';
    final pref = await SharedPreferences.getInstance();
    String? extractUser = pref.getString('token');
    final url = Uri.parse(baseUrl);
    try {
      final respon = await http.post(
        url,
        headers: {
          "Token": extractUser!,
        },
        body: body,
      );
    } catch (error) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.nameUser),
      ),
      body: FutureBuilder<List<PaymentModel>>(
        future: myFuture,
        builder: (context, snapshot) => snapshot.hasData
            ? f.isEmpty
                ? const Center(
                    child: Text('No Due'),
                  )
                : ListView.separated(
                    separatorBuilder: (context, index) => const Divider(),
                    itemCount: f.length,
                    itemBuilder: (c, i) {
                      final item = f[i];
                      IconData icon = FontAwesomeIcons.store;
                      Color backgroundColor = Colors.amber;
                      Color color = Colors.black87;

                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          child: FaIcon(
                            (FontAwesomeIcons.creditCard),
                            size: 21,
                            color: color,
                          ),
                        ),
                        title: Column(
                          children: [
                            Row(
                              children: [Text(item.monthName), Text(item.year)],
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Row(
                              children: [
                                Text("Rs: ${item.amount}"),
                              ],
                            ),
                          ],
                        ),
                        subtitle: Column(
                          children: const [],
                        ),
                        trailing: ElevatedButton(
                            onPressed: () => showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                      // title: const Text('Payment'),
                                      content: const Text(
                                          'Are you sure you want to pay this payment '),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, 'Cancel'),
                                          child: const Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, 'OK'),
                                          child: const Text('OK'),
                                        ),
                                      ],
                                    )),
                            child: Text('Pay')),
                        onTap: () {
                          /// This will clear previously selected data or photo
                          // context.read<CustomerPhotoCubit>().reset();
                        },
                      );
                    })
            :

            // By default, show a loading spinner.
            const Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
