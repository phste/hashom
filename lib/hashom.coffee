{CompositeDisposable} = require 'atom'
Hashes = require('jshashes')

module.exports = Hashom =
  hashomView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable
    @subscriptions.add atom.commands.add 'atom-workspace',
      'hashom:MD5': => @md5()
  deactivate: ->
    @subscriptions.dispose()

  hash: (hashFunction) ->
    if editor = atom.workspace.getActiveTextEditor()
      selection = editor.getLastSelection()
      selectedText = selection.getText()
      if selectedText != ''
        hashedText = hashFunction.hex(selectedText)
        selection.insertText(hashedText)

  md5: ->
    @hash(new Hashes.MD5())
