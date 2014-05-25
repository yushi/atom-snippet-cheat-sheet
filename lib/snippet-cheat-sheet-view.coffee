{$$$, View} = require 'atom'

_ = require 'underscore-plus'

module.exports =
class SnippetCheatSheetView extends View
  @content: ->
    @div class: 'overlay from-top', =>
      @h1 "Snippet Cheat Sheet"
      @table '', =>
        @tbody ''

  initialize: (serializeState) ->
    atom.workspaceView.command "snippet-cheat-sheet:toggle", => @toggle()

  # Returns an object that can be retrieved when package is activated
  serialize: ->

  # Tear down any state and detach
  destroy: ->
    @detach()

  getSnippets: (editor) ->
    scope = editor.getCursorScopes()
    snippets = {}
    for properties in atom.syntax.propertiesForScope(scope, 'snippets')
      snippetProperties = _.valueForKeyPath(properties, 'snippets') ? {}
      for snippetPrefix, snippet of snippetProperties
        snippets[snippetPrefix] ?= snippet
    snippets

  toggle: (editor) ->
    if @hasParent()
      @detach()
      @.find('tbody').children().remove()
      return

    @.find('tbody').append $$$ ->
      @tr '', =>
        @th 'Trigger'
        @th 'Name'

    editor = atom.workspace.getActiveEditor()
    snippets = @getSnippets(editor)
    keys = (k for k of snippets)
    for k in keys.sort()
      snippet = snippets[k]
      @.find('tbody').append $$$ ->
        @tr '', =>
          @td '', =>
            @span snippet.prefix
          @td '', =>
            @strong snippet.name

    atom.workspaceView.append(this)
