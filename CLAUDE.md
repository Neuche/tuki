# Tukis - Dialogic Project

## Scenes Created

### changuito_hello.tscn
A simple scene demonstrating Dialogic integration with a changuito sprite.

**Location:** `res://scenes/changuito_hello.tscn`

**Structure:**
- `Node2D` (root) - Main scene node with script
- `ColorRect` - White background (1152x648)
- `Sprite2D` - Changuito character sprite (centered)

**Script:** `changuito_hello.gd` - Automatically starts the "hello" dialogue timeline on scene load

## Dialogic Resources

### Character: Changuito
**Location:** `res://dialogic/characters/changuito.dch`
- Display name: "Changuito"
- Default portrait: changuito1.png
- Color: Light blue

### Timeline: Hello
**Location:** `res://dialogic/timelines/hello.dtl`
- Simple greeting dialogue
- Makes changuito appear and say "Hello!"

## Assets Used
- `changuito1.png` - Main changuito sprite (685KB)
- `changuito2.png` - Alternative changuito sprite
- `changuito3.png` - Alternative changuito sprite

## How to Run
1. Open the project in Godot
2. Run the `changuito_hello.tscn` scene
3. The changuito will appear and greet you using Dialogic
