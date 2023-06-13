# Generated by devtools/yamaker.

LIBRARY()

LICENSE(BSL-1.0)

LICENSE_TEXTS(.yandex_meta/licenses.list.txt)

PEERDIR(
    contrib/libs/expat
    contrib/libs/poco/Foundation
)

ADDINCL(
    GLOBAL contrib/libs/expat
    GLOBAL contrib/libs/poco/XML/include
    contrib/libs/poco/Foundation/include
    contrib/libs/poco/XML/src
)

NO_COMPILER_WARNINGS()

NO_UTIL()

CFLAGS(
    -DHAVE_EXPAT_CONFIG_H
    -DPOCO_ENABLE_CPP11
    -DPOCO_ENABLE_CPP14
    -DPOCO_NO_AUTOMATIC_LIBS
    -DPOCO_UNBUNDLED
    -DXML_DTD
    -DXML_NS
)

IF (OS_DARWIN)
    CFLAGS(
        -DPOCO_OS_FAMILY_UNIX
        -DPOCO_NO_STAT64
    )
ELSEIF (OS_LINUX)
    CFLAGS(
        -DPOCO_OS_FAMILY_UNIX
        -DPOCO_HAVE_FD_EPOLL
    )
ELSEIF (OS_WINDOWS)
    CFLAGS(
        -DPOCO_OS_FAMILY_WINDOWS
    )
ENDIF()

SRCS(
    src/AbstractContainerNode.cpp
    src/AbstractNode.cpp
    src/Attr.cpp
    src/AttrMap.cpp
    src/Attributes.cpp
    src/AttributesImpl.cpp
    src/CDATASection.cpp
    src/CharacterData.cpp
    src/ChildNodesList.cpp
    src/Comment.cpp
    src/ContentHandler.cpp
    src/DOMBuilder.cpp
    src/DOMException.cpp
    src/DOMImplementation.cpp
    src/DOMObject.cpp
    src/DOMParser.cpp
    src/DOMSerializer.cpp
    src/DOMWriter.cpp
    src/DTDHandler.cpp
    src/DTDMap.cpp
    src/DeclHandler.cpp
    src/DefaultHandler.cpp
    src/Document.cpp
    src/DocumentEvent.cpp
    src/DocumentFragment.cpp
    src/DocumentType.cpp
    src/Element.cpp
    src/ElementsByTagNameList.cpp
    src/Entity.cpp
    src/EntityReference.cpp
    src/EntityResolver.cpp
    src/EntityResolverImpl.cpp
    src/ErrorHandler.cpp
    src/Event.cpp
    src/EventDispatcher.cpp
    src/EventException.cpp
    src/EventListener.cpp
    src/EventTarget.cpp
    src/InputSource.cpp
    src/LexicalHandler.cpp
    src/Locator.cpp
    src/LocatorImpl.cpp
    src/MutationEvent.cpp
    src/Name.cpp
    src/NamePool.cpp
    src/NamedNodeMap.cpp
    src/NamespaceStrategy.cpp
    src/NamespaceSupport.cpp
    src/Node.cpp
    src/NodeAppender.cpp
    src/NodeFilter.cpp
    src/NodeIterator.cpp
    src/NodeList.cpp
    src/Notation.cpp
    src/ParserEngine.cpp
    src/ProcessingInstruction.cpp
    src/QName.cpp
    src/SAXException.cpp
    src/SAXParser.cpp
    src/Text.cpp
    src/TreeWalker.cpp
    src/ValueTraits.cpp
    src/WhitespaceFilter.cpp
    src/XMLException.cpp
    src/XMLFilter.cpp
    src/XMLFilterImpl.cpp
    src/XMLReader.cpp
    src/XMLStreamParser.cpp
    src/XMLStreamParserException.cpp
    src/XMLString.cpp
    src/XMLWriter.cpp
)

END()
