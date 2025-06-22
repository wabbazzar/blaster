.PHONY: serve test-foundation visual-test mobile-test math-test probability-test collision-test animation-test verify-render clean-cache debug-render auto-test pwa-test test-board test-movement

# Core development server (mobile-ready)
serve:
	@python3 -m http.server 8000 --bind 0.0.0.0

# Cross-platform visual testing
visual-test:
	@open http://localhost:8000/visual_tests/test_harness.html || xdg-open http://localhost:8000/visual_tests/test_harness.html

# Mobile-specific testing
mobile-test:
	@open http://localhost:8000/visual_tests/mobile_test.html || xdg-open http://localhost:8000/visual_tests/mobile_test.html

# Mathematical progression testing
math-test:
	@open http://localhost:8000/visual_tests/math_test.html || xdg-open http://localhost:8000/visual_tests/math_test.html

# Probability distribution testing
probability-test:
	@open http://localhost:8000/visual_tests/probability_test.html || xdg-open http://localhost:8000/visual_tests/probability_test.html

# Collision detection testing
collision-test:
	@open http://localhost:8000/visual_tests/collision_test.html || xdg-open http://localhost:8000/visual_tests/collision_test.html

# Animation testing
animation-test:
	@open http://localhost:8000/visual_tests/animation_test.html || xdg-open http://localhost:8000/visual_tests/animation_test.html

# Target overlap testing
target-overlap-test:
	@open http://localhost:8000/visual_tests/target_overlap_test.html || xdg-open http://localhost:8000/visual_tests/target_overlap_test.html

# Text overflow testing
text-overflow-test:
	@open http://localhost:8000/visual_tests/text_overflow_test.html || xdg-open http://localhost:8000/visual_tests/text_overflow_test.html

# Scoreboard testing
scoreboard-test:
	@open http://localhost:8000/visual_tests/scoreboard_test.html || xdg-open http://localhost:8000/visual_tests/scoreboard_test.html

# Practice mode testing
practice-mode-test:
	@open http://localhost:8000/visual_tests/practice_mode_test.html || xdg-open http://localhost:8000/visual_tests/practice_mode_test.html

# Question position testing
question-position-test:
	@open http://localhost:8000/visual_tests/question_position_test.html || xdg-open http://localhost:8000/visual_tests/question_position_test.html

# Question update testing
question-update-test:
	@open http://localhost:8000/visual_tests/question_update_test.html || xdg-open http://localhost:8000/visual_tests/question_update_test.html

# REAL game testing (tests actual game, not fake components)
real-game-test:
	@open http://localhost:8000/visual_tests/real_game_test.html || xdg-open http://localhost:8000/visual_tests/real_game_test.html

# Touch event testing
touch-test:
	@open http://localhost:8000/visual_tests/touch_test.html || xdg-open http://localhost:8000/visual_tests/touch_test.html

# Device testing information
device-test:
	@echo "Connect mobile device and navigate to: http://[your-ip]:8000/"
	@echo "Your local IP addresses:"
	@ifconfig | grep "inet " | grep -v 127.0.0.1 | awk '{print "  " $$2}' || ipconfig | grep "IPv4" | awk '{print "  " $$NF}'
	@echo ""
	@echo "On your mobile device:"
	@echo "  1. Connect to same WiFi network as this computer"
	@echo "  2. Open browser and go to one of the IP addresses above"
	@echo "  3. Add :8000 to the end (e.g., http://192.168.1.100:8000)"
	@echo "  4. Test touch controls and responsive design"

# Render verification across platforms
verify-render:
	@open http://localhost:8000/visual_tests/render_verify.html

# Cache management for all platforms
clean-cache:
	@echo "Desktop: Ctrl+Shift+R (Win/Linux) or Cmd+Shift+R (Mac)"
	@echo "Mobile Safari: Settings > Safari > Clear History and Website Data"
	@echo "Chrome Mobile: Menu > History > Clear browsing data"

# Debug render pipeline
debug-render:
	@open http://localhost:8000/visual_tests/debug_render.html

# Automated cross-platform test suite
auto-test:
	@node test_runner.js || python test_runner.py

# PWA testing
pwa-test:
	@open http://localhost:8000/visual_tests/pwa_test.html 

# Force start server (kills existing server first)
force-serve:
	@echo "Stopping any existing servers..."
	@pkill -f "python.*http.server" || true
	@sleep 1
	@echo "Starting Card Blaster server on http://localhost:8000"
	@echo "For mobile device testing, use your local IP address"
	@python3 -m http.server 8000

# Debug card selection system
debug-card-selection:
	@open http://localhost:8000/visual_tests/debug_card_selection.html || xdg-open http://localhost:8000/visual_tests/debug_card_selection.html

# ===== CARD BLASTER TEST SUITE =====
# All tests moved to tests/ directory

test-foundation:
	@open http://localhost:8000/tests/test_foundation.html || xdg-open http://localhost:8000/tests/test_foundation.html

test-board:
	@open http://localhost:8000/tests/test_board.html || xdg-open http://localhost:8000/tests/test_board.html

test-movement:
	@open http://localhost:8000/tests/test_movement.html || xdg-open http://localhost:8000/tests/test_movement.html

test-projectiles:
	@open http://localhost:8000/tests/test_projectiles.html || xdg-open http://localhost:8000/tests/test_projectiles.html

test-targets:
	@open http://localhost:8000/tests/test_targets.html || xdg-open http://localhost:8000/tests/test_targets.html

test-collision:
	@open http://localhost:8000/tests/test_collision.html || xdg-open http://localhost:8000/tests/test_collision.html

test-data:
	@open http://localhost:8000/tests/test_data.html || xdg-open http://localhost:8000/tests/test_data.html

test-scoring:
	@open http://localhost:8000/tests/test_scoring.html || xdg-open http://localhost:8000/tests/test_scoring.html

test-complete:
	@open http://localhost:8000/tests/test_complete.html || xdg-open http://localhost:8000/tests/test_complete.html

test-target-bugs:
	@open http://localhost:8000/tests/test_target_bugs.html || xdg-open http://localhost:8000/tests/test_target_bugs.html

test-target-fixes:
	@open http://localhost:8000/tests/test_target_fixes.html || xdg-open http://localhost:8000/tests/test_target_fixes.html

test-positioning:
	@open http://localhost:8000/tests/test_target_positioning.html || xdg-open http://localhost:8000/tests/test_target_positioning.html

test-final-fixes:
	@open http://localhost:8000/tests/test_final_fixes.html || xdg-open http://localhost:8000/tests/test_final_fixes.html

test-actual-bugs:
	@open http://localhost:8000/tests/test_actual_bugs.html || xdg-open http://localhost:8000/tests/test_actual_bugs.html

test-board-boundary:
	@open http://localhost:8000/tests/test_board_boundary.html || xdg-open http://localhost:8000/tests/test_board_boundary.html

# Mobile testing commands
test-mobile-assessment:
	@open http://localhost:8000/tests/test_mobile_assessment.html || xdg-open http://localhost:8000/tests/test_mobile_assessment.html

test-mobile-device:
	@echo "🚨 MOBILE DEVICE TESTING 🚨"
	@echo "Connect your mobile device and navigate to:"
	@echo "http://$(shell ifconfig | grep 'inet ' | grep -v 127.0.0.1 | head -1 | awk '{print $$2}' 2>/dev/null || echo '[your-ip]'):8000/"
	@echo ""
	@echo "Mobile Testing Checklist:"
	@echo "  ❌ Touch controls (currently keyboard only)"
	@echo "  ❌ Responsive design (fixed 400px width)"  
	@echo "  ❌ Virtual fire button (spacebar only)"
	@echo "  ❌ Mobile-friendly HUD"
	@echo "  ❌ PWA installation capability"

# Run all core tests in sequence
test-all:
	@echo "Running all Card Blaster tests..."
	@make test-foundation
	@sleep 2
	@make test-movement
	@sleep 2
	@make test-projectiles
	@sleep 2
	@make test-targets
	@sleep 2
	@make test-collision
	@sleep 2
	@make test-complete
	@sleep 2
	@make test-board-boundary
	@sleep 2
	@make test-mobile-assessment

# New features testing
test-new-features:
	@open http://localhost:8000/tests/test_new_features.html || xdg-open http://localhost:8000/tests/test_new_features.html

# Swipe controls and toggle testing
test-swipe-toggle:
	@open http://localhost:8000/tests/test_swipe_and_toggle_features.html || xdg-open http://localhost:8000/tests/test_swipe_and_toggle_features.html

# Highlight border fix testing
test-highlight-border:
	@open http://localhost:8000/tests/test_highlight_border_fix.html || xdg-open http://localhost:8000/tests/test_highlight_border_fix.html

# ===== PROGRESSIVE GAMEPLAY TEST SUITE =====
# Mobile-first cross-platform testing for progressive gameplay system

# Mobile-first progressive testing
test-progressive-mobile:
	@open http://localhost:8000/tests/mobile_progressive_test.html || xdg-open http://localhost:8000/tests/mobile_progressive_test.html

# Desktop enhancement testing
test-progressive-desktop:
	@open http://localhost:8000/tests/desktop_progressive_test.html || xdg-open http://localhost:8000/tests/desktop_progressive_test.html

# Deck discovery system testing
test-deck-discovery:
	@open http://localhost:8000/tests/deck_discovery_test.html || xdg-open http://localhost:8000/tests/deck_discovery_test.html

# Card learning system testing
test-card-states:
	@open http://localhost:8000/tests/card_states_test.html || xdg-open http://localhost:8000/tests/card_states_test.html

# Animation system testing
test-animations:
	@open http://localhost:8000/tests/animations_test.html || xdg-open http://localhost:8000/tests/animations_test.html

# PWA functionality testing
test-pwa-progressive:
	@open http://localhost:8000/tests/pwa_test.html || xdg-open http://localhost:8000/tests/pwa_test.html

# Performance testing
test-performance:
	@open http://localhost:8000/tests/performance_test.html || xdg-open http://localhost:8000/tests/performance_test.html

# Automated progressive test suite
test-all-progressive:
	@echo "Running comprehensive progressive gameplay tests..."
	@make test-progressive-mobile
	@sleep 2
	@make test-progressive-desktop
	@sleep 2
	@make test-deck-discovery
	@sleep 2
	@make test-card-states
	@sleep 2
	@make test-animations
	@sleep 2
	@make test-pwa-progressive
