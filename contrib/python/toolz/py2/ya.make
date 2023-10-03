# Generated by devtools/yamaker (pypi).

PY2_LIBRARY()

VERSION(0.10.0)

LICENSE(BSD-3-Clause)

NO_LINT()

PY_SRCS(
    TOP_LEVEL
    tlz/__init__.py
    tlz/_build_tlz.py
    toolz/__init__.py
    toolz/_signatures.py
    toolz/compatibility.py
    toolz/curried/__init__.py
    toolz/curried/exceptions.py
    toolz/curried/operator.py
    toolz/dicttoolz.py
    toolz/functoolz.py
    toolz/itertoolz.py
    toolz/recipes.py
    toolz/sandbox/__init__.py
    toolz/sandbox/core.py
    toolz/sandbox/parallel.py
    toolz/utils.py
)

RESOURCE_FILES(
    PREFIX contrib/python/toolz/py2/
    .dist-info/METADATA
    .dist-info/top_level.txt
)

END()

RECURSE_FOR_TESTS(
    tests
)
