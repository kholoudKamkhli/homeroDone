import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:homero/models/worker_model.dart';
import 'package:homero/screens/workers/worker_view.dart';

class WorkerWidget extends StatefulWidget {
  WorkerModel worker;
  Function changecolor;
  int index;
  WorkerWidget(
      {required this.worker,
      required this.changecolor,  required this.index,

      });

  @override
  State<WorkerWidget> createState() => _WorkerWidgetState();
}

class _WorkerWidgetState extends State<WorkerWidget> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        if(isSelected){
          numOfChoosenWorkers--;
          print("num of chosen workers $numOfChoosenWorkers");
          isSelected = !isSelected;
          widget.changecolor(isSelected,widget.index);
        }
        else{
          if(numOfChoosenWorkers==0){
            numOfChoosenWorkers++;
            print("num of choen workers $numOfChoosenWorkers");
            isSelected = !isSelected;
            print(isSelected);
            widget.changecolor(isSelected,widget.index);
          }
        }

        setState(() {

        });
     },
     //  onTap: (){
     //    widget.changecolor();
     //  },
      child: Card(
        color: isSelected==false?Theme.of(context).cardTheme.color:Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: SizedBox(
          height: 100,
          width: 370,
          child: Row(
            children: [
              Container(
                width: 62,
                height: 62,
                child: Image.network(widget.worker.imagePath),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 9, top: 6, bottom: 2),
                    child: Text(
                      widget.worker.name,
                      style: Theme.of(context).textTheme.bodyLarge),
                    ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 9, vertical: 8),
                        child: Text(
                          widget.worker.jobTitle,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                      const SizedBox(
                        width: 100,
                      ),
                      Text(
                        "${widget.worker.numOfRatings} Ratings",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Row(
                        children: [
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
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (rating) {
                                print(widget.worker.numOfRatings);
                              },
                            ),
                          ),
                          SizedBox(width:50),
                          Icon(Icons.done,color: Color.fromARGB(255, 126, 127, 131,),size: 14,),
                          SizedBox(width: 3,),
                          Text("${widget.worker.numOfTasks} Cleaning Tasks",style: Theme.of(context).textTheme.bodySmall)

                        ],
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
