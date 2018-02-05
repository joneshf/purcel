let purcel : { package : Text
             , modules : List ./Module.dhall
             , dependencies : List ./Module.dhall
             }
           = { package = "prelude"
             , modules =
               [ { name = "Control/Applicative.purs"
                 , contents = https://raw.githubusercontent.com/purescript/purescript-prelude/v3.1.1/src/Control/Applicative.purs as Text
                 }
               , { name = "Control/Apply.js"
                 , contents = https://raw.githubusercontent.com/purescript/purescript-prelude/v3.1.1/src/Control/Apply.js as Text
                 }
               , { name = "Control/Apply.purs"
                 , contents = https://raw.githubusercontent.com/purescript/purescript-prelude/v3.1.1/src/Control/Apply.purs as Text
                 }
               , { name = "Control/Bind.js"
                 , contents = https://raw.githubusercontent.com/purescript/purescript-prelude/v3.1.1/src/Control/Bind.js as Text
                 }
               , { name = "Control/Bind.purs"
                 , contents = https://raw.githubusercontent.com/purescript/purescript-prelude/v3.1.1/src/Control/Bind.purs as Text
                 }
               , { name = "Control/Category.purs"
                 , contents = https://raw.githubusercontent.com/purescript/purescript-prelude/v3.1.1/src/Control/Category.purs as Text
                 }
               , { name = "Control/Monad.purs"
                 , contents = https://raw.githubusercontent.com/purescript/purescript-prelude/v3.1.1/src/Control/Monad.purs as Text
                 }
               , { name = "Control/Semigroupoid.purs"
                 , contents = https://raw.githubusercontent.com/purescript/purescript-prelude/v3.1.1/src/Control/Semigroupoid.purs as Text
                 }
               , { name = "Data/Boolean.purs"
                 , contents = https://raw.githubusercontent.com/purescript/purescript-prelude/v3.1.1/src/Data/Boolean.purs as Text
                 }
               , { name = "Data/BooleanAlgebra.purs"
                 , contents = https://raw.githubusercontent.com/purescript/purescript-prelude/v3.1.1/src/Data/BooleanAlgebra.purs as Text
                 }
               , { name = "Data/Bounded.js"
                 , contents = https://raw.githubusercontent.com/purescript/purescript-prelude/v3.1.1/src/Data/Bounded.js as Text
                 }
               , { name = "Data/Bounded.purs"
                 , contents = https://raw.githubusercontent.com/purescript/purescript-prelude/v3.1.1/src/Data/Bounded.purs as Text
                 }
               , { name = "Data/CommutativeRing.purs"
                 , contents = https://raw.githubusercontent.com/purescript/purescript-prelude/v3.1.1/src/Data/CommutativeRing.purs as Text
                 }
               , { name = "Data/DivisionRing.purs"
                 , contents = https://raw.githubusercontent.com/purescript/purescript-prelude/v3.1.1/src/Data/DivisionRing.purs as Text
                 }
               , { name = "Data/Eq.js"
                 , contents = https://raw.githubusercontent.com/purescript/purescript-prelude/v3.1.1/src/Data/Eq.js as Text
                 }
               , { name = "Data/Eq.purs"
                 , contents = https://raw.githubusercontent.com/purescript/purescript-prelude/v3.1.1/src/Data/Eq.purs as Text
                 }
               , { name = "Data/EuclideanRing.js"
                 , contents = https://raw.githubusercontent.com/purescript/purescript-prelude/v3.1.1/src/Data/EuclideanRing.js as Text
                 }
               , { name = "Data/EuclideanRing.purs"
                 , contents = https://raw.githubusercontent.com/purescript/purescript-prelude/v3.1.1/src/Data/EuclideanRing.purs as Text
                 }
               , { name = "Data/Field.purs"
                 , contents = https://raw.githubusercontent.com/purescript/purescript-prelude/v3.1.1/src/Data/Field.purs as Text
                 }
               , { name = "Data/Function.purs"
                 , contents = https://raw.githubusercontent.com/purescript/purescript-prelude/v3.1.1/src/Data/Function.purs as Text
                 }
               , { name = "Data/Functor.js"
                 , contents = https://raw.githubusercontent.com/purescript/purescript-prelude/v3.1.1/src/Data/Functor.js as Text
                 }
               , { name = "Data/Functor.purs"
                 , contents = https://raw.githubusercontent.com/purescript/purescript-prelude/v3.1.1/src/Data/Functor.purs as Text
                 }
               , { name = "Data/HeytingAlgebra.js"
                 , contents = https://raw.githubusercontent.com/purescript/purescript-prelude/v3.1.1/src/Data/HeytingAlgebra.js as Text
                 }
               , { name = "Data/HeytingAlgebra.purs"
                 , contents = https://raw.githubusercontent.com/purescript/purescript-prelude/v3.1.1/src/Data/HeytingAlgebra.purs as Text
                 }
               , { name = "Data/NaturalTransformation.purs"
                 , contents = https://raw.githubusercontent.com/purescript/purescript-prelude/v3.1.1/src/Data/NaturalTransformation.purs as Text
                 }
               , { name = "Data/Ord.js"
                 , contents = https://raw.githubusercontent.com/purescript/purescript-prelude/v3.1.1/src/Data/Ord.js as Text
                 }
               , { name = "Data/Ord.purs"
                 , contents = https://raw.githubusercontent.com/purescript/purescript-prelude/v3.1.1/src/Data/Ord.purs as Text
                 }
               , { name = "Data/Ord/Unsafe.js"
                 , contents = https://raw.githubusercontent.com/purescript/purescript-prelude/v3.1.1/src/Data/Ord/Unsafe.js as Text
                 }
               , { name = "Data/Ord/Unsafe.purs"
                 , contents = https://raw.githubusercontent.com/purescript/purescript-prelude/v3.1.1/src/Data/Ord/Unsafe.purs as Text
                 }
               , { name = "Data/Ordering.purs"
                 , contents = https://raw.githubusercontent.com/purescript/purescript-prelude/v3.1.1/src/Data/Ordering.purs as Text
                 }
               , { name = "Data/Ring.js"
                 , contents = https://raw.githubusercontent.com/purescript/purescript-prelude/v3.1.1/src/Data/Ring.js as Text
                 }
               , { name = "Data/Ring.purs"
                 , contents = https://raw.githubusercontent.com/purescript/purescript-prelude/v3.1.1/src/Data/Ring.purs as Text
                 }
               , { name = "Data/Semigroup.js"
                 , contents = https://raw.githubusercontent.com/purescript/purescript-prelude/v3.1.1/src/Data/Semigroup.js as Text
                 }
               , { name = "Data/Semigroup.purs"
                 , contents = https://raw.githubusercontent.com/purescript/purescript-prelude/v3.1.1/src/Data/Semigroup.purs as Text
                 }
               , { name = "Data/Semiring.js"
                 , contents = https://raw.githubusercontent.com/purescript/purescript-prelude/v3.1.1/src/Data/Semiring.js as Text
                 }
               , { name = "Data/Semiring.purs"
                 , contents = https://raw.githubusercontent.com/purescript/purescript-prelude/v3.1.1/src/Data/Semiring.purs as Text
                 }
               , { name = "Data/Show.js"
                 , contents = https://raw.githubusercontent.com/purescript/purescript-prelude/v3.1.1/src/Data/Show.js as Text
                 }
               , { name = "Data/Show.purs"
                 , contents = https://raw.githubusercontent.com/purescript/purescript-prelude/v3.1.1/src/Data/Show.purs as Text
                 }
               , { name = "Data/Unit.js"
                 , contents = https://raw.githubusercontent.com/purescript/purescript-prelude/v3.1.1/src/Data/Unit.js as Text
                 }
               , { name = "Data/Unit.purs"
                 , contents = https://raw.githubusercontent.com/purescript/purescript-prelude/v3.1.1/src/Data/Unit.purs as Text
                 }
               , { name = "Data/Void.purs"
                 , contents = https://raw.githubusercontent.com/purescript/purescript-prelude/v3.1.1/src/Data/Void.purs as Text
                 }
               , { name = "Prelude.purs"
                 , contents = https://raw.githubusercontent.com/purescript/purescript-prelude/v3.1.1/src/Prelude.purs as Text
                 }
               ]
             , dependencies = [] : List ./Module.dhall
             }
in
    purcel
