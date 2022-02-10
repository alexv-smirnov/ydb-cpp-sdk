# Generated by devtools/yamaker (pypi).

PY3_LIBRARY()

OWNER(
    orivej
    g:python-contrib
)

VERSION(21.3)

LICENSE(
    BSD-2-Clause OR
    Apache-2.0
)

PEERDIR(
    contrib/python/pyparsing
)

NO_LINT()

PY_SRCS(
    TOP_LEVEL
    packaging/__about__.py
    packaging/__init__.py
    packaging/_manylinux.py
    packaging/_musllinux.py
    packaging/_structures.py
    packaging/markers.py
    packaging/requirements.py
    packaging/specifiers.py
    packaging/tags.py
    packaging/utils.py
    packaging/version.py
)

RESOURCE_FILES(
    PREFIX contrib/python/packaging/py3/
    .dist-info/METADATA
    .dist-info/top_level.txt
    packaging/py.typed
)

END()
