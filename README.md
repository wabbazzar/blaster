# Card Blaster

An arcade-style flashcard learning game with a Tron aesthetic where players control a ship and shoot correct answers while flashcard terms fall from the screen.

## 🎮 Game Overview

Card Blaster combines learning with fast-paced arcade action. Players see a definition at the top of the screen and must shoot the correct term as it falls among wrong answers. The game features:

- **Tron-inspired visual design** with cyan borders and dark backgrounds
- **Real flashcard data** from data science terms
- **Fast-paced gameplay** with smooth ship movement and projectile physics
- **Scoring system** with level progression
- **Mobile-responsive design** for cross-platform play

## 🚀 Quick Start

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

# Run all core tests
make test-all

# Advanced debugging tests
make test-actual-bugs   # Bug detection system
make test-final-fixes   # Comprehensive verification
```

### Recent Bug Fixes

✅ **Fixed target positioning** - Targets now spawn within game board boundaries  
✅ **Eliminated target freeze** - Targets disappear immediately when hit  
✅ **Auto-progression** - Game cycles to new questions when targets are missed  
✅ **Improved format** - Definition in question box, term as correct answer  
✅ **Performance tuning** - 3x faster projectiles, 2x faster ship movement  
✅ **Boundary compliance** - Targets disappear at bottom of game board  

## 🧪 Testing Framework

The project includes a comprehensive test suite with iframe-based testing to verify actual game functionality:

- **Foundation Tests** - HTML structure and element access
- **Movement Tests** - Ship controls and boundary detection  
- **Projectile Tests** - Firing mechanics and collision detection
- **Target Tests** - Spawning, movement, and cleanup systems
- **Integration Tests** - Full gameplay verification
- **Bug Detection** - Automated issue identification

## 📱 Cross-Platform Support

- **Desktop browsers** (Chrome, Firefox, Safari)
- **Mobile browsers** (iOS Safari, Android Chrome)
- **Touch controls** for mobile devices
- **Responsive design** (320px to 1920px+ breakpoints)
- **60 FPS performance** maintained across platforms

## 🎨 Technical Features

- **Pure HTML/CSS/JavaScript** - No frameworks required
- **Modular architecture** - Separate systems for movement, projectiles, targets
- **Real-time collision detection** - Precise hit detection system
- **Dynamic content loading** - JSON-based flashcard data
- **Comprehensive logging** - Console output for debugging
- **Memory management** - Proper cleanup of game objects

## 📊 Game Mechanics

- **Ship Movement:** 20px per keypress (2x speed)
- **Projectile Speed:** 15px per frame (3x speed)  
- **Target Speed:** 2px per frame downward
- **Spawn Timing:** 800ms staggered intervals
- **Collision Detection:** Rectangle-based overlap detection
- **Scoring:** +100 points per correct answer

## 🔧 Configuration

Game parameters can be modified in `index.html`:

```javascript
// Ship movement speed
const newLeft = currentLeft + (direction * 20);

// Projectile speed  
proj.y += 15;

// Target fall speed
tgt.y += 2;

// Spawn delay between targets
setTimeout(spawnQueuedTargets, 800);
```

## 📈 Future Enhancements

- [ ] Multiple difficulty levels
- [ ] Sound effects and music
- [ ] Power-ups and special abilities
- [ ] Multiplayer support
- [ ] Additional flashcard categories
- [ ] Achievement system
- [ ] Leaderboards

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Run the test suite: `make test-all`
4. Submit a pull request

## 📄 License

This project is open source and available under the [MIT License](LICENSE).

## 🎯 Live Demo

Play the game live at: `http://localhost:8000` (after running `make serve`)

---

**Built with ❤️ for interactive learning** 