import 'package:flutter/material.dart';
import '../../core/theme/colors.dart';
import '../widgets/bouncing_widget.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen>
    with TickerProviderStateMixin {
  late AnimationController _balanceController;
  late AnimationController _transactionController;
  late Animation<double> _balanceAnimation;
  late Animation<double> _fadeAnimation;
  late List<Animation<Offset>> _transactionSlideAnimations;

  final double _balance = 125.50;
  final List<Map<String, dynamic>> _transactions = [
    {
      'id': 'TXN001',
      'type': 'ride',
      'description': 'Trip to Office',
      'amount': -25.50,
      'date': '2024-01-15',
      'time': '2:30 PM',
    },
    {
      'id': 'TXN002',
      'type': 'topup',
      'description': 'Wallet Top-up',
      'amount': 100.00,
      'date': '2024-01-14',
      'time': '10:15 AM',
    },
    {
      'id': 'TXN003',
      'type': 'ride',
      'description': 'Trip to Mall',
      'amount': -18.75,
      'date': '2024-01-14',
      'time': '6:45 PM',
    },
    {
      'id': 'TXN004',
      'type': 'refund',
      'description': 'Trip Refund',
      'amount': 15.25,
      'date': '2024-01-13',
      'time': '3:20 PM',
    },
  ];

  @override
  void initState() {
    super.initState();

    _balanceController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _transactionController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _balanceAnimation = Tween<double>(
      begin: 0.0,
      end: _balance,
    ).animate(CurvedAnimation(
      parent: _balanceController,
      curve: Curves.easeOut,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _balanceController,
      curve: const Interval(0.5, 1.0, curve: Curves.easeIn),
    ));

    _transactionSlideAnimations = List.generate(
      _transactions.length,
      (index) => Tween<Offset>(
        begin: const Offset(0, 1),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: _transactionController,
        curve: Interval(
          index * 0.1,
          0.5 + (index * 0.1),
          curve: Curves.easeOut,
        ),
      )),
    );

    _balanceController.forward();
    Future.delayed(const Duration(milliseconds: 500), () {
      _transactionController.forward();
    });
  }

  @override
  void dispose() {
    _balanceController.dispose();
    _transactionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BouncingWidget(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.arrow_back,
            color: AppColors.primary,
          ),
        ),
        title: const Text(
          'Wallet',
          style: TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          BouncingWidget(
            onTap: () {
              // Handle wallet settings
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 16),
              child: Icon(
                Icons.more_vert,
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Balance Card
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.primary, AppColors.accent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: const Text(
                      'Current Balance',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  AnimatedBuilder(
                    animation: _balanceAnimation,
                    builder: (context, child) {
                      return Text(
                        '\$${_balanceAnimation.value.toStringAsFixed(2)}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: Row(
                      children: [
                        Expanded(
                          child: BouncingWidget(
                            onTap: () {
                              // Handle add money
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.add,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    'Add Money',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: BouncingWidget(
                            onTap: () {
                              // Handle send money
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.send,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    'Send',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Transactions Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Recent Transactions',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  BouncingWidget(
                    onTap: () {
                      // Handle view all transactions
                    },
                    child: const Text(
                      'View All',
                      style: TextStyle(
                        color: AppColors.accent,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Transactions List
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _transactions.length,
                itemBuilder: (context, index) {
                  final transaction = _transactions[index];

                  return SlideTransition(
                    position: _transactionSlideAnimations[index],
                    child: AnimatedTransactionTile(
                      transaction: transaction,
                      delay: Duration(milliseconds: index * 100),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AnimatedTransactionTile extends StatefulWidget {
  final Map<String, dynamic> transaction;
  final Duration delay;

  const AnimatedTransactionTile({
    super.key,
    required this.transaction,
    required this.delay,
  });

  @override
  State<AnimatedTransactionTile> createState() => _AnimatedTransactionTileState();
}

class _AnimatedTransactionTileState extends State<AnimatedTransactionTile>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.9,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    Future.delayed(widget.delay, () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  IconData _getTransactionIcon(String type) {
    switch (type) {
      case 'ride':
        return Icons.directions_car;
      case 'topup':
        return Icons.add_circle;
      case 'refund':
        return Icons.refresh;
      default:
        return Icons.payment;
    }
  }

  Color _getTransactionColor(String type) {
    switch (type) {
      case 'ride':
        return Colors.red;
      case 'topup':
        return Colors.green;
      case 'refund':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final amount = widget.transaction['amount'] as double;
    final isPositive = amount > 0;

    return ScaleTransition(
      scale: _scaleAnimation,
      child: BouncingWidget(
        onTap: () {
          // Handle transaction details
        },
        child: Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: _getTransactionColor(widget.transaction['type'])
                      .withOpacity(0.1),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Icon(
                  _getTransactionIcon(widget.transaction['type']),
                  color: _getTransactionColor(widget.transaction['type']),
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.transaction['description'],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${widget.transaction['date']} at ${widget.transaction['time']}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                '${isPositive ? '+' : ''}\$${amount.abs().toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: isPositive ? Colors.green : Colors.red,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}