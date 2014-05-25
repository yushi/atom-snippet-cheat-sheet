{WorkspaceView} = require 'atom'
SnippetCheatSheet = require '../lib/snippet-cheat-sheet'

# Use the command `window:run-package-specs` (cmd-alt-ctrl-p) to run specs.
#
# To run a specific `it` or `describe` block add an `f` to the front (e.g. `fit`
# or `fdescribe`). Remove the `f` to unfocus the block.

describe "SnippetCheatSheet", ->
  activationPromise = null

  beforeEach ->
    atom.workspaceView = new WorkspaceView
    activationPromise = atom.packages.activatePackage('snippet-cheat-sheet')

  describe "when the snippet-cheat-sheet:toggle event is triggered", ->
    it "attaches and then detaches the view", ->
      expect(atom.workspaceView.find('.snippet-cheat-sheet')).not.toExist()

      # This is an activation event, triggering it will cause the package to be
      # activated.
      atom.workspaceView.trigger 'snippet-cheat-sheet:toggle'

      waitsForPromise ->
        activationPromise

      runs ->
        expect(atom.workspaceView.find('.snippet-cheat-sheet')).toExist()
        atom.workspaceView.trigger 'snippet-cheat-sheet:toggle'
        expect(atom.workspaceView.find('.snippet-cheat-sheet')).not.toExist()
