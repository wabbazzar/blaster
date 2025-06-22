# Card Blaster

An arcade-style flashcard learning game with a Tron aesthetic where players control a ship and shoot correct answers while flashcard terms fall from the screen.

## 🎮 Live Demo

**Play now:** [https://wabbazzar.github.io/blaster/](https://wabbazzar.github.io/blaster/)

## 🎮 Game Overview

Card Blaster combines learning with fast-paced arcade action. Players see a definition at the top of the screen and must shoot the correct term as it falls among wrong answers. The game features:

- **Tron-inspired visual design** with cyan borders and dark backgrounds
- **Real flashcard data** from data science terms
- **Fast-paced gameplay** with smooth ship movement and projectile physics
- **Scoring system** with level progression
- **Mobile-responsive design** for cross-platform play

## 🚀 Quick Start

### Option 1: Play Online (Recommended)
Simply visit: [https://wabbazzar.github.io/blaster/](https://wabbazzar.github.io/blaster/)

### Option 2: Local Development
1. **Clone the repository:**
   ```bash
   git clone https://github.com/wabbazzar/blaster.git
   cd blaster
   ```

2. **Start the development server:**
   ```bash
   make serve
   ```

3. **Open the game:**
   Navigate to `http://localhost:8000` in your browser

## 🎯 How to Play

- **Move Ship:** Use left/right arrow keys
- **Shoot:** Press spacebar to fire projectiles
- **Objective:** Read the definition at the top and shoot the correct term
- **Scoring:** +100 points for each correct answer
- **Progression:** Game automatically loads new questions

## 📱 Mobile Support

**Current Status:** Desktop-optimized (mobile improvements coming soon)
- Game works on mobile browsers but optimized for desktop
- Touch controls and responsive design in development
- See `docs/mobile_todo.md` for mobile enhancement roadmap

## 🛠️ Development

### Project Structure

```
flashcard_blaster/
├── index.html          # Main game file
├── Makefile           # Development commands
├── assets/            # Game data and resources
│   └── data_science_cards.json
├── tests/             # Comprehensive test suite
├── docs/              # Documentation
│   └── mobile_todo.md # Mobile development plan
├── .github/           # GitHub Actions for deployment
└── README.md
```

### Development Commands

```bash
# Start development server
make serve

# Run individual tests
make test-foundation    # Basic HTML structure
make test-movement      # Ship movement controls
make test-projectiles   # Projectile system
make test-targets       # Target spawning and movement
make test-collision     # Collision detection
make test-complete      # Full game integration

# Mobile testing
make test-mobile-assessment  # Mobile compatibility check
make test-mobile-device     # Real device testing instructions

# Run all core tests
make test-all

# Advanced debugging tests
make test-actual-bugs   # Bug detection system
make test-board-boundary # Target boundary verification
```

## 🚀 Deployment

The game is automatically deployed to GitHub Pages via GitHub Actions:

- **Live URL:** [https://wabbazzar.github.io/blaster/](https://wabbazzar.github.io/blaster/)
- **Auto-deployment** on push to main branch
- **Custom 404 page** with Tron-themed design
- **Mobile-optimized** meta tags and viewport configuration

### Manual Deployment
```bash
# The game deploys automatically, but you can trigger manually by:
git push origin main
# GitHub Actions will handle the rest
```

## 🎯 Live Demo

Play the game live at: `http://localhost:8000` (after running `make serve`)

---

**Built with ❤️ for interactive learning** 