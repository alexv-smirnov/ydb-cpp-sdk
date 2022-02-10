PY2_LIBRARY()

OWNER(blinkov nslus g:python-contrib)

VERSION(1.0.18)

LICENSE(BSD-3-Clause)

PEERDIR(
    contrib/python/six
    contrib/python/wcwidth
)

NO_LINT()

NO_CHECK_IMPORTS(
    prompt_toolkit.clipboard.pyperclip
    prompt_toolkit.contrib.telnet.*
    prompt_toolkit.eventloop.asyncio_posix
    prompt_toolkit.eventloop.asyncio_win32
    prompt_toolkit.eventloop.posix
    prompt_toolkit.eventloop.win32
    prompt_toolkit.input.win32
    prompt_toolkit.input.win32_pipe
    prompt_toolkit.output.conemu
    prompt_toolkit.output.win32
    prompt_toolkit.output.windows10
    prompt_toolkit.terminal.conemu_output
    prompt_toolkit.terminal.vt100_input
    prompt_toolkit.terminal.vt100_output
    prompt_toolkit.terminal.win32_input
    prompt_toolkit.terminal.win32_output
    prompt_toolkit.win32_types
)

PY_SRCS(
    TOP_LEVEL
    prompt_toolkit/__init__.py
    prompt_toolkit/application.py
    prompt_toolkit/auto_suggest.py
    prompt_toolkit/buffer.py
    prompt_toolkit/buffer_mapping.py
    prompt_toolkit/cache.py
    prompt_toolkit/clipboard/__init__.py
    prompt_toolkit/clipboard/base.py
    prompt_toolkit/clipboard/in_memory.py
    prompt_toolkit/clipboard/pyperclip.py
    prompt_toolkit/completion.py
    prompt_toolkit/contrib/__init__.py
    prompt_toolkit/contrib/completers/__init__.py
    prompt_toolkit/contrib/completers/base.py
    prompt_toolkit/contrib/completers/filesystem.py
    prompt_toolkit/contrib/completers/system.py
    prompt_toolkit/contrib/regular_languages/__init__.py
    prompt_toolkit/contrib/regular_languages/compiler.py
    prompt_toolkit/contrib/regular_languages/completion.py
    prompt_toolkit/contrib/regular_languages/lexer.py
    prompt_toolkit/contrib/regular_languages/regex_parser.py
    prompt_toolkit/contrib/regular_languages/validation.py
    prompt_toolkit/contrib/telnet/__init__.py
    prompt_toolkit/contrib/telnet/application.py
    prompt_toolkit/contrib/telnet/log.py
    prompt_toolkit/contrib/telnet/protocol.py
    prompt_toolkit/contrib/telnet/server.py
    prompt_toolkit/contrib/validators/__init__.py
    prompt_toolkit/contrib/validators/base.py
    prompt_toolkit/document.py
    prompt_toolkit/enums.py
    prompt_toolkit/eventloop/__init__.py
    prompt_toolkit/eventloop/asyncio_base.py
    prompt_toolkit/eventloop/asyncio_posix.py
    prompt_toolkit/eventloop/asyncio_win32.py
    prompt_toolkit/eventloop/base.py
    prompt_toolkit/eventloop/callbacks.py
    prompt_toolkit/eventloop/inputhook.py
    prompt_toolkit/eventloop/posix.py
    prompt_toolkit/eventloop/posix_utils.py
    prompt_toolkit/eventloop/select.py
    prompt_toolkit/eventloop/utils.py
    prompt_toolkit/eventloop/win32.py
    prompt_toolkit/filters/__init__.py
    prompt_toolkit/filters/base.py
    prompt_toolkit/filters/cli.py
    prompt_toolkit/filters/types.py
    prompt_toolkit/filters/utils.py
    prompt_toolkit/history.py
    prompt_toolkit/input.py
    prompt_toolkit/interface.py
    prompt_toolkit/key_binding/__init__.py
    prompt_toolkit/key_binding/bindings/__init__.py
    prompt_toolkit/key_binding/bindings/basic.py
    prompt_toolkit/key_binding/bindings/completion.py
    prompt_toolkit/key_binding/bindings/emacs.py
    prompt_toolkit/key_binding/bindings/named_commands.py
    prompt_toolkit/key_binding/bindings/scroll.py
    prompt_toolkit/key_binding/bindings/utils.py
    prompt_toolkit/key_binding/bindings/vi.py
    prompt_toolkit/key_binding/defaults.py
    prompt_toolkit/key_binding/digraphs.py
    prompt_toolkit/key_binding/input_processor.py
    prompt_toolkit/key_binding/manager.py
    prompt_toolkit/key_binding/registry.py
    prompt_toolkit/key_binding/vi_state.py
    prompt_toolkit/keys.py
    prompt_toolkit/layout/__init__.py
    prompt_toolkit/layout/containers.py
    prompt_toolkit/layout/controls.py
    prompt_toolkit/layout/dimension.py
    prompt_toolkit/layout/lexers.py
    prompt_toolkit/layout/margins.py
    prompt_toolkit/layout/menus.py
    prompt_toolkit/layout/mouse_handlers.py
    prompt_toolkit/layout/processors.py
    prompt_toolkit/layout/prompt.py
    prompt_toolkit/layout/screen.py
    prompt_toolkit/layout/toolbars.py
    prompt_toolkit/layout/utils.py
    prompt_toolkit/mouse_events.py
    prompt_toolkit/output.py
    prompt_toolkit/reactive.py
    prompt_toolkit/renderer.py
    prompt_toolkit/search_state.py
    prompt_toolkit/selection.py
    prompt_toolkit/shortcuts.py
    prompt_toolkit/styles/__init__.py
    prompt_toolkit/styles/base.py
    prompt_toolkit/styles/defaults.py
    prompt_toolkit/styles/from_dict.py
    prompt_toolkit/styles/from_pygments.py
    prompt_toolkit/styles/utils.py
    prompt_toolkit/terminal/__init__.py
    prompt_toolkit/terminal/conemu_output.py
    prompt_toolkit/terminal/vt100_input.py
    prompt_toolkit/terminal/vt100_output.py
    prompt_toolkit/terminal/win32_input.py
    prompt_toolkit/terminal/win32_output.py
    prompt_toolkit/token.py
    prompt_toolkit/utils.py
    prompt_toolkit/validation.py
    prompt_toolkit/win32_types.py
)

RESOURCE_FILES(
    PREFIX contrib/python/prompt-toolkit/py2/
    .dist-info/METADATA
    .dist-info/top_level.txt
)

END()

RECURSE_FOR_TESTS(
    tests
)
