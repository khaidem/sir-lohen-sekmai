import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snp_garbage_collection/src/core/core.dart';
import 'package:snp_garbage_collection/src/core/helper/get_position.dart';
import 'package:snp_garbage_collection/src/payment/example.dart';
import 'package:http/http.dart' as http;

class PaymentDetailPage extends StatefulWidget {
  const PaymentDetailPage({
    Key? key,
    required this.userName,
    required this.customerNo,
  }) : super(key: key);
  final String userName;
  final String customerNo;

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

//*** This Method will show all the user who did not pay or no due */

  Future<List<PaymentModel>> getPayment() async {
    String baseUrl =
        'https://staging.sekmaimunicipalcouncild2d.com/api/payments/${widget.customerNo}';
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

  //*** This Method will pay the amount */
  Future payDone(
    String customerId,
    String month,
    String year,
  ) async {
    String baseUrl =
        'https://staging.sekmaimunicipalcouncild2d.com/api/payments';
    final pref = await SharedPreferences.getInstance();
    String? extractUser = pref.getString('token');
    final url = Uri.parse(baseUrl);
    Position _position = await getPosition();

    _position;
    try {
      await http.post(
        url,
        headers: {
          "Token": extractUser!,
        },
        body: json.encode({
          'customer_id': customerId,
          'month': month,
          'year': year,
          'geo_location': "${_position.latitude},${_position.longitude}"
        }),
      );
      // logger.e(response.toString());
    } catch (error) {
      rethrow;
    }
  }

  loadData() async {
    await getPayment();
  }

  @override
  Widget build(BuildContext context) {
    // loadData();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.userName),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.refresh))
        ],
      ),
      body: FutureBuilder<List<PaymentModel>>(
        future: getPayment(),
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
                      // IconData icon = FontAwesomeIcons.store;
                      // Color backgroundColor = Colors.amber;
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
                                      ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            payDone(item.customerId, item.month,
                                                item.year);
                                            print('setSate');
                                          });
                                          // getPayment();
                                          Navigator.pop(context);
                                          print('pop');
                                        },
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  )),
                          child: const Text('Pay'),
                        ),
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
