# Generic Dependency Solvers

## Notes

### SAT
I think the fancy way to say what we want here is a "SAT Solver"

- [Wikipedia article on SAT solvers](https://en.wikipedia.org/wiki/SAT_solver)
- [FreeBSD leveraging PicoSAT for packages](https://github.com/freebsd/pkg/tree/master/external/picosat)
- [Blog article explaining SAT problems and using MiniSAT](https://codingnest.com/modern-sat-solvers-fast-neat-underused-part-1-of-n/)

### GitLab Semver Parsing

- [GitLab article about generic semver parsing](https://about.gitlab.com/blog/2021/09/28/generic-semantic-version-processing/)


### Constraints Programming

<https://potassco.org/aspcud/>
Tools for Answer Set Programming developed at the University of Potsdam.


"you can also write lib-smt logic for this pretty easy, the s-exp language or python bindings are both reasonable"

"Depending on what you need it's also worth reading about the cudf format, which may allow many solvers off the same spec"

## Discussion

Question:

```
Anyone know of a good "generic dependency solver" tool? Similar to https://www.gecode.org/ ?
```

Series One, from Paul Monson:

```
aspcud is a good solver, but you would either need to write bindings or find some existing bindings for the ecosystem you need


https://potassco.org/aspcud/
Tools for Answer Set Programming developed at the University of Potsdam.


you can also write lib-smt logic for this pretty easy, the s-exp language or python bindings are both reasonable


Depending on what you need it's also worth reading about the cudf format, which may allow many solvers off the same spec

I also found this while wondering if anyone directly supports version formats that are common: https://about.gitlab.com/blog/2021/09/28/generic-semantic-version-processing/
```

Series Two, from prakhunov

```
I think at this point everything moved on to SAT solvers for these

Like freebsd just pulls in picosat for it's dependency solving:
https://github.com/freebsd/pkg/tree/master/external/picosat
As long as you can get your version constraints properly passed in maybe thats all that is needed

And I think this still gets maintained: http://minisat.se/

But maybe that is overkill

This article seems recent enough: https://codingnest.com/modern-sat-solvers-fast-neat-underused-part-1-of-n/ But yeah probably overkill


pmonson
I didn't realize freebsd just used picosat


prakhunov
Yup, i think the rest of the code is here: https://github.com/freebsd/pkg/blob/7dcb9a66652c5cad3436847fa33c420612031b38/libpkg/pkg_solve.c
```

Series Three, from radek:
```
What sort of dependency issues? Most of the time dep issues aren't due to tooling, but rather incompatible bounds declared by package authors. IE You add package A and B, both A and B want C as a transitive dep, but A wants version 3 and B wants version 4.

Your own solver won't fix that

(This is the exact problem Stackage was created to solve btw)
```


