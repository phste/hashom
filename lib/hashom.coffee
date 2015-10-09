{CompositeDisposable} = require 'atom'
CryptoJS = require('crypto-js')

module.exports = Hashom =
  hashomView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable
    @subscriptions.add atom.commands.add 'atom-workspace',
      'hashom:MD5': => @md5()
      'hashom:SHA1': => @sha1(),
      'hashom:SHA256': => @sha256(),
      'hashom:SHA512': => @sha512(),
  deactivate: ->
    @subscriptions.dispose()

  hash: (hashFunction) ->
    if editor = atom.workspace.getActiveTextEditor()
      selection = editor.getLastSelection()
      selectedText = selection.getText()
      if selectedText != ''
        console.log(hashFunction)
        hashedText = hashFunction(selectedText).toString(CryptoJS.enc.Hex);
        selection.insertText(hashedText)

  md5: ->
    @hash(CryptoJS.MD5)

  sha1: ->
    @hash(CryptoJS.SHA1)

  sha256: ->
    @hash(CryptoJS.SHA256)

  sha512: ->
    @hash(CryptoJS.SHA512)
