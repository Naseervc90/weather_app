import 'package:flutter/material.dart';

class ModernSearchWidget extends StatefulWidget {
  final Function(String) onSearch;
  final bool isLoading;

  const ModernSearchWidget({
    Key? key,
    required this.onSearch,
    required this.isLoading,
  }) : super(key: key);

  @override
  State<ModernSearchWidget> createState() => _ModernSearchWidgetState();
}

class _ModernSearchWidgetState extends State<ModernSearchWidget> {
  final TextEditingController _controller = TextEditingController();

  void _handleSearch() {
    if (_controller.text.trim().isNotEmpty) {
      widget.onSearch(_controller.text.trim());
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // Search Input
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: isDark ? const Color(0xFF2A3A4C) : Colors.grey.shade100,
            ),
            child: TextField(
              controller: _controller,
              style: TextStyle(
                color: isDark ? Colors.white : Colors.black87,
                fontSize: 16,
              ),
              decoration: InputDecoration(
                hintText: 'Enter city name',
                hintStyle: TextStyle(
                  color: isDark ? Colors.white60 : Colors.black54,
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: isDark ? Colors.white60 : Colors.black54,
                ),
                suffixIcon:
                    widget.isLoading
                        ? Padding(
                          padding: const EdgeInsets.all(12),
                          child: SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: isDark ? Colors.white60 : Colors.black54,
                            ),
                          ),
                        )
                        : null,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
              ),
              onSubmitted: (_) => _handleSearch(),
              enabled: !widget.isLoading,
            ),
          ),

          const SizedBox(height: 16),

          // Get Weather Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: widget.isLoading ? null : _handleSearch,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4A90E2),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 0,
              ),
              child:
                  widget.isLoading
                      ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                      : const Text(
                        'Get Weather',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
