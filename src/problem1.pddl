(define (problem problem1)

    (:domain Dungeon)
    (:objects
        roomA1 roomA2 roomA3 roomA4 roomA5 roomA6 roomA7 roomA8 roomB1 roomB2 roomB3 roomB4 roomB5 roomB6 roomB7 roomB8 roomC1 roomC2 roomC3 roomC4 roomC5 roomC6 roomC7 roomC8 roomD1 roomD2 roomD3 roomD4 roomD5 roomD6 roomD7 roomD8 - room
        hero1 hero2 - hero
        curr next - turn
    )
    (:init
        ; Define the initial hero statuses
        (at-hero hero1 roomD4)
        (at-hero hero2 roomB8)
        (holding-nothing hero1)
        (holding-nothing hero2)

        ; Define turns
        (current-turn curr)
        (hero-turn hero1 curr)
        (hero-turn hero2 curr)
        ; Define relations between turns
        (next-turn curr next)
        (next-turn next curr)

        ; Define special rooms
        (at-monster roomA3)
        (at-monster roomB2)
        (at-monster roomB6)
        (at-monster roomC3)
        (at-monster roomD1)
        (at-monster roomD8)
        (at-sword roomA8)
        (at-sword roomB4)
        (at-sword roomD2)
        (at-lock roomA4)
        (at-lock roomA7)
        (at-lock roomC5)
        (at-lock roomD5)
        (at-key roomC7)
        (at-trap roomB1)
        (at-trap roomD3)

        ; Define room connections
        (connected roomA1 roomA2)
        (connected roomA2 roomA3)
        (connected roomA3 roomA4)
        (connected roomA4 roomA5)
        (connected roomA5 roomA6)
        (connected roomA6 roomA7)
        (connected roomA7 roomA8)

        (connected roomA8 roomA7)
        (connected roomA7 roomA6)
        (connected roomA6 roomA5)
        (connected roomA5 roomA4)
        (connected roomA4 roomA3)
        (connected roomA3 roomA2)
        (connected roomA2 roomA1)

        (connected roomB1 roomB2)
        (connected roomB2 roomB3)
        (connected roomB3 roomB4)
        (connected roomB4 roomB5)
        (connected roomB5 roomB6)
        (connected roomB6 roomB7)
        (connected roomB7 roomB8)

        (connected roomB8 roomB7)
        (connected roomB7 roomB6)
        (connected roomB6 roomB5)
        (connected roomB5 roomB4)
        (connected roomB4 roomB3)
        (connected roomB3 roomB2)
        (connected roomB2 roomB1)

        (connected roomC1 roomC2)
        (connected roomC2 roomC3)
        (connected roomC3 roomC4)
        (connected roomC4 roomC5)
        (connected roomC5 roomC6)
        (connected roomC6 roomC7)
        (connected roomC7 roomC8)

        (connected roomC8 roomC7)
        (connected roomC7 roomC6)
        (connected roomC6 roomC5)
        (connected roomC5 roomC4)
        (connected roomC4 roomC3)
        (connected roomC3 roomC2)
        (connected roomC2 roomC1)

        (connected roomD1 roomD2)
        (connected roomD2 roomD3)
        (connected roomD3 roomD4)
        (connected roomD4 roomD5)
        (connected roomD5 roomD6)
        (connected roomD6 roomD7)
        (connected roomD7 roomD8)

        (connected roomD8 roomD7)
        (connected roomD7 roomD6)
        (connected roomD6 roomD5)
        (connected roomD5 roomD4)
        (connected roomD4 roomD3)
        (connected roomD3 roomD2)
        (connected roomD2 roomD1)

        (connected roomA1 roomB1)
        (connected roomB1 roomC1)
        (connected roomC1 roomD1)

        (connected roomD1 roomC1)
        (connected roomC1 roomB1)
        (connected roomB1 roomA1)

        (connected roomA2 roomB2)
        (connected roomB2 roomC2)
        (connected roomC2 roomD2)

        (connected roomD2 roomC2)
        (connected roomC2 roomB2)
        (connected roomB2 roomA2)

        (connected roomA3 roomB3)
        (connected roomB3 roomC3)
        (connected roomC3 roomD3)

        (connected roomD3 roomC3)
        (connected roomC3 roomB3)
        (connected roomB3 roomA3)

        (connected roomA4 roomB4)
        (connected roomB4 roomC4)
        (connected roomC4 roomD4)

        (connected roomD4 roomC4)
        (connected roomC4 roomB4)
        (connected roomB4 roomA4)

        (connected roomA5 roomB5)
        (connected roomB5 roomC5)
        (connected roomC5 roomD5)

        (connected roomD5 roomC5)
        (connected roomC5 roomB5)
        (connected roomB5 roomA5)

        (connected roomA6 roomB6)
        (connected roomB6 roomC6)
        (connected roomC6 roomD6)

        (connected roomD6 roomC6)
        (connected roomC6 roomB6)
        (connected roomB6 roomA6)

        (connected roomA7 roomB7)
        (connected roomB7 roomC7)
        (connected roomC7 roomD7)

        (connected roomD7 roomC7)
        (connected roomC7 roomB7)
        (connected roomB7 roomA7)

        (connected roomA8 roomB8)
        (connected roomB8 roomC8)
        (connected roomC8 roomD8)

        (connected roomD8 roomC8)
        (connected roomC8 roomB8)
        (connected roomB8 roomA8)
    )

    (:goal
        (and
            (at-hero hero1 roomA1)
            (at-hero hero2 roomA1)
        )
    )
)