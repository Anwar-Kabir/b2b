// import 'package:flutter/material.dart';
// import 'package:isotopeit_b2b/utils/color.dart';

// class BannerDetails extends StatelessWidget {
//   const BannerDetails({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Banner  Details',
//           style: TextStyle(color: Colors.white),
//         ),
//         backgroundColor: AppColor.primaryColor.withOpacity(0.7),
//         iconTheme: const IconThemeData(
//           color: Colors.white,
//         ),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Product Image
//               Center(
//                 child: Image.asset(
//                   'assets/abc.jpg', // replace with your image URL or asset
//                   height: 200,
//                   width: 200,
//                 ),
//               ),
//               const SizedBox(height: 10),

//               const SizedBox(height: 20),

//               // Additional Details
//               const Text(
//                 'Banner Details',
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 10),
//               _buildDetailRow('Details', 'Suscipit aut sunt qu'),
//               _buildDetailRow('Columns', '4'),
//               _buildDetailRow('Serial Number', '100'),
//               _buildDetailRow('Link label', ' '),
//               _buildDetailRow('Link', ' '),
//               _buildDetailRow('Created at', ' '),
//               const SizedBox(height: 20),
//             ],
//           ),
//         ),
//       ),
//       bottomNavigationBar: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Expanded(
//               child: OutlinedButton(
//                 onPressed: () {},
//                 child: const Text('Edit'),
//               ),
//             ),
//             const SizedBox(width: 10),
//             Expanded(
//               child: ElevatedButton(
//                 onPressed: () {},
//                 style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
//                 child: const Text(
//                   'Delete',
//                   style: TextStyle(color: Colors.white),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // Widget to build image selection (thumbnails)
//   Widget _buildImageSelection(String imagepath) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 5.0),
//       child: Container(
//         height: 60,
//         width: 60,
//         decoration: BoxDecoration(
//           border: Border.all(color: Colors.green),
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: Image.asset(imagepath, fit: BoxFit.cover),
//       ),
//     );
//   }

//   // Widget to build key-value rows for product details
//   Widget _buildDetailRow(String title, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           Text(title, style: TextStyle(fontSize: 16, color: Colors.grey[700])),
//           const SizedBox(
//             width: 15,
//           ),
//           Text(value,
//               style:
//                   const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//         ],
//       ),
//     );
//   }
// }
