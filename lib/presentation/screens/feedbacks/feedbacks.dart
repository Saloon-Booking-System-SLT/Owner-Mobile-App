import 'package:flutter/material.dart';
import 'feedbacks-view-details.dart';
import 'feedback-reply.dart';
import '../../widgets/feedbacks/rating_summary_widget.dart';
import '../../widgets/feedbacks/filter_buttons_widget.dart';
import '../../widgets/feedbacks/feedback_card_widget.dart';

class FeedbacksPage extends StatefulWidget {
  const FeedbacksPage({Key? key}) : super(key: key);

  @override
  State<FeedbacksPage> createState() => _FeedbacksPageState();
}

class _FeedbacksPageState extends State<FeedbacksPage> {
  String selectedFilter = 'All';

  final List<Map<String, dynamic>> ratings = [
    {'stars': 5, 'percentage': 80, 'count': 92},
    {'stars': 4, 'percentage': 11, 'count': 13},
    {'stars': 3, 'percentage': 5, 'count': 6},
    {'stars': 2, 'percentage': 3, 'count': 3},
    {'stars': 1, 'percentage': 1, 'count': 1},
  ];

  final List<Map<String, dynamic>> feedbacks = [
    {
      'name': 'Sophia Bennett',
      'service': 'Haircut with Emily',
      'date': 'July 12, 2024',
      'review': 'Emily was attentive and gave me a fantastic haircut. The salon had a welcoming atmosphere.',
      'rating': 5.0,
      'timestamp': DateTime.parse('2024-07-12').millisecondsSinceEpoch,
    },
    {
      'name': 'Ethan Carter',
      'service': 'Manicure with Olivia',
      'date': 'July 10, 2024',
      'review': 'Olivia\'s manicure was impeccable, and she was very friendly. I\'m very pleased with the results.',
      'rating': 5.0,
      'timestamp': DateTime.parse('2024-07-10').millisecondsSinceEpoch,
    },
    {
      'name': 'Isabella Davis',
      'service': 'Facial with Chloe',
      'date': 'July 8, 2024',
      'review': 'Chloe\'s facial was incredibly relaxing and my skin feels rejuvenated. I highly recommend her.',
      'rating': 5.0,
      'timestamp': DateTime.parse('2024-07-08').millisecondsSinceEpoch,
    },
    {
      'name': 'Michael Johnson',
      'service': 'Hair Color with Sarah',
      'date': 'July 15, 2024',
      'review': 'Sarah did an amazing job with my hair color. The results exceeded my expectations!',
      'rating': 4.5,
      'timestamp': DateTime.parse('2024-07-15').millisecondsSinceEpoch,
    },
    {
      'name': 'Emma Wilson',
      'service': 'Massage with David',
      'date': 'July 5, 2024',
      'review': 'David\'s massage technique is excellent. Very relaxing and professional.',
      'rating': 4.0,
      'timestamp': DateTime.parse('2024-07-05').millisecondsSinceEpoch,
    },
    {
      'name': 'James Brown',
      'service': 'Beard Trim with Alex',
      'date': 'July 18, 2024',
      'review': 'Alex gave me the perfect beard trim. Attention to detail was impressive.',
      'rating': 3.5,
      'timestamp': DateTime.parse('2024-07-18').millisecondsSinceEpoch,
    },
  ];

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
                
                // Rating Summary Card
                RatingSummaryWidget(
                  overallRating: 4.7,
                  reviewCount: 115,
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
                        builder: (context) => const FeedbackDetailsPage(),
                      ),
                    );
                  },
                  onReply: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ReplyToFeedbackPage(),
                      ),
                    );
                  },
                )).toList(),
                
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRatingSummary() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.shade300,
          width: 1.5,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left side - Overall Rating
          Expanded(
            flex: 2,
            child: Column(
              children: [
                const Text(
                  '4.7',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    height: 1,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ...List.generate(4, (index) => const Icon(
                      Icons.star,
                      color: Color(0xFFFFA726),
                      size: 20,
                    )),
                    const Icon(
                      Icons.star_border,
                      color: Color(0xFFFFA726),
                      size: 20,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  '115 reviews',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(width: 24),
          
          // Right side - Rating Bars
          Expanded(
            flex: 3,
            child: Column(
              children: ratings.map((rating) => _buildRatingBar(
                rating['stars'],
                rating['percentage'],
              )).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRatingBar(int stars, int percentage) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(
            '$stars',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: percentage / 100,
                backgroundColor: Colors.grey.shade200,
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.black87),
                minHeight: 8,
              ),
            ),
          ),
          const SizedBox(width: 12),
          SizedBox(
            width: 32,
            child: Text(
              '$percentage%',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterButtons() {
    final filters = ['All', 'Newest', 'Top Rated'];
    
    return Row(
      children: filters.map((filter) {
        final isSelected = selectedFilter == filter;
        return Padding(
          padding: const EdgeInsets.only(right: 12),
          child: GestureDetector(
            onTap: () => setState(() => selectedFilter = filter),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected 
                    ? const Color(0xFF1565C0).withOpacity(0.1)
                    : Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: isSelected 
                      ? const Color(0xFF1565C0).withOpacity(0.3)
                      : Colors.grey.shade300,
                  width: 1.5,
                ),
              ),
              child: Text(
                filter,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: isSelected 
                      ? const Color(0xFF1565C0)
                      : Colors.black87,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildFeedbackCard(Map<String, dynamic> feedback) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.shade300,
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User Info Row
          Row(
            children: [
              // Avatar
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.person_outline,
                  color: Colors.grey.shade400,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              // User Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      feedback['name'],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      feedback['service'],
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      feedback['date'],
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade500,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // Review Text
          Text(
            feedback['review'],
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade700,
              height: 1.5,
              fontWeight: FontWeight.w400,
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Action Buttons
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 44,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FeedbackDetailsPage(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1565C0),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'View Details',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: SizedBox(
                  height: 44,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ReplyToFeedbackPage(),
                        ),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      backgroundColor: const Color(0xFFF5F5F5),
                      foregroundColor: Colors.black87,
                      side: BorderSide(
                        color: Colors.grey.shade300,
                        width: 1.5,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Reply to Feedback',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}