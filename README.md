# PitchSpellingModel

[![Build Status](https://travis-ci.org/bwetherfield/PitchSpellingModel.svg?branch=latest)](https://travis-ci.org/bwetherfield/PitchSpellingModel)

## Contents

### Encodings

[`Encodings`](https://github.com/bwetherfield/PitchSpellingModel/tree/latest/Sources/Encodings) implements mappings between models of music and notation, drawn from the **dn-m** ecosystem (_cf._ [`Music`](https://github.com/dn-m/Music), [`NotationalModel`](https://github.com/dn-m/NotationalModel)), and my Pitch Spelling Model.

### NetworkStructures

[`NetworkStructures`](https://github.com/bwetherfield/PitchSpellingModel/tree/latest/Sources/NetworkStructures) implements all the network operations and algorithms needed for the performance of Pitch Spelling Algorithms in forward and inverse directions.

### SpellingNetworks

[`SpellingNetworks`](https://github.com/bwetherfield/PitchSpellingModel/tree/latest/Sources/SpellingNetworks) specializes the **Encodings** and **NetworkStructures** modules to the use cases of the Pitch Spelling model.
