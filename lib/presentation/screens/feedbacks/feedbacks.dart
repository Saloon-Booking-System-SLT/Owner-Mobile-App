// import 'package:flutter/material.dart';
// import 'feedbacks-view-details.dart';
// import 'feedback-reply.dart';
// import '../../widgets/feedbacks/rating_summary_widget.dart';
// import '../../widgets/feedbacks/filter_buttons_widget.dart';
// import '../../widgets/feedbacks/feedback_card_widget.dart';
//
// class FeedbacksPage extends StatefulWidget {
//   const FeedbacksPage({Key? key}) : super(key: key);
//
//   @override
//   State<FeedbacksPage> createState() => _FeedbacksPageState();
// }
//
// class _FeedbacksPageState extends State<FeedbacksPage> {
//   String selectedFilter = 'All';
//
//   final List<Map<String, dynamic>> ratings = [
//     {'stars': 5, 'percentage': 80, 'count': 92},
//     {'stars': 4, 'percentage': 11, 'count': 13},
//     {'stars': 3, 'percentage': 5, 'count': 6},
//     {'stars': 2, 'percentage': 3, 'count': 3},
//     {'stars': 1, 'percentage': 1, 'count': 1},
//   ];
//
//   final List<Map<String, dynamic>> feedbacks = [
//     {
//       'name': 'Sophia Bennett',
//       'service': 'Haircut with Emily',
//       'date': 'July 12, 2024',
//       'review': 'Emily was attentive and gave me a fantastic haircut. The salon had a welcoming atmosphere.',
//       'rating': 5.0,
//       'timestamp': DateTime.parse('2024-07-12').millisecondsSinceEpoch,
//     },
//     {
//       'name': 'Ethan Carter',
//       'service': 'Manicure with Olivia',
//       'date': 'July 10, 2024',
//       'review': 'Olivia\'s manicure was impeccable, and she was very friendly. I\'m very pleased with the results.',
//       'rating': 5.0,
//       'timestamp': DateTime.parse('2024-07-10').millisecondsSinceEpoch,
//     },
//     {
//       'name': 'Isabella Davis',
//       'service': 'Facial with Chloe',
//       'date': 'July 8, 2024',
//       'review': 'Chloe\'s facial was incredibly relaxing and my skin feels rejuvenated. I highly recommend her.',
//       'rating': 5.0,
//       'timestamp': DateTime.parse('2024-07-08').millisecondsSinceEpoch,
//     },
//     {
//       'name': 'Michael Johnson',
//       'service': 'Hair Color with Sarah',
//       'date': 'July 15, 2024',
//       'review': 'Sarah did an amazing job with my hair color. The results exceeded my expectations!',
//       'rating': 4.5,
//       'timestamp': DateTime.parse('2024-07-15').millisecondsSinceEpoch,
//     },
//     {
//       'name': 'Emma Wilson',
//       'service': 'Massage with David',
//       'date': 'July 5, 2024',
//       'review': 'David\'s massage technique is excellent. Very relaxing and professional.',
//       'rating': 4.0,
//       'timestamp': DateTime.parse('2024-07-05').millisecondsSinceEpoch,
//     },
//     {
//       'name': 'James Brown',
//       'service': 'Beard Trim with Alex',
//       'date': 'July 18, 2024',
//       'review': 'Alex gave me the perfect beard trim. Attention to detail was impressive.',
//       'rating': 3.5,
//       'timestamp': DateTime.parse('2024-07-18').millisecondsSinceEpoch,
//     },
//   ];
//
//   // Get filtered feedbacks based on selected filter
//   List<Map<String, dynamic>> get filteredFeedbacks {
//     switch (selectedFilter) {
//       case 'Newest':
//         return List.from(feedbacks)
//           ..sort((a, b) => b['timestamp'].compareTo(a['timestamp']));
//       case 'Top Rated':
//         return List.from(feedbacks)
//           ..sort((a, b) => b['rating'].compareTo(a['rating']));
//       default:
//         return feedbacks;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
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
//                 // Rating Summary Card
//                 RatingSummaryWidget(
//                   overallRating: 4.7,
//                   reviewCount: 115,
//                   ratings: ratings,
//                 ),
//
//                 const SizedBox(height: 24),
//
//                 // Filter Buttons
//                 FilterButtonsWidget(
//                   selectedFilter: selectedFilter,
//                   onFilterSelected: (filter) {
//                     setState(() {
//                       selectedFilter = filter;
//                     });
//                   },
//                 ),
//
//                 const SizedBox(height: 24),
//
//                 // Feedback List
//                 ...filteredFeedbacks.map((feedback) => FeedbackCardWidget(
//                   feedback: feedback,
//                   onViewDetails: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => const FeedbackDetailsPage(),
//                       ),
//                     );
//                   },
//                   onReply: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => const ReplyToFeedbackPage(),
//                       ),
//                     );
//                   },
//                 )).toList(),
//
//                 const SizedBox(height: 24),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
// }

import 'package:flutter/material.dart';
import '../../../data/services/feedback_service.dart';
import 'feedbacks-view-details.dart';
import 'feedback-reply.dart';
import '../../widgets/feedbacks/rating_summary_widget.dart';
import '../../widgets/feedbacks/filter_buttons_widget.dart';
import '../../widgets/feedbacks/feedback_card_widget.dart';

class FeedbacksPage extends StatefulWidget {
  final String salonId; // Pass salon ID from logged-in owner

  const FeedbacksPage({
    Key? key,
    required this.salonId,
  }) : super(key: key);

  @override
  State<FeedbacksPage> createState() => _FeedbacksPageState();
}

class _FeedbacksPageState extends State<FeedbacksPage> {
  String selectedFilter = 'All';
  bool isLoading = true;
  String? errorMessage;

  List<Map<String, dynamic>> feedbacks = [];
  List<Map<String, dynamic>> ratings = [];
  double overallRating = 0.0;
  int reviewCount = 0;

  @override
  void initState() {
    super.initState();
    _fetchFeedbacks();
  }

  Future<void> _fetchFeedbacks() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final result = await FeedbackService.getSalonFeedbacks(widget.salonId);

      if (result['success']) {
        final List<dynamic> fetchedFeedbacks = result['feedbacks'];

        // Convert to the format expected by the UI
        final List<Map<String, dynamic>> formattedFeedbacks =
        fetchedFeedbacks.map((feedback) {
          return {
            'id': feedback['_id'],
            'name': feedback['customerName'] ?? 'Anonymous',
            'service': _getServiceName(feedback),
            'date': FeedbackService.formatDate(feedback['createdAt']),
            'review': feedback['comment'] ?? 'No comment provided',
            'rating': (feedback['rating'] as num).toDouble(),
            'timestamp': DateTime.parse(feedback['createdAt']).millisecondsSinceEpoch,
            'appointmentId': feedback['appointmentId'],
            'professionalId': feedback['professionalId'],
            'professionalName': feedback['professionalId']?['name'] ?? 'N/A',
            'userEmail': feedback['userEmail'],
            'status': feedback['status'],
          };
        }).toList();

        // Calculate statistics
        final ratingDistribution =
        FeedbackService.calculateRatingDistribution(fetchedFeedbacks);
        final avgRating =
        FeedbackService.calculateAverageRating(fetchedFeedbacks);

        setState(() {
          feedbacks = formattedFeedbacks;
          ratings = ratingDistribution;
          overallRating = avgRating;
          reviewCount = formattedFeedbacks.length;
          isLoading = false;
        });
      } else {
        setState(() {
          errorMessage = result['message'];
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'An error occurred: $e';
        isLoading = false;
      });
    }
  }

  String _getServiceName(Map<String, dynamic> feedback) {
    // If professional info is populated
    if (feedback['professionalId'] != null &&
        feedback['professionalId'] is Map) {
      return 'Service with ${feedback['professionalId']['name'] ?? 'Staff'}';
    }
    return 'Service';
  }

  // Get filtered feedbacks based on selected filter
  List<Map<String, dynamic>> get filteredFeedbacks {
    switch (selectedFilter) {
      case 'Newest':
        return List.from(feedbacks)
          ..sort((a, b) => b['timestamp'].compareTo(a['timestamp']));
      case 'Top Rated':
        return List.from(feedbacks)
          ..sort((a, b) => b['rating'].compareTo(a['rating']));
      default:
        return feedbacks;
    }
  }

  @override
  Widget build(BuildContext context) {
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
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.black),
            onPressed: _fetchFeedbacks,
          ),
        ],
      ),
      body: SafeArea(
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: Colors.grey.shade400),
            const SizedBox(height: 16),
            Text(
              errorMessage!,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _fetchFeedbacks,
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1565C0),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
            ),
          ],
        ),
      );
    }

    if (feedbacks.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.feedback_outlined,
              size: 64,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 16),
            Text(
              'No feedbacks yet',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Customer feedbacks will appear here',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade500,
              ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _fetchFeedbacks,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),

              // Rating Summary Card
              RatingSummaryWidget(
                overallRating: overallRating,
                reviewCount: reviewCount,
                ratings: ratings,
              ),

              const SizedBox(height: 24),

              // Filter Buttons
              FilterButtonsWidget(
                selectedFilter: selectedFilter,
                onFilterSelected: (filter) {
                  setState(() {
                    selectedFilter = filter;
                  });
                },
              ),

              const SizedBox(height: 24),

              // Feedback List
              ...filteredFeedbacks.map((feedback) => FeedbackCardWidget(
                feedback: feedback,
                onViewDetails: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FeedbackDetailsPage(
                        feedback: feedback,
                      ),
                    ),
                  );
                },
                onReply: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ReplyToFeedbackPage(
                        feedback: feedback,
                      ),
                    ),
                  );
                },
              )).toList(),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}