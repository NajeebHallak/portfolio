import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

enum AppAnimateType {
  bottomToTop,
  topToBottom,
  leftToRight,
  rightToLeft,
  scaleUp,
}

class AppAnimate extends StatefulWidget {
  final Widget child;
  final String? keyKey;
  final int delayInMs;
  final int? durationInMs; // 👈 جعل القيمة اختيارية للتحكم التلقائي
  final double offsetFraction;
  final AppAnimateType type;
  final bool enableHover;
  final double hoverScale;
  final bool enableGlow;
  final Color? glowColor;

  const AppAnimate({
    super.key,
    required this.child,
    this.keyKey,
    this.delayInMs = 0,
    this.durationInMs, // 👈 لم تعد محدودة بـ 800 بشكل ثابت
    this.offsetFraction = 0.3,
    this.type = AppAnimateType.bottomToTop,
    this.enableHover = false,
    this.hoverScale = 1.03,
    this.enableGlow = false,
    this.glowColor,
  });

  @override
  State<AppAnimate> createState() => _AppAnimateState();
}

class _AppAnimateState extends State<AppAnimate>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  bool _isHovered = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this);

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // 👈 فحص نوع الجهاز حسب عرض الشاشة: موبايل (800ms) - لاب توب/ديسك توب (1800ms)
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 768;
    final int effectiveDuration =
        widget.durationInMs ?? (isMobile ? 600 : 5000);

    _controller.duration = Duration(milliseconds: effectiveDuration);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startAnimation() {
    if (_controller.isAnimating || _controller.isCompleted) return;

    if (widget.delayInMs > 0) {
      Future.delayed(Duration(milliseconds: widget.delayInMs), () {
        if (mounted) _controller.forward();
      });
    } else {
      _controller.forward();
    }
  }

  Widget _buildInteractiveChild() {
    if (!widget.enableHover) return widget.child;

    final theme = Theme.of(context);
    final activeGlowColor = widget.glowColor ?? theme.colorScheme.primary;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutCubic,
        transform: Matrix4.identity()
          ..scale(_isHovered ? widget.hoverScale : 1.0),
        transformAlignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: (_isHovered && widget.enableGlow)
              ? [
                  BoxShadow(
                    color: activeGlowColor.withValues(alpha: 0.15),
                    blurRadius: 12,
                    spreadRadius: 2,
                  ),
                ]
              : [],
        ),
        child: widget.child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Key detectorKey = Key(
      widget.keyKey ?? 'app_animate_${identityHashCode(this)}',
    );

    return VisibilityDetector(
      key: detectorKey,
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.10) {
          _startAnimation();
        }
      },
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          final progress = _animation.value;
          final opacity = progress.clamp(0.0, 1.0);

          double dx = 0.0;
          double dy = 0.0;

          final currentOffset = (1.0 - progress) * widget.offsetFraction * 100;

          switch (widget.type) {
            case AppAnimateType.bottomToTop:
              dy = currentOffset;
              break;
            case AppAnimateType.topToBottom:
              dy = -currentOffset;
              break;
            case AppAnimateType.leftToRight:
              dx = -currentOffset;
              break;
            case AppAnimateType.rightToLeft:
              dx = currentOffset;
              break;
            case AppAnimateType.scaleUp:
              dy = currentOffset * 0.3;
              break;
          }

          final scale = widget.type == AppAnimateType.scaleUp
              ? 0.8 + (0.2 * progress)
              : 1.0;

          return RepaintBoundary(
            child: Opacity(
              opacity: opacity,
              child: Transform(
                transform: Matrix4.identity()
                  ..translate(dx, dy)
                  ..scale(scale),
                alignment: Alignment.center,
                child: child,
              ),
            ),
          );
        },
        child: _buildInteractiveChild(),
      ),
    );
  }
}
