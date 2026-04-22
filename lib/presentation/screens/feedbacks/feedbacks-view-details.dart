// import 'package:flutter/material.dart';
// import 'feedback-reply.dart';
// import '../../widgets/feedbacks/user_profile_widget.dart';
// import '../../widgets/feedbacks/rating_summary_widget.dart';
// import '../../widgets/feedbacks/sub_rating_widget.dart';
// import '../../widgets/feedbacks/customer_comment_widget.dart';
// import '../../widgets/feedbacks/service_details_widget.dart';
// import '../../widgets/feedbacks/reply_button_widget.dart';
//
// class FeedbackDetailsPage extends StatelessWidget {
//   const FeedbackDetailsPage({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//           backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           onPressed: () => Navigator.pop(context),
//           icon: const Icon(Icons.arrow_back, color: Colors.black, size: 28),
//         ),
//         title: const Text(
//           'Feedbacks',
//           style: TextStyle(
//             fontSize: 22,
//             fontWeight: FontWeight.bold,
//             color: Colors.black,
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 24.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const SizedBox(height: 24),
//
//                 // User Profile Card
//                 const UserProfileCardWidget(
//                   name: 'Sophia Bennett',
//                   email: 'sophiabennett@gmail.com',
//                 ),
//
//                 const SizedBox(height: 24),
//
//                 // Date and Appointment Info
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text(
//                       'Date: 2024-07-26',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                         color: Colors.black87,
//                       ),
//                     ),
//                     const SizedBox(height: 6),
//                     Text(
//                       'Appointment ID: 123456',
//                       style: TextStyle(
//                         fontSize: 14,
//                         color: Colors.grey.shade600,
//                         fontWeight: FontWeight.w400,
//                       ),
//                     ),
//                   ],
//                 ),
//
//                 const SizedBox(height: 32),
//
//                 // Rating Section
//                 const Text(
//                   'Rating',
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black,
//                   ),
//                 ),
//
//                 const SizedBox(height: 20),
//
//                 const RatingSummaryWidget(
//                   overallRating: 4.5,
//                   reviewCount: 1,
//                   ratings: [
//                     {'stars': 5, 'percentage': 100},
//                     {'stars': 4, 'percentage': 0},
//                     {'stars': 3, 'percentage': 0},
//                     {'stars': 2, 'percentage': 0},
//                     {'stars': 1, 'percentage': 0},
//                   ],
//                 ),
//
//                 const SizedBox(height: 24),
//
//                 // Salon and Staff Rating
//                 const SubRatingsWidget(
//                   subRatings: [
//                     {'label': 'Salon Rating:', 'rating': 5.0},
//                     {'label': 'Staff Rating:', 'rating': 4.0},
//                   ],
//                 ),
//
//                 const SizedBox(height: 32),
//
//                 // Customer Comment Section
//                 const Text(
//                   'Customer Comment',
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black,
//                   ),
//                 ),
//
//                 const SizedBox(height: 16),
//
//                 const CustomerCommentWidget(
//                   comment: 'The service was excellent, and the staff was very friendly. I especially loved the ambiance of the salon. Will definitely come back!',
//                 ),
//
//                 const SizedBox(height: 24),
//
//                 // Reply Button
//                 ReplyButtonWidget(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => const ReplyToFeedbackPage(),
//                       ),
//                     );
//                   },
//                 ),
//
//                 const SizedBox(height: 32),
//
//                 // Service Details Section
//                 const Text(
//                   'Service Details',
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black,
//                   ),
//                 ),
//
//                 const SizedBox(height: 20),
//
//                 const ServiceDetailsWidget(
//                   details: [
//                     {'label': 'Service:', 'value': 'Haircut and Styling'},
//                     {'label': 'Staff:', 'value': 'Emily Carter'},
//                     {'label': 'Date:', 'value': '2024-07-26'},
//                     {'label': 'Time:', 'value': '2:00 PM'},
//                   ],
//                 ),
//
//                 const SizedBox(height: 32),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'feedback-reply.dart';
import '../../widgets/feedbacks/user_profile_widget.dart';
import '../../widgets/feedbacks/customer_comment_widget.dart';
import '../../widgets/feedbacks/service_details_widget.dart';
import '../../widgets/feedbacks/reply_button_widget.dart';

class FeedbackDetailsPage extends StatelessWidget {
  final Map<String, dynamic> feedback;

  const FeedbackDetailsPage({
    Key? key,
    required this.feedback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Extract data from feedback object
    final String customerName = feedback['name'] ?? 'Anonymous';
    final String userEmail = feedback['userEmail'] ?? 'N/A';
    final String date = feedback['date'] ?? 'N/A';
    final String appointmentId = feedback['appointmentId']?.toString() ?? 'N/A';
    final double rating = (feedback['rating'] as num?)?.toDouble() ?? 0.0;
    final String comment = feedback['review'] ?? 'No comment provided';
    final String service = feedback['service'] ?? 'N/A';
    final String professionalName = feedback['professionalName'] ?? 'N/A';
    final String status = feedback['status'] ?? 'pending';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: Colors.black, size: 28),
        ),
        title: const Text(
          'Feedbacks',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),

                // User Profile Card
                UserProfileCardWidget(
                  name: customerName,
                  email: userEmail,
                ),

                const SizedBox(height: 24),

                // Status Badge
                if (status != 'approved')
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: status == 'pending'
                          ? Colors.orange.shade100
                          : Colors.red.shade100,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      status.toUpperCase(),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: status == 'pending'
                            ? Colors.orange.shade700
                            : Colors.red.shade700,
                      ),
                    ),
                  ),

                if (status != 'approved') const SizedBox(height: 16),

                // Date and Appointment Info
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Date: $date',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Appointment ID: ${appointmentId.substring(0, appointmentId.length > 12 ? 12 : appointmentId.length)}...',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 32),

                // Rating Section
                const Text(
                  'Rating',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),

                const SizedBox(height: 20),

                // Star Rating Display
                Row(
                  children: [
                    ...List.generate(5, (index) {
                      return Icon(
                        index < rating.round()
                            ? Icons.star
                            : Icons.star_border,
                        color: Colors.amber,
                        size: 32,
                      );
                    }),
                    const SizedBox(width: 12),
                    Text(
                      rating.toStringAsFixed(1),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 32),

                // Customer Comment Section
                const Text(
                  'Customer Comment',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),

                const SizedBox(height: 16),

                CustomerCommentWidget(
                  comment: comment,
                ),

                const SizedBox(height: 24),

                // Reply Button
                ReplyButtonWidget(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ReplyToFeedbackPage(
                          feedback: feedback,
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 32),

                // Service Details Section
                const Text(
                  'Service Details',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),

                const SizedBox(height: 20),

                ServiceDetailsWidget(
                  details: [
                    {'label': 'Service:', 'value': service},
                    {'label': 'Staff:', 'value': professionalName},
                    {'label': 'Date:', 'value': date},
                    {'label': 'Customer:', 'value': customerName},
                  ],
                ),

                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}