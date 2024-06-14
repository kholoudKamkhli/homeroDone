import 'package:cloud_firestore/cloud_firestore.dart';

List mainServices = [
  {
    "id": "1",
    "title": "Cleaning",
    "imageUrl":
        "https://firebasestorage.googleapis.com/v0/b/homear-intern.appspot.com/o/app_images%2FRectangle%202631.png?alt=media&token=366d1c16-2865-422d-8935-db852c7a01ff"
  },
  {
    "id": "2",
    "title": "Cooking",
    "imageUrl":
        "https://firebasestorage.googleapis.com/v0/b/homear-intern.appspot.com/o/app_images%2FVector.png?alt=media&token=92976e35-a871-4a8d-873e-4cce1a8f495f"
  },
  {
    "id": "3",
    "title": "Repair",
    "imageUrl":
        "https://firebasestorage.googleapis.com/v0/b/homear-intern.appspot.com/o/app_images%2FGroup.png?alt=media&token=d23c65f8-6308-4b56-9fc0-23e7c9efce13"
  },
  {
    "id": "4",
    "title": "Re-Organize",
    "imageUrl":
        "https://firebasestorage.googleapis.com/v0/b/homear-intern.appspot.com/o/app_images%2FGroup%2034941.png?alt=media&token=d137f3c3-23f1-4a3e-8353-8c8a052e8479"
  },
  {
    "id": "5",
    "title": "Beauty",
    "imageUrl":
        "https://firebasestorage.googleapis.com/v0/b/homear-intern.appspot.com/o/app_images%2FGroup%2034942.png?alt=media&token=6a9d195d-cdff-4cd8-86a8-e8d06d3c4e0e"
  }
];

List supServices = [
  [
    {
      "id": "1",
      "title": "Deep",
      "imageUrl":
          "https://firebasestorage.googleapis.com/v0/b/homear-intern.appspot.com/o/app_images%2FGroup%2034983.png?alt=media&token=300dbe05-de39-4f1e-8257-dd625bb5de53",
      "cost": 200
    },
    {
      "id": "2",
      "title": "Dishes",
      "imageUrl":
          "https://firebasestorage.googleapis.com/v0/b/homear-intern.appspot.com/o/app_images%2FVector%20(3).png?alt=media&token=409a5cbd-907e-4516-a489-45f3341be4e8",
      "cost": 200
    },
  ],
  [
    {
      "id": "1",
      "title": "Dinner",
      "imageUrl":
          "https://firebasestorage.googleapis.com/v0/b/homear-intern.appspot.com/o/app_images%2FGroup%2034941.png?alt=media&token=d137f3c3-23f1-4a3e-8353-8c8a052e8479",
      "cost": 200
    },
    {
      "id": "2",
      "title": "Breakfast",
      "imageUrl":
          "https://firebasestorage.googleapis.com/v0/b/homear-intern.appspot.com/o/app_images%2FGroup%2034941.png?alt=media&token=d137f3c3-23f1-4a3e-8353-8c8a052e8479",
      "cost": 200
    },
  ],
  [
    {
      "id": "1",
      "title": "House",
      "imageUrl":
          "https://firebasestorage.googleapis.com/v0/b/homear-intern.appspot.com/o/app_images%2FGroup%2034941.png?alt=media&token=d137f3c3-23f1-4a3e-8353-8c8a052e8479",
      "cost": 200
    },
    {
      "id": "2",
      "title": "Cabinet",
      "imageUrl":
          "https://firebasestorage.googleapis.com/v0/b/homear-intern.appspot.com/o/app_images%2FGroup%2034941.png?alt=media&token=d137f3c3-23f1-4a3e-8353-8c8a052e8479",
      "cost": 200
    },
  ],
  [
    {
      "id": "1",
      "title": "House",
      "imageUrl":
          "https://firebasestorage.googleapis.com/v0/b/homear-intern.appspot.com/o/app_images%2FGroup%2034941.png?alt=media&token=d137f3c3-23f1-4a3e-8353-8c8a052e8479",
      "cost": 200
    },
    {
      "id": "2",
      "title": "Cabinet",
      "imageUrl":
          "https://firebasestorage.googleapis.com/v0/b/homear-intern.appspot.com/o/app_images%2FGroup%2034941.png?alt=media&token=d137f3c3-23f1-4a3e-8353-8c8a052e8479",
      "cost": 200
    },
  ],
  [
    {
      "id": "1",
      "title": "House",
      "imageUrl":
          "https://firebasestorage.googleapis.com/v0/b/homear-intern.appspot.com/o/app_images%2FGroup%2034941.png?alt=media&token=d137f3c3-23f1-4a3e-8353-8c8a052e8479",
      "cost": 200
    },
    {
      "id": "2",
      "title": "Cabinet",
      "imageUrl":
          "https://firebasestorage.googleapis.com/v0/b/homear-intern.appspot.com/o/app_images%2FGroup%2034941.png?alt=media&token=d137f3c3-23f1-4a3e-8353-8c8a052e8479",
      "cost": 200
    },
  ],
];

// void addData() {
//   for (int i = 0; i <= mainServices.length; i++) {
//     FirebaseFirestore.instance
//         .collection('Test')
//         .add(mainServices[i])
//         .then((value) {
//       supServices.forEach((element) {
//         element.forEach(em){}
//       });
//       FirebaseFirestore.instance
//           .collection('Test')
//           .doc(value.id)
//           .collection('supServices')
//           .add(supServices[i]);
//     });
//   }
// }



void addServices(List mainServices, List subServices) async {

  final firestore = FirebaseFirestore.instance;

  for (int i = 0; i < mainServices.length; i++) {
    String docId = FirebaseFirestore.instance.collection('mainServices').doc().id;
    final mainService = mainServices[i];

    // Add main service to Firestore
    final mainServiceDoc = await firestore
        .collection('mainServices')
        .doc(docId)
        .set({...mainService, "docID": docId});

    // Add sub-services to Firestore
    for (int j = 0; j < subServices[i].length; j++) {
      final subService = subServices[i][j];
      await firestore
          .collection('mainServices/$docId/subServices')
          .add(subService);
    }
  }
}
