(define (domain Dungeon)

    (:requirements :typing :negative-preconditions :universal-preconditions :disjunctive-preconditions)

    (:types
        room hero turn
    )

    (:predicates
        ; Define the locations of objects
        (at-hero ?h - hero ?r - room)
        (at-monster ?r - room)
        (at-sword ?r - room)
        (at-key ?r - room)
        (at-lock ?r - room)
        (at-trap ?r - room)
        (connected ?r1 ?r2 - room)

        ; Define room statuses
        (is-destroyed ?r - room)
        (is-disarmed ?r - room)

        ; Define hero statuses
        (holding-nothing ?h - hero)
        (holding-sword ?h - hero)
        (holding-key ?h - hero)

        ; Define heroes' goals
        (has-goal ?h - hero ?r - room)
        (has-escaped ?h - hero)

        ; Define turns
        (hero-turn ?h - hero ?t - turn)
        (current-turn ?t - turn)
        (next-turn ?t1 ?t2 - turn)
    )

    ; Move to an adjacent room where there is no monster, no trap, and no lock
    (:action move
        :parameters (?from ?to - room ?h - hero ?curr ?next - turn)
        :precondition (and
            (at-hero ?h ?from)
            (connected ?from ?to)
            (not (is-destroyed ?to))
            (not (at-monster ?to))
            (not (at-trap ?to))
            (not (at-lock ?to))
            (or
                (not (at-trap ?from))
                (is-disarmed ?from)
            )

            (hero-turn ?h ?curr)
            (current-turn ?curr)
            (next-turn ?curr ?next)
            (not (has-escaped ?h))
        )
        :effect (and
            (when
                (has-goal ?h ?to)
                (has-escaped ?h)
            )

            (at-hero ?h ?to)
            (not (at-hero ?h ?from))
            (is-destroyed ?from)

            (hero-turn ?h ?next)
            (not (hero-turn ?h ?curr))
        )
    )

    ; Move to an adjacent room where there is a trap if he is holding nothing
    (:action move-trap
        :parameters (?from ?to - room ?h - hero ?curr ?next - turn)
        :precondition (and
            (at-hero ?h ?from)
            (connected ?from ?to)
            (not (is-destroyed ?to))
            (not (at-monster ?to))
            (at-trap ?to) (holding-nothing ?h)
            (not (at-lock ?to))
            (or
                (not (at-trap ?from))
                (is-disarmed ?from)
            )

            (hero-turn ?h ?curr)
            (current-turn ?curr)
            (next-turn ?curr ?next)
            (not (has-escaped ?h))
        )
        :effect (and
            (at-hero ?h ?to)
            (not (at-hero ?h ?from))
            (is-destroyed ?from)
            ; (is-disarmed ?r)

            (hero-turn ?h ?next)
            (not (hero-turn ?h ?curr))
        )
    )

    ; Move to an adjacent room where there is a monster if he is holding a sword
    (:action move-monster
        :parameters (?from ?to - room ?h - hero ?curr ?next - turn)
        :precondition (and
            (at-hero ?h ?from)
            (connected ?from ?to)
            (not (is-destroyed ?to))
            (at-monster ?to) (holding-sword ?h)
            (not (at-trap ?to))
            (not (at-lock ?to))
            (or
                (not (at-trap ?from))
                (is-disarmed ?from)
            )

            (hero-turn ?h ?curr)
            (current-turn ?curr)
            (next-turn ?curr ?next)
            (not (has-escaped ?h))
        )
        :effect (and
            (at-hero ?h ?to)
            (not (at-hero ?h ?from))
            (is-destroyed ?from)

            (hero-turn ?h ?next)
            (not (hero-turn ?h ?curr))
        )
    )

    ; Move to an adjacent room where there is a lock if he is holding a key
    (:action move-lock
        :parameters (?from ?to - room ?h - hero ?curr ?next - turn)
        :precondition (and
            (at-hero ?h ?from)
            (connected ?from ?to)
            (not (is-destroyed ?to))
            (not (at-monster ?to))
            (not (at-trap ?to))
            (at-lock ?to) (holding-key ?h)
            (or
                (not (at-trap ?from))
                (is-disarmed ?from)
            )

            (hero-turn ?h ?curr)
            (current-turn ?curr)
            (next-turn ?curr ?next)
            (not (has-escaped ?h))
        )
        :effect (and
            (at-hero ?h ?to)
            (not (at-hero ?h ?from))
            (is-destroyed ?from)

            (hero-turn ?h ?next)
            (not (hero-turn ?h ?curr))
        )
    )

    ; Pick up a sword if he is holding nothing
    (:action pick-up-sword
        :parameters (?r - room ?h - hero ?curr ?next - turn)
        :precondition (and
            (at-hero ?h ?r)
            (at-sword ?r)
            (holding-nothing ?h)

            (hero-turn ?h ?curr)
            (current-turn ?curr)
            (next-turn ?curr ?next)
            (not (has-escaped ?h))
        )
        :effect (and
            (holding-sword ?h)
            (not (holding-nothing ?h))
            (not (at-sword ?r))

            (hero-turn ?h ?next)
            (not (hero-turn ?h ?curr))
        )
    )

    ; Pick up a key if he is holding nothing
    (:action pick-up-key
        :parameters (?r - room ?h - hero ?curr ?next - turn)
        :precondition (and
            (at-hero ?h ?r)
            (at-key ?r)
            (holding-nothing ?h)

            (hero-turn ?h ?curr)
            (current-turn ?curr)
            (next-turn ?curr ?next)
            (not (has-escaped ?h))
        )
        :effect (and
            (holding-key ?h)
            (not (holding-nothing ?h))
            (not (at-key ?r))

            (hero-turn ?h ?next)
            (not (hero-turn ?h ?curr))
        )
    )

    ; Drop a sword if he is holding one and not in a room with a monster/trap
    (:action drop-sword
        :parameters (?r - room ?h - hero ?curr ?next - turn)
        :precondition (and
            (at-hero ?h ?r)
            (holding-sword ?h)
            (not (at-monster ?r))
            (not (at-trap ?r))
            (not (at-lock ?r))

            (hero-turn ?h ?curr)
            (current-turn ?curr)
            (next-turn ?curr ?next)
            (not (has-escaped ?h))
        )
        :effect (and
            (holding-nothing ?h)
            (not (holding-sword ?h))
            (at-sword ?r)

            (hero-turn ?h ?next)
            (not (hero-turn ?h ?curr))
        )
    )

    ; Drop a key if he is holding a key and not in a room with a lock
    (:action drop-key
        :parameters (?r - room ?h - hero ?curr ?next - turn)
        :precondition (and
            (at-hero ?h ?r)
            (holding-key ?h)
            (not (at-monster ?r))
            (not (at-trap ?r))
            (not (at-lock ?r))

            (hero-turn ?h ?curr)
            (current-turn ?curr)
            (next-turn ?curr ?next)
            (not (has-escaped ?h))
        )
        :effect (and
            (holding-nothing ?h)
            (not (holding-key ?h))
            (at-key ?r)

            (hero-turn ?h ?next)
            (not (hero-turn ?h ?curr))
        )
    )

    ; Disarm a trap if he is holding nothing
    (:action disarm-trap
        :parameters (?r - room ?h - hero ?curr ?next - turn)
        :precondition (and
            (at-hero ?h ?r)
            (holding-nothing ?h)
            (not (at-monster ?r))
            (at-trap ?r)
            (not (at-lock ?r))

            (hero-turn ?h ?curr)
            (current-turn ?curr)
            (next-turn ?curr ?next)
            (not (has-escaped ?h))
        )
        :effect (and
            (is-disarmed ?r)

            (hero-turn ?h ?next)
            (not (hero-turn ?h ?curr))
        )
    )

    ; Pass a sword to another hero
    (:action pass-sword
        :parameters (?r - room ?giver ?receiver - hero ?curr ?next - turn)
        :precondition (and
            (at-hero ?giver ?r)
            (holding-sword ?giver)
            (at-hero ?receiver ?r)
            (holding-nothing ?receiver)
            (not (= ?giver ?receiver))

            (hero-turn ?giver ?curr)
            (current-turn ?curr)
            (next-turn ?curr ?next)
            (not (has-escaped ?giver))
        )
        :effect (and
            (holding-nothing ?giver)
            (not (holding-sword ?giver))
            (holding-sword ?receiver)

            (hero-turn ?giver ?next)
            (not (hero-turn ?giver ?curr))
        )
    )

    ; Pass a key to another hero
    (:action pass-key
        :parameters (?r - room ?giver ?receiver - hero ?curr ?next - turn)
        :precondition (and
            (at-hero ?giver ?r)
            (holding-key ?giver)
            (at-hero ?receiver ?r)
            (holding-nothing ?receiver)
            (not (= ?giver ?receiver))

            (hero-turn ?giver ?curr)
            (current-turn ?curr)
            (next-turn ?curr ?next)
            (not (has-escaped ?giver))
        )
        :effect (and
            (holding-nothing ?giver)
            (not (holding-key ?giver))
            (holding-key ?receiver)

            (hero-turn ?giver ?next)
            (not (hero-turn ?giver ?curr))
        )
    )

    (:action do-nothing
        :parameters (?r - room ?h - hero ?curr ?next - turn)
        :precondition (and
            (at-hero ?h ?r)
            (has-escaped ?h)

            (hero-turn ?h ?curr)
            (current-turn ?curr)
            (next-turn ?curr ?next)
        )
        :effect (and
            (hero-turn ?h ?next)
            (not (hero-turn ?h ?curr))
        )
    )

    ; Advance a turn
    (:action advance-turn
        :parameters (?curr ?next - turn)
        :precondition (and
            (forall
                (?h - hero)
                (or
                    (hero-turn ?h ?next)
                    (has-escaped ?h)
                )
            )

            (current-turn ?curr)
            (next-turn ?curr ?next)
        )
        :effect (and
            (not (current-turn ?curr))
            (current-turn ?next)
        )
    )

)