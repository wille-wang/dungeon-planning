# Dungeon Planning Problem

This project defines a **round-based multi-hero dungeon planning problem** using a [Planning Domain Definition Language](https://en.wikipedia.org/wiki/Planning_Domain_Definition_Language) (PDDL) model. The goal is to help multiple heroes escape from a dungeon filled with monsters, traps, and locked doors in the fewest number of rounds. The dungeon is composed of connected rooms, and each hero must strategize to avoid monsters, disarm traps, and unlock doors to achieve their escape.

|     | 1   | 2   | 3   | 4   | 5   | 6   | 7   | 8   |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| A   | 🚪   |     | 👾   | 🔒   |     |     | 🔒   | 🗡️   |
| B   | 🪤   | 👾   |     | 🗡️   |     | 👾   |     | 🦸‍♂️   |
| C   |     |     | 👾   |     | 🔒   |     | 🔑   |     |
| D   | 👾   | 🗡️   | 🪤   | 🦸‍♂️   | 🔒   |     |     | 👾   |

## Rules

- The dungeon is a grid of connected rooms, where each room may contain a hero 🦸‍♂️, monster 👾, sword 🗡️, key 🔑, locked door 🔒, trap 🪤, or be empty.
- On each turn, a hero can perform one of the following actions:
  - Move to an adjacent empty room.
  - Move to an adjacent room with a monster 👾, only if the hero holds a sword 🗡️.
  - Move to an adjacent room with a locked door 🔒, only if the hero holds a key 🔑.
  - Move to an adjacent room with a trap 🪤 and disarm the trap, only if the hero holds nothing.
  - Pick up a sword 🗡️ or key 🔑 if the hero is holding nothing.
  - Throw a sword 🗡️ or key 🔑 if the hero is holding one.
  - Pass a sword 🗡️ or key 🔑 to another hero 🦸‍♂️ in the same room.
  - Do nothing (if the hero has already escaped).
- Once a hero leaves a room, that room is destroyed and becomes inaccessible for the remainder of the game.
- The order in which heroes take their turns in a round is flexible, and once a hero escapes, they no longer participate in subsequent turns. Additionally, a hero may detour around the goal room as long as their total number of turns does not exceed those of the other heroes.

## Repository Structure

```plaintext
.
├── out
│   ├── plan.txt            # Show the sequence of actions generated by the solver
│   └── solver-output.txt   # Log the output and statistics from the solver
├── README.md
└── src
    ├── domain.pddl         # Define the planning domain
    └── problem1.pddl       # Define a specific problem in the domain
```

## Usage

It is recommended to run the code for this project at [PDDL Editor](https://editor.planning.domains/).

1. Upload `src/domain.pddl` and `src/problem1.pddl` to the PDDL Editor.
2. Click <kbd>Solver</kbd>:
   1. Set the domain as `domain.pddl`.
   2. Set the problem as `problem1.pddl`.
   3. Choose a solver. BFWS is recommended.
