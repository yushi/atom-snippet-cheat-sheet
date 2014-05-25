SnippetCheatSheetView = require './snippet-cheat-sheet-view'

module.exports =
  snippetCheatSheetView: null

  activate: (state) ->
    @snippetCheatSheetView =
      new SnippetCheatSheetView(state.snippetCheatSheetViewState)

  deactivate: ->
    @snippetCheatSheetView.destroy()

  serialize: ->
    snippetCheatSheetViewState: @snippetCheatSheetView.serialize()
