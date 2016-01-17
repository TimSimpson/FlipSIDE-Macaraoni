NND32 aka NND3D3
================

This library aims to recreate the FlipSIDE engine, or at least anything useful
from it (the source file was named NND3D2.bas).

In the FlipSIDE engine, since there was no dynamic memory (at least none I knew
about back then) all structures for characters, sprites, etc was initialized
at the start and was iterated everywhere. While this began to seem primitive to
me I feel there is some value in it now, especially as data driven design in
games becomes such a big deal.

nnd32::world

    Defines the "world", or global values, that get passed to upteen million
    functions which define the game.

    The old functions themselves are part of the game class, which is seperate
    and has no state.
