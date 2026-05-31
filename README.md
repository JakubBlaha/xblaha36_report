# Project Summary

Goal: Build a formal framework for evaluating whether a set of test cases provides adequate coverage of a software requirement. The immediate test bed is a collection of real avionics/embedded software requirements from Embraer (stored in req/).

## The three-step pipeline:

Translate a natural-language requirement into a formal representation.
Translate the corresponding test cases into the same formal representation.
Check mechanically which conditions of the requirement are not exercised by any test (coverage gap detection).

## Formalism principles:

The formalism is a custom, logic-agnostic formal base with the following structure:

The formalism defines a formal language for expressing software requirements and test cases, designed so that coverage gaps can be detected mechanically.

It starts from primitives: a time domain (either discrete or continuous, chosen per requirement) and a set of typed values including booleans, numbers, time points, and intervals.

On top of that it introduces entities — typed, named objects that represent the things a requirement talks about (signals, memory locations, communication channels, events, states, etc.). Each entity type has a fixed set of permitted attributes. Both a requirement and its test cases share the same entity set, which is the foundation for coverage comparison.

Expressions are the language for computing values: arithmetic, time navigation (previous/next step, relative offsets), querying an entity's value at a given time, and aggregates over intervals. Predicates build boolean conditions from expressions via comparisons, logical connectives, quantifiers, and event-specific checks.

Operations are the atomic actions a system can perform on entities. Each operation has a formal description of what must hold in the execution trace as a result.

Temporal constructs lift point-in-time predicates to whole-trace properties, expressing things like "this always holds", "this eventually holds", "this condition causes that effect within a time bound", or "these events occur in a specific order".

Finally, a requirement is a formal constraint on a trace built from the above; a test case is a concrete sequence of operation invocations with assertions. Coverage checking determines which conditions of the requirement are not exercised by any test case.