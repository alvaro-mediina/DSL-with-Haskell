
# Functional Laboratory

**Author**: Medina Alvaro - Soria Pedro - Teruel Belén

**Note**: In this README.md you will find: Tasks, some theoretical questions about the Functional Paradigm and how to run the DSL to visualize the Escher image.

The instructions for this laboratory can be found in: https://tinyurl.com/funcional-2024-famaf

# 1. Tasks

## Verification that they can do things.
- [X] Haskell installed and provided working tests (Install.md contains the installation instructions).

## 1.1. Language
- [X] Module `Drawing.hs` with type `Drawing` and combinators. Points 1 to 3 of the instructions.
- [X] Definition of functions (schematics) for drawing manipulation.
- [X] Module `Pred.hs`. Extra point if you define predicates for unnecessary transformations (for example, mirroring twice is the identity).

## 1.2. Geometric Interpretation
- [X] Module `Interp.hs`.

## 1.3. Artistic expression (Use of language)
- [X] Visualize the drawing of 'Drawing/Feo.hs'.
- [X] Module `Dibujos/Grilla.hs`.
- [X] Module `Dibujos/Escher.hs`.
- [X] List of drawings in `Main.hs`.

## 1.4 Tests
- [X] Tests for `Dibujo.hs`.
- [X] Tests for `Pred.hs`.


# 2. Experience
At the time of doing the lab at first, we ran into the problem of re-understanding how Haskell works, once we got familiar again we started to develop the syntax of the language, to see if the functions worked we asked chatgpt to make us examples and we tested them. To do the pred part we used the same methodology. Then for the geometrical interpretation of the functions in the `Interp.hs` module we used the semantics given in the instruction.  Finally, for the programming of the Escher module, the recommended Peter Henderson article and the `Feo.hs` file were of great help. We got a bit stuck in this last part, since the drawings did not fit well, but we solved it by copying literally the functions of the article.
As for the group work, we were able to organize ourselves from the beginning. To avoid problems, we talked about the time that each one of us was going to dedicate to the project in order to distribute the tasks as evenly as possible.


# 3. Some questions

1. Why are the functionalities separated into the indicated modules? Please explain in detail the responsibility of each module.
2. Why are the basic shapes not included in the language definition, and instead it is a parameter of the type?
3. What is the advantage of using a `fold` function over direct pattern-matching?
4. What is the difference between the predicates defined in Pred.hs and the tests?


# Responses

## Answer 1
The functionalities are separated in different modules in order to differentiate, the syntax of the semantics or its interpretation, as well as the use of them.
In `Drawings.hs` is defined the syntax of the language or DSL (Domain Specific Language) that we have implemented, that is to say in this module is specified what can be legally written in this language and which are the functions that the user can use.
In `Interp.hs` is defined the semantics or interpretation of the language, what we did was to use the gloss library for the generation of graphics, in turn we use the Data.Point.Arithmetic module that allows us to perform arithmetic operations between vectors to be able to implement the semantics as defined in the laboratory statement. 
Inside the Drawings folder, there are different modules in which we use the language to be able to make the different drawings requested. Each module is represented by its configuration, given by its name, interpretation and its basic type.
Finally the module `Main.hs` is in charge of the creation of the screen where the drawing is projected and which drawing is going to be projected, choosing the desired configurations (accessible by calling Main with the parameter `list`).

## Answer 2
We do this to have an abstraction and make the language more flexible and reusable. This way `Draw a` can be used with any type of basic shapes (e.g. Pentagon, Hexagon, etc). 
This technique is known as `parametric programming` and allows the code to be agnostic to the specific data type it is working with.

## Answer 3
When we use direct pattern-matching, we must write a pattern for each possible case instead `fold` provides a more general and flexible way of processing the data structure.
On the other hand, in `fold` we use a function that is applied to each element of the data structure in a systematic way. This function can perform any type of operation on each element.
In summary, using a `fold` function instead of doing direct pattern-matching gives you more flexibility, modularity and control over how to process a data structure.

## Answer 4
We have to keep in mind that in the `Pred.hs` file we define the `Pred` type and operational functions for predicates, such as `change`,`anyDib`,`allDib`, among others.

* About the `Pred` type: It is our type for the definition of predicates.
* On the operational functions: Through existing predicates we will be able to operate on them. Pej: Rotate all triangles.

On the other hand in `TestPred.hs`, test file, the functions of Pred.hs are used to corroborate that they work correctly. In effect, `TestPred.hs` depends on `Pred.hs` but they fulfill different roles.

# 4. Execution

## Main
- Initial execution: `cabal run drawings <drawing>` (Optional)
- Execution with choice of drawing: `cabal run drawings list`.

## Test
- Test for `Drawing.hs`: `cabal test drawing`.
- Test for `Pred.hs`: `cabal test predicates`.


