
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../controllers/view_models/order_view_model.dart';

class PaymentHistory extends StatefulWidget {
  static const String routeName = "payment history";

  @override
  State<PaymentHistory> createState() => _PaymentHistoryState();
}

class _PaymentHistoryState extends State<PaymentHistory> {
  var orders;
  OrderViewModel orderViewModel = OrderViewModel();
  initOrders() async {
    orderViewModel.getAllOrders();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initOrders();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OrderViewModel>(
      create: (_)=>orderViewModel,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Payment History",
            style: Theme.of(context).appBarTheme.titleTextStyle,

          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back,
                ),
            onPressed: () => Navigator.pop(context),
          ),
          elevation: 0,
          centerTitle: true,
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            BlocBuilder<OrderViewModel,OrderState>(builder: (context,state){
              if(state is ErrorState){
                return Center(child: Text(state.errorMessage),);
              }
              else if(state is LoadedState){
                return ListView.builder(
                  itemBuilder: (buildContext, index) {
                    return Container(
                      margin:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                      height: 90,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.black12,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width:MediaQuery.of(context).size.width*0.5,
                                  child: const Text(
                                    "Service Ordered",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ),
                                Text(
                                  state.orders[index].serviceName,
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5,),
                            Row(
                              children: [
                                SizedBox(
                                  width:MediaQuery.of(context).size.width*0.5,
                                  child: const Text(
                                    "Amount Paid",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ),
                                Text(
                                  state.orders[index].cost.toString(),
                                  style: const TextStyle(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 5,),
                            Row(
                              children: [
                                SizedBox(
                                  width:MediaQuery.of(context).size.width*0.5,
                                  child: const Text(
                                    "Order status",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ),
                                Text(
                                  state.orders[index].isFinished?"Finished":"Scheduled",
                                  style: const TextStyle(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: state.orders!.length,
                );
              }
              else{
                return const Center(child: CircularProgressIndicator(),);
              }
            })
            ,
          ],
        ),
      ),
    );
  }
}
