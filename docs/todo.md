# Card Blaster Development Plan - ZERO ASSUMPTIONS, TOTAL VERIFICATION

## CRITICAL RULES - READ THESE OR DIE
1. **EVERY LINE OF CODE MUST BE VISUALLY VERIFIED** - No exceptions
2. **EVERY ASSUMPTION MUST BE PROVEN** - Test everything
3. **USE THE ACTUAL GAME CODE** - No fake test components
4. **VISUAL PROOF REQUIRED** - Screenshots, console logs, or it didn't happen
5. **TINY STEPS** - If a step takes more than 5 minutes, it's too big
6. **NO CARD LOGIC** - Just read from JSON, period

## Phase 0: Foundation & Test Infrastructure (NO GAME YET)

### Step 0.1: Create Empty HTML Page
- [ ] Create index.html with ONLY `<!DOCTYPE html><html><body><h1>Card Blaster</h1></body></html>`
- [ ] **VISUAL TEST**: Open in browser, see "Card Blaster" text
- [ ] **PROOF**: Take screenshot showing h1 renders

### Step 0.2: Add Basic CSS Reset
- [ ] Add style tag with `* { margin: 0; padding: 0; box-sizing: border-box; }`
- [ ] Add `body { background: #000; color: #00ffff; }`
- [ ] **VISUAL TEST**: Background is black, text is cyan
- [ ] **PROOF**: Use color picker to verify #000000 and #00ffff

### Step 0.3: Create Makefile
```makefile
serve:
	python3 -m http.server 8000

test-foundation:
	open http://localhost:8000/test_foundation.html
```
- [ ] **VISUAL TEST**: Run `make serve`, verify server starts
- [ ] **PROOF**: Terminal shows "Serving HTTP on 0.0.0.0 port 8000"

### Step 0.4: Create Visual Test Framework
- [ ] Create test_foundation.html that loads index.html in iframe
- [ ] Add function to get iframe document: `function getGameDoc() { return document.getElementById('gameFrame').contentDocument; }`
- [ ] Add function to log results: `function log(pass, msg) { ... }`
- [ ] **VISUAL TEST**: Open test page, see iframe with game
- [ ] **PROOF**: Console shows "Test framework loaded"

### Step 0.5: Test That We Can Access Game Elements
- [ ] In test_foundation.html, add test: `const h1 = getGameDoc().querySelector('h1');`
- [ ] Log: `log(h1 !== null, 'Can find h1 element');`
- [ ] Log: `log(h1.textContent === 'Card Blaster', 'H1 says Card Blaster');`
- [ ] **VISUAL TEST**: See "PASS: Can find h1 element" in test results
- [ ] **PROOF**: Both tests show green PASS

## Phase 1: Static Game Board (NO MOVEMENT YET)

### Step 1.1: Create Game Container
- [ ] Add to index.html: `<div id="gameBoard" style="width: 400px; height: 600px; border: 1px solid cyan;"></div>`
- [ ] **VISUAL TEST**: See 400x600 cyan border box
- [ ] **PROOF**: Measure with browser dev tools, verify 400x600

### Step 1.2: Test Game Board Dimensions
- [ ] Create test_board.html
- [ ] Test: `const board = getGameDoc().getElementById('gameBoard');`
- [ ] Test: `log(board.offsetWidth === 400, 'Board width is 400px');`
- [ ] Test: `log(board.offsetHeight === 600, 'Board height is 600px');`
- [ ] **VISUAL TEST**: All tests PASS
- [ ] **PROOF**: Screenshot of passing tests

### Step 1.3: Add Ship Element (STATIC)
- [ ] Add to gameBoard: `<div id="ship" style="position: absolute; bottom: 20px; left: 180px; width: 40px; height: 40px; background: cyan;"></div>`
- [ ] **VISUAL TEST**: See cyan square at bottom center
- [ ] **PROOF**: Ship is visible, centered horizontally

### Step 1.4: Test Ship Position
- [ ] In test_board.html, add ship position tests
- [ ] Test: `const ship = getGameDoc().getElementById('ship');`
- [ ] Test: `log(ship.style.bottom === '20px', 'Ship is 20px from bottom');`
- [ ] Test: `log(ship.style.left === '180px', 'Ship starts at 180px');`
- [ ] **VISUAL TEST**: All position tests PASS
- [ ] **PROOF**: Console shows all green

### Step 1.5: Add Question Area (STATIC)
- [ ] Add above gameBoard: `<div id="questionArea" style="height: 100px; border: 1px solid cyan;"><div id="questionText">Question goes here</div></div>`
- [ ] **VISUAL TEST**: See question area above game board
- [ ] **PROOF**: "Question goes here" text visible

### Step 1.6: Test Question Area Exists
- [ ] Test: `const qa = getGameDoc().getElementById('questionArea');`
- [ ] Test: `const qt = getGameDoc().getElementById('questionText');`
- [ ] Test: `log(qa !== null, 'Question area exists');`
- [ ] Test: `log(qt.textContent === 'Question goes here', 'Question text correct');`
- [ ] **VISUAL TEST**: All tests PASS
- [ ] **PROOF**: Screenshot of passing tests

## Phase 2: Ship Movement (KEYBOARD ONLY FIRST)

### Step 2.1: Add Ship Movement Function
```javascript
function moveShip(direction) {
    const ship = document.getElementById('ship');
    const currentLeft = parseInt(ship.style.left) || 0;
    const newLeft = currentLeft + (direction * 10);
    ship.style.left = newLeft + 'px';
    console.log('Ship moved to:', newLeft);
}
```
- [ ] Add to index.html in script tag
- [ ] **VISUAL TEST**: Open console, type `moveShip(1)`, ship moves right
- [ ] **PROOF**: Console shows "Ship moved to: 190"

### Step 2.2: Test Ship Movement Function
- [ ] Create test_movement.html
- [ ] Test: `gameWin.moveShip(1); // Move right`
- [ ] Test: `const newPos = parseInt(ship.style.left);`
- [ ] Test: `log(newPos === 190, 'Ship moved right to 190px');`
- [ ] **VISUAL TEST**: Ship visually moves right
- [ ] **PROOF**: Test passes and ship at new position

### Step 2.3: Add Keyboard Controls
```javascript
document.addEventListener('keydown', function(e) {
    console.log('Key pressed:', e.key);
    if (e.key === 'ArrowLeft') moveShip(-1);
    if (e.key === 'ArrowRight') moveShip(1);
});
```
- [ ] Add to index.html
- [ ] **VISUAL TEST**: Press arrow keys, ship moves
- [ ] **PROOF**: Console logs key presses and movements

### Step 2.4: Test Keyboard Controls Work
- [ ] In test_movement.html, simulate keypress
- [ ] `gameWin.document.dispatchEvent(new KeyboardEvent('keydown', {key: 'ArrowRight'}));`
- [ ] Test ship moved right
- [ ] **VISUAL TEST**: Ship moves on keypress
- [ ] **PROOF**: Position changes in test

### Step 2.5: Add Ship Boundaries
```javascript
function moveShip(direction) {
    const ship = document.getElementById('ship');
    const board = document.getElementById('gameBoard');
    const currentLeft = parseInt(ship.style.left) || 0;
    const newLeft = currentLeft + (direction * 10);
    const maxLeft = board.offsetWidth - ship.offsetWidth;
    
    if (newLeft >= 0 && newLeft <= maxLeft) {
        ship.style.left = newLeft + 'px';
        console.log('Ship moved to:', newLeft);
    } else {
        console.log('Ship hit boundary at:', currentLeft);
    }
}
```
- [ ] Update moveShip function
- [ ] **VISUAL TEST**: Ship stops at edges
- [ ] **PROOF**: Console shows "hit boundary" messages

### Step 2.6: Test Ship Boundaries
- [ ] Test ship can't go below 0
- [ ] Test ship can't go above board width - ship width
- [ ] Move ship to 0, try moving left, verify stays at 0
- [ ] Move ship to max, try moving right, verify stays at max
- [ ] **VISUAL TEST**: Ship stops at both edges
- [ ] **PROOF**: All boundary tests PASS

## Phase 3: Projectiles (STATIC FIRST, THEN MOVING)

### Step 3.1: Create Static Projectile
```javascript
function createProjectile() {
    const ship = document.getElementById('ship');
    const projectile = document.createElement('div');
    projectile.className = 'projectile';
    projectile.style.position = 'absolute';
    projectile.style.width = '5px';
    projectile.style.height = '10px';
    projectile.style.background = '#00ffff';
    projectile.style.left = (parseInt(ship.style.left) + 17) + 'px';
    projectile.style.bottom = '60px';
    document.getElementById('gameBoard').appendChild(projectile);
    console.log('Projectile created at:', projectile.style.left);
}
```
- [ ] Add function to index.html
- [ ] **VISUAL TEST**: Call `createProjectile()`, see cyan rectangle above ship
- [ ] **PROOF**: Projectile visible at ship's x position

### Step 3.2: Test Projectile Creation
- [ ] Create test_projectiles.html
- [ ] Test projectile appears when function called
- [ ] Test projectile x position matches ship center
- [ ] Test projectile starts at correct height
- [ ] **VISUAL TEST**: Projectile appears above ship
- [ ] **PROOF**: All position tests PASS

### Step 3.3: Add Spacebar to Fire
```javascript
document.addEventListener('keydown', function(e) {
    console.log('Key pressed:', e.key);
    if (e.key === 'ArrowLeft') moveShip(-1);
    if (e.key === 'ArrowRight') moveShip(1);
    if (e.key === ' ') createProjectile();
});
```
- [ ] Update keydown handler
- [ ] **VISUAL TEST**: Press spacebar, projectile appears
- [ ] **PROOF**: Console shows "Projectile created at: X"

### Step 3.4: Make Projectiles Move
```javascript
let projectiles = [];

function createProjectile() {
    // ... existing code ...
    projectiles.push({
        element: projectile,
        y: 60
    });
}

function updateProjectiles() {
    projectiles.forEach((proj, index) => {
        proj.y += 5;
        proj.element.style.bottom = proj.y + 'px';
        
        if (proj.y > 600) {
            proj.element.remove();
            projectiles.splice(index, 1);
            console.log('Projectile removed');
        }
    });
}

setInterval(updateProjectiles, 50);
```
- [ ] Add projectile movement system
- [ ] **VISUAL TEST**: Projectiles move upward
- [ ] **PROOF**: Console shows "Projectile removed" when they leave screen

### Step 3.5: Test Projectile Movement
- [ ] Test projectiles move up
- [ ] Test projectiles get removed at top
- [ ] Test multiple projectiles can exist
- [ ] Count projectiles array before and after removal
- [ ] **VISUAL TEST**: Multiple projectiles moving
- [ ] **PROOF**: Array length changes correctly

## Phase 4: Falling Targets (STATIC FIRST)

### Step 4.1: Create Static Target
```javascript
function createTarget(text, x) {
    const target = document.createElement('div');
    target.className = 'target';
    target.style.position = 'absolute';
    target.style.width = '100px';
    target.style.height = '60px';
    target.style.background = '#003366';
    target.style.border = '2px solid #00ffff';
    target.style.left = x + 'px';
    target.style.top = '0px';
    target.textContent = text;
    target.style.color = '#00ffff';
    target.style.textAlign = 'center';
    target.style.lineHeight = '60px';
    document.getElementById('gameBoard').appendChild(target);
    console.log('Target created:', text, 'at x:', x);
}
```
- [ ] Add function
- [ ] Call `createTarget('Test Answer', 150)`
- [ ] **VISUAL TEST**: See target with text at top
- [ ] **PROOF**: Target visible with "Test Answer" text

### Step 4.2: Test Target Creation
- [ ] Create test_targets.html
- [ ] Test target appears at correct position
- [ ] Test target has correct text
- [ ] Test target styling is correct
- [ ] **VISUAL TEST**: Target visible with styling
- [ ] **PROOF**: All property tests PASS

### Step 4.3: Make Targets Fall
```javascript
let targets = [];

function createTarget(text, x, isCorrect) {
    // ... existing code ...
    targets.push({
        element: target,
        y: 0,
        isCorrect: isCorrect,
        text: text
    });
}

function updateTargets() {
    targets.forEach((target, index) => {
        target.y += 2;
        target.element.style.top = target.y + 'px';
        
        if (target.y > 600) {
            target.element.remove();
            targets.splice(index, 1);
            console.log('Target removed:', target.text);
        }
    });
}

setInterval(updateTargets, 50);
```
- [ ] Add falling logic
- [ ] **VISUAL TEST**: Targets fall down screen
- [ ] **PROOF**: Console shows removal messages

### Step 4.4: Test Target Movement
- [ ] Test targets fall at correct speed
- [ ] Test targets get removed at bottom
- [ ] Test multiple targets can exist
- [ ] Verify isCorrect property maintained
- [ ] **VISUAL TEST**: Multiple targets falling
- [ ] **PROOF**: All movement tests PASS

## Phase 5: Collision Detection

### Step 5.1: Add Basic Collision Check
```javascript
function checkCollisions() {
    projectiles.forEach((proj, pIndex) => {
        const pRect = proj.element.getBoundingClientRect();
        
        targets.forEach((target, tIndex) => {
            const tRect = target.element.getBoundingClientRect();
            
            if (pRect.left < tRect.right &&
                pRect.right > tRect.left &&
                pRect.top < tRect.bottom &&
                pRect.bottom > tRect.top) {
                
                console.log('HIT!', target.text, 'Correct:', target.isCorrect);
                
                // Remove both
                proj.element.remove();
                projectiles.splice(pIndex, 1);
                
                target.element.remove();
                targets.splice(tIndex, 1);
            }
        });
    });
}

setInterval(checkCollisions, 50);
```
- [ ] Add collision detection
- [ ] **VISUAL TEST**: Shoot target, both disappear
- [ ] **PROOF**: Console shows "HIT!" message

### Step 5.2: Test Collision Detection
- [ ] Create test_collisions.html
- [ ] Create target at known position
- [ ] Create projectile below it
- [ ] Move projectile up until collision
- [ ] Test both are removed
- [ ] **VISUAL TEST**: Collision removes both
- [ ] **PROOF**: Arrays emptied after collision

## Phase 6: Score and Lives System

### Step 6.1: Add Score Display
```html
<div id="scoreDisplay">Score: <span id="score">0</span></div>
```
```javascript
let score = 0;
function updateScore(points) {
    score += points;
    document.getElementById('score').textContent = score;
    console.log('Score updated:', score);
}
```
- [ ] Add score HTML and JS
- [ ] Call `updateScore(100)`
- [ ] **VISUAL TEST**: Score shows 100
- [ ] **PROOF**: Display updates correctly

### Step 6.2: Add Lives Display
```html
<div id="livesDisplay">Lives: <span id="lives">5</span></div>
```
```javascript
let lives = 5;
function loseLife() {
    lives--;
    document.getElementById('lives').textContent = lives;
    console.log('Lives remaining:', lives);
    
    if (lives <= 0) {
        console.log('GAME OVER');
    }
}
```
- [ ] Add lives system
- [ ] Call `loseLife()` multiple times
- [ ] **VISUAL TEST**: Lives decrease to 0
- [ ] **PROOF**: Console shows "GAME OVER"

### Step 6.3: Connect Score/Lives to Collisions
```javascript
function checkCollisions() {
    // ... existing code ...
    if (collision) {
        if (target.isCorrect) {
            updateScore(100);
        } else {
            loseLife();
        }
    }
}
```
- [ ] Update collision handler
- [ ] **VISUAL TEST**: Hit correct = score up, wrong = life down
- [ ] **PROOF**: Score and lives change appropriately

### Step 6.4: Test Score/Lives Integration
- [ ] Create correct and wrong targets
- [ ] Shoot correct target, verify score +100
- [ ] Shoot wrong target, verify lives -1
- [ ] Test game over at 0 lives
- [ ] **VISUAL TEST**: UI updates correctly
- [ ] **PROOF**: All integration tests PASS

## Phase 7: Load Questions from JSON

### Step 7.1: Create Test JSON
```json
{
    "accepted_cards": [
        {
            "id": "test1",
            "term": "Test Term 1",
            "definition": "Test Definition 1",
            "wrong_answers": ["Wrong 1", "Wrong 2", "Wrong 3"]
        }
    ]
}
```
- [ ] Create assets/test_cards.json
- [ ] **VISUAL TEST**: File exists in browser
- [ ] **PROOF**: Can access via http://localhost:8000/assets/test_cards.json

### Step 7.2: Load JSON Data
```javascript
let cards = [];

async function loadCards() {
    try {
        const response = await fetch('./assets/test_cards.json');
        const data = await response.json();
        cards = data.accepted_cards;
        console.log('Loaded cards:', cards.length);
    } catch (error) {
        console.error('Failed to load cards:', error);
    }
}
```
- [ ] Add load function
- [ ] Call `loadCards()`
- [ ] **VISUAL TEST**: Console shows "Loaded cards: 1"
- [ ] **PROOF**: No errors in console

### Step 7.3: Test JSON Loading
- [ ] Create test_json.html
- [ ] Test cards array populated
- [ ] Test card has correct properties
- [ ] Test wrong_answers exists
- [ ] **VISUAL TEST**: Card data accessible
- [ ] **PROOF**: All property tests PASS

## Phase 8: Question Display System

### Step 8.1: Display First Question
```javascript
let currentCard = null;

function showQuestion() {
    if (cards.length === 0) return;
    
    currentCard = cards[0];
    document.getElementById('questionText').textContent = `What is ${currentCard.term}?`;
    console.log('Showing question:', currentCard.term);
}
```
- [ ] Add question display
- [ ] Call after loadCards()
- [ ] **VISUAL TEST**: Question shows "What is Test Term 1?"
- [ ] **PROOF**: Correct formatting

### Step 8.2: Create Answer Targets
```javascript
function spawnAnswers() {
    if (!currentCard) return;
    
    const answers = [
        { text: currentCard.definition, correct: true },
        { text: currentCard.wrong_answers[0], correct: false },
        { text: currentCard.wrong_answers[1], correct: false },
        { text: currentCard.wrong_answers[2], correct: false }
    ];
    
    // Shuffle
    answers.sort(() => Math.random() - 0.5);
    
    // Create targets
    answers.forEach((answer, index) => {
        createTarget(answer.text, index * 100, answer.correct);
    });
}
```
- [ ] Add answer spawning
- [ ] **VISUAL TEST**: 4 targets appear with answers
- [ ] **PROOF**: One is definition, three are wrong

### Step 8.3: Test Answer System
- [ ] Test 4 answers spawn
- [ ] Test correct answer included
- [ ] Test positions don't overlap
- [ ] Test shuffle works (run multiple times)
- [ ] **VISUAL TEST**: Different arrangements
- [ ] **PROOF**: Randomization verified

## Phase 9: Game Loop

### Step 9.1: Create Basic Game Loop
```javascript
let gameRunning = false;

function startGame() {
    gameRunning = true;
    score = 0;
    lives = 5;
    updateScore(0);
    document.getElementById('lives').textContent = lives;
    
    loadCards().then(() => {
        showQuestion();
        spawnAnswers();
    });
    
    console.log('Game started');
}

function gameLoop() {
    if (!gameRunning) return;
    
    updateProjectiles();
    updateTargets();
    checkCollisions();
    
    requestAnimationFrame(gameLoop);
}
```
- [ ] Add game loop structure
- [ ] Call `startGame()` then `gameLoop()`
- [ ] **VISUAL TEST**: Game runs continuously
- [ ] **PROOF**: Smooth animation

### Step 9.2: Test Game Loop
- [ ] Test game starts correctly
- [ ] Test all systems update
- [ ] Test can shoot and hit targets
- [ ] Test score updates
- [ ] **VISUAL TEST**: Full gameplay works
- [ ] **PROOF**: Can play the game

## Phase 10: Complete Game Flow

### Step 10.1: Add New Question After Correct Hit
```javascript
function handleCorrectHit() {
    updateScore(100);
    
    // Clear remaining targets
    targets.forEach(t => t.element.remove());
    targets = [];
    
    // Show next question
    setTimeout(() => {
        showQuestion(); // For now, same question
        spawnAnswers();
    }, 500);
}
```
- [ ] Add question progression
- [ ] **VISUAL TEST**: Hit correct, new targets spawn
- [ ] **PROOF**: Old targets cleared first

### Step 10.2: Add Game Over
```javascript
function gameOver() {
    gameRunning = false;
    console.log('GAME OVER - Final Score:', score);
    
    // Clear everything
    projectiles.forEach(p => p.element.remove());
    targets.forEach(t => t.element.remove());
    projectiles = [];
    targets = [];
}
```
- [ ] Add game over handling
- [ ] **VISUAL TEST**: Game stops at 0 lives
- [ ] **PROOF**: All elements cleared

### Step 10.3: Add Start Button
```html
<button onclick="startGame()">Start Game</button>
```
- [ ] Add start button
- [ ] **VISUAL TEST**: Click starts game
- [ ] **PROOF**: Game initializes properly

### Step 10.4: Final Integration Test
- [ ] Start game
- [ ] Move ship left and right
- [ ] Shoot projectiles
- [ ] Hit correct answer - score increases
- [ ] Hit wrong answer - lose life
- [ ] Lose all lives - game over
- [ ] **VISUAL TEST**: Complete game cycle
- [ ] **PROOF**: All systems integrated

## Phase 11: Polish and Styling

### Step 11.1: Add Tron Styling
```css
.target {
    background: rgba(0, 51, 102, 0.8);
    border: 2px solid #00ffff;
    box-shadow: 0 0 10px #00ffff;
}

#ship {
    background: linear-gradient(45deg, #00ffff, #0099ff);
    box-shadow: 0 0 20px #00ffff;
}

.projectile {
    background: #00ffff;
    box-shadow: 0 0 10px #00ffff;
}
```
- [ ] Add visual effects
- [ ] **VISUAL TEST**: Glowing neon style
- [ ] **PROOF**: Screenshot of styled game

### Step 11.2: Add Hit Animations
```css
@keyframes correctHit {
    0% { transform: scale(1); opacity: 1; }
    100% { transform: scale(2); opacity: 0; }
}

@keyframes wrongHit {
    0% { transform: scale(1) rotate(0); }
    100% { transform: scale(0.5) rotate(180deg); opacity: 0; }
}
```
- [ ] Add animations
- [ ] Apply on collision
- [ ] **VISUAL TEST**: Targets animate on hit
- [ ] **PROOF**: Smooth animations

### Step 11.3: Add Sound Effects (Optional)
- [ ] Add audio elements
- [ ] Play on shoot, hit, game over
- [ ] **VISUAL TEST**: Sounds play correctly
- [ ] **PROOF**: No console errors

## Phase 12: Final Testing Suite

### Step 12.1: Create Comprehensive Test
- [ ] Create test_complete.html
- [ ] Test every single function
- [ ] Test all game states
- [ ] Test edge cases
- [ ] **VISUAL TEST**: All tests PASS
- [ ] **PROOF**: Screenshot of 100% pass

### Step 12.2: Performance Test
- [ ] Monitor FPS during gameplay
- [ ] Check memory usage
- [ ] Verify no memory leaks
- [ ] Test with many projectiles/targets
- [ ] **VISUAL TEST**: Maintains 60 FPS
- [ ] **PROOF**: Performance metrics

### Step 12.3: Cross-Browser Test
- [ ] Test in Chrome
- [ ] Test in Firefox
- [ ] Test in Safari
- [ ] Test in Edge
- [ ] **VISUAL TEST**: Works in all browsers
- [ ] **PROOF**: Screenshots from each

## FINAL CHECKLIST

### Core Functionality
- [ ] Ship moves left/right with boundaries
- [ ] Spacebar fires projectiles
- [ ] Targets fall from top
- [ ] Collision detection works
- [ ] Score increases on correct hit
- [ ] Lives decrease on wrong hit
- [ ] Questions load from JSON
- [ ] Game over at 0 lives

### Visual Verification
- [ ] Every function has a visual test
- [ ] Every test uses ACTUAL game code
- [ ] No assumptions without proof
- [ ] Console logs verify behavior
- [ ] Screenshots document working state

### Code Quality
- [ ] No complex card logic
- [ ] Simple JSON reading
- [ ] Clear function names
- [ ] Logged every action
- [ ] Error handling present

## SUCCESS CRITERIA

The game is DONE when:
1. Can play from start to game over
2. All tests pass using real game code
3. No assumptions left unproven
4. Every feature visually verified
5. Clean, working Card Blaster game

## REMEMBER

- **TEST THE ACTUAL GAME CODE**
- **VISUAL PROOF OR IT DIDN'T HAPPEN**
- **TINY STEPS WITH VERIFICATION**
- **NO ASSUMPTIONS**
- **NO COMPLEX CARD LOGIC**
- **JUST MAKE IT WORK**
