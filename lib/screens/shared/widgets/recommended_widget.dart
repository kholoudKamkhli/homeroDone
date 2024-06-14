import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:homero/models/service_model.dart';
import '../../../controllers/database/recommendation_database.dart';
import '../../../models/reccomendation_model.dart';
import '../../../models/worker_model.dart';
import '../../service_details/service_details_view.dart';

class RecommendedWidget extends StatefulWidget {
  RecommendationModel recommendationModel;

  RecommendedWidget({required this.recommendationModel});

  @override
  State<RecommendedWidget> createState() => _RecommendedWidgetState();
}

class _RecommendedWidgetState extends State<RecommendedWidget> {
  WorkerModel? worker;
  SubServiceModel ?subService2;
  late SubServiceModel subService;
  initRecommend()async{
    worker = await RecommendationDatabase.getRecommendedWorker(widget.recommendationModel.id);
    subService2 = await RecommendationDatabase.getRecommendedSubService(widget.recommendationModel.id);
    setState(() {
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initRecommend();
    setState(() {
    });
  }
  @override
  Widget build(BuildContext context) {
    return  worker!=null&&subService2!=null?Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      child: SizedBox(
        height:149 ,
        width: 370,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: SizedBox(
                height: 128,

                  child: Image.network(widget.recommendationModel.imagePath)),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SizedBox(height: 60,
                      child: Padding(
                        padding:  EdgeInsets.only(left: 5,top: 8,bottom: 8,right: MediaQuery.of(context).size.width*0.1),
                        child: Text(worker!.serviceName,style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          //color: Colors.black54
                        ),),
                      ),
                    ),
                    const SizedBox(width: 10,),
                    Row(
                      children: [
                        SizedBox(
                          width: 60,
                          height: 60,
                          child: IconButton(
                            icon: CircleAvatar(
                              radius: 50,
                              backgroundImage: NetworkImage(worker!.imagePath),
                            ),
                            color: Color.fromARGB(255, 52, 205, 196),
                            onPressed: () {
                              // do something
                            },
                          ),
                        ),
                        Text(worker!.name,style: const TextStyle(fontWeight: FontWeight.w400,fontSize: 12),)
                      ],
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text("Latest Reviews",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 12),),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(worker!.latestReview,style:Theme.of(context).textTheme.bodySmall,),
                ),
                Row(children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text("Rate",style:Theme.of(context).textTheme.bodySmall,),),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: RatingBar.builder(
                          initialRating: 3,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemSize: 20.0,
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                              color: Color.fromARGB(255, 52, 205, 196)
                          ),
                          onRatingUpdate: (rating) {
                            print(rating);
                          },
                        ),
                      )
                    ],
                  ),
                  InkWell(
                    onTap: (){
                      print("sending service with id ${subService2!.id}");
                      Navigator.pushNamed(context, ServiceDetailsView.routeName,arguments: {
                        'service': subService2,
                        'workerName': worker!.name,
                      },);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: Container(
                        alignment: Alignment.center,
                        width: 130,
                        height: 32,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 52, 205, 196),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child:  Text("Order Now",style: TextStyle(
                          color: Colors.
                            white
                        ),),
                      ),
                    ),
                  )

                ],)
              ],
            ),
          ],
        ),
      ),
    ):Center(child: CircularProgressIndicator(),);
  }
}
