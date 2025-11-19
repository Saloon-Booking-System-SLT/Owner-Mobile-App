import 'package:flutter/material.dart';

class FeedbackReplyScreen extends StatefulWidget {
  const FeedbackReplyScreen({super.key});

  @override
  State<FeedbackReplyScreen> createState() => _FeedbackReplyScreenState();
}

class _FeedbackReplyScreenState extends State<FeedbackReplyScreen> {
  final TextEditingController _replyController = TextEditingController();
  int _likes = 2;
  bool _isLiked = false;

  @override
  void dispose() {
    _replyController.dispose();
    super.dispose();
  }

  void _handleLike() {
    setState(() {
      if (_isLiked) {
        _likes--;
        _isLiked = false;
      } else {
        _likes++;
        _isLiked = true;
      }
    });
  }

  void _handleSendReply() {
    if (_replyController.text.trim().isNotEmpty) {
      // Handle sending reply
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Reply sent successfully!')));
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please enter a reply')));
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
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Feedbacks',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Customer Profile Section
              Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.grey[300],
                    child: Icon(
                      Icons.person,
                      size: 35,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Sophia Bennett',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'sophiabennett@gmail.com',
                        style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Star Rating
              Row(
                children: List.generate(
                  5,
                  (index) =>
                      const Icon(Icons.star, color: Colors.black87, size: 28),
                ),
              ),
              const SizedBox(height: 16),

              // Customer Feedback Comment
              Text(
                'The service was excellent, and the staff was very friendly. I especially loved the ambiance of the salon. Will definitely come back!',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[800],
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 16),

              // Like and Dislike Buttons
              Row(
                children: [
                  // Like Button
                  InkWell(
                    onTap: _handleLike,
                    borderRadius: BorderRadius.circular(4),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        children: [
                          Icon(
                            _isLiked ? Icons.thumb_up : Icons.thumb_up_outlined,
                            size: 20,
                            color:
                                _isLiked
                                    ? const Color(0xFF0D5EAC)
                                    : Colors.grey[700],
                          ),
                          const SizedBox(width: 6),
                          Text(
                            '$_likes',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[700],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),

                  // Dislike Button
                  InkWell(
                    onTap: () {
                      // Handle dislike
                    },
                    borderRadius: BorderRadius.circular(4),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Icon(
                        Icons.thumb_down_outlined,
                        size: 20,
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Reply Text Field
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: TextField(
                  controller: _replyController,
                  maxLines: 6,
                  decoration: InputDecoration(
                    hintText: 'Write your reply...',
                    hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.all(16),
                  ),
                  style: const TextStyle(fontSize: 14, color: Colors.black87),
                ),
              ),
              const SizedBox(height: 20),

              // Send Reply Button
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: _handleSendReply,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0D5EAC),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 14,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Send Reply',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
